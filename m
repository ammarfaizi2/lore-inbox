Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVCCWpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVCCWpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCCWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:42:18 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:9959 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S262678AbVCCWcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:32:31 -0500
Date: Thu, 3 Mar 2005 23:32:09 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, deactivate() scheduling issue
In-Reply-To: <42276746.6060600@ru.mvista.com>
Message-Id: <Pine.OSF.4.05.10503032311510.22011-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.599 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I read the code the driver task (A) should _not_ be removed from the
runqueue. It has to be waken up to call schedule_timeout() such it gets
back on the runqueue after 10 ms. If it is taken out of the runqueue at
line 76 it will stay off the runqueue forever in the TASK_UNINTERRUBTIBLE
state!

As I read the use PREEMPT_ACTIVE, it is there to test on wether this
rescheduling is volentery or forced (a preemption). If it is forced the
task shall ofcourse not go off the runqueue but stay there to run again
when it gets the highest priority. That is why PREEMPT_ACTIVE is set in
preempt_schedule() and preempt_schedule_irq(). On the other hand if the
task itself has called schedule() or schedule_timeout() it has to go out
of the runqueue and wait for some event to wake it up.

Yes there will be tasks in state other that TASK_RUNNING on the runqueue.
The "bug" as I see it is in the scheduler interface: There is no way to
set the task state and call schedule() or schedule_timeout() atomicly.
Therefore you can be preempted while the state is not TASK_RUNNING.

Esben


On Thu, 3 Mar 2005, Eugeny S. Mints wrote:

> please consider the following scenario for full RT kernel.
> 
> Task A is running then an irq is occured which in turn wakes up irq 
> related thread (B) of a higher priority than A.
> 
> my current understanding that actual context switch between A and B will 
> occure at preempt_schedule_irq() on the "return form irq " path.
> 
> in this case the following "if" statement in __schedule() always returns 
> false since  preempt_schedule_irq() always sets up  PREEMPT_ACTIVE 
> before __schedule() call.
> 
>          if ((prev->state & ~TASK_RUNNING_MUTEX) &&
>                          !(preempt_count() & PREEMPT_ACTIVE)) {
> 
> as result the deactivate() is never called for preempted task A in this 
> scenario. BUt if the task A is preempted while not in TASK_RUNNING state 
> such behaviour seems incorrect since we get a task in not TASK_RUNNING 
> state linked into a run queue.
> 
> An example:
> 
> drivers/net/irda/sir_dev.c: 76 (2.6.10 kernel)
> 
>          spin_lock_irqsave(&dev->tx_lock, flags); /* serialize th other 
> tx operations */
>          while (dev->tx_buff.len > 0) {    /* wait until tx idle */
>                  spin_unlock_irqrestore(&dev->tx_lock, flags);
> 76:             set_current_state(TASK_UNINTERRUPTIBLE);
>                  schedule_timeout(msecs_to_jiffies(10));
>                  spin_lock_irqsave(&dev->tx_lock, flags);
>          }
> 
> At  line 76 irqs are enabled, preemption is enabled.
> Let assume the task A executes this code and gets preempted right after 
> line 76. Task state is TASK_UNINTERRUPTIBLE but it will not be 
> deactevated. Of cource this is the bug in set_current_state() 
> utilization in this particular driver but schedule stuff should be 
> robust to such bugs I believe. There are a lot such bugs in the kernel I 
> believe.
> 
> Not sure what the actual reason for !(preempt_count() & PREEMPT_ACTIVE)) 
>    condition is but if it's just a sort of optimization (not remove a 
> task from run queue if it was preemped in TASK_RUNNING state) then 
> probably it should be removed in order to save correctness. Patch attached.
> 
> 	Eugeny
> 
> 

