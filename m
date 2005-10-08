Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVJHCqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVJHCqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVJHCqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 22:46:11 -0400
Received: from [210.76.114.20] ([210.76.114.20]:24005 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932130AbVJHCqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 22:46:09 -0400
Message-ID: <434732DA.20701@ccoss.com.cn>
Date: Sat, 08 Oct 2005 10:45:46 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] Some question about Ingo scheduler.
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Everyone on lkml

    I am read linux scheduler at home in last vacation.

    After read , I have some question that want to consult:

    1.

    In schedule() function, we can find some code like this:

   
        if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
                switch_count = &prev->nvcsw;
                if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
                                unlikely(signal_pending(prev))))
                        prev->state = TASK_RUNNING;
                else {
                        if (prev->state == TASK_UNINTERRUPTIBLE)
                                rq->nr_uninterruptible++;
                        deactivate_task(prev, rq);
                }
        }

    I think I can understand code in two braces: they want to change
status of task which have signal pending when sleep, or remove task
that is 'deep sleeping' from ready queue.
    but my question is why we do not need such code (in both braces)
when preempt is enable?

   
    2. in scheduler_tick()

    Before split time slice, we should be check some conditions first, these
check code is copied here:

                /*
                 * Prevent a too long timeslice allowing a task to 
monopolize
                 * the CPU. We do this by splitting up the timeslice into
                 * smaller pieces.
                 *
                 * Note: this does not mean the task's timeslices expire or
                 * get lost in any way, they just might be preempted by
                 * another task of equal priority. (one with higher
                 * priority would have preempted this task already.) We
                 * requeue this task to the end of the list on this priority
                 * level, which is in essence a round-robin of tasks with
                 * equal priority.
                 *
                 * This only applies to tasks in the interactive
                 * delta range with at least TIMESLICE_GRANULARITY to 
requeue.
                 */
                if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
                        p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
                        (p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
                        (p->array == rq->active)) {
                                                                                                   

                        requeue_task(p, rq->active);
                        set_tsk_need_resched(p);
                }

    My  second question is , what's mean of

    (task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY(p)

    ??

   
Thanks in advanced.

sailor


