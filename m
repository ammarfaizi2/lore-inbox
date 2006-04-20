Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWDTPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWDTPSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDTPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:18:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:19329 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750994AbWDTPSx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:18:53 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: =?iso-8859-1?q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: [RFC][PATCH -rt] Make futex_wait() use an hrtimer for timeout
Date: Thu, 20 Apr 2006 08:18:40 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
References: <20060412114243.42351c35@frecb000686> <200604131350.42945.dvhltc@us.ibm.com>
In-Reply-To: <200604131350.42945.dvhltc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604200818.41270.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 13:50, Darren Hart wrote:
> On Wednesday 12 April 2006 02:42, Sébastien Dugué wrote:
> >   Hi,
> >
> >   This patch modifies futex_wait() to use an hrtimer + schedule() in
> > place of schedule_timeout() in an RT kernel.
>
> I haven't seen any public discussion on this, so I just wanted to put in a
> nod.  It will greatly improve the latency for realtime applications using
> pthread_cond_timedwait().

Ingo,

I've checked the latest RT tree just to be sure this patch wasn't just 
silently included and still haven't seen any discussion.  Do you have any 
particular concerns about this patch that we might be able to address?

Thanks,

--Darren

>
> Acked-by: Darren Hart <dvhltc@us.ibm.com>
>
> >   More details in the patch header.
> >
> >   Sébastien.
> >
> >
> > -------------------------------------------------------------------------
> >-- -----
> >
> >   This patch modifies futex_wait() to use an hrtimer + schedule() in
> > place of schedule_timeout().
> >
> >   schedule_timeout() is tick based, therefore the timeout granularity is
> > the tick (1 ms, 4 ms or 10 ms depending on HZ). By using a high
> > resolution timer for timeout wakeup, we can attain a much finer timeout
> > granularity (in the microsecond range). This parallels what is already
> > done for futex_lock_pi().
> >
> >   The timeout passed to the syscall is no longer converted to jiffies
> > and is therefore passed to do_futex() and futex_wait() as a timespec
> > therefore keeping nanosecond resolution.
> >
> >   Also this removes the need to pass the nanoseconds timeout part to
> > futex_lock_pi() in val2.
> >
> >   In futex_wait(), if the timeout is zero then a regular schedule() is
> > performed. Otherwise, an hrtimer is fired before schedule() is called.
> >
> >  include/linux/futex.h |    2 -
> >  kernel/futex.c        |   56
> > +++++++++++++++++++++++++++++++++----------------- kernel/futex_compat.c
> > | 9 --------
> >  3 files changed, 40 insertions(+), 27 deletions(-)
> >
> >
> > Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
> >
> > Index: linux-2.6.16-rt16/include/linux/futex.h
> > ===================================================================
> > --- linux-2.6.16-rt16.orig/include/linux/futex.h	2006-04-12
> > 11:20:57.000000000 +0200 +++
> > linux-2.6.16-rt16/include/linux/futex.h	2006-04-12 11:21:01.000000000
> > +0200 @@ -93,7 +93,7 @@ struct robust_list_head {
> >   */
> >  #define ROBUST_LIST_LIMIT	2048
> >
> > -long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
> > +long do_futex(u32 __user *uaddr, int op, u32 val, struct timespec
> > *timeout, u32 __user *uaddr2, u32 val2, u32 val3);
> >
> >  extern int handle_futex_death(u32 __user *uaddr, struct task_struct
> > *curr); Index: linux-2.6.16-rt16/kernel/futex.c
> > ===================================================================
> > --- linux-2.6.16-rt16.orig/kernel/futex.c	2006-04-12 11:20:57.000000000
> > +0200 +++ linux-2.6.16-rt16/kernel/futex.c	2006-04-12 11:21:01.000000000
> > +0200 @@ -49,6 +49,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/signal.h>
> >  #include <asm/futex.h>
> > +#include <linux/hrtimer.h>
> >
> >  #include "rtmutex_common.h"
> >
> > @@ -968,7 +969,7 @@ static void unqueue_me_pi(struct futex_q
> >  	drop_key_refs(&q->key);
> >  }
> >
> > -static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
> > +static int futex_wait(u32 __user *uaddr, u32 val, struct timespec *time)
> >  {
> >  	struct task_struct *curr = current;
> >  	DECLARE_WAITQUEUE(wait, curr);
> > @@ -976,6 +977,8 @@ static int futex_wait(u32 __user *uaddr,
> >  	struct futex_q q;
> >  	u32 uval;
> >  	int ret;
> > +	struct hrtimer_sleeper t;
> > +	int rem = 0;
> >
> >  	q.pi_state = NULL;
> >   retry:
> > @@ -1057,7 +1060,31 @@ static int futex_wait(u32 __user *uaddr,
> >  		unsigned long nosched_flag = current->flags & PF_NOSCHED;
> >
> >  		current->flags &= ~PF_NOSCHED;
> > -		time = schedule_timeout(time);
> > +
> > +		if (time->tv_sec == 0 && time->tv_nsec == 0)
> > +			schedule();
> > +		else {
> > +
> > +			hrtimer_init(&t.timer, CLOCK_MONOTONIC, HRTIMER_REL);
> > +			hrtimer_init_sleeper(&t, current);
> > +			t.timer.expires = timespec_to_ktime(*time);
> > +
> > +			hrtimer_start(&t.timer, t.timer.expires, HRTIMER_REL);
> > +
> > +			/*
> > +			 * the timer could have already expired, in which
> > +			 * case current would be flagged for rescheduling.
> > +			 * Don't bother calling schedule.
> > +			 */
> > +			if (likely(t.task))
> > +				schedule();
> > +
> > +			hrtimer_cancel(&t.timer);
> > +
> > +			/* Flag if a timeout occured */
> > +			rem = (t.task == NULL);
> > +		}
> > +
> >  		current->flags |= nosched_flag;
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> > @@ -1070,7 +1097,7 @@ static int futex_wait(u32 __user *uaddr,
> >  	/* If we were woken (and unqueued), we succeeded, whatever. */
> >  	if (!unqueue_me(&q))
> >  		return 0;
> > -	if (time == 0)
> > +	if (rem)
> >  		return -ETIMEDOUT;
> >  	/*
> >  	 * We expect signal_pending(current), but another thread may
> > @@ -1093,7 +1120,7 @@ static int futex_wait(u32 __user *uaddr,
> >   * races the kernel might see a 0 value of the futex too.)
> >   */
> >  static int futex_lock_pi(u32 __user *uaddr, int detect,
> > -			 unsigned long sec, long nsec, int trylock)
> > +			 struct timespec *time, int trylock)
> >  {
> >  	struct task_struct *curr = current;
> >  	struct futex_hash_bucket *hb;
> > @@ -1107,11 +1134,11 @@ static int futex_lock_pi(u32 __user *uad
> >
> >  	pr_debug("Futex lock pi: %d\n", current->pid);
> >
> > -	if (sec != MAX_SCHEDULE_TIMEOUT) {
> > +	if (time->tv_sec || time->tv_nsec) {
> >  		to = &timeout;
> >  		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
> >  		hrtimer_init_sleeper(to, current);
> > -		to->timer.expires = ktime_set(sec, nsec);
> > +		to->timer.expires = timespec_to_ktime(*time);
> >  	}
> >
> >  	q.pi_state = NULL;
> > @@ -1708,7 +1735,7 @@ void exit_robust_list(struct task_struct
> >  	}
> >  }
> >
> > -long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
> > +long do_futex(u32 __user *uaddr, int op, u32 val, struct timespec
> > *timeout, u32 __user *uaddr2, u32 val2, u32 val3)
> >  {
> >  	int ret;
> > @@ -1734,13 +1761,13 @@ long do_futex(u32 __user *uaddr, int op,
> >  		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
> >  		break;
> >  	case FUTEX_LOCK_PI:
> > -		ret = futex_lock_pi(uaddr, val, timeout, val2, 0);
> > +		ret = futex_lock_pi(uaddr, val, timeout, 0);
> >  		break;
> >  	case FUTEX_UNLOCK_PI:
> >  		ret = futex_unlock_pi(uaddr);
> >  		break;
> >  	case FUTEX_TRYLOCK_PI:
> > -		ret = futex_lock_pi(uaddr, 0, timeout, val2, 1);
> > +		ret = futex_lock_pi(uaddr, 0, timeout, 1);
> >  		break;
> >  	default:
> >  		ret = -ENOSYS;
> > @@ -1753,8 +1780,7 @@ asmlinkage long sys_futex(u32 __user *ua
> >  			  struct timespec __user *utime, u32 __user *uaddr2,
> >  			  u32 val3)
> >  {
> > -	struct timespec t;
> > -	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
> > +	struct timespec t = {.tv_sec=0, .tv_nsec=0};
> >  	u32 val2 = 0;
> >
> >  	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
> > @@ -1762,12 +1788,6 @@ asmlinkage long sys_futex(u32 __user *ua
> >  			return -EFAULT;
> >  		if (!timespec_valid(&t))
> >  			return -EINVAL;
> > -		if (op == FUTEX_WAIT)
> > -			timeout = timespec_to_jiffies(&t) + 1;
> > -		else {
> > -			timeout = t.tv_sec;
> > -			val2 = t.tv_nsec;
> > -		}
> >  	}
> >  	/*
> >  	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
> > @@ -1775,7 +1795,7 @@ asmlinkage long sys_futex(u32 __user *ua
> >  	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
> >  		val2 = (u32) (unsigned long) utime;
> >
> > -	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
> > +	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
> >  }
> >
> >  static struct super_block *
> > Index: linux-2.6.16-rt16/kernel/futex_compat.c
> > ===================================================================
> > --- linux-2.6.16-rt16.orig/kernel/futex_compat.c	2006-04-12
> > 11:20:57.000000000 +0200 +++
> > linux-2.6.16-rt16/kernel/futex_compat.c	2006-04-12 11:21:01.000000000
> > +0200 @@ -125,8 +125,7 @@ asmlinkage long compat_sys_futex(u32 __u
> >  		struct compat_timespec __user *utime, u32 __user *uaddr2,
> >  		u32 val3)
> >  {
> > -	struct timespec t;
> > -	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
> > +	struct timespec t = {.tv_sec=0, .tv_nsec=0};
> >  	int val2 = 0;
> >
> >  	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
> > @@ -134,12 +133,6 @@ asmlinkage long compat_sys_futex(u32 __u
> >  			return -EFAULT;
> >  		if (!timespec_valid(&t))
> >  			return -EINVAL;
> > -		if (op == FUTEX_WAIT)
> > -			timeout = timespec_to_jiffies(&t) + 1;
> > -		else {
> > -			timeout = t.tv_sec;
> > -			val2 = t.tv_nsec;
> > -		}
> >  	}
> >  	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
> >  		val2 = (int) (unsigned long) utime;
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
