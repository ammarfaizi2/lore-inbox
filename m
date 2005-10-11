Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVJKHve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVJKHve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVJKHve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:51:34 -0400
Received: from [210.76.114.20] ([210.76.114.20]:45486 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751407AbVJKHvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:51:33 -0400
Message-ID: <434B6F0D.4040808@ccoss.com.cn>
Date: Tue, 11 Oct 2005 15:51:41 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Question] Some question about Ingo scheduler.
References: <434732DA.20701@ccoss.com.cn> <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain> <434B1FBD.3000803@ccoss.com.cn> <Pine.LNX.4.58.0510110147370.30989@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510110147370.30989@localhost.localdomain>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt Wrote:

>[added back the LKML since others might learn from this too]
>
>On Tue, 11 Oct 2005, liyu wrote:
>
>  
>
>>For first question, I have a few confused yet.
>>As Steven said, if PREEMPT_ACTIVE is set, we cann't preempt current task,
>>because of
>>we can not wake up it later, however, the process of task switch will
>>save information
>>of the task context to task_struct (also thread_info), why we cann't wake
>>up it?
>>    
>>
>
>First let me corrent that statement.  I said that if PREEMPT_ACTIVE is
>set, we can't take the task off the run queue.  I didn't say we can't
>preempt that task, since that _is_ what is about to happen.
>
>OK I worded it wrong.  I shouldn't say we "can't" wake it up. What I
>should have said is that we may not know to wake it up.  You are right,
>all the information is there to wake it up but the case might happen where
>we just don't know to do it.
>
>Here's some common code to look at.
>
>add_wait_queue(q, wait);
>set_current_state(TASK_UNINTERRUPTIBLE);
>if (!some_event)
>	schedule();
>set_current_state(TASK_RUNNING);
>remove_wait_queue(q, wait);
>
>
>This above code isn't directly from the kernel but the logic of it is all
>over the place.  So the task is going to wait for some event, and when
>that event happens, it will wake up all the tasks that are on the wait
>queue.  Now what happens if the event happened before the
>set_current_state(TASK_UNINTERRUPTIBLE)?  Normally that would be OK
>because of the check to see if some_event happened, and if it did then
>don't call schedule.
>
>Now back to that PREEMPT_ACTIVE check. If the above case happens, and then
>the task is preempted before it set itself back to TASK_RUNNING, without
>the PREEMPT_ACTIVE check in schedule, the process would be removed from
>the task run queue.  That means it is no longer in the queue to be
>scheduled. But the event already happened that would have woken it back
>up.  So this task would forever stay in the TASK_UNINTERRUPTIBLE state and
>never wake up.  The PREEMPT_ACTIVE check is to allow the task to stay on
>the run queue until it gets to a point that itself calls schedule. As the
>above logic might allow (if the event has not happened yet).
>
>So what determines what can be scheduled, is the fact that the task is on
>the run queue, _not_ whether or not the task is in the TASK_RUNNING state.
>At least with preemption enabled.  Not being in TASK_RUNNING will take the
>task off the run queue when that task calls schedule itself, not when it
>is preempted.
>
>Does this make more sense?
>
>-- Steve
>
>
>  
>
Hi, Steve:

    Thanks for so detailed explain.

    It seem I am not understand what is sleep and wakeup truly.

    What's your mean of "in runqueue"? I think you mean the
task_struct is in one priority array (active or expired)
of one queue. the schedule() only can process task in runqueue.
In deactivate_task(), it will reset task_struct->array to NULL,
After call it, we can not wake up that task.

    However, I read try_to_wake_up(), and found it can handle that case
which task_struct->array is NULL, it will be call activate_task()
to insert task to one runqueue. and default_wake_function() will
call try_to_wake_up(), so we still can wake up it.

    I am confused again. this quesion is more interesting and more.

    Wait for reply.

    Good luck.


--liyu
   




