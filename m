Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271328AbTGQBza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbTGQBza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:55:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17298
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271328AbTGQBz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:55:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O6.1int
Date: Thu, 17 Jul 2003 12:13:02 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, Wade <neroz@ii.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>, Wiktor Wodecki <wodecki@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171213.02643.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug in the O6int patch probably wasn't responsible for WIktor's problem 
actually. It shouldn't manifest for a very long time. Anyway here is the fix 
and a couple of minor cleanups.

--- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-17 11:24:54.000000000 +1000
+++ linux-2.6.0-testck1/kernel/sched.c	2003-07-17 11:59:01.000000000 +1000
@@ -78,7 +78,7 @@
 #define STARVATION_LIMIT	(10*HZ)
 #define SLEEP_BUFFER		(HZ/100)
 #define NODE_THRESHOLD		125
-#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
+#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -390,8 +390,6 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		unsigned long runtime = jiffies - p->avg_start;
-
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
 		 * will get just under interactive status with a small runtime
@@ -402,6 +400,11 @@ static inline void activate_task(task_t 
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
 				MAX_BONUS;
 		} else {
+			unsigned long runtime = jiffies - p->avg_start;
+
+			if (runtime > MAX_SLEEP_AVG)
+				runtime = MAX_SLEEP_AVG;
+
 			/*
 			 * This code gives a bonus to interactive tasks.
 			 *

