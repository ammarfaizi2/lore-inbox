Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUJWUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUJWUbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUJWUbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:31:34 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62372
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261294AbUJWUaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:30:06 -0400
Subject: Re: [RFC][PATCH] Restricted hard realtime
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: paulmck@us.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       karim@opersys.com
In-Reply-To: <20041023194721.GB1268@us.ibm.com>
References: <20041023194721.GB1268@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 23 Oct 2004 22:22:01 +0200
Message-Id: <1098562921.3306.182.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 12:47 -0700, Paul E. McKenney wrote:
> Attaining hard-realtime response in an existing general-purpose operating
> system has been seen as a "big-bang" conversion.  The problem is that
> the entire OS kernel must be modified to ensure that all code paths
> are deterministic.  It would be much better if there was an evolutionary
> path to hard realtime.
> 
> Since multicore dies and multithreaded CPUs are quite common and
> becoming quite inexpensive, why not simply designate a particular
> CPU as the hard realtime CPU?  Interrupts can be directed to the
> other CPUs, and cpus_allowed can be used to force processes requiring
> hard-realtime support to run on the designated CPU.  Various other
> tricks can be used to lock the user process's pages into memory.
>
> This much has been done many times in many operating systems, and,
> if the hard-realtime processes run strictly in user mode, this is
> (almost) all that is required.
>
> But even if the hard-realtime processes refrain from invoking system
> calls, there are any number of traps and exceptions that can occur.
> Besides, it is often convenient to use systems calls, for example,
> a batch industrial process may require realtime response while the
> batch is processing, but not between batches.  It is convenient to
> allow the realtime processes to do things like log statistics to
> mass storage or the network between batches, but without interfering
> with any other realtime processes that might (for example) need
> realtime response while preparing for the next batch.
> 
> One way to handle this is to offload the system calls and exceptions
> from the designated realtime CPU to the other CPUs.  The attached
> (raw, untested, probably does not compile) patch shows one way of
> doing this.  Then any overly long kernel code paths execute on
> the non-realtime CPUs, where they do not interfere with realtime
> latency on the designated realtime CPU.
> 
> This patch does have a number of shortcomings (surprise, surprise!):
> 
> o	It is untested, probably doesn't even compile.
> 
> o	It has not been merged with Ingo's real-time preemption
> 	patch.  Perhaps Ingo sees this as a good thing.  ;-)
> 
> o	The designated realtime CPU is hardcoded, as is the CPU
> 	to which the system calls are offloaded.  This happens
> 	to line up with the purported PPC ability to direct all
> 	interrupts to CPU 0.  This would obviously need to be
> 	fixed in a production version.  Preferably in a way that
> 	matches where the PAGG/cpusets/CKRM guys end up, but they
> 	seem to still be hashing things out.
> 
> o	There is no API to set the new TIF_SYSCALL_RTOFFLOAD
> 	bit to designate the task as a hard-realtime task.  There
> 	are any number of ways this might be done, including
> 	a /proc interface, a new syscall, an ioctl, or who knows
> 	what else.  Suggestions welcome, especially those accompanied
> 	by a corresponding patch.
> 
> o	It currently handles only syscalls, not traps or exceptions.
> 
> o	It does not yet allow for real-time-safe system calls.
> 	This capability is quite important, as it would allow Linux
> 	to evolve towards hard realtime to the extent desired, one
> 	system call at a time, for example, as Ingo's real-time
> 	preemption made a particular system call deterministic.
> 
> o	Going further out over the edge, one could have system calls
> 	that are deterministic in some cases (e.g., writes to ramfs
> 	vs. writes to disk) and could offload themselves only as required.
> 
> o	There are some portions of the scheduler that acquire other
> 	CPUs' runqueue locks, which is not something that the designated
> 	realtime CPU ought to be doing.  Similarly, the other CPUs
> 	should not be acquiring the designated realtime CPU's runqueue
> 	lock.  For example, sched_migrate_task()'s job becomes more
> 	interesting.  There are no doubt other similar issues.
> 
> o	Real-time application developers would no doubt want some sort
> 	of per-task flag that prohibited offloading, so that executing
> 	a (non-deterministic) system call would result in an error
> 	rather than in offloading.
> 
> So, the idea is to provide an evolutionary path towards hard realtime
> in Linux.  Capabilities within Linux can be given hard-realtime
> response separately and as needed.  And there are likely a number of
> capabilities that will never require hard realtime response, for example,
> given current techological trends, a 1MB synchronous write to disk is
> going to take some time, and will be subject to the usual retry and
> error conditions.  This approach allows such operations to keep their
> simpler non-realtime code.
> 
> [Stepping aside, and donning the asbestos suit with tungsten pinstripes...]
> 
> Thoughts?

I haven't seen an embedded SMP system yet. Focussing this on SMP systems
is ignoring the majority of possible applications.

There are solutions around to make this work on UP by converting the cpu
irq enable/disable flag to software. 

- the dual kernel approach of RTLINUX
- the domain approach of RTAI/Adeos
- the in kernel approach of KURT/Libertos

All have one thing in common. The restriction of using existing
syscalls, concurrency controls and other facilities provided by the
kernel. So you end up implementing a set of parallel rt-aware
functionality or you must modify the in kernel facilities to make this
work.

Hard realtime is not only a question of irq response and a priviledged
userspace process. Sure there are applications which can be implemented
selfcontained, but then I really do not need a SMP system.

tglx


