Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVKQGUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVKQGUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 01:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVKQGUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 01:20:40 -0500
Received: from [210.76.114.20] ([210.76.114.20]:56206 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932611AbVKQGUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 01:20:40 -0500
Message-ID: <437C2133.2030103@ccoss.com.cn>
Date: Thu, 17 Nov 2005 14:20:35 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
CC: Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question]How to restrict some kind of task?
References: <4379B5EB.40709@ccoss.com.cn> <200511152121.30107.kernel@kolivas.org> <437A8867.8080809@ccoss.com.cn>
In-Reply-To: <437A8867.8080809@ccoss.com.cn>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu wrote:

> Con Kolivas Wrote:
>
>> On Tue, 15 Nov 2005 21:18, liyu wrote:
>>  
>>
>>> Hi, All.
>>>
>>>    I want to restrict some kind of task.
>>>
>>>    For example, for some task have one schedule policy SCHED_XYZ, when
>>> it reach beyond
>>> 40% CPU time, we force it yield CPU.
>>>
>>>    I inserted some code in scheduler_tick(), like this:
>>>   
>>>
>>>>        if (check_task_overload(rq)) {
>>>>                if (xyz_task(p) && yield_cpu(p, rq)) {
>>>>                        set_tsk_need_resched(p);
>>>>                        p->prio = effective_prio(p);
>>>>                        p->time_slice = task_timeslice(p);
>>>>                        p->first_time_slice = 0;
>>>>                        goto out_unlock;
>>>>                }
>>>>        }
>>>>     
>>>
>>>    Of course, before these code, we hold our rq->lock first, so we 
>>> should
>>> go to 'out_unlock'.
>>>    The function xyz_task(p) just is macro (p->policy == SCHED_XYZ), and
>>> yield_cpu() also is simple, it just move the task to expired array,
>>>
>>> int yield_cpu(task_t *p, runqueue_t *rq)
>>> {
>>>    dequeue_task(p, p->array);
>>>    requeue_task(p, rq->expired);
>>>    return 1;
>>> }
>>>   
>>
>>
>> Don't requeue after dequeue. You enqueue after dequeue.
>>
>> Con
>>
>>
>>  
>>
> Thanks Con first.
>
> I am sorry that is a my typo. if we wrote requeue_task() after 
> dequeue_task(), we will crash
> beacause remove task from prio_array twice.
>
> The last of this mail is my patch. You will find it is similar to 
> SCHED_ISO of the your CK patch,
> However, this is more radicaler than SCHED_ISO.
>
> I am gonna crazy for it.
>
> Thanks.
>
>
> PATCH:
>
> --- linux-2.6.13.3/kernel/sched.c    2005-11-16 08:57:56.000000000 +0800
> +++ linux-2.6.13.3.keep/kernel/sched.c    2005-11-15 
> 15:21:47.000000000 +0800
> @@ -51,6 +51,21 @@
>
> #include <asm/unistd.h>
>
> +/* liyu@ccoss.com.cn */
> +int keep_tick;
> +int keep_over;
> +int keep_dbg;
> +int keep_switch = 3*HZ; /* sysctl var */
> +#define PF_KEEPOVER    0x01000000
> +#define PF_NONREGU      (PF_EXITING|PF_DEAD|PF_DUMPCORE)
> +#define KEEP_TEST_PERIOD (keep_switch)
> +#define KEEP_LOAD_CFG (40)
> +#define KEEP_LOAD_STD (KEEP_TEST_PERIOD*KEEP_LOAD_CFG/100)
> +#define KEEP_LOAD_DELTA  (KEEP_TEST_PERIOD*5/100)
> +#define KEEP_LOAD_TOP  (KEEP_LOAD_STD)
> +#define KEEP_LOAD_BTM  (KEEP_LOAD_STD-KEEP_LOAD_DELTA)
> +/* enda */
> +
> /*
>  * Convert user-nice values [ -20 ... 0 ... 19 ]
>  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
> @@ -256,6 +271,12 @@
>     unsigned long ttwu_cnt;
>     unsigned long ttwu_local;
> #endif
> +  /* liyu@ccoss.com.cn */
> +  int keep_tick;
> +  int keep_over;
> +  spinlock_t keep_lock;
> +  struct list_head keep;
> +  /* enda */
> };
>
> static DEFINE_PER_CPU(struct runqueue, runqueues);
> @@ -592,6 +613,10 @@
>  */
> static void dequeue_task(struct task_struct *p, prio_array_t *array)
> {
> +/* liyu@ccoss.com.cn */
> +    if (p->flags & PF_KEEPOVER)
> +        return;
> +/* enda */
>     array->nr_active--;
>     list_del(&p->run_list);
>     if (list_empty(array->queue + p->prio))
> @@ -600,6 +625,10 @@
>
> static void enqueue_task(struct task_struct *p, prio_array_t *array)
> {
> +    /* liyu@ccoss.com.cn */
> +    if (p->flags & PF_KEEPOVER)
> +        return;
> +    /* enda */
>     sched_info_queued(p);
>     list_add_tail(&p->run_list, array->queue + p->prio);
>     __set_bit(p->prio, array->bitmap);
> @@ -613,6 +642,10 @@
>  */
> static void requeue_task(struct task_struct *p, prio_array_t *array)
> {
> +    /* liyu@ccoss.com.cn */
> +    if (p->flags & PF_KEEPOVER)
> +        return;
> +    /* enda */
>     list_move_tail(&p->run_list, array->queue + p->prio);
> }
>
> @@ -2474,6 +2507,61 @@
>         cpustat->steal = cputime64_add(cpustat->steal, tmp);
> }
>
> +/* liyu@ccoss.com.cn */
> +static int
> +keep_check_overload(runqueue_t *rq)
> +{
> +    if (rq->keep_tick > KEEP_LOAD_TOP)
> +        rq->keep_over = 1;
> +    else if (rq->keep_over && rq->keep_tick<KEEP_LOAD_BTM)
> +        rq->keep_over = 0;
> +    keep_tick = rq->keep_tick; /* sysctl var for debug, but only work 
> on UP */
> +    keep_over = rq->keep_over; /* like above */
> +    return rq->keep_over;
> +}
> +
> +static int
> +enqueue_keep(struct task_struct *p, runqueue_t *rq)
> +{
> +    unsigned long flags;
> +
> +    spin_lock_irqsave(&rq->keep_lock, flags);
> +    if (p->flags & (PF_KEEPOVER|PF_NONREGU)) {
> +        spin_unlock_irqrestore(&rq->keep_lock, flags);
> +        return 0;
> +    }
> +    if (p->array)
> +        deactivate_task(p, rq);
> +    list_add(&p->run_list, &rq->keep);
> +    p->flags |= PF_KEEPOVER;
> +    spin_unlock_irqrestore(&rq->keep_lock, flags);
> +    return 1;
> +}
> +
> +static void
> +clear_keep(runqueue_t *rq)
> +{
> +    struct task_struct *p;
> +    unsigned long flags;
> +
> +    spin_lock_irqsave(&rq->keep_lock, flags);
> +    while (!list_empty(&rq->keep)) {
> +        p = list_entry(rq->keep.next, struct task_struct, run_list);
> +        if (p->flags & PF_KEEPOVER) {
> +            list_del(&p->run_list);
> +            p->state = TASK_RUNNING;
> +            p->flags &= (~PF_KEEPOVER);
> +             __activate_task(p, rq);
> +        } else {
> +                show_stack(p, NULL);
> +              panic(KERN_ALERT"dq normal-task%d. ", p->pid);
> +        }
> +    }       +    spin_unlock_irqrestore(&rq->keep_lock, flags);
> +}
> +
> +/* enda */
> +
> /*
>  * This function gets called by the timer code, with HZ frequency.
>  * We call it with interrupts disabled.
> @@ -2492,6 +2580,22 @@
>
>     rq->timestamp_last_tick = now;
>
> +    /* liyu@ccoss.com.cn */
> +    if (in_interrupt()) {
> +        if (keep_task(p)) {
> +            if ( ++rq->keep_tick>KEEP_TEST_PERIOD )
> +                rq->keep_tick = KEEP_TEST_PERIOD;
> +        }
> +        else if (!--rq->keep_tick) {
> +            rq->keep_tick = 1;
> +        }
> +        spin_lock(&rq->lock);
> +        if ( !keep_check_overload(rq) )
> +            clear_keep(rq);
> +        spin_unlock(&rq->lock);
> +    }
> +    /* enda */
> +
>     if (p == rq->idle) {
>         if (wake_priority_sleeper(rq))
>             goto out;
> @@ -2527,6 +2631,19 @@
>         }
>         goto out_unlock;
>     }
> +
> +    /* liyu@ccoss.com.cn */
> +    if (keep_check_overload(rq)) {
> +        if (keep_task(p) && enqueue_keep(p, rq)) {
> +            set_tsk_need_resched(p);
> +            p->prio = effective_prio(p);
> +            p->time_slice = task_timeslice(p);
> +            p->first_time_slice = 0;
> +            goto out_unlock;
> +        }   +    }
> +    /* enda */
> +
>     if (!--p->time_slice) {
>         dequeue_task(p, rq->active);
>         set_tsk_need_resched(p);
> @@ -2859,6 +2976,7 @@
>         rq->expired_timestamp = 0;
>         rq->best_expired_prio = MAX_PRIO;
>     }
> +  
>     idx = sched_find_first_bit(array->bitmap);
>     queue = array->queue + idx;
> @@ -3485,10 +3603,20 @@
>     BUG_ON(p->array);
>     p->policy = policy;
>     p->rt_priority = prio;
> -    if (policy != SCHED_NORMAL)
> -        p->prio = MAX_RT_PRIO-1 - p->rt_priority;
> -    else
> -        p->prio = p->static_prio;
> +    /* liyu@ccoss.com.cn */
> +/*     if (policy != SCHED_NORMAL) */
> +/*         p->prio = MAX_RT_PRIO-1 - p->rt_priority; */
> +/*     else */
> +/*         p->prio = p->static_prio; */
> +    switch (policy) {
> +    case SCHED_RR:
> +    case SCHED_FIFO:
> +      p->prio = MAX_RT_PRIO-1 - p->rt_priority;
> +      break;
> +    default:
> +      p->prio = p->static_prio;
> +    };
> +    /* endm */
> }
>
> /**
> @@ -3510,9 +3638,12 @@
>     /* double check policy once rq lock held */
>     if (policy < 0)
>         policy = oldpolicy = p->policy;
> -    else if (policy != SCHED_FIFO && policy != SCHED_RR &&
> -                policy != SCHED_NORMAL)
> -            return -EINVAL;
> +    /* liyu@ccoss.com.cn */
> +     else if (policy != SCHED_FIFO && policy != SCHED_RR &&
> +         policy != SCHED_NORMAL && policy != SCHED_KEEP)
> +             return -EINVAL;
> +    /* endm */
> +
>     /*
>      * Valid priorities for SCHED_FIFO and SCHED_RR are
>      * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
> @@ -3521,17 +3652,30 @@
>         (p->mm &&  param->sched_priority > MAX_USER_RT_PRIO-1) ||
>         (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
>         return -EINVAL;
> -    if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
> +    /* liyu@ccoss.com.cn */
> +    //    if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
> +    //        return -EINVAL;
> +    if ((policy == SCHED_NORMAL) != (param->sched_priority == 0)) {
> +      if ((policy == SCHED_KEEP) != (param->sched_priority == 0))
> +        return -EINVAL;
> +    }
> +    if (policy==SCHED_KEEP && !p->mm)
>         return -EINVAL;
> -
> +    /* endm */
>     /*
>      * Allow unprivileged RT tasks to decrease priority:
>      */
>     if (!capable(CAP_SYS_NICE)) {
>         /* can't change policy */
>         if (policy != p->policy &&
> -            !p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
> -            return -EPERM;
> +            !p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
> +          /* liyu@ccoss.com.cn */
> +          //return -EPERM;
> +          {
> +            if (policy != SCHED_KEEP)
> +              return -EPERM;
> +          }
> +        /* endm */
>         /* can't increase priority */
>         if (policy != SCHED_NORMAL &&
>             param->sched_priority > p->rt_priority &&
> @@ -5184,7 +5328,12 @@
>         INIT_LIST_HEAD(&rq->migration_queue);
> #endif
>         atomic_set(&rq->nr_iowait, 0);
> -
> +        /* liyu@ccoss.com.cn */
> +        rq->keep_lock = SPIN_LOCK_UNLOCKED;
> +        INIT_LIST_HEAD(&rq->keep);
> +        rq->keep_tick = 1;
> +        rq->keep_over = 0;
> +        /* enda */           for (j = 0; j < 2; j++) {
>             array = rq->arrays + j;
>             for (k = 0; k < MAX_PRIO; k++) {
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
I fixed it. we should insert code start of enqueue_task():

static void enqueue_task(struct task_struct *p, prio_array_t *array)
{
             unsigned long flags;
   
             spin_lock_irqsave(&(task_rq(p)->keep_lock), flags);
             if (p->flags & PF_KEEPOVER) {
                     list_del(&p->run_list);
                     p->state = TASK_RUNNING;
                     p->flags &= ~PF_KEEPOVER;
             }
             spin_unlock_irqrestore(&(task_rq(p)->keep_lock), flags);

....
}
However, this patch still have problem, it may lock entire system.

I am trying to catch this bug~.

-Liyu
