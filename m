Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWBMBKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWBMBKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWBMBKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:10:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:32985 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751523AbWBMBKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:10:33 -0500
Date: Mon, 13 Feb 2006 02:10:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] hrtimer: optimize hrtimer_run_queues
Message-ID: <Pine.LNX.4.61.0602130210120.23827@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every time hrtimer_run_queues() is called, get_time() is called twice,
which can be quite expensive, just reading xtime is much cheaper and
does the same job (at least for the current low resolution timer, for
high resolution timer we can something different later).
Cache the expiry time in last_expired, so run_hrtimer_queue() doesn't
has to calculate it (clock sources usually know when their expired).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/hrtimer.h |    1 +
 kernel/hrtimer.c        |   17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-12 18:33:07.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-12 18:33:21.000000000 +0100
@@ -89,6 +89,7 @@ struct hrtimer_base {
 	ktime_t			resolution;
 	ktime_t			(*get_time)(void);
 	struct hrtimer		*curr_timer;
+	ktime_t			last_expired;
 };
 
 /*
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-12 18:33:16.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-12 18:33:21.000000000 +0100
@@ -541,7 +541,7 @@ int hrtimer_get_res(clockid_t which_cloc
  */
 static inline void run_hrtimer_queue(struct hrtimer_base *base)
 {
-	ktime_t now = base->get_time();
+	ktime_t now = base->last_expired;
 	struct rb_node *node;
 
 	spin_lock_irq(&base->lock);
@@ -594,10 +594,19 @@ static inline void run_hrtimer_queue(str
 void hrtimer_run_queues(void)
 {
 	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
-	int i;
+	ktime_t now, mono;
+	int seq;
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++)
-		run_hrtimer_queue(&base[i]);
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		now = timespec_to_ktime(xtime);
+		mono = timespec_to_ktime(wall_to_monotonic);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	base[CLOCK_REALTIME].last_expired = now;
+	run_hrtimer_queue(&base[CLOCK_REALTIME]);
+	base[CLOCK_MONOTONIC].last_expired = ktime_add(now, mono);
+	run_hrtimer_queue(&base[CLOCK_MONOTONIC]);
 }
 
 /*
