Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVJKFpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVJKFpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVJKFpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:45:55 -0400
Received: from [210.76.114.20] ([210.76.114.20]:29612 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751371AbVJKFpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:45:55 -0400
Message-ID: <434B4B60.4050703@ccoss.com.cn>
Date: Tue, 11 Oct 2005 13:19:28 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Some question about Ingo scheduler.
References: <434732DA.20701@ccoss.com.cn> <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt Wrote:

>On Sat, 8 Oct 2005, liyu wrote:
>
>  
>
>>Hi, Everyone on lkml
>>    
>>
>
>Hi Liyu,
>
>  
>
>>    I am read linux scheduler at home in last vacation.
>>
>>    After read , I have some question that want to consult:
>>
>>    1.
>>
>>    In schedule() function, we can find some code like this:
>>
>>
>>        if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
>>                switch_count = &prev->nvcsw;
>>                if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
>>                                unlikely(signal_pending(prev))))
>>                        prev->state = TASK_RUNNING;
>>                else {
>>                        if (prev->state == TASK_UNINTERRUPTIBLE)
>>                                rq->nr_uninterruptible++;
>>                        deactivate_task(prev, rq);
>>                }
>>        }
>>
>>    I think I can understand code in two braces: they want to change
>>status of task which have signal pending when sleep, or remove task
>>that is 'deep sleeping' from ready queue.
>>    but my question is why we do not need such code (in both braces)
>>when preempt is enable?
>>    
>>
>
>I'm sorry I don't quite understand your question, but I can at least
>explain the logic of what is happening.
>
>The first "if" is entered if the prev task is in something other than the
>TASK_RUNNING state (which is zero).  It also has to not have the
>PREEMPT_ACTIVE set.  The next "if" checks to see if the prev task is in
>the TASK_INTERRUPTIBLE state and has a signal pending. Which the
>TASK_INTERRUPTIBLE state allows to be woken up on signals.
>
>If there is no signal or the task is sleeping other than
>TASK_INTERRUPTIBLE then the task is taken off the run queue.
>
>Now the reason for the check against PREEMPT_ACTIVE is very important
>here.  If PREEMPT_ACTIVE is set, then that means that the task was
>preempted by something else and did _not_ call schedule directly. Code
>that usually sets current to something other than TASK_RUNNING usually has
>logic around it to test if it should call schedule and be taken off the
>run queue.  If PREEMPT_ACTIVE is set, then that means you don't know where
>in this logic the task was preempted. If you take it off the run queue
>now, it may not have been in a position to ever wake up. So you don't
>ever want a preemption to take a task off the run queue. Only when the
>task implicitly calls schedule.
>
>  
>
>>    2. in scheduler_tick()
>>
>>    Before split time slice, we should be check some conditions first, these
>>check code is copied here:
>>
>>                /*
>>                 * Prevent a too long timeslice allowing a task to
>>monopolize
>>                 * the CPU. We do this by splitting up the timeslice into
>>                 * smaller pieces.
>>                 *
>>                 * Note: this does not mean the task's timeslices expire or
>>                 * get lost in any way, they just might be preempted by
>>                 * another task of equal priority. (one with higher
>>                 * priority would have preempted this task already.) We
>>                 * requeue this task to the end of the list on this priority
>>                 * level, which is in essence a round-robin of tasks with
>>                 * equal priority.
>>                 *
>>                 * This only applies to tasks in the interactive
>>                 * delta range with at least TIMESLICE_GRANULARITY to
>>requeue.
>>                 */
>>                if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
>>                        p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
>>                        (p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
>>                        (p->array == rq->active)) {
>>
>>
>>                        requeue_task(p, rq->active);
>>                        set_tsk_need_resched(p);
>>                }
>>
>>    My  second question is , what's mean of
>>
>>    (task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY(p)
>>
>>    
>>
>
>Sorry, I'm not about to even think about what Ingo's doing here ;-) I just
>trust Ingo knows what he's doing.
>
>You need to ask Ingo himself.
>
>-- Steve
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

Thanks a lot for your reply first, to Steven especially.

For second question, a my friend reply me, but his reply wrote by chinese.
I try translate them here, they may be not very exactly.

((task_timeslice(p) -  p->time_slice) % TIMESLICE_GRANULARITY(p))

It just is 'preempt-point', the time interval of preempt-point vary by circumstances of task run. 
, IOW, the result of TIMESLICE_GRANULARITY(p) is different at each clock interrput. it have 
related to task-->sleep_avg, SMP and total of CPU.

In general, if HZ equal 100, then

TIMESLICE_GRANULARITY £½ (1~29)*total_of_CPU

In other words, if task is an interactive task, and time slice used is integral times of current preempt
interval (TIMESLICE_GRANULARITY) , and time slice remain is more then preempt interval, it arrive 
the preempt-point, which current task yield CPU, enter one new schedule cycle.


For first question, I have a few confused yet.
As Steven said, if PREEMPT_ACTIVE is set, we cann't preempt current 
task, because of
we can not wake up it later, however, the process of task switch will 
save information
of the task context to task_struct (also thread_info), why we cann't 
wake up it?

