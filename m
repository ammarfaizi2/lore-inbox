Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWCOLdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWCOLdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWCOLdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:33:20 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30632
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751726AbWCOLdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:33:19 -0500
Subject: Re: + posix-timer-cleanup-common_timer_get.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200603121139.k2CBdTAx001302@shell0.pdx.osdl.net>
References: <200603121139.k2CBdTAx001302@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 12:33:52 +0100
Message-Id: <1142422432.19916.714.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 03:37 -0800, akpm@osdl.org wrote:
> The patch titled
> 
>      hrtimers: posix-timer: cleanup common_timer_get()
> 
> has been added to the -mm tree.  Its filename is
> 
>      posix-timer-cleanup-common_timer_get.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this

The patch breaks the return values for SIGEV_NONE timers. Fix below

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.16-updates/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/posix-timers.c
+++ linux-2.6.16-updates/kernel/posix-timers.c
@@ -606,36 +606,41 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	ktime_t now, remaining;
+	ktime_t now, remaining, iv;
 	struct hrtimer *timer = &timr->it.real.timer;
 
 	memset(cur_setting, 0, sizeof(struct itimerspec));
 
+	iv = timr->it.real.interval;
+
 	/* interval timer ? */
-	if (timr->it.real.interval.tv64 == 0) {
-		cur_setting->it_interval =
-			ktime_to_timespec(timr->it.real.interval);
-	} else if (!hrtimer_active(timer))
+	if (iv.tv64)
+		cur_setting->it_interval = ktime_to_timespec(iv);
+	else if (!hrtimer_active(timer) &&
+		 (timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
 		return;
 
 	now = timer->base->get_time();
 
 	/*
-	 * When a requeue is pending or this is a SIGEV_NONE timer
-	 * move the expiry time forward by intervals, so expiry is >
-	 * now.
+	 * When a requeue is pending or this is a SIGEV_NONE
+	 * timer move the expiry time forward by intervals, so
+	 * expiry is > now.
 	 */
-	if (timr->it_requeue_pending & REQUEUE_PENDING ||
-	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		timr->it_overrun += hrtimer_forward(timer, now,
-						    timr->it.real.interval);
-	}
+	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
+	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
+		timr->it_overrun += hrtimer_forward(timer, now, iv);
 
 	remaining = ktime_sub(timer->expires, now);
 	/* Return 0 only, when the timer is expired and not pending */
-	if (remaining.tv64 <= 0)
-		cur_setting->it_value.tv_nsec = 1;
-	else
+	if (remaining.tv64 <= 0) {
+		/*
+		 * A single shot SIGEV_NONE timer must return 0, when
+		 * it is expired !
+		 */
+		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+			cur_setting->it_value.tv_nsec = 1;
+	} else
 		cur_setting->it_value = ktime_to_timespec(remaining);
 }
 


