Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWASUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWASUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161430AbWASUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:54:59 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:56053 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1161427AbWASUy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:54:57 -0500
Message-ID: <43CFFC60.8010405@mvista.com>
Date: Thu, 19 Jan 2006 12:53:52 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Clean up of hrtimer code.
References: <43CEF172.2000308@mvista.com> <1137701896.7947.56.camel@localhost.localdomain>
In-Reply-To: <1137701896.7947.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> George,
> 
> On Wed, 2006-01-18 at 17:54 -0800, George Anzinger wrote:
> 
>>Description:
>>
>>This patch cleans up the interface to hrtimers by changing the init code
>>to pass the mode as well as the clock.  This allow the init code to
>>select the correct base and eliminates extra timer re-init code in
>>posix-timers.  We also simplify the restart interface by defining a
>>restart union with an entry for nanosleep use.
> 
> 
> Thanks. I revamped it against mainline and picked up most of your
> changes with a couple of modifications.
> 
> Will show up later tonight in the hrtimer-git repository on kernel.org
> when I finished testing.
> 
> 	tglx
> 
> 
>>+/**
>>+ * We want to use the "monotonic" base for everything except
>>+ * CLOCK_REALTIME* with the absolute flag set.  We need to
>>+ * account for the hole in the clocks caused by the CPU clocks
>>+ * (sigh).  We could use a case statement or, depend on REALTIME
>>+ * clocks being even and MONOTONIC being odd.  This even allow us
>>+ * to expand easily beyond 2 clocks.
>>+ *
>>+ */
>>+#define _clock_to_base(clock) (clock <= CLOCK_MONOTONIC ? clock : clock - 2)
>>+int clock_to_base_index(clock_t clock, enum hrtimer_mode mode)
>>+{
>>+	int baseindex = _clock_to_base(clock);
>>+
>>+	if (mode == HRTIMER_ABS)
>>+		return baseindex;
>>+	return baseindex | 1;
>>+}
> 
> 
> I skipped this, as I prefer that we add two unused entries into the base
> array for following reasons:
> 
> If the code gets called with one of the skipped clock_ids, the magic
> adjustment corrects them to a valid clock id and we certainly could get
> some hard to track problems that way.
> 
> The assumption that the CLOCK_REALTIME/MONOTONIC relationship is valid
> for all additional clocks is not correct.

Well, it is until it isn't.  There really does need to be a paring of some 
sort to sort out the ABS flag.
> 
> 
>> /**
>>  * hrtimer_init - initialize a timer to the given clock
>>  *
>>  * @timer:	the timer to be initialized
>>  * @clock_id:	the clock to be used
>>- */
>>-void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id)
>>+  * mode:        HRTIMER_ABS if absolute mode
>>+*/
>>+void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id,
>>+		  enum hrtimer_mode mode)
>> {
>>+	struct hrtimer_base *bases =
>>+		per_cpu(hrtimer_bases, raw_smp_processor_id());
>>+
>> 	memset(timer, 0, sizeof(struct hrtimer));
>>-	hrtimer_rebase(timer, clock_id);
>>+	timer->base = &bases[clock_to_base_index(clock_id, mode)];
>> }
> 
> 
> Changed that to the rules above.
>  
>  
> 
>>-	restart = &current_thread_info()->restart_block;
>>-	restart->fn = (clockid == CLOCK_MONOTONIC) ?
>>-		nanosleep_restart_mono : nanosleep_restart_real;
>>-	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
>>-	restart->arg1 = timer.expires.tv64 >> 32;
>>-	restart->arg2 = (unsigned long) rmtp;
>>+	restart = (union restart_union *)&current_thread_info()->restart_block;
>>+	restart->ns.fn = nanosleep_restart;
>>+	restart->ns.time = timer.expires;
>>+	restart->ns.rmtp = rmtp;
>>+	restart->ns.mode = (unsigned char)mode;
>>+	restart->ns.clock = (unsigned char)clockid;
> 
> 
> Adding 
> 
> 	restart->arg3 = timer.base->index;
> 
> is just enough. No need for creating this union thingy. The mode
> information is not necessary, as the timer is always restarted in
> absolute mode with the existing expires value on the previous base.
> 
The union is more about making things look nice and clean.  Actually the new 
timer should be started on the relative base in absolute mode.  I.e. it is a 
relative timer and should NOT be affected by clock setting, but we do have an 
absolute expire time.  ABS timers are never restarted so, you are right, we 
don't need the mode in the restart block.
> 
> 
>> 	return -ERESTART_RESTARTBLOCK;
>> }
>>Index: linux-2.6.16-rc/kernel/posix-timers.c
>>===================================================================
>>--- linux-2.6.16-rc.orig/kernel/posix-timers.c
>>+++ linux-2.6.16-rc/kernel/posix-timers.c
>>@@ -194,9 +194,6 @@ static inline int common_clock_set(const
>> 
>> static inline int common_timer_create(struct k_itimer *new_timer)
>> {
>>-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock);
> 
> 
> I kept that init as a dummy one. Thats simpler than adding all the 
> if(!base) stuff into the hrtimer code. Not having those checks gives a
> nice oops, when somebody tries to access a non initialized hrtimer !

An additional problem that you may want to address it that the SIGEV_NONE 
timers never get their time set (that being done by being put in the timer 
queue) and so the return value on a timer_gettime() is wrong.  I have updated 
the absolute timer test on sourceforge (in the CVS) to test for this, and, of 
course it fails.  I, in one version, added a NO_QUEUE flag to the mode to 
tell the enqueue_timer code to return just prior to actually doing the 
enqueue to handle this.  The other possibility is to fill the expire time in 
in posix-timers.c, but that means it has to do stuff that is already coded in 
enqueue_timer.  Your choice, but currently what happens is wrong.

George

> 
> George, thats the current revamped version against 2.6.16-rc1:
> 
> include/linux/hrtimer.h |    5 +---
>  kernel/fork.c           |    2 -
>  kernel/hrtimer.c        |   57 +++++++++++++++++++-----------------------------
>  kernel/posix-timers.c   |   37 +++++++------------------------
>  4 files changed, 35 insertions(+), 66 deletions(-)
> 
> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> index c657f3d..6361544 100644
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -101,9 +101,8 @@ struct hrtimer_base {
>  /* Exported timer functions: */
>  
>  /* Initialize timers: */
> -extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock);
> -extern void hrtimer_rebase(struct hrtimer *timer, const clockid_t which_clock);
> -
> +extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
> +			 enum hrtimer_mode mode);
>  
>  /* Basic timer operations: */
>  extern int hrtimer_start(struct hrtimer *timer, ktime_t tim,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4ae8cfc..7f0ab5e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -802,7 +802,7 @@ static inline int copy_signal(unsigned l
>  	init_sigpending(&sig->shared_pending);
>  	INIT_LIST_HEAD(&sig->posix_timers);
>  
> -	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC);
> +	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_REL);
>  	sig->it_real_incr.tv64 = 0;
>  	sig->real_timer.function = it_real_fn;
>  	sig->real_timer.data = tsk;
> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> index f580dd9..383ef7b 100644
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
> @@ -66,6 +66,12 @@ EXPORT_SYMBOL_GPL(ktime_get_real);
>  
>  /*
>   * The timer bases:
> + *
> + * Note: If we want to add new timer bases, we have to skip the two
> + * clock ids captured by the cpu-timers. We do this by holding empty
> + * entries rather than doing math adjustment of the clock ids.
> + * This ensures that we capture erroneous accesses to these clock ids
> + * rather than moving them into the range of valid clock id's.
>   */
>  
>  #define MAX_HRTIMER_BASES 2
> @@ -483,29 +489,25 @@ ktime_t hrtimer_get_remaining(const stru
>  }
>  
>  /**
> - * hrtimer_rebase - rebase an initialized hrtimer to a different base
> + * hrtimer_init - initialize a timer to the given clock
>   *
> - * @timer:	the timer to be rebased
> + * @timer:	the timer to be initialized
>   * @clock_id:	the clock to be used
> + * @mode:	timer mode abs/rel
>   */
> -void hrtimer_rebase(struct hrtimer *timer, const clockid_t clock_id)
> +void hrtimer_init(struct hrtimer *timer, clockid_t clock_id, 
> +		  enum hrtimer_mode mode)
>  {
>  	struct hrtimer_base *bases;
>  
> +	memset(timer, 0, sizeof(struct hrtimer));
> +
>  	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
> -	timer->base = &bases[clock_id];
> -}
>  
> -/**
> - * hrtimer_init - initialize a timer to the given clock
> - *
> - * @timer:	the timer to be initialized
> - * @clock_id:	the clock to be used
> - */
> -void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id)
> -{
> -	memset(timer, 0, sizeof(struct hrtimer));
> -	hrtimer_rebase(timer, clock_id);
> +	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_ABS)
> +		clock_id = CLOCK_MONOTONIC;
> +
> +	timer->base = &bases[clock_id];
>  }
>  
>  /**
> @@ -643,8 +645,7 @@ schedule_hrtimer_interruptible(struct hr
>  	return schedule_hrtimer(timer, mode);
>  }
>  
> -static long __sched
> -nanosleep_restart(struct restart_block *restart, clockid_t clockid)
> +static long __sched nanosleep_restart(struct restart_block *restart)
>  {
>  	struct timespec __user *rmtp;
>  	struct timespec tu;
> @@ -654,7 +655,7 @@ nanosleep_restart(struct restart_block *
>  
>  	restart->fn = do_no_restart_syscall;
>  
> -	hrtimer_init(&timer, clockid);
> +	hrtimer_init(&timer, (clockid_t) restart->arg3, HRTIMER_ABS);
>  
>  	timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
>  
> @@ -674,16 +675,6 @@ nanosleep_restart(struct restart_block *
>  	return -ERESTART_RESTARTBLOCK;
>  }
>  
> -static long __sched nanosleep_restart_mono(struct restart_block *restart)
> -{
> -	return nanosleep_restart(restart, CLOCK_MONOTONIC);
> -}
> -
> -static long __sched nanosleep_restart_real(struct restart_block *restart)
> -{
> -	return nanosleep_restart(restart, CLOCK_REALTIME);
> -}
> -
>  long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
>  		       const enum hrtimer_mode mode, const clockid_t clockid)
>  {
> @@ -692,7 +683,7 @@ long hrtimer_nanosleep(struct timespec *
>  	struct timespec tu;
>  	ktime_t rem;
>  
> -	hrtimer_init(&timer, clockid);
> +	hrtimer_init(&timer, clockid, mode);
>  
>  	timer.expires = timespec_to_ktime(*rqtp);
>  
> @@ -710,11 +701,11 @@ long hrtimer_nanosleep(struct timespec *
>  		return -EFAULT;
>  
>  	restart = &current_thread_info()->restart_block;
> -	restart->fn = (clockid == CLOCK_MONOTONIC) ?
> -		nanosleep_restart_mono : nanosleep_restart_real;
> +	restart->fn = nanosleep_restart;
>  	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
>  	restart->arg1 = timer.expires.tv64 >> 32;
>  	restart->arg2 = (unsigned long) rmtp;
> +	restart->arg3 = (unsigned long) timer.base->index;
>  
>  	return -ERESTART_RESTARTBLOCK;
>  }
> @@ -741,10 +732,8 @@ static void __devinit init_hrtimers_cpu(
>  	struct hrtimer_base *base = per_cpu(hrtimer_bases, cpu);
>  	int i;
>  
> -	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
> +	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
>  		spin_lock_init(&base->lock);
> -		base++;
> -	}
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> index 3b606d3..54f0866 100644
> --- a/kernel/posix-timers.c
> +++ b/kernel/posix-timers.c
> @@ -194,9 +194,7 @@ static inline int common_clock_set(const
>  
>  static int common_timer_create(struct k_itimer *new_timer)
>  {
> -	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock);
> -	new_timer->it.real.timer.data = new_timer;
> -	new_timer->it.real.timer.function = posix_timer_fn;
> +	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
>  	return 0;
>  }
>  
> @@ -693,6 +691,7 @@ common_timer_set(struct k_itimer *timr, 
>  		 struct itimerspec *new_setting, struct itimerspec *old_setting)
>  {
>  	struct hrtimer *timer = &timr->it.real.timer;
> +	enum hrtimer_mode mode;
>  
>  	if (old_setting)
>  		common_timer_get(timr, old_setting);
> @@ -714,14 +713,10 @@ common_timer_set(struct k_itimer *timr, 
>  	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
>  		return 0;
>  
> -	/* Posix madness. Only absolute CLOCK_REALTIME timers
> -	 * are affected by clock sets. So we must reiniatilize
> -	 * the timer.
> -	 */
> -	if (timr->it_clock == CLOCK_REALTIME && (flags & TIMER_ABSTIME))
> -		hrtimer_rebase(timer, CLOCK_REALTIME);
> -	else
> -		hrtimer_rebase(timer, CLOCK_MONOTONIC);
> +	mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
> +	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
> +	timr->it.real.timer.data = timr;
> +	timr->it.real.timer.function = posix_timer_fn;
>  
>  	timer->expires = timespec_to_ktime(new_setting->it_value);
>  
> @@ -732,8 +727,7 @@ common_timer_set(struct k_itimer *timr, 
>  	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
>  		return 0;
>  
> -	hrtimer_start(timer, timer->expires, (flags & TIMER_ABSTIME) ?
> -		      HRTIMER_ABS : HRTIMER_REL);
> +	hrtimer_start(timer, timer->expires, mode);
>  	return 0;
>  }
>  
> @@ -948,21 +942,8 @@ sys_clock_getres(const clockid_t which_c
>  static int common_nsleep(const clockid_t which_clock, int flags,
>  			 struct timespec *tsave, struct timespec __user *rmtp)
>  {
> -	int mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
> -	int clockid = which_clock;
> -
> -	switch (which_clock) {
> -	case CLOCK_REALTIME:
> -		/* Posix madness. Only absolute timers on clock realtime
> -		   are affected by clock set. */
> -		if (mode != HRTIMER_ABS)
> -			clockid = CLOCK_MONOTONIC;
> -	case CLOCK_MONOTONIC:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	return hrtimer_nanosleep(tsave, rmtp, mode, clockid);
> +	return hrtimer_nanosleep(tsave, rmtp, flags & TIMER_ABSTIME ?
> +				 HRTIMER_ABS : HRTIMER_REL, which_clock);
>  }
>  
>  asmlinkage long
>  
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
