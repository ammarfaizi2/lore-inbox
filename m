Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVCDMUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVCDMUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVCDMTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:19:00 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:26018 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261342AbVCDLsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:48:19 -0500
Message-ID: <42284CDB.5010309@ru.mvista.com>
Date: Fri, 04 Mar 2005 14:56:11 +0300
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, deactivate() scheduling issue
References: <Pine.OSF.4.05.10503032311510.22011-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10503032311510.22011-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> As I read the code the driver task (A) should _not_ be removed from the
> runqueue. It has to be waken up to call schedule_timeout() such it gets
> back on the runqueue after 10 ms. If it is taken out of the runqueue at
> line 76 it will stay off the runqueue forever in the TASK_UNINTERRUBTIBLE
> state!
Exactly. This is definilty the bug in the driver code - a developer just
didn;t care about proper utilization of set_current_state(). The driver 
works
just because as you have described - his fortune
that scheduler doesn't remove task in not TASK_RUNNING state from a run 
queue.
And my main question was - does everybody think it's ok have task in not 
TASK_RUNNING state in run queue. My current feeling is that this should 
not be allowed.
> As I read the use PREEMPT_ACTIVE, it is there to test on wether this
> rescheduling is volentery or forced (a preemption). If it is forced the
> task shall ofcourse not go off the runqueue but stay there to run again
> when it gets the highest priority. That is why PREEMPT_ACTIVE is set in
> preempt_schedule() and preempt_schedule_irq(). On the other hand if the
> task itself has called schedule() or schedule_timeout() it has to go out
> of the runqueue and wait for some event to wake it up.
You right - it works perfectly - but not for  my test case - I believe 
task in not TASK_RUNNING state should be removed from a run queue by the 
first (any - volontery or forced) execution of the schedule() which 
detects the task state is not TASK_RUNNIG.
> 
> Yes there will be tasks in state other that TASK_RUNNING on the runqueue.
> The "bug" as I see it is in the scheduler interface: There is no way to
> set the task state and call schedule() or schedule_timeout() atomicly.
> Therefore you can be preempted while the state is not TASK_RUNNING.
Exactly. IMO this interface is weird and needs rework. I don;t undestand 
what the reason to set task state before schedule_timeout() call but not 
inside, right before the schedule(). The actual task state may be passed 
as a parameter.

As to tasks in not TASK_RUNNING state into a run queue - I always 
believe the definition of a run queue is - queue of tasks ready to run, 
i.e. in TASK_RUNNING state.
	
	Eugeny
> 
> Esben
> 
> 
> On Thu, 3 Mar 2005, Eugeny S. Mints wrote:
> 
> 
>>please consider the following scenario for full RT kernel.
>>
>>Task A is running then an irq is occured which in turn wakes up irq 
>>related thread (B) of a higher priority than A.
>>
>>my current understanding that actual context switch between A and B will 
>>occure at preempt_schedule_irq() on the "return form irq " path.
>>
>>in this case the following "if" statement in __schedule() always returns 
>>false since  preempt_schedule_irq() always sets up  PREEMPT_ACTIVE 
>>before __schedule() call.
>>
>>         if ((prev->state & ~TASK_RUNNING_MUTEX) &&
>>                         !(preempt_count() & PREEMPT_ACTIVE)) {
>>
>>as result the deactivate() is never called for preempted task A in this 
>>scenario. BUt if the task A is preempted while not in TASK_RUNNING state 
>>such behaviour seems incorrect since we get a task in not TASK_RUNNING 
>>state linked into a run queue.
>>
>>An example:
>>
>>drivers/net/irda/sir_dev.c: 76 (2.6.10 kernel)
>>
>>         spin_lock_irqsave(&dev->tx_lock, flags); /* serialize th other 
>>tx operations */
>>         while (dev->tx_buff.len > 0) {    /* wait until tx idle */
>>                 spin_unlock_irqrestore(&dev->tx_lock, flags);
>>76:             set_current_state(TASK_UNINTERRUPTIBLE);
>>                 schedule_timeout(msecs_to_jiffies(10));
>>                 spin_lock_irqsave(&dev->tx_lock, flags);
>>         }
>>
>>At  line 76 irqs are enabled, preemption is enabled.
>>Let assume the task A executes this code and gets preempted right after 
>>line 76. Task state is TASK_UNINTERRUPTIBLE but it will not be 
>>deactevated. Of cource this is the bug in set_current_state() 
>>utilization in this particular driver but schedule stuff should be 
>>robust to such bugs I believe. There are a lot such bugs in the kernel I 
>>believe.
>>
>>Not sure what the actual reason for !(preempt_count() & PREEMPT_ACTIVE)) 
>>   condition is but if it's just a sort of optimization (not remove a 
>>task from run queue if it was preemped in TASK_RUNNING state) then 
>>probably it should be removed in order to save correctness. Patch attached.
>>
>>	Eugeny
>>
>>
> 
> 
> 
> 


