Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTDEUEQ (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbTDEUEQ (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:04:16 -0500
Received: from enigma.lanl.gov ([128.165.250.185]:43395 "EHLO enigma.lanl.gov")
	by vger.kernel.org with ESMTP id S262642AbTDEUEG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 15:04:06 -0500
Date: Sat, 5 Apr 2003 13:15:37 -0700
From: hendriks@lanl.gov
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030405201537.GA18755@lanl.gov>
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org> <20030405004427.GG15620@lanl.gov> <20030405064559.A2331@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405064559.A2331@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 06:45:59AM +0100, Christoph Hellwig wrote:
> On Fri, Apr 04, 2003 at 05:44:28PM -0700, hendriks@lanl.gov wrote:
> > Here's the answer to the second half...  The kernel API is reasonably
> > large so let me know if anybody wants more detail anywhere.  The C
> > library is basically a 1:1 mapping for these calls.
> > 
> > Also, if anybody wants to know more about BProc in general, they can
> > check out:  http://public.lanl.gov/cluster/papers/papers/hendriks-ics02.pdf
> > 
> > API for the syscall:
> > 
> > arg0 is a function number and meaning of the rest of the arguments
> > depends on that.
> > 
> > For arg0:
> 
> Stop right here.  We don't want even more muliplexer syscalls.  Please
> untangle this to individual calls.

The reason it is the way it is because when I'm trying to avoid
stomping on other syscalls, having a small foot print is a good thing.

BProc will always be a fringe kind of thing.  Adding more than a
syscall or two seems like quite a bit of polution in the main kernel
to me.  Similarly, I don't think the main kernel should include the
BProc patch.  It changes fairly often, isn't 100% unintrusive and
would be used by less than .1% of people out there.

Breaking out every call into a separate syscall number would also make
it more difficult to add new features in the future.

> > 0x0001 - BPROC_SYS_VERSION - get BProc version
> >   arg1 is a pointer to a bproc_version_t which gets filled in.
> > 
> >   return value: 0 on success, -errno on error
> 
> Scratch this one, syscall ABIs are supposed to be stable.

This version is here only to make sure that the kernel module and
master/slave daemon are properly matched - that is they're going to be
sending/receiving the same messages from each other.  The message
interface (which is used ONLY by the daemons) is not stable - it can't
be.  Fixing that in stone would prevent bug fixes.  Things can also go
badly in weird ways if the daemons and the kernel code don't agree on
what the protocol is.

The rest of the ABI, all the other calls here are supposed to be
stable.  Only the daemons ever look at the version number.

> > 0x0002 - BPROC_SYS_DEBUG - undocumented debugging call a magic
> >   debugging hook who's argument meanings are fluid, currently it does:
> >   arg1 = 0 - return number of children by checking pptr and opptr.
> >   arg1 = 1 - return true/false indicating whether wait() will be local.
> >   arg1 = 2 - return value of nlchild (internal BProc process book keeping val)
> >   arg1 = 3 - perform process ID sanity check and return information about
> >              pptr and opptr in linux and BProc.
> 
> Debug stuff doesn't need a syscall, please get rid of this one.

It's got to be in some kind of kernel communication layer...  All
these calls involve answering some kind of question that involves
sitting on the task list lock and counting stuff.  Little test
programs make these calls since they know what the answers *should*
be.

Whether this one gets built in at all is currently an ifdef.  I only
included in the list because it's currently built in my default.

> > 0x0003 - BPROC_SYS_MASTER - get master daemon file descriptor.  The master
> >                        daemon reads/writes messages to/from kernel
> >                        space with this file descriptor.
> >   no arguments
> > 
> >   return value: a new file descriptor or -errno on failure.
> 
> Shouldn't this better be a new character device?
> 
> (Dito for the other fd stuff)

It could be - it was at first.  Part of avoiding stepping on too many
things included not needing more magic numbers for character device
nodes.

Since the syscall was already there, it seemed convenient to get the
FDs though that instead of a device node.

I considered making it a type of socket but that seemed gross.
Instead I looked at the pipe() code doing something similar to that.

> > 0x0201 - BPROC_SYS_INFO - get information on node status
> >   arg1 pointer to an array of bproc_node_info_t's  (first element contains
> >        index of last node seen, nodes returned will start with next node)
> >   arg2 number of elements in array
> > 
> >   return value: number of elements returned on success, -errno on error
> 
> This should be read() on a special file.
> 
> > 
> > 0x0202 - BPROC_SYS_STATUS - set node status
> >   arg1 node number
> >   arg2 new node state
> > 
> >   return value: 0 on success, -errno on error
> 
> Write on a special file.
> 
> > 
> > 0x0203 - BPROC_SYS_CHOWN - change node permission bits (perms are file-like)
> 
> So why is this no file, e.g. in sysfs?

Two reasons:

  1 - I want this call to work from anywhere in the system.  This
      isn't a complete SSI, there's no shared filesystem.

  2 - This information isn't maintained in kernel space right now.
      The master daemon (a normal user space process) keeps track of
      it and does permission checks when move requests come by.

  2.5 - I haven't ported to 2.5 yet.  I've been hearing good things
    about it so I'll probably look at it soon (i.e. when I get some
    time).  The reason I don't like to mess around with development
    kernels until they stabilize is that a little instability on 1
    machine might be tolerable - on a 1024 node machine, it's really
    not.

> > 0x0207 - BPROC_SYS_CHROOT - ask slave node to chroot()
> >   arg1 node number
> >   arg2 pointer to patch to chroot() to.
> 
> Please explain this a bit more.  Can't you use namespace properly on
> the slaves somehow?

There's some legacy here - this stuff pre-dates pivot_root.

I should say a little more about the kind of environment the slaves
operate in.  The slave nodes are very bare-bones (this makes them
reliable).  They are diskless, they boot linux + initrd out of flash
on the board and the slave node gets running with an essentially blank
file system.  The less software you install on a node, the more
reliable it is.

The problem was that we needed something a little more featureful as
the root file system.  The way around this was to mount whatever we
wanted to use at the root fs and then have the slave daemon chroot to
it.  Processes that migrated to the node after that would see the root
file system we wanted.

> > 0x0208 - BPROC_SYS_REBOOT - ask slave node to reboot
> >   arg1 node number
> > 
> >   return value: 0 on success, -errno on error
> > 
> > 0x0209 - BPROC_SYS_HALT - ask slave node to halt
> >   arg1 node number
> > 
> >   return value: 0 on success, -errno on error
> > 
> > 0x020A - BPROC_SYS_PWROFF - ask slave node to power off
> >   arg1 node number
> > 
> >   return value: 0 on success, -errno on error
> 
> Can't you just call sys_reboot on the remote node?

If you just call reboot on the node w/o getting BProc in the loop,
then it wouldn't cleanly disconnect before rebooting.  That node would
appear hung to the rest of the system until the master decided that it
was dead.  That's done with a simple timeout right now.

Since our nodes are running *nothing* but the Bproc slave, you can't
log in some other way to kill the slave and then reboot and you can't
run shutdown -r or something like that becuase there are no init
scripts.

> > 0x020B - BPROC_SYS_PINFO - get information about location of remote processes
> >   arg1 pointer to an array of bproc_proc_info_t's  (first element contains
> >        index of last proc seen, procs returned will start with next node)
> >   arg2 number of elements in array
> > 
> >   return value: number of elements returned on success, -errno on error
> 
> Should be read() on a special file.

It started life like that but then I liked the idea of being able to
do it from any node in the system.  (remember no shared fs) 

> > 0x020E - BPROC_SYS_RECONNECT - ask slave daemon to reconnect
> >   arg1 node number
> >   arg2 pointer to bproc_connect_t which contains 2 sockaddrs - a local
> >        and remote address for the slave to use when re-connecting to
> >        the master.
> 
> Don't use bproc_connect_t but the real arguments.
> 
> > 0x0301 - BPROC_SYS_REXEC - remote exec (replace current process with exec
> >                            performed on remote node)
> >   arg1 node number
> >   arg2 pointer to bproc_move_t (contains exec args, io setup info, etc)
> > 
> >   return value: no return (it's an exec) on success, -errno on error
> > 
> > 0x0302 - BPROC_SYS_MOVE - move caller to remote node
> >   arg1 node number
> >   arg2 pointer to bproc_move_t (contains flags, io setup info, etc)
> >   
> >   arg2 move flags (how much of the memory space gets sent)
> > 
> >   return value: 0 on success, -errno on error
> > 
> > 0x0303 - BPROC_SYS_RFORK - fork a child onto another node.  This is a
> >                            combination of the fork and move calls with
> >                            semantics such that no child process is
> >                            ever created (from the parent's point of
> >                            view) if the move step fails.
> >   arg1 node number
> >   arg2 pointer to bproc_move_t (contains flags, io setup info, etc)
> > 
> >   return value: parent: child pid on success, -errno on error
> >                 child: 0
> > 
> > 0x0304 - BPROC_SYS_EXECMOVE - exec and then move.  This is a
> >                               combination of the xec and move
> >                               syscalls.  This call performs an exec
> >                               and then moves the resulting process
> >                               image to a remote node before it is
> >                               allowed to run.  This is used to place
> >                               images of programs which are not BProc
> >                               aware on remote nodes.
> >   arg1 node number
> >   arg2 pointer to bproc_move_t (contains exec args, io setup info, etc.)
> > 
> >   return value: no return on success, -errno on error if error happens
> >   in exec().  If error happens during the move step the process will
> >   exit with errno as its status.
> > 
> > 0x0306 - BPROC_SYS_VRFORK - vector rfork - create many child processes
> >                             on many remote nodes efficiently.
> > 
> >   arg1 pointer to bproc_move_t.  This contains the number of children
> >        to create, a list of nodes to move to, an array to store the
> >        resulting child process IDs, and possibly IO setup information.
> > 
> >   return value: parent: number of nodes or -errno on error.
> >                         pid array contains pids or -errno for each child.
> >                 child:  rank in list of nodes (0 .. n-1)
> > 
> > 0x0307 - BPROC_SYS_EXEC - use master node to perform exec.  A process
> >                           running on a slave node can ask it's "ghost"
> >                           on the front end to perform an exec for it.
> >                           The results of that exec will replace the
> >                           process on the slave node.
> >   arg1 pointer to bproc_move_t (contains execve args)
> > 
> >   return value: no return on success, -errno on failure.
> > 
> > 0x0309 - BPROC_SYS_VEXECMOVE - vector execmove - create many child
> >                                processes on many remote nodes
> >                                efficiently.  The child process image
> >                                is the result of the supplied execve.
> > 
> >   arg1 pointer to bproc_move_t.  This contains the number of children
> >        to create, a list of nodes to move to, an array to store the
> >        resulting child process IDs, execve args and possibly IO setup
> >        information.
> > 
> >   return value: parent: number of nodes or -errno on failure.  The array 
> >                 children: no return.  If BPROC_RANK=XXXXXXX exists in the
> >                           environment, vexecmove will replace the Xs with
> >                           the child's rank in vexecmove.
> > 
> > 0x1000 - at this offset, bproc provides an interface to virtual memory
> >          area dumper (vmadump).  VMADump is the process save/restore
> >          mechanism that BProc uses internally.
> 
> I think all these are pretty generic for any SSI clustering.  Could
> you please talk to the Compaq and Mosix folks about a common API?

I think it's not quite as generic as you might think.  Compaq
(OpenSSI, I presume) and Mosix are mostly concerned with providing a
really transparent SSI.  BProc is concerned only with process creation
and management - it's a partial SSI.  It does nothing for a shared
name space.  I've always viewed the global FS as a separate problem
with the answer being something like Lustre.

The difference in goals means that BProc is going to opt for
scalability at the cost of maintaining a perfect SSI.  Not providing
complete transparency (for filesystem and everything else) is a huge
win for scalability.  At the risk of pissing some people off....  The
scalability of completely transparent SSI systems is usually measured
in the 10s of nodes.  DEC/Compaq/HP claimed to scale to 32 or 64 nodes
the last time we talked to them here at the lab.  I don't know how
many remote processes a single machine can reasonably support in
Mosix.  We currently have a 1024 node (1 master + 1023 slaves) BProc
system ("Pink") here at the lab.

Since BProc doesn't provide a complete SSI, the migration API includes
some extra stuff to smooth over the rough spots.  For example, BProc's
API includes some extrastuff for setting up I/O (stdin/out/err) for
the remote process.  So anyway, while there certainly is overlap, I
think OpenSSI and Mosix are probably different enough that coming up
with a sensible common API will be difficult.

Having that many nodes also makes mass process creation much more
important.  I think the mass process creation primitives became
important for us around 128 nodes.  Now we can put a 4MB process on
1023 nodes in 0.7 sec. :)

The last time we talked to DEC/Compaq/HP here at the lab, they seemed
mostly uninterested in what we were doing anyway.

Disclaimer:  Any views expressed here are my own and not my employer's.

> > 0x1000 - VMAD_DO_DUMP - dump the calling process's image to a file descriptor
> >   arg1 file descriptor
> >   arg2 dump flags (controls which regions are dumped and which regions
> >        are stored as references to files.)
> > 
> >   return value: during dump:  number of bytes written to the file descriptor.
> >                 during undump: 0 (when the process image is restored, it will
> >                 start by returning from this system call)
> 
> I'm pretty sure this would better be a /proc/<pid>/image file you
> can read from.

I'm a little fuzzy on what you mean here.  If you're suggesting that a
process read from its own /proc/pid/image, then that's hard because
the process is changing while you do it.  In the 3rd party case (which
vmadump doesn't support) it gets more tricky because you need to make
sure the process is stopped and the CPU state stored while you're
reading this.

The reason I like the FD interface is because of how BProc uses it.
When a process migrates, BProc opens a tcp socket between the two
machines, then it calls dump and undump back-to-back so you can
migrate w/o any file system dependencies at all.

> > 0x1001 - VMAD_DO_UNDUMP - restore a process image from a file
> >                           descriptor.  The new image will replace the
> >                           calling process just like exec.
> >   arg1 file descriptor
> > 
> >   return value: no return on success, -errno on failure.
> > 
> > side note: where possible, vmadump adds a binary format for dump files
> > which allows a dump stored in a file to be executed directly.
> 
> Can't you always use this binary format?  And btw, does this checkpoint
> and restore code depend on the rest of bproc?  I'd love to see it even
> in normal, not cluster-awaer kernels.

Unfortunately no (w/o user land magic that is).  On alpha, for
example, you have the problem that exec doesn't save enough on the way
into the syscall so you can't restore everything on the way out.  This
is the callee-saved register problem again.  On x86 and ppc it works
fine.

You could put some alpha magic in the user library to work around
this.  I haven't bothered since I never use this feature myself.  I
always thought of it as a curiosity that wasn't all that useful.

I also don't use the binary format when undump'ing in a process
migration because that would require writing out the image to a file.
That presumes that I have a writable file system at my disposal (this
is often not the case on our clusters) and some place in mind to write
it.  Then I'd have to clean it up later too.  It seems like a needless
extra step.  Keep in mind that these direct VMADump calls are made
available as a convenience mostly for testing.

VMADump doesn't depend on BProc at all.  You will, however, need a
system call for it the way it's written now :)

> > 0x1030 - VMAD_LIB_CLEAR - clear the library list
> >   no arguments
> 
> What library lists are all those calls about?  Needs more explanation.

If you look at the virtual memory space of a dynamically linked
program, the percentage of space used by the program itself (i.e. not
libraries) is often very small.  In an effort to make process
migration really cheap, we're willing to say that files X, Y and Z are
available on the machine where we'll be restoring the process image.
The candidates for remote caching are, obviously, large shared
libraries.

So, the dumper needs to know what it can expect to find on the remote
system and what it can't.  That's where the library list comes in.  It
probably should just be called the remote file list or something.
It's a gross hack where we tell the kernel code what it doesn't need
to dump.  Anything that isn't dumped gets stored in the dump file as a
reference to a file.  (e.g. map X bytes of /lib/libc-2.3.2.so @ offset
Y)

And yeah, this might be cleaner as a writable special file but this
was easy given the big syscall mux.

 - Erik
