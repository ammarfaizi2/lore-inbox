Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGHPR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGHPR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGHPR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:17:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1736 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964818AbWGHPR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:17:56 -0400
Subject: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394
	audio
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Pieter Palmers <pieterp@joow.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 11:18:42 -0400
Message-Id: <1152371924.4736.169.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pieter has found this bug in -rt:

We are experiencing 'soft' deadlocks when running our code (Freebob, 
i.e. userspace lib for firewire audio) on RT kernels. After a few 
seconds of system freeze, I get a kernel panic message that signals a soft lockup.

I've uploaded the photo's of the panic here:
http://freebob.sourceforge.net/old/img_3378.jpg (without flash)
http://freebob.sourceforge.net/old/img_3377.jpg (with flash)
both are of suboptimal quality unfortunately, but all info is readable 
on one or the other.

The problems occur when an ISO stream (receive and/or transmit) is shut 
down in a SCHED_FIFO thread. More precisely when running the freebob 
jackd backend in real-time mode. And even more precise: they only seem 
to occur when jackd is shut down. There are no problems when jackd is 
started without RT scheduling.

I havent been able to reproduce this with other test programs that are 
shutting down streams in a SCHED_FIFO thread.

The problem is not reproducible on non-RT kernels, and it only occurs on those configured for 
PREEMPT_RT. If I use PREEMPT_DESKTOP, there is no problem. The PREEMPT_DESKTOP setting was the only change between the two tests, all other kernel settings (threaded irq's etc...) were unchanged.

My tests are performed on 2.6.17-rt1, but the lockups are confirmed for 
PREEMPT_RT configured kernels 2.6.14 and 2.6.16.

Some extra information:

Lee Revell wrote:

> <...>
>
> It seems that the -rt patch changes tasklet_kill:
>
> Unpatched 2.6.17:
>
> void tasklet_kill(struct tasklet_struct *t)
> {
>         if (in_interrupt())
>                 printk("Attempt to kill tasklet from interrupt\n");
>
>         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>                 do
>                         yield();
>                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
>         }
>         tasklet_unlock_wait(t);
>         clear_bit(TASKLET_STATE_SCHED, &t->state);
> }
>
> 2.6.17-rt:
>
> void tasklet_kill(struct tasklet_struct *t)
> {
>         if (in_interrupt())
>                 printk("Attempt to kill tasklet from interrupt\n");
>
>         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>                 do                              msleep(1);
>                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
>         }
>         tasklet_unlock_wait(t);
>         clear_bit(TASKLET_STATE_SCHED, &t->state);
> }
>
> You should ask Ingo & the other -rt developers what the intent of this
> change was.  Obviously it loops forever waiting for the state bit to
> change.

On Thu, 2006-07-06 at 22:14 +0200, Pieter Palmers wrote:

> > I've put the debugging printk's into tasklet_kill. One interesting 
> > remark is that now that they are in place, I had to start/stop jackd 
> > multiple times before deadlock occurs. Without the printk's the machine 
> > always locked up on the first pass. However I stopped after the first 
> > lockup, so maybe this is not really significant.
> > 
> > Anyway, the new tasklet_kill looks like this:
> > 
> > void tasklet_kill(struct tasklet_struct *t)
> > {
> > 	printk("enter tasklet_kill\n");
> > 	if (in_interrupt())
> > 		printk("Attempt to kill tasklet from interrupt\n");
> > 	
> > 	printk("passed interrupt check\n");
> > 
> > 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> > 		do
> > 			msleep(1);
> > 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
> > 	}
> > 	printk("passed test_and_set_bit\n");
> > 	
> > 	tasklet_unlock_wait(t);
> > 	printk("passed tasklet_unlock_wait\n");
> > 	
> > 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> > }
> > 
> > And the last line printed before lockup is:
> > "passed test_and_set_bit"
>   
This makes the change in tasklet_unlock_wait() as the prime suspect for this problem.






