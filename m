Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUJWV3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUJWV3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUJWV3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:29:47 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:33577 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261238AbUJWV3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:29:30 -0400
Date: Sat, 23 Oct 2004 14:24:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041023212421.GF1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041023194721.GB1268@us.ibm.com> <1098562921.3306.182.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098562921.3306.182.camel@thomas>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:22:01PM +0200, Thomas Gleixner wrote:
> On Sat, 2004-10-23 at 12:47 -0700, Paul E. McKenney wrote:
> > Attaining hard-realtime response in an existing general-purpose operating
> > system has been seen as a "big-bang" conversion.  The problem is that
> > the entire OS kernel must be modified to ensure that all code paths
> > are deterministic.  It would be much better if there was an evolutionary
> > path to hard realtime.
> > 
> > Since multicore dies and multithreaded CPUs are quite common and
> > becoming quite inexpensive, why not simply designate a particular
> > CPU as the hard realtime CPU?  Interrupts can be directed to the
> > other CPUs, and cpus_allowed can be used to force processes requiring
> > hard-realtime support to run on the designated CPU.  Various other
> > tricks can be used to lock the user process's pages into memory.
> >
> > This much has been done many times in many operating systems, and,
> > if the hard-realtime processes run strictly in user mode, this is
> > (almost) all that is required.
> >
> > But even if the hard-realtime processes refrain from invoking system
> > calls, there are any number of traps and exceptions that can occur.
> > Besides, it is often convenient to use systems calls, for example,
> > a batch industrial process may require realtime response while the
> > batch is processing, but not between batches.  It is convenient to
> > allow the realtime processes to do things like log statistics to
> > mass storage or the network between batches, but without interfering
> > with any other realtime processes that might (for example) need
> > realtime response while preparing for the next batch.
> > 
> > One way to handle this is to offload the system calls and exceptions
> > from the designated realtime CPU to the other CPUs.  The attached
> > (raw, untested, probably does not compile) patch shows one way of
> > doing this.  Then any overly long kernel code paths execute on
> > the non-realtime CPUs, where they do not interfere with realtime
> > latency on the designated realtime CPU.
> > 
> > This patch does have a number of shortcomings (surprise, surprise!):
> > 
> > o	It is untested, probably doesn't even compile.
> > 
> > o	It has not been merged with Ingo's real-time preemption
> > 	patch.  Perhaps Ingo sees this as a good thing.  ;-)
> > 
> > o	The designated realtime CPU is hardcoded, as is the CPU
> > 	to which the system calls are offloaded.  This happens
> > 	to line up with the purported PPC ability to direct all
> > 	interrupts to CPU 0.  This would obviously need to be
> > 	fixed in a production version.  Preferably in a way that
> > 	matches where the PAGG/cpusets/CKRM guys end up, but they
> > 	seem to still be hashing things out.
> > 
> > o	There is no API to set the new TIF_SYSCALL_RTOFFLOAD
> > 	bit to designate the task as a hard-realtime task.  There
> > 	are any number of ways this might be done, including
> > 	a /proc interface, a new syscall, an ioctl, or who knows
> > 	what else.  Suggestions welcome, especially those accompanied
> > 	by a corresponding patch.
> > 
> > o	It currently handles only syscalls, not traps or exceptions.
> > 
> > o	It does not yet allow for real-time-safe system calls.
> > 	This capability is quite important, as it would allow Linux
> > 	to evolve towards hard realtime to the extent desired, one
> > 	system call at a time, for example, as Ingo's real-time
> > 	preemption made a particular system call deterministic.
> > 
> > o	Going further out over the edge, one could have system calls
> > 	that are deterministic in some cases (e.g., writes to ramfs
> > 	vs. writes to disk) and could offload themselves only as required.
> > 
> > o	There are some portions of the scheduler that acquire other
> > 	CPUs' runqueue locks, which is not something that the designated
> > 	realtime CPU ought to be doing.  Similarly, the other CPUs
> > 	should not be acquiring the designated realtime CPU's runqueue
> > 	lock.  For example, sched_migrate_task()'s job becomes more
> > 	interesting.  There are no doubt other similar issues.
> > 
> > o	Real-time application developers would no doubt want some sort
> > 	of per-task flag that prohibited offloading, so that executing
> > 	a (non-deterministic) system call would result in an error
> > 	rather than in offloading.
> > 
> > So, the idea is to provide an evolutionary path towards hard realtime
> > in Linux.  Capabilities within Linux can be given hard-realtime
> > response separately and as needed.  And there are likely a number of
> > capabilities that will never require hard realtime response, for example,
> > given current techological trends, a 1MB synchronous write to disk is
> > going to take some time, and will be subject to the usual retry and
> > error conditions.  This approach allows such operations to keep their
> > simpler non-realtime code.
> > 
> > [Stepping aside, and donning the asbestos suit with tungsten pinstripes...]
> > 
> > Thoughts?
> 
> I haven't seen an embedded SMP system yet. Focussing this on SMP systems
> is ignoring the majority of possible applications.

Seeing SMP support for ARM lead me to believe that this was not too far
over the edge.

> There are solutions around to make this work on UP by converting the cpu
> irq enable/disable flag to software. 
> 
> - the dual kernel approach of RTLINUX

	which requires that the hard realtime stuff use a non-Linux RTOS.

> - the domain approach of RTAI/Adeos

	which, as I understand it, essentially forwards interrupts to
	different kernels multiplexed on the same image.

> - the in kernel approach of KURT/Libertos

	which requires that the realtime code be in the kernel, which
	is sometimes OK, but often not.

A fourth approach is to run something like the Xen VMM, and have it provide a
single OS with the illusion that there are two CPUs.  As you say, the
OS cannot be allowed to really disable interrupts, instead, the underlying
VMM must track whether the OS thinks it has interrupts disabled on a
given "CPU", and refrain from delivering the interrupt until the OS
is ready.

Of course, on a multithreaded CPU or SMP system, the VMM is not required.

> All have one thing in common. The restriction of using existing
> syscalls, concurrency controls and other facilities provided by the
> kernel. So you end up implementing a set of parallel rt-aware
> functionality or you must modify the in kernel facilities to make this
> work.
> 
> Hard realtime is not only a question of irq response and a priviledged
> userspace process. Sure there are applications which can be implemented
> selfcontained, but then I really do not need a SMP system.

Agreed, one would really want all services to be hard realtime.  I am
saying that it would be good to get there step by step rather than
split-brain or big-bang.

						Thanx, Paul
