Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265605AbSKFEDa>; Tue, 5 Nov 2002 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbSKFEDa>; Tue, 5 Nov 2002 23:03:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5699 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265605AbSKFED3>; Tue, 5 Nov 2002 23:03:29 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Werner Almesberger <wa@almesberger.net>, Andy Pfiffer <andyp@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Nov 2002 21:07:34 -0700
In-Reply-To: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
Message-ID: <m1heevfiih.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Tue, 5 Nov 2002, Werner Almesberger wrote:
> 
> > Now, if we assume that it's okay for kexec to use a system call,
> > the next question is whether kexec should indeed use it, i.e.
> > whether a system call makes sense for what it is trying to do.
> > Since there are no device files or network elements naturally
> > involved here (i.e. other major kernel function interfaces),
> > the answer seems to be "yes".
> 
> That's not obvious.  By the same logics, we would need syscalls for
> turning off overcommit, etc., etc.
>
> FWIW, I suspect that
> 	open("/proc/image", O_EXCL|O_WRONLY);
> 	bunch of lseek()/write()
> 	close()
> would be more natural - definitely easier to understand than arguments of
> your sys_kexec().  It's easy to switch from your code to that - you
> put initialization into ->open(), pulling segments from userland into
> ->write(), use default ->lseek() and do actual work on ->close() if
> no errors had happened.  file->private_data will point to intermediate
> state you need.
> 
> After all, that's what happens - you form an image, writing to it user-supplied
> data from given buffers at given offsets and when you are done with that you
> commit the changes.  IMO special syscall is less natural match for that
> than sequence above - commit-on-close is not something unusual, so it matches
> the semantics of all syscalls involved...

First take a look at a ELF header.  There is a one to one mapping between
the arguments to kexec and the segments found there.  

Second lseek()/write() pairs do not have the capacity to specify holes/bss
segments kexec does, so it would not be a 1 to 1 transform.  But I can
live without holes.

Third I am not fully certain it makes sense to implement a function that will
boot into a user specified image remotely.  If the export process has
too many capabilities we could be in trouble.

Are you arguing for more /proc files?  Where does the magic file come
from?   I cannot request the allocation of a device number because the 
allocation was frozen before 2.4 started.  Though char 1 minor 11
seems the obvious choice.   Or should it be a magic file in sysfs
instead of procfs?  All of the require the code to live someplace
where I need to allocate a place in the namespace.  So there is no
inherent advantage over a system call.  And unless someone exports the
hooks to properly shutdown the system to modules it is useless.

Given that this is a seldom used system function I agree that it does not
need to be optimized.

I do not have any problem with changing the interface to something
more palatable to other kernel developers.  But I will only do it for
one of two reasons.  My patch will never get accepted in any
reasonable time frame and it makes maintenance easier for me.  Or
makes the interface palatable for acceptance, into the kernel.
Neither position currently appears apparent.

----------
Now to dig into the heart of the issue.

I could write the new kernel image into /dev/mem and just jump to
it.  Because that is really all I want an interface to do.  There
are several practical problems, with something quite that simple.

No kernel shutdown code is run, so I am left with processors flying
all over the place, devices doing all manner of things, after their
device drivers have walked away.  Something needs to put the system in
a quiescent state.  The fix I call the reboot notifiers, and
device_shutdown.  (And then implement a bunch of ->shutdown() methods)

As we all know writing to /dev/mem is not safe because the memory is
being use for other things.  So I need a way to safely use memory
during the transition, from one kernel to another.  

Personally I would love to be able to allocate one big contiguous
buffer that the kernel is not using and neither is the image I will
eventually load.  Then I could just memcpy from that buffer and I
would be done.

Alas memory management in the kernel is done in pages, and can be
fragmented after running for many moons.  So I need to allocate all of
my memory in pages, and I need to let the kernel know where it will
all eventually live so I can correctly order the memcpy operations.

Once all the memory copying is sorted out I need to jump to the new
kernel (a kernel being anything that runs without an OS).  Logically
all you should have to do is do a single jump instruction but in
practice there is much more that has to be done.  The kernel when it
loads up looks around and enables all sorts of cpu optimizations so
the kernel runs as well as possible on the processor.  The new kernel
image needs to be given a least common denominator interface so it can
enable what it is prepared to take advantage of.   In addition to what
the normal shutdown path can accomplish on x86 this involves disabling
page, changing the gdt, and changing the idt, and possibly disabling
SMP.  It should be possible to enhance device_shutdown so it can
properly disable SMP though if that will happen still remains in the
air.

-----------------------------------------

So kexec needs:

- An allocated slot in some namespace.
- The ability to request the kernel devices shut themselves down.
- Buffers that are safe to use.
- The ability to transition the cpu into a state that is suitable
  for jumping to another kernel.
- Awareness of it's existence.

To some extent every piece of this is intimately tied to the kernel
implementation, from the ability to modify page tables, when jumping
to a new kernel, to the best algorithm for finding a safe memory
buffer, to the proper way to shutdown devices this week, and being
intimately tied to the kernel the code needs to find a home in the
kernel.


Eric
 
