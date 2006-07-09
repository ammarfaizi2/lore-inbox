Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWGIBvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWGIBvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 21:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWGIBvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 21:51:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13295 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161041AbWGIBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 21:51:54 -0400
Subject: Re: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394
	audio
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Pieter Palmers <pieterp@joow.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1152371924.4736.169.camel@mindpipe>
References: <1152371924.4736.169.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 21:51:34 -0400
Message-Id: <1152409894.32734.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Sorry, I've been quiet, and will be again soon.  I'm in a process of
changing jobs, and I am now employed by Red Hat and will soon be working
on Xen.

Anyway, I'll take a look at what you got and see if I can help at all.

On Sat, 2006-07-08 at 11:18 -0400, Lee Revell wrote:
> Pieter has found this bug in -rt:
> 
> We are experiencing 'soft' deadlocks when running our code (Freebob, 
> i.e. userspace lib for firewire audio) on RT kernels. After a few 
> seconds of system freeze, I get a kernel panic message that signals a soft lockup.
> 
> I've uploaded the photo's of the panic here:
> http://freebob.sourceforge.net/old/img_3378.jpg (without flash)

uw, what a headache.

> http://freebob.sourceforge.net/old/img_3377.jpg (with flash)

Hmm no headache but hard to read. Good that the functions
ohci1394_unregister_iso_tasklet and down are readable, and those are the
important information.

> both are of suboptimal quality unfortunately, but all info is readable 
> on one or the other.

yep.

> 
> The problems occur when an ISO stream (receive and/or transmit) is shut 
> down in a SCHED_FIFO thread. More precisely when running the freebob 
> jackd backend in real-time mode. And even more precise: they only seem 
> to occur when jackd is shut down. There are no problems when jackd is 
> started without RT scheduling.
> 
> I havent been able to reproduce this with other test programs that are 
> shutting down streams in a SCHED_FIFO thread.
> 
> The problem is not reproducible on non-RT kernels, and it only occurs on those configured for 
> PREEMPT_RT. If I use PREEMPT_DESKTOP, there is no problem. The PREEMPT_DESKTOP setting was the only change between the two tests, all other kernel settings (threaded irq's etc...) were unchanged.
> 
> My tests are performed on 2.6.17-rt1, but the lockups are confirmed for 
> PREEMPT_RT configured kernels 2.6.14 and 2.6.16.
> 
> Some extra information:
> 
> Lee Revell wrote:
> 
> > <...>
> >
> > It seems that the -rt patch changes tasklet_kill:
> >
> > Unpatched 2.6.17:
> >
> > void tasklet_kill(struct tasklet_struct *t)
> > {
> >         if (in_interrupt())
> >                 printk("Attempt to kill tasklet from interrupt\n");
> >
> >         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> >                 do
> >                         yield();

Very bad for -rt kernels.

> >                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
> >         }
> >         tasklet_unlock_wait(t);
> >         clear_bit(TASKLET_STATE_SCHED, &t->state);
> > }
> >
> > 2.6.17-rt:
> >
> > void tasklet_kill(struct tasklet_struct *t)
> > {
> >         if (in_interrupt())
> >                 printk("Attempt to kill tasklet from interrupt\n");
> >
> >         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> >                 do                              msleep(1);
> >                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
> >         }
> >         tasklet_unlock_wait(t);
> >         clear_bit(TASKLET_STATE_SCHED, &t->state);
> > }
> >
> > You should ask Ingo & the other -rt developers what the intent of this
> > change was.  Obviously it loops forever waiting for the state bit to
> > change.

The reason for this is that yield is just evil.  And even more evil for
-rt.  What yield does is this:  Process is waiting for something to
happen that will be done by another running process, and instead of
using a wait queue or some other method, it simply spins with the yield,
to let the other task do it.  But with a rt task, yield will only yield
to other processes with the same priority or higher, so if the process
that it is waiting on is of lower priority, then you will spin forever.

The msleep replacement is just a hack and not really a solution.  It
puts the task to sleep, for one ms, to let other tasks run.  Now, if
there's another task of higher priority spinning someplace else, then
you can still starve the task you are waiting on.

We are probably in tasklet_unlock_wait which is:

static inline void tasklet_unlock_wait(struct tasklet_struct *t)
{
	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
}

Which just looks scary.

Ingo, this looks really bad if the process killing the tasklet, preempts
the tasklet on wake up in the tasklet_kill msleep, and the tasklet state
happens to be TASKLET_STATE_RUN.  Perhaps, we need a msleep_rt which
only sleeps if PREEMPT_RT is defined, and put that in by the barrier.

Lee, can you cause this problem with PREEMPT_DESKTOP with softirq as
threads?

Also, add a msleep(1); by the barrier(); and see if that solves the
problem.

> 
> On Thu, 2006-07-06 at 22:14 +0200, Pieter Palmers wrote:
> 
> > > I've put the debugging printk's into tasklet_kill. One interesting 
> > > remark is that now that they are in place, I had to start/stop jackd 
> > > multiple times before deadlock occurs. Without the printk's the machine 
> > > always locked up on the first pass. However I stopped after the first 
> > > lockup, so maybe this is not really significant.
> > > 
> > > Anyway, the new tasklet_kill looks like this:
> > > 
> > > void tasklet_kill(struct tasklet_struct *t)
> > > {
> > > 	printk("enter tasklet_kill\n");
> > > 	if (in_interrupt())
> > > 		printk("Attempt to kill tasklet from interrupt\n");
> > > 	
> > > 	printk("passed interrupt check\n");
> > > 
> > > 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> > > 		do
> > > 			msleep(1);
> > > 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
> > > 	}
> > > 	printk("passed test_and_set_bit\n");
> > > 	
> > > 	tasklet_unlock_wait(t);
> > > 	printk("passed tasklet_unlock_wait\n");
> > > 	
> > > 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> > > }
> > > 
> > > And the last line printed before lockup is:
> > > "passed test_and_set_bit"
> >   
> This makes the change in tasklet_unlock_wait() as the prime suspect for this problem.

This looks like the case.

-- Steve


