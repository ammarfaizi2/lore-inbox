Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132695AbRDQOwq>; Tue, 17 Apr 2001 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRDQOwh>; Tue, 17 Apr 2001 10:52:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2074 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132695AbRDQOwc>; Tue, 17 Apr 2001 10:52:32 -0400
Date: Tue, 17 Apr 2001 17:07:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org, Peter Rival <frival@zk3.dec.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>
Subject: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010417170717.H2696@athlon.random>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu> <20010413084805.B3118@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010413084805.B3118@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Fri, Apr 13, 2001 at 08:48:05AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 08:48:05AM -0500, Bob McElrath wrote:
> Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> > > (But since the X server shouldn't have the ability to corrupt the
> > > kernel's process list, there has to be a problem in the kernel
> > > somewhere)
> > 
> > The X server has enough priviledge to corrupt anything. Its unlikely to and
> > I do agree they two are likely to be unrelated.
> 
> Well, nix that idea.  I just fell back to 2.2.19, and I see neither the
> X crash nor the process-table-hang crash (which rules out hardware
> problems, thankfully).  The X crash is also kernel related, it seems.
> 
> I'm using XFree86 4.0.3 with the mga driver.  It hangs in mga_storm.c on
> a line that looks like:
>     while (MGAISBUSY()) {}
> where:
>     #define MGAISBUSY() (INREG8(MGAREG_Status + 2) & 0x01)
> 
> Killing and restarting X causes it to immediately hang in the same
> place.  (I have to reboot to recover the console)
> 
> This would seem to be PCI related.  Have any significant PCI code
> changes been made to the alpha architecture, especially pyxis or
> cabriolet code?  I see that arch/alpha/kernel has been totally
> rearranged, but since this doesn't crash in kernel code, I have no idea
> how to debug it.

It seems it was an SMP race in the rw alpha semaphores. I rewrote the
rwsemaphores starting from my first implementation of them in C that is now
adpoted by the ppc port (I added some scalability and locking optimization),
and made them generic dropping all the rwsem stuff that is been included into
2.4.4pre[23] (the generic rwsemaphores in those kernels is broken, try to use
them in other archs or x86 and you will notice) and I cannot reproduce the hang
any longer.

My generic rwsem should be also cleaner and faster than the generic ones in
2.4.4pre3 and they can be turned off completly so an architecture can really
takeover with its own asm implementation (while with the 2.4.4pre3 design this
is obviously not possible because lib/rwsem.c compilation isn't conditional and
such file knows the internals of the struct rw_semaphore).

In the below generic implementation of the rw sem the max limit of concurrent
readers in the critical section is 2^sizeof(int) and down_read is recursive.
There's no limit of tasks sleeping in the slow path either by down_read or
down_write. The waitqueue wakeups are done without any additional lock (the
lock in the waitqueue is unused).

So please try to reproduce the hang with 2.4.4pre3 with those two
patches applied:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre3aa3/00_alpha-numa-3
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre3aa3/00_rwsem-generic-1

All alpha users should run with at least the above two patches applied
to compile their tree and to make sure to have rock solid rwsemaphores.

Both patches are suggested for inclusion, the arch optimizations can be done on
top of the cleaner and arch friendly rwsem code (just copy the asm files from
2.4.4pre3 and set CONFIG_GENERIC_RWSEM to `n') and the current lib/rwsem.c can be
moved in arch/i386/kernel without any problem. I didn't do that myself because
I wasn't going to audit every line of the x86 asm rwsem right now and I only
wanted obviously right stuff into my tree but I'd appreciate if David could do
that. Note that besides my patch drops the asm stuff I don't want to reject the asm
based implementation in the long run, but I only care to proivide a solid
and clean generic implementation that can be used as a fallback anytime on any
arch by only changing a configuration option.

The alpha-numa patch also fixes some mm bug in the common code.

Andrea
