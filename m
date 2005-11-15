Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKOKQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKOKQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVKOKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:16:04 -0500
Received: from [210.76.114.20] ([210.76.114.20]:30168 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932337AbVKOKQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:16:03 -0500
Message-ID: <4379B5EB.40709@ccoss.com.cn>
Date: Tue, 15 Nov 2005 18:18:19 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question]How to restrict some kind of task?
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.

    I want to restrict some kind of task.
   
    For example, for some task have one schedule policy SCHED_XYZ, when 
it reach beyond
40% CPU time, we force it yield CPU.
   
    I inserted some code in scheduler_tick(), like this:

>         if (check_task_overload(rq)) {
>                 if (xyz_task(p) && yield_cpu(p, rq)) {
>                         set_tsk_need_resched(p);
>                         p->prio = effective_prio(p);
>                         p->time_slice = task_timeslice(p);
>                         p->first_time_slice = 0;
>                         goto out_unlock;
>                 }
>         }


    Of course, before these code, we hold our rq->lock first, so we should
go to 'out_unlock'.
    The function xyz_task(p) just is macro (p->policy == SCHED_XYZ), and
yield_cpu() also is simple, it just move the task to expired array,

int yield_cpu(task_t *p, runqueue_t *rq)
{
    dequeue_task(p, p->array);
    requeue_task(p, rq->expired);
    return 1;
}

    These code are so simple, but is make system crash, if I create some
XYZ policy task.
   
    I tried the more radical idea (remove these tasks from runqueue to 
our one
list_head that spin_lock protected), but crash again and again.

    if need, I can paste my global patch.
   
    Thanks in advanced.

-liyu

   
   
 

