Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWE0Gsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWE0Gsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 02:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWE0Gsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 02:48:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6494 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751422AbWE0Gsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 02:48:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O48OmTr+fhvL3Mp6P519B3b92inavnstN1CyJsgZnwhA+W+VqcsGtfDFJ6dfY68IeZeuAnSES2h8cIkgyXQTepinSa2p7gAlQgDsyJejwAWcxiXbQLBdvsTymfNwzeAR6FM8rmn2MSYXNwdIKXoakEjO60Sh1xIHGDdYEFwh5fQ=
Message-ID: <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
Date: Sat, 27 May 2006 12:18:30 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Peter Williams" <pwil3058@bigpond.net.au>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Cc: "Mike Galbraith" <efault@gmx.de>, "Con Kolivas" <kernel@kolivas.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Kingsley Cheung" <kingsley@aurema.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Rene Herman" <rene.herman@keyaccess.nl>
In-Reply-To: <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
> This patch implements hard CPU rate caps per task as a proportion of a
> single CPU's capacity expressed in parts per thousand.
>
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>  include/linux/sched.h |    8 ++
>  kernel/Kconfig.caps   |   14 +++-
>  kernel/sched.c        |  154 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 168 insertions(+), 8 deletions(-)
>
> Index: MM-2.6.17-rc4-mm3/include/linux/sched.h
> ===================================================================
> --- MM-2.6.17-rc4-mm3.orig/include/linux/sched.h        2006-05-26 10:46:35.000000000 +1000
> +++ MM-2.6.17-rc4-mm3/include/linux/sched.h     2006-05-26 11:00:07.000000000 +1000
> @@ -796,6 +796,10 @@ struct task_struct {
>  #ifdef CONFIG_CPU_RATE_CAPS
>         unsigned long long avg_cpu_per_cycle, avg_cycle_length;
>         unsigned int cpu_rate_cap;
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +       unsigned int cpu_rate_hard_cap;
> +       struct timer_list sinbin_timer;

Using a timer for releasing tasks from their sinbin sounds like a  bit
of an overhead. Given that there could be 10s of thousands of tasks.
Is it possible to use the scheduler_tick() function take a look at all
deactivated tasks (as efficiently as possible) and activate them when
its time to activate them or just fold the functionality by defining a
time quantum after which everyone is worken up. This time quantum
could be the same as the time over which limits are honoured.

> +#endif
>  #endif
>         enum sleep_type sleep_type;
>
> @@ -994,6 +998,10 @@ struct task_struct {
>  #ifdef CONFIG_CPU_RATE_CAPS
>  unsigned int get_cpu_rate_cap(const struct task_struct *);
>  int set_cpu_rate_cap(struct task_struct *, unsigned int);
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +unsigned int get_cpu_rate_hard_cap(const struct task_struct *);
> +int set_cpu_rate_hard_cap(struct task_struct *, unsigned int);
> +#endif
>  #endif
>
>  static inline pid_t process_group(struct task_struct *tsk)
> Index: MM-2.6.17-rc4-mm3/kernel/Kconfig.caps
> ===================================================================
> --- MM-2.6.17-rc4-mm3.orig/kernel/Kconfig.caps  2006-05-26 10:45:26.000000000 +1000
> +++ MM-2.6.17-rc4-mm3/kernel/Kconfig.caps       2006-05-26 11:00:07.000000000 +1000
> @@ -3,11 +3,21 @@
>  #
>
>  config CPU_RATE_CAPS
> -       bool "Support (soft) CPU rate caps"
> +       bool "Support CPU rate caps"
>         default n
>         ---help---
> -         Say y here if you wish to be able to put a (soft) upper limit on
> +         Say y here if you wish to be able to put a soft upper limit on
>           the rate of CPU usage by individual tasks.  A task which has been
>           allocated a soft CPU rate cap will be limited to that rate of CPU
>           usage unless there is spare CPU resources available after the needs
>           of uncapped tasks are met.
> +
> +config CPU_RATE_HARD_CAPS
> +       bool "Support CPU rate hard caps"
> +       depends on CPU_RATE_CAPS
> +       default n
> +       ---help---
> +         Say y here if you wish to be able to put a hard upper limit on
> +         the rate of CPU usage by individual tasks.  A task which has been
> +         allocated a hard CPU rate cap will be limited to that rate of CPU
> +         usage regardless of whether there is spare CPU resources available.
> Index: MM-2.6.17-rc4-mm3/kernel/sched.c
> ===================================================================
> --- MM-2.6.17-rc4-mm3.orig/kernel/sched.c       2006-05-26 11:00:02.000000000 +1000
> +++ MM-2.6.17-rc4-mm3/kernel/sched.c    2006-05-26 13:50:11.000000000 +1000
> @@ -201,21 +201,33 @@ static inline unsigned int task_timeslic
>
>  #ifdef CONFIG_CPU_RATE_CAPS
>  #define CAP_STATS_OFFSET 8
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +static void sinbin_release_fn(unsigned long arg);
> +#define min_cpu_rate_cap(p) min((p)->cpu_rate_cap, (p)->cpu_rate_hard_cap)
> +#else
> +#define min_cpu_rate_cap(p) (p)->cpu_rate_cap
> +#endif
>  #define task_has_cap(p) unlikely((p)->flags & PF_HAS_CAP)
>  /* this assumes that p is not a real time task */
>  #define task_is_background(p) unlikely((p)->cpu_rate_cap == 0)
>  #define task_being_capped(p) unlikely((p)->prio >= CAPPED_PRIO)
> -#define cap_load_weight(p) (((p)->cpu_rate_cap * SCHED_LOAD_SCALE) / 1000)
> +#define cap_load_weight(p) ((min_cpu_rate_cap(p) * SCHED_LOAD_SCALE) / 1000)
>
>  static void init_cpu_rate_caps(task_t *p)
>  {
>         p->cpu_rate_cap = 1000;
>         p->flags &= ~PF_HAS_CAP;
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +       p->cpu_rate_hard_cap = 1000;
> +       init_timer(&p->sinbin_timer);
> +       p->sinbin_timer.function = sinbin_release_fn;
> +       p->sinbin_timer.data = (unsigned long) p;
> +#endif
>  }
>
>  static inline void set_cap_flag(task_t *p)
>  {
> -       if (p->cpu_rate_cap < 1000 && !has_rt_policy(p))
> +       if (min_cpu_rate_cap(p) < 1000 && !has_rt_policy(p))
>                 p->flags |= PF_HAS_CAP;
>         else
>                 p->flags &= ~PF_HAS_CAP;
> @@ -223,7 +235,7 @@ static inline void set_cap_flag(task_t *
>
>  static inline int task_exceeding_cap(const task_t *p)
>  {
> -       return (p->avg_cpu_per_cycle * 1000) > (p->avg_cycle_length * p->cpu_rate_cap);
> +       return (p->avg_cpu_per_cycle * 1000) > (p->avg_cycle_length * min_cpu_rate_cap(p));
>  }
>
>  #ifdef CONFIG_SCHED_SMT
> @@ -257,7 +269,7 @@ static int task_exceeding_cap_now(const
>
>         delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
>         lhs = (p->avg_cpu_per_cycle + delta) * 1000;
> -       rhs = (p->avg_cycle_length + delta) * p->cpu_rate_cap;
> +       rhs = (p->avg_cycle_length + delta) * min_cpu_rate_cap(p);
>
>         return lhs > rhs;
>  }
> @@ -266,6 +278,10 @@ static inline void init_cap_stats(task_t
>  {
>         p->avg_cpu_per_cycle = 0;
>         p->avg_cycle_length = 0;
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +       init_timer(&p->sinbin_timer);
> +       p->sinbin_timer.data = (unsigned long) p;
> +#endif
>  }
>
>  static inline void inc_cap_stats_cycle(task_t *p, unsigned long long now)
> @@ -1213,6 +1229,64 @@ static void deactivate_task(struct task_
>         p->array = NULL;
>  }
>
> +#ifdef CONFIG_CPU_RATE_HARD_CAPS
> +#define task_has_hard_cap(p) unlikely((p)->cpu_rate_hard_cap < 1000)
> +
> +/*
> + * Release a task from the sinbin
> + */
> +static void sinbin_release_fn(unsigned long arg)
> +{
> +       unsigned long flags;
> +       struct task_struct *p = (struct task_struct*)arg;
> +       struct runqueue *rq = task_rq_lock(p, &flags);
> +
> +       p->prio = effective_prio(p);
> +
> +       __activate_task(p, rq);
> +
> +       task_rq_unlock(rq, &flags);
> +}
> +
> +static unsigned long reqd_sinbin_ticks(const task_t *p)
> +{
> +       unsigned long long res;
> +
> +       res = p->avg_cpu_per_cycle * 1000;
> +
> +       if (res > p->avg_cycle_length * p->cpu_rate_hard_cap) {
> +               (void)do_div(res, p->cpu_rate_hard_cap);
> +               res -= p->avg_cpu_per_cycle;
> +               /*
> +                * IF it was available we'd also subtract
> +                * the average sleep per cycle here
> +                */
> +               res >>= CAP_STATS_OFFSET;
> +               (void)do_div(res, (1000000000 / HZ));

Please use NSEC_PER_SEC if that is what 10^9 stands for in the above
calculation.

> +
> +               return res ? : 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static void sinbin_task(task_t *p, unsigned long durn)
> +{
> +       if (durn == 0)
> +               return;
> +       deactivate_task(p, task_rq(p));
> +       p->sinbin_timer.expires = jiffies + durn;
> +       add_timer(&p->sinbin_timer);
> +}
> +#else
> +#define task_has_hard_cap(p) 0
> +#define reqd_sinbin_ticks(p) 0
> +
> +static inline void sinbin_task(task_t *p, unsigned long durn)
> +{
> +}
> +#endif
> +
>  /*
>   * resched_task - mark a task 'to be rescheduled now'.
>   *
> @@ -3508,9 +3582,16 @@ need_resched_nonpreemptible:
>                 }
>         }
>
> -       /* do this now so that stats are correct for SMT code */
> -       if (task_has_cap(prev))
> +       if (task_has_cap(prev)) {
>                 inc_cap_stats_both(prev, now);
> +               if (task_has_hard_cap(prev) && !prev->state &&
> +                   !rt_task(prev) && !signal_pending(prev)) {
> +                       unsigned long sinbin_ticks = reqd_sinbin_ticks(prev);
> +
> +                       if (sinbin_ticks)
> +                               sinbin_task(prev, sinbin_ticks);
> +               }
> +       }
>
>         cpu = smp_processor_id();
>         if (unlikely(!rq->nr_running)) {
> @@ -4539,6 +4620,67 @@ out:
>  }
>
<snip>

Balbir
Linux Technology Center
IBM Software Labs
