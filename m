Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVEXAHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEXAHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVEXAHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:07:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9969 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261255AbVEXAEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:04:54 -0400
Message-ID: <42926F83.9050608@mvista.com>
Date: Mon, 23 May 2005 17:04:19 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
References: <42909DC2.7922E05D@tv-sign.ru>
In-Reply-To: <42909DC2.7922E05D@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> sys_timer_settime/sys_timer_delete needs to delete k_itimer->real.timer
> synchronously while holding ->it_lock, which is also locked in posix_timer_fn.
> 
> This patch removes timer_active/set_timer_inactive which plays with
> timer_list's internals in favour of using try_to_del_timer_sync(),
> which was introduced in the previous patch.

Is there a particular reason for this, like it does not work, for example, or 
are you just trying to clean up code?

The reason I ask is that this code, to the best of my knowledge, works and it 
also works if the timer is queued on another list prior to its being handled by 
posix_timer_fn, which is exactly what happens in the HRT code.

We also note that this code is the subject of a patch to the RT patch to cover 
the same issue when softirqs are run from threads and therefor allow 
posix_timer_fn to be preempted.  (That fix being mainly to expand usage from 
just SMP to SMP || SOFTIRQ_PREEMPT.)

If this currently works, please leave it alone.

George
-- 
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.12-rc4-mm2/kernel/posix-timers.c~2_USE	2005-04-30 18:05:29.000000000 +0400
> +++ 2.6.12-rc4-mm2/kernel/posix-timers.c	2005-05-22 18:34:10.000000000 +0400
> @@ -89,23 +89,6 @@ static struct idr posix_timers_id;
>  static DEFINE_SPINLOCK(idr_lock);
>  
>  /*
> - * Just because the timer is not in the timer list does NOT mean it is
> - * inactive.  It could be in the "fire" routine getting a new expire time.
> - */
> -#define TIMER_INACTIVE 1
> -
> -#ifdef CONFIG_SMP
> -# define timer_active(tmr) \
> -		((tmr)->it.real.timer.entry.prev != (void *)TIMER_INACTIVE)
> -# define set_timer_inactive(tmr) \
> -		do { \
> -			(tmr)->it.real.timer.entry.prev = (void *)TIMER_INACTIVE; \
> -		} while (0)
> -#else
> -# define timer_active(tmr) BARFY	// error to use outside of SMP
> -# define set_timer_inactive(tmr) do { } while (0)
> -#endif
> -/*
>   * we assume that the new SIGEV_THREAD_ID shares no bits with the other
>   * SIGEV values.  Here we put out an error if this assumption fails.
>   */
> @@ -226,7 +209,6 @@ static inline int common_timer_create(st
>  	init_timer(&new_timer->it.real.timer);
>  	new_timer->it.real.timer.data = (unsigned long) new_timer;
>  	new_timer->it.real.timer.function = posix_timer_fn;
> -	set_timer_inactive(new_timer);
>  	return 0;
>  }
>  
> @@ -480,7 +462,6 @@ static void posix_timer_fn(unsigned long
>  	int do_notify = 1;
>  
>  	spin_lock_irqsave(&timr->it_lock, flags);
> - 	set_timer_inactive(timr);
>  	if (!list_empty(&timr->it.real.abs_timer_entry)) {
>  		spin_lock(&abs_list.lock);
>  		do {
> @@ -983,8 +964,8 @@ common_timer_set(struct k_itimer *timr, 
>  	 * careful here.  If smp we could be in the "fire" routine which will
>  	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
>  	 */
> +	if (try_to_del_timer_sync(&timr->it.real.timer) < 0) {
>  #ifdef CONFIG_SMP
> -	if (timer_active(timr) && !del_timer(&timr->it.real.timer))
>  		/*
>  		 * It can only be active if on an other cpu.  Since
>  		 * we have cleared the interval stuff above, it should
> @@ -994,11 +975,9 @@ common_timer_set(struct k_itimer *timr, 
>  		 * a "retry" exit status.
>  		 */
>  		return TIMER_RETRY;
> -
> -	set_timer_inactive(timr);
> -#else
> -	del_timer(&timr->it.real.timer);
>  #endif
> +	}
> +
>  	remove_from_abslist(timr);
>  
>  	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
> @@ -1083,8 +1062,9 @@ retry:
>  static inline int common_timer_del(struct k_itimer *timer)
>  {
>  	timer->it.real.incr = 0;
> +
> +	if (try_to_del_timer_sync(&timer->it.real.timer) < 0) {
>  #ifdef CONFIG_SMP
> -	if (timer_active(timer) && !del_timer(&timer->it.real.timer))
>  		/*
>  		 * It can only be active if on an other cpu.  Since
>  		 * we have cleared the interval stuff above, it should
> @@ -1094,9 +1074,9 @@ static inline int common_timer_del(struc
>  		 * a "retry" exit status.
>  		 */
>  		return TIMER_RETRY;
> -#else
> -	del_timer(&timer->it.real.timer);
>  #endif
> +	}
> +
>  	remove_from_abslist(timer);
>  
>  	return 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
