Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWBMBMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWBMBMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWBMBMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:12:07 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38361 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751530AbWBMBL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:11:57 -0500
Date: Mon, 13 Feb 2006 02:11:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] hrtimer: optimize hrtimer_get_remaining
Message-ID: <Pine.LNX.4.61.0602130211470.23855@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hrtimer_get_remaining doesn't need to lock the hrtimer_base to read the
time. Also use hrtimer_get_remaining at two other places.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

 kernel/hrtimer.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 01:39:19.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 01:41:59.000000000 +0100
@@ -482,15 +482,7 @@ int hrtimer_cancel(struct hrtimer *timer
  */
 ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
-	struct hrtimer_base *base;
-	unsigned long flags;
-	ktime_t rem;
-
-	base = lock_hrtimer_base(timer, &flags);
-	rem = ktime_sub(timer->expires, timer->base->get_time());
-	unlock_hrtimer_base(timer, &flags);
-
-	return rem;
+	return ktime_sub(timer->expires, timer->base->get_time());
 }
 
 /**
@@ -639,7 +631,6 @@ static long __sched nanosleep_restart(st
 	struct sleep_hrtimer t;
 	struct timespec __user *rmtp;
 	struct timespec tu;
-	ktime_t time;
 
 	restart->fn = do_no_restart_syscall;
 
@@ -650,8 +641,7 @@ static long __sched nanosleep_restart(st
 
 	rmtp = (struct timespec __user *) restart->arg2;
 	if (rmtp) {
-		time = ktime_sub(t.timer.expires, t.timer.base->get_time());
-		tu = ktime_to_timespec(time);
+		tu = ktime_to_timespec(hrtimer_get_remaining(&t.timer));
 		if (copy_to_user(rmtp, &tu, sizeof(tu)))
 			return -EFAULT;
 	}
@@ -668,7 +658,6 @@ long hrtimer_nanosleep(struct timespec *
 	struct restart_block *restart;
 	struct sleep_hrtimer t;
 	struct timespec tu;
-	ktime_t rem;
 
 	hrtimer_init(&t.timer, clockid, mode);
 	t.timer.expires = timespec_to_ktime(*rqtp);
@@ -680,8 +669,7 @@ long hrtimer_nanosleep(struct timespec *
 		return -ERESTARTNOHAND;
 
 	if (rmtp) {
-		rem = ktime_sub(t.timer.expires, t.timer.base->get_time());
-		tu = ktime_to_timespec(rem);
+		tu = ktime_to_timespec(hrtimer_get_remaining(&t.timer));
 		if (copy_to_user(rmtp, &tu, sizeof(tu)))
 			return -EFAULT;
 	}
