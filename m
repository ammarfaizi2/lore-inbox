Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUGPFAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUGPFAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUGPFAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:00:06 -0400
Received: from fmr05.intel.com ([134.134.136.6]:28049 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266511AbUGPDy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:54:26 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] One possible bugfix for CLOCK_REALTIME timer. 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 16 Jul 2004 11:53:58 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E04B13848@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] One possible bugfix for CLOCK_REALTIME timer. 
Thread-Index: AcRImT4tGCB1EhuuQjiZyDzl9M1QEwiTvUeQ
From: "Hu, Boris" <boris.hu@intel.com>
To: <george@mvista.com>
Cc: <drepper@redhat.com>, "Li, Adam" <adam.li@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jul 2004 03:54:00.0510 (UTC) FILETIME=[871E8DE0:01C46AE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore it. I am very sorry. It is my company's mail server problem to bounce it. :(

Boris Hu (Hu Jiangtao) 
***************************************** 
There are my thoughts, not my employer's. 
*****************************************

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Hu, Boris
>Sent: 2004Äê6ÔÂ2ÈÕ 20:01
>To: george@mvista.com
>Cc: drepper@redhat.com; Li, Adam; Hu, Boris; linux-kernel@vger.kernel.org
>Subject: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
>
> <<posix-abs_timer-bugfix.diff>> George,
>
>There is one bug of CLOCK_REALTIME timer reported by Adam at
>http://sources.redhat.com/ml/libc-alpha/2004-05/msg00177.html.
>
>Here is one possible bugfix and it is against linux-2.6.6. All
>TIMER_ABSTIME cloks will be collected in k_clock struct and updated in
>sys_clock_settime. Could you review it? Thanks.
>
>
>diff -urN -X rt.ia32/base/dontdiff
>linux-2.6.6/include/linux/posix-timers.h
>linux-2.6.6.dev/include/linux/posix-timers.h
>--- linux-2.6.6/include/linux/posix-timers.h	2004-05-10
>10:32:29.000000000 +0800
>+++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-02
>10:30:57.000000000 +0800
>@@ -1,9 +1,14 @@
> #ifndef _linux_POSIX_TIMERS_H
> #define _linux_POSIX_TIMERS_H
>
>+#include <linux/list.h>
>+#include <linux/spinlock.h>
>+
> struct k_clock {
> 	int res;		/* in nano seconds */
>-	int (*clock_set) (struct timespec * tp);
>+        struct list_head abs_timer_list;
>+        spinlock_t abs_timer_lock;
>+        int (*clock_set) (struct timespec * tp);
> 	int (*clock_get) (struct timespec * tp);
> 	int (*nsleep) (int flags,
> 		       struct timespec * new_setting,
>diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/include/linux/timer.h
>linux-2.6.6.dev/include/linux/timer.h
>--- linux-2.6.6/include/linux/timer.h	2004-05-10 10:32:54.000000000
>+0800
>+++ linux-2.6.6.dev/include/linux/timer.h	2004-06-02
>19:16:08.000000000 +0800
>@@ -9,6 +9,7 @@
>
> struct timer_list {
> 	struct list_head entry;
>+	struct list_head abs_timer_entry;
> 	unsigned long expires;
>
> 	spinlock_t lock;
>diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/kernel/posix-timers.c
>linux-2.6.6.dev/kernel/posix-timers.c
>--- linux-2.6.6/kernel/posix-timers.c	2004-05-10 10:32:37.000000000
>+0800
>+++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-02
>19:12:31.000000000 +0800
>@@ -7,6 +7,9 @@
>  *
>  *			     Copyright (C) 2002 2003 by MontaVista
>Software.
>  *
>+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
>+ *                           Copyright (C) 2004 Boris Hu
>+ *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License, or
>(at
>@@ -200,7 +203,9 @@
>  */
> static __init int init_posix_timers(void)
> {
>-	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
>+	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
>+                .abs_timer_lock = SPIN_LOCK_UNLOCKED
>
>+        };
> 	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
> 		.clock_get = do_posix_clock_monotonic_gettime,
> 		.clock_set = do_posix_clock_monotonic_settime
>@@ -388,6 +393,7 @@
> 		return;
> 	}
> 	posix_clocks[clock_id] = *new_clock;
>+        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
> }
>
> static struct k_itimer * alloc_posix_timer(void)
>@@ -843,8 +849,15 @@
> 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
>{
> 		if (timr->it_timer.expires == jiffies)
> 			timer_notify_task(timr);
>-		else
>+		else {
> 			add_timer(&timr->it_timer);
>+                        if (flags & TIMER_ABSTIME) {
>+                                spin_lock(&clock->abs_timer_lock);
>+
>list_add_tail(&(timr->it_timer.abs_timer_entry),
>+
>&(clock->abs_timer_list));
>+                                spin_unlock(&clock->abs_timer_lock);
>+                        }
>+                }
> 	}
> 	return 0;
> }
>@@ -1085,16 +1098,61 @@
> sys_clock_settime(clockid_t which_clock, const struct timespec __user
>*tp)
> {
> 	struct timespec new_tp;
>+        struct timespec before, now;
>+        struct k_clock *clock;
>+        long ret;
>+        struct timer_list *timer, *tmp;
>+        struct timespec delta;
>+        u64 exp = 0;
>
>-	if ((unsigned) which_clock >= MAX_CLOCKS ||
>+        if ((unsigned) which_clock >= MAX_CLOCKS ||
> 					!posix_clocks[which_clock].res)
> 		return -EINVAL;
>-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
>+
>+        clock = &posix_clocks[which_clock];
>+
>+        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> 		return -EFAULT;
> 	if (posix_clocks[which_clock].clock_set)
> 		return posix_clocks[which_clock].clock_set(&new_tp);
>
>-	return do_sys_settimeofday(&new_tp, NULL);
>+        do_posix_gettime(clock, &before);
>+
>+	ret = do_sys_settimeofday(&new_tp, NULL);
>+
>+        /*
>+         * Check if there exist TIMER_ABSTIME timers to update.
>+         */
>+        if (which_clock != CLOCK_REALTIME ||
>+            list_empty(&clock->abs_timer_list))
>+                return ret;
>+
>+        do_posix_gettime(clock, &now);
>+        delta.tv_sec = before.tv_sec - now.tv_sec;
>+        delta.tv_nsec = before.tv_nsec - now.tv_nsec;
>+        while (delta.tv_nsec >= NSEC_PER_SEC) {
>+                delta.tv_sec ++;
>+                delta.tv_nsec -= NSEC_PER_SEC;
>+        }
>+        while (delta.tv_nsec < 0) {
>+                delta.tv_sec --;
>+                delta.tv_nsec += NSEC_PER_SEC;
>+        }
>+
>+        tstojiffie(&delta, clock->res, &exp);
>+
>+        spin_lock(&(clock->abs_timer_lock));
>+        list_for_each_entry_safe(timer, tmp,
>+                                 &clock->abs_timer_list,
>+                                 abs_timer_entry) {
>+                if (timer && del_timer(timer)) { //the timer has not
>run
>+                        timer->expires += exp;
>+                        add_timer(timer);
>+                } else
>+                        list_del(&timer->abs_timer_entry);
>+        }
>+        spin_unlock(&(clock->abs_timer_lock));
>+        return ret;
> }
>
> asmlinkage long
>
>Good Luck !
>Boris Hu (Hu Jiangtao)
>Intel China Software Center
>86-021-5257-4545#1277
>iNET: 8-752-1277
>************************************
>There are my thoughts, not my employer's.
>************************************
>"gpg --recv-keys --keyserver wwwkeys.pgp.net 0FD7685F"
>{0FD7685F:CFD6 6F5C A2CB 7881 725B  CEA0 956F 9F14 0FD7 685F}
>

