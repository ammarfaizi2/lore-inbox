Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSKERSc>; Tue, 5 Nov 2002 12:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSKERSc>; Tue, 5 Nov 2002 12:18:32 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:45987 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264975AbSKERS3>; Tue, 5 Nov 2002 12:18:29 -0500
Date: Tue, 5 Nov 2002 15:24:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jim Houston <jim.houston@attbi.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] O(1) CPU time accounting
Message-ID: <Pine.LNX.4.44L.0211051523280.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

this incremental patch (over your O(1) CPU time patch) makes
nice levels work again, though they are fairly steep now:

  PID USER     PRI  NI  SIZE  RSS SWAP SHARE STAT %CPU %MEM   TIME COMMAND
  848 riel      22   0  1284  276 1008  1260 R    92.8  0.0  23:56 loop
  849 riel      23   5  1284  276 1008  1260 R N   4.2  0.0   1:05 loop
  850 riel      24  10  1284  276 1008  1260 R N   1.3  0.0   0:21 loop
  851 riel      32  15  1284  276 1008  1260 R N   0.7  0.0   0:12 loop
  852 riel      32  19  1284  276 1008  1260 R N   0.5  0.0   0:09 loop

This might be a decent basis for an O(1) per-user fair
scheduler, after some more balancing and cleaning up of
excess code.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

===== kernel/sched.c 1.138 vs edited =====
--- 1.138/kernel/sched.c	Tue Oct 29 15:55:16 2002
+++ edited/kernel/sched.c	Tue Nov  5 14:41:18 2002
@@ -72,6 +72,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define MAX_DEMOTION		10

 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -125,17 +126,27 @@
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
 	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))

+#define TIMESLICE_DOWN(prio) (MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *prio / MAX_DEMOTION))
+
+#define TIMESLICE_UP(prio) MIN_TIMESLICE
+
 static inline unsigned int task_timeslice(task_t *p)
 {
+	int priority;
+	unsigned int timeslice;
 	/*
 	 * The more favorable priority the shorter the time slice.
 	 * For 100 Hz clock this gives a range 10 - 191 ms.
 	 * For 1000 Hz clock this gives 1 - 157 ms.
 	 */
-	if (HZ > 100)
-		return(((p)->prio - MAX_RT_PRIO)*4 + 1);
+	priority = p->prio - p->static_prio;
+
+	if (priority >= 0)
+		timeslice = TIMESLICE_DOWN(priority);
 	else
-		return(((p)->prio - MAX_RT_PRIO)/2 + 1);
+		timeslice = TIMESLICE_UP(priority);
+
+	return timeslice;
 }

 /*
@@ -310,13 +321,15 @@
 static inline int effective_prio(task_t *p)
 {
 	int bonus, prio;
-
+
 	prio =  p->static_prio + (10 * p->run_avg/MAX_RUN_AVG) - 5;
 	prio = (p->prio*3 + prio)/4;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
+	if (prio > p->static_prio + MAX_DEMOTION)
+		prio = p->static_prio + MAX_DEMOTION;
 	return prio;
 }

@@ -1034,6 +1047,8 @@
 		set_tsk_need_resched(p);
 		if (p->prio < MAX_PRIO-1)
 			p->prio++;
+		if (p->prio < p->static_prio)
+			p->prio = p->static_prio;
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 		enqueue_task(p, rq->active);

