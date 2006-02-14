Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWBNKOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWBNKOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWBNKLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:33514 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030274AbWBNKLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:03 -0500
Date: Tue, 14 Feb 2006 11:11:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 03/12] hrtimer: optimize hrtimer_run_queues
Message-ID: <Pine.LNX.4.61.0602141110540.3706@scrub.home>
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
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 include/linux/hrtimer.h |    1 +
 kernel/hrtimer.c        |   17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-13 22:29:45.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-13 22:29:56.000000000 +0100
@@ -89,6 +89,7 @@ struct hrtimer_base {
 	ktime_t			resolution;
 	ktime_t			(*get_time)(void);
 	struct hrtimer		*curr_timer;
+	ktime_t			last_expired;
 };
 
 /*
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 22:29:51.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 22:29:56.000000000 +0100
@@ -541,7 +541,7 @@ int hrtimer_get_res(const clockid_t whic
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
