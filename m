Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDEAdJ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTDEAdJ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:33:09 -0500
Received: from enigma.lanl.gov ([128.165.250.185]:35459 "EHLO enigma.lanl.gov")
	by vger.kernel.org with ESMTP id S261533AbTDEAc6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 19:32:58 -0500
Date: Fri, 4 Apr 2003 17:44:28 -0700
From: hendriks@lanl.gov
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030405004427.GG15620@lanl.gov>
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404203531.A29501@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 08:35:31PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 04, 2003 at 12:32:18PM -0700, Erik Hendriks wrote:
> > Is it possible to get a Linux system call number allocated for BProc?
> > (http://sourceforge.net/projects/bproc) I've been using arbitrary
> > system call numbers for a while but there have been collisions with
> > new kernel features.  I'd like to avoid that in the future.  BProc
> > currently works on 2.4.x kernels on x86, alpha and ppc (32bit).
> 
> Please explain why you need syscalls and the exact APIs.

Here's the answer to the second half...  The kernel API is reasonably
large so let me know if anybody wants more detail anywhere.  The C
library is basically a 1:1 mapping for these calls.

Also, if anybody wants to know more about BProc in general, they can
check out:  http://public.lanl.gov/cluster/papers/papers/hendriks-ics02.pdf

API for the syscall:

arg0 is a function number and meaning of the rest of the arguments
depends on that.

For arg0:

0x0001 - BPROC_SYS_VERSION - get BProc version
  arg1 is a pointer to a bproc_version_t which gets filled in.

  return value: 0 on success, -errno on error

0x0002 - BPROC_SYS_DEBUG - undocumented debugging call a magic
  debugging hook who's argument meanings are fluid, currently it does:
  arg1 = 0 - return number of children by checking pptr and opptr.
  arg1 = 1 - return true/false indicating whether wait() will be local.
  arg1 = 2 - return value of nlchild (internal BProc process book keeping val)
  arg1 = 3 - perform process ID sanity check and return information about
             pptr and opptr in linux and BProc.

0x0003 - BPROC_SYS_MASTER - get master daemon file descriptor.  The master
                       daemon reads/writes messages to/from kernel
                       space with this file descriptor.
  no arguments

  return value: a new file descriptor or -errno on failure.

0x0004 - BPROC_SYS_SLAVE - get slave daemon file descriptor.  The slave
                      daemon reads/writes messages to/from kernel
                      space with this file descriptor.
  no arguments

  return value: a new file descriptor or -errno on failure.

0x0005 - BPROC_SYS_IOD - get I/O daemon file descriptor.  The I/O daemon
                    reads/writes messages to/from kernel space with
                    this file descriptor.
  no arguments

  return value is a new file descriptor or -errno on failure.

0x0006 - BPROC_SYS_NOTIFY - get notifier file descriptor.  An app can get a
                       file descriptor which becomes ready for reading
                       whenever a BProc machine state change happens.
  no arguments

  return value: a new file descriptor or -errno on failure.


0x0201 - BPROC_SYS_INFO - get information on node status
  arg1 pointer to an array of bproc_node_info_t's  (first element contains
       index of last node seen, nodes returned will start with next node)
  arg2 number of elements in array

  return value: number of elements returned on success, -errno on error

0x0202 - BPROC_SYS_STATUS - set node status
  arg1 node number
  arg2 new node state

  return value: 0 on success, -errno on error

0x0203 - BPROC_SYS_CHOWN - change node permission bits (perms are file-like)
  arg1 node number
  arg2 new node perm

  return value: 0 on success, -errno on error

0x0207 - BPROC_SYS_CHROOT - ask slave node to chroot()
  arg1 node number
  arg2 pointer to patch to chroot() to.

  return value: 0 on success, -errno on error

0x0208 - BPROC_SYS_REBOOT - ask slave node to reboot
  arg1 node number

  return value: 0 on success, -errno on error

0x0209 - BPROC_SYS_HALT - ask slave node to halt
  arg1 node number

  return value: 0 on success, -errno on error

0x020A - BPROC_SYS_PWROFF - ask slave node to power off
  arg1 node number

  return value: 0 on success, -errno on error

0x020B - BPROC_SYS_PINFO - get information about location of remote processes
  arg1 pointer to an array of bproc_proc_info_t's  (first element contains
       index of last proc seen, procs returned will start with next node)
  arg2 number of elements in array

  return value: number of elements returned on success, -errno on error

0x020E - BPROC_SYS_RECONNECT - ask slave daemon to reconnect
  arg1 node number
  arg2 pointer to bproc_connect_t which contains 2 sockaddrs - a local
       and remote address for the slave to use when re-connecting to
       the master.

  return value: 0 on success, -errno on error

0x0301 - BPROC_SYS_REXEC - remote exec (replace current process with exec
                           performed on remote node)
  arg1 node number
  arg2 pointer to bproc_move_t (contains exec args, io setup info, etc)

  return value: no return (it's an exec) on success, -errno on error

0x0302 - BPROC_SYS_MOVE - move caller to remote node
  arg1 node number
  arg2 pointer to bproc_move_t (contains flags, io setup info, etc)
  
  arg2 move flags (how much of the memory space gets sent)

  return value: 0 on success, -errno on error

0x0303 - BPROC_SYS_RFORK - fork a child onto another node.  This is a
                           combination of the fork and move calls with
                           semantics such that no child process is
                           ever created (from the parent's point of
                           view) if the move step fails.
  arg1 node number
  arg2 pointer to bproc_move_t (contains flags, io setup info, etc)

  return value: parent: child pid on success, -errno on error
                child: 0

0x0304 - BPROC_SYS_EXECMOVE - exec and then move.  This is a
                              combination of the xec and move
                              syscalls.  This call performs an exec
                              and then moves the resulting process
                              image to a remote node before it is
                              allowed to run.  This is used to place
                              images of programs which are not BProc
                              aware on remote nodes.
  arg1 node number
  arg2 pointer to bproc_move_t (contains exec args, io setup info, etc.)

  return value: no return on success, -errno on error if error happens
  in exec().  If error happens during the move step the process will
  exit with errno as its status.

0x0306 - BPROC_SYS_VRFORK - vector rfork - create many child processes
                            on many remote nodes efficiently.

  arg1 pointer to bproc_move_t.  This contains the number of children
       to create, a list of nodes to move to, an array to store the
       resulting child process IDs, and possibly IO setup information.

  return value: parent: number of nodes or -errno on error.
                        pid array contains pids or -errno for each child.
                child:  rank in list of nodes (0 .. n-1)

0x0307 - BPROC_SYS_EXEC - use master node to perform exec.  A process
                          running on a slave node can ask it's "ghost"
                          on the front end to perform an exec for it.
                          The results of that exec will replace the
                          process on the slave node.
  arg1 pointer to bproc_move_t (contains execve args)

  return value: no return on success, -errno on failure.

0x0309 - BPROC_SYS_VEXECMOVE - vector execmove - create many child
                               processes on many remote nodes
                               efficiently.  The child process image
                               is the result of the supplied execve.

  arg1 pointer to bproc_move_t.  This contains the number of children
       to create, a list of nodes to move to, an array to store the
       resulting child process IDs, execve args and possibly IO setup
       information.

  return value: parent: number of nodes or -errno on failure.  The array 
                children: no return.  If BPROC_RANK=XXXXXXX exists in the
                          environment, vexecmove will replace the Xs with
                          the child's rank in vexecmove.

0x1000 - at this offset, bproc provides an interface to virtual memory
         area dumper (vmadump).  VMADump is the process save/restore
         mechanism that BProc uses internally.

0x1000 - VMAD_DO_DUMP - dump the calling process's image to a file descriptor
  arg1 file descriptor
  arg2 dump flags (controls which regions are dumped and which regions
       are stored as references to files.)

  return value: during dump:  number of bytes written to the file descriptor.
                during undump: 0 (when the process image is restored, it will
                start by returning from this system call)

0x1001 - VMAD_DO_UNDUMP - restore a process image from a file
                          descriptor.  The new image will replace the
                          calling process just like exec.
  arg1 file descriptor

  return value: no return on success, -errno on failure.

side note: where possible, vmadump adds a binary format for dump files
which allows a dump stored in a file to be executed directly.

0x1002 VMAD_DO_EXECDUMP - this is a combination of the exec and dump
                          system calls.  An exec is performed and the
                          resulting process image is dumped to a file
                          descriptor.  The process will exit after the
                          dump is complete.

  arg1 pointer to vmadump_execdump_args (contains execve arguments, a
       file descriptor to dump to and dump flags)

  return value: no return on success, -errno on failure.

VMADump has a "library list" in kernel space.  This is the list of
files it presumes are available at undump time if you ask it not to
dump "libaries".

0x1030 - VMAD_LIB_CLEAR - clear the library list
  no arguments

  return value: 0 on success, -errno no failure.

0x1031 - VMAD_LIB_ADD - add a new library to the list
  arg1 pointer to filename
  arg2 length of filename

  return value: 0 on success, -errno no failure.

0x1032 - VMAD_LIB_DEL - delete a library from the list
  arg1 pointer to filename
  arg2 length of filename

  return value: 0 on success, -errno no failure.

0x1033 - VMAD_LIB_LIST - get the contents of the library list
  arg1 pointer to region to store library list
  arg2 size of region

  The list of libraries is store as a null delimited list of strings.

  return value: number of bytes stored on success, -errno no failure.

0x1034 - VMAD_LIB_SIZE - get the size in bytes of the library list
  no arguments

  return value: size in bytes of the library list
