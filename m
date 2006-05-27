Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWE0HEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWE0HEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWE0HEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:04:04 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:40897 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751432AbWE0HEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:04:02 -0400
Message-ID: <4477F9DC.8090107@bigpond.net.au>
Date: Sat, 27 May 2006 17:03:56 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest> <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>
In-Reply-To: <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 07:03:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On 5/26/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
> <snip>
>>
>> Notes:
>>
>> 1. To minimize the overhead incurred when testing to skip caps 
>> processing for
>> uncapped tasks a new flag PF_HAS_CAP has been added to flags.
>>
>> 2. The implementation involves the addition of two priority slots to the
>> run queue priority arrays and this means that MAX_PRIO no longer
>> represents the scheduling priority of the idle process and can't be 
>> used to
>> test whether priority values are in the valid range.  To alleviate this
>> problem a new function sched_idle_prio() has been provided.
> 
> I am a little confused by this. Why link the bandwidth expired tasks a
> cpu (its caps) to a priority slot? Is this a hack to conitnue using
> the prio_array? why not move such tasks to the expired array?

Because it won't work as after the array switch they may get to run 
before tasks who aren't exceeding their cap (or don't have a cap).

> 
> <snip>
>>  /*
>>   * Some day this will be a full-fledged user tracking system..
>>   */
>> @@ -787,6 +793,10 @@ struct task_struct {
>>         unsigned long sleep_avg;
>>         unsigned long long timestamp, last_ran;
>>         unsigned long long sched_time; /* sched_clock time spent 
>> running */
>> +#ifdef CONFIG_CPU_RATE_CAPS
>> +       unsigned long long avg_cpu_per_cycle, avg_cycle_length;
>> +       unsigned int cpu_rate_cap;
>> +#endif
> 
> How is a cycle defined?

 From one "on CPU" to the next.

> What are the units of a cycle?

Well since sched_clock() is used they are obviously nanoseconds 
multiplied by 2 to the power of CAP_STATS_OFFSET.  But it's fairly 
irrelevant as we're only interested in their ratio and that's dimensionless.

> Could we please
> document the units for the declarations above

No.

> 
>>         enum sleep_type sleep_type;
>>
>>         unsigned long policy;
>> @@ -981,6 +991,11 @@ struct task_struct {
>>  #endif
>>  };
>>
>> +#ifdef CONFIG_CPU_RATE_CAPS
>> +unsigned int get_cpu_rate_cap(const struct task_struct *);
>> +int set_cpu_rate_cap(struct task_struct *, unsigned int);
>> +#endif
>> +
>>  static inline pid_t process_group(struct task_struct *tsk)
>>  {
>>         return tsk->signal->pgrp;
>> @@ -1040,6 +1055,7 @@ static inline void put_task_struct(struc
>>  #define PF_SPREAD_SLAB 0x08000000      /* Spread some slab caches 
>> over cpuset */
>>  #define PF_MEMPOLICY   0x10000000      /* Non-default NUMA mempolicy */
>>  #define PF_MUTEX_TESTER        0x02000000      /* Thread belongs to 
>> the rt mutex tester */
>> +#define PF_HAS_CAP     0x20000000      /* Has a CPU rate cap */
>>
>>  /*
>>   * Only the _current_ task can read/write to tsk->flags, but other
>> Index: MM-2.6.17-rc4-mm3/init/Kconfig
>> ===================================================================
>> --- MM-2.6.17-rc4-mm3.orig/init/Kconfig 2006-05-26 10:39:59.000000000 
>> +1000
>> +++ MM-2.6.17-rc4-mm3/init/Kconfig      2006-05-26 10:45:26.000000000 
>> +1000
>> @@ -286,6 +286,8 @@ config RELAY
>>
>>           If unsure, say N.
>>
>> +source "kernel/Kconfig.caps"
>> +
>>  source "usr/Kconfig"
>>
>>  config UID16
>> Index: MM-2.6.17-rc4-mm3/kernel/Kconfig.caps
>> ===================================================================
>> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
>> +++ MM-2.6.17-rc4-mm3/kernel/Kconfig.caps       2006-05-26 
>> 10:45:26.000000000 +1000
>> @@ -0,0 +1,13 @@
>> +#
>> +# CPU Rate Caps Configuration
>> +#
>> +
>> +config CPU_RATE_CAPS
>> +       bool "Support (soft) CPU rate caps"
>> +       default n
>> +       ---help---
>> +         Say y here if you wish to be able to put a (soft) upper 
>> limit on
>> +         the rate of CPU usage by individual tasks.  A task which has 
>> been
>> +         allocated a soft CPU rate cap will be limited to that rate 
>> of CPU
>> +         usage unless there is spare CPU resources available after 
>> the needs
>> +         of uncapped tasks are met.
>> Index: MM-2.6.17-rc4-mm3/kernel/sched.c
>> ===================================================================
>> --- MM-2.6.17-rc4-mm3.orig/kernel/sched.c       2006-05-26 
>> 10:44:51.000000000 +1000
>> +++ MM-2.6.17-rc4-mm3/kernel/sched.c    2006-05-26 11:00:02.000000000 
>> +1000
>> @@ -57,6 +57,19 @@
>>
>>  #include <asm/unistd.h>
>>
>> +#ifdef CONFIG_CPU_RATE_CAPS
>> +#define IDLE_PRIO      (MAX_PRIO + 2)
>> +#else
>> +#define IDLE_PRIO      MAX_PRIO
>> +#endif
>> +#define BGND_PRIO      (IDLE_PRIO - 1)
>> +#define CAPPED_PRIO    (IDLE_PRIO - 2)
>> +
>> +int sched_idle_prio(void)
>> +{
>> +       return IDLE_PRIO;
>> +}
>> +
>>  /*
>>   * Convert user-nice values [ -20 ... 0 ... 19 ]
>>   * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
>> @@ -186,6 +199,149 @@ static inline unsigned int task_timeslic
>>         return static_prio_timeslice(p->static_prio);
>>  }
>>
>> +#ifdef CONFIG_CPU_RATE_CAPS
>> +#define CAP_STATS_OFFSET 8
>> +#define task_has_cap(p) unlikely((p)->flags & PF_HAS_CAP)
>> +/* this assumes that p is not a real time task */
>> +#define task_is_background(p) unlikely((p)->cpu_rate_cap == 0)
>> +#define task_being_capped(p) unlikely((p)->prio >= CAPPED_PRIO)
>> +#define cap_load_weight(p) (((p)->cpu_rate_cap * SCHED_LOAD_SCALE) / 
>> 1000)
> 
> Could we please use a const or #define'd name instead of 1000. How
> about TOTAL_CAP_IN_PARTS? It would make the code easier to read and
> maintain.
> 
>> +
>> +static void init_cpu_rate_caps(task_t *p)
>> +{
>> +       p->cpu_rate_cap = 1000;
>> +       p->flags &= ~PF_HAS_CAP;
>> +}
>> +
>> +static inline void set_cap_flag(task_t *p)
>> +{
>> +       if (p->cpu_rate_cap < 1000 && !has_rt_policy(p))
>> +               p->flags |= PF_HAS_CAP;
>> +       else
>> +               p->flags &= ~PF_HAS_CAP;
>> +}
> 
> Why don't you re-use RLIMIT_INFINITY?

I presume that it means something else.

> 
>> +
>> +static inline int task_exceeding_cap(const task_t *p)
>> +{
>> +       return (p->avg_cpu_per_cycle * 1000) > (p->avg_cycle_length * 
>> p->cpu_rate_cap);
>> +}
>> +
>> +#ifdef CONFIG_SCHED_SMT
>> +static unsigned int smt_timeslice(task_t *p)
>> +{
>> +       if (task_has_cap(p) && task_being_capped(p))
>> +               return 0;
>> +
>> +       return task_timeslice(p);
>> +}
>> +
>> +static int task_priority_gt(const task_t *thisp, const task_t *thatp)
>> +{
>> +       if (task_has_cap(thisp) && (task_being_capped(thisp)))
>> +           return 0;
>> +
>> +       if (task_has_cap(thatp) && (task_being_capped(thatp)))
>> +           return 1;
>> +
>> +       return thisp->static_prio < thatp->static_prio;
>> +}
> 
> This function needs some comments. At least with respect to what is
> thisp and thatp

gt means "greater than" (as any Fortran programmer knows :-)) and is 
sufficient documentation.

> 
>> +#endif
>> +
>> +/*
>> + * Update usage stats to "now" before making comparison
>> + * Assume: task is actually on a CPU
>> + */
>> +static int task_exceeding_cap_now(const task_t *p, unsigned long long 
>> now)
>> +{
>> +       unsigned long long delta, lhs, rhs;
>> +
>> +       delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
>> +       lhs = (p->avg_cpu_per_cycle + delta) * 1000;
>> +       rhs = (p->avg_cycle_length + delta) * p->cpu_rate_cap;
>> +
>> +       return lhs > rhs;
>> +}
>> +
>> +static inline void init_cap_stats(task_t *p)
>> +{
>> +       p->avg_cpu_per_cycle = 0;
>> +       p->avg_cycle_length = 0;
>> +}
>> +
>> +static inline void inc_cap_stats_cycle(task_t *p, unsigned long long 
>> now)
>> +{
>> +       unsigned long long delta;
>> +
>> +       delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
>> +       p->avg_cycle_length += delta;
>> +}
>> +
>> +static inline void inc_cap_stats_both(task_t *p, unsigned long long now)
>> +{
>> +       unsigned long long delta;
>> +
>> +       delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
>> +       p->avg_cycle_length += delta;
>> +       p->avg_cpu_per_cycle += delta;
>> +}
>> +
>> +static inline void decay_cap_stats(task_t *p)
>> +{
>> +       p->avg_cycle_length *= ((1 << CAP_STATS_OFFSET) - 1);
>> +       p->avg_cycle_length >>= CAP_STATS_OFFSET;
>> +       p->avg_cpu_per_cycle *= ((1 << CAP_STATS_OFFSET) - 1);
>> +       p->avg_cpu_per_cycle >>= CAP_STATS_OFFSET;
>> +}
>> +#else
>> +#define task_has_cap(p) 0
>> +#define task_is_background(p) 0
>> +#define task_being_capped(p) 0
>> +#define cap_load_weight(p) SCHED_LOAD_SCALE
>> +
>> +static inline void init_cpu_rate_caps(task_t *p)
>> +{
>> +}
>> +
>> +static inline void set_cap_flag(task_t *p)
>> +{
>> +}
>> +
>> +static inline int task_exceeding_cap(const task_t *p)
>> +{
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_SCHED_SMT
>> +#define smt_timeslice(p) task_timeslice(p)
>> +
>> +static inline int task_priority_gt(const task_t *thisp, const task_t 
>> *thatp)
>> +{
>> +       return thisp->static_prio < thatp->static_prio;
>> +}
>> +#endif
>> +
>> +static inline int task_exceeding_cap_now(const task_t *p, unsigned 
>> long long now)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline void init_cap_stats(task_t *p)
>> +{
>> +}
>> +
>> +static inline void inc_cap_stats_cycle(task_t *p, unsigned long long 
>> now)
>> +{
>> +}
>> +
>> +static inline void inc_cap_stats_both(task_t *p, unsigned long long now)
>> +{
>> +}
>> +
>> +static inline void decay_cap_stats(task_t *p)
>> +{
>> +}
>> +#endif
>> +
>>  #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)      \
>>                                 < (long long) (sd)->cache_hot_time)
>>
>> @@ -197,8 +353,8 @@ typedef struct runqueue runqueue_t;
>>
>>  struct prio_array {
>>         unsigned int nr_active;
>> -       DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for 
>> delimiter */
>> -       struct list_head queue[MAX_PRIO];
>> +       DECLARE_BITMAP(bitmap, IDLE_PRIO+1); /* include 1 bit for 
>> delimiter */
>> +       struct list_head queue[IDLE_PRIO];
>>  };
>>
>>  /*
>> @@ -710,6 +866,10 @@ static inline int __normal_prio(task_t *
>>  {
>>         int bonus, prio;
>>
>> +       /* Ensure that background tasks stay at BGND_PRIO */
>> +       if (task_is_background(p))
>> +               return BGND_PRIO;
>> +
>>         bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
>>
>>         prio = p->static_prio - bonus;
>> @@ -786,6 +946,8 @@ static inline int expired_starving(runqu
>>
>>  static void set_load_weight(task_t *p)
>>  {
>> +       set_cap_flag(p);
>> +
>>         if (has_rt_policy(p)) {
>>  #ifdef CONFIG_SMP
>>                 if (p == task_rq(p)->migration_thread)
>> @@ -798,8 +960,22 @@ static void set_load_weight(task_t *p)
>>                 else
>>  #endif
>>                         p->load_weight = 
>> RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
>> -       } else
>> +       } else {
>>                 p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
>> +
>> +               /*
>> +                * Reduce the probability of a task escaping its CPU 
>> rate cap
>> +                * due to load balancing leaving it on a lighly used CPU
>> +                * This will be optimized away if rate caps aren't 
>> configured
>> +                */
>> +               if (task_has_cap(p)) {
>> +                       unsigned int clw; /* load weight based on cap */
>> +
>> +                       clw = cap_load_weight(p);
>> +                       if (clw < p->load_weight)
>> +                               p->load_weight = clw;
>> +               }
> 
> You could  use
> p->load_weight = min(cap_load_weight(p), p->load_weight);

Yes.

> 
> 
>> +       }
>>  }
>>
>>  static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t 
>> *p)
>> @@ -869,7 +1045,8 @@ static void __activate_task(task_t *p, r
>>  {
>>         prio_array_t *target = rq->active;
>>
>> -       if (unlikely(batch_task(p) || (expired_starving(rq) && 
>> !rt_task(p))))
>> +       if (unlikely(batch_task(p) || (expired_starving(rq) && 
>> !rt_task(p)) ||
>> +                       task_being_capped(p)))
>>                 target = rq->expired;
>>         enqueue_task(p, target);
>>         inc_nr_running(p, rq);
>> @@ -975,8 +1152,30 @@ static void activate_task(task_t *p, run
>>  #endif
>>
>>         if (!rt_task(p))
>> +               /*
>> +                * We want to do the recalculation even if we're 
>> exceeding
>> +                * a cap so that everything still works when we stop
>> +                * exceeding our cap.
>> +                */
>>                 p->prio = recalc_task_prio(p, now);
>>
>> +       if (task_has_cap(p)) {
>> +               inc_cap_stats_cycle(p, now);
>> +               /* Background tasks are handled in effective_prio()
>> +                * in order to ensure that they stay at BGND_PRIO
>> +                * but we need to be careful that we don't override
>> +                * it here
>> +                */
>> +               if (task_exceeding_cap(p) && !task_is_background(p)) {
>> +                       p->normal_prio = CAPPED_PRIO;
>> +                       /*
>> +                        * Don't undo any priority ineheritance
>> +                        */
>> +                       if (!rt_task(p))
>> +                               p->prio = CAPPED_PRIO;
>> +               }
>> +       }
> 
> Within all tasks at CAPPED_PRIO, is priority of the task used for 
> scheduling?

Unless a task is exceeding its cap it gets scheduled as per usual and 
even if it is exceeding its cap its time slice allocation is still done 
as per usual so "nice" and interactivity will still have some effect for 
competing "over cap" tasks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
