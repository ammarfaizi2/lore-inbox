Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271801AbTGRPzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271888AbTGRPxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:53:33 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:55467
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271886AbTGRPws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:52:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O7int for interactivity
Date: Sat, 19 Jul 2003 02:10:49 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307190210.49687.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update to my Oint patches for 2.5/6 interactivity. Note I will be 
away for a week so bash away and abuse this one lots and when I get back I can 
see what else needs doing. Note I posted a preview earlier but this is the formal
O7 patch (check the datestamp which people hate in the naming of my patches).
I know this is turning into a marathon effort but... as you're all probably aware
there is nothing simple about tuning this beast. Thanks to all the testers and
people commenting; keep it coming please.

Changes in this patch:
The sleep buffer has been removed yet again. To smooth out X is just not 
enough reason for this to be here as it can induce unfairness elsewhere, and 
the actual size necessary for the sleep buffer to work nicely would depend on 
the hardware.

Kernel threads are excluded from the idle detection code so they can become 
max interactive regardless of how long they sleep. Should prevent some of
the bugs seen recently.

The requeuing has been rewritten. User threads will be requeued inversely 
proportional to how cpu interactive they are. Prevents interactive tasks from
starving other interactive tasks during periods of cpu activity. This may have
been causing slowdowns in unlucky circumstances in O6

Con

patch-O7int-0307190129 is available here:
http://kernel.kolivas.org/2.5

and here:

--- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-17 19:59:16.000000000 +1000
+++ linux-2.6.0-testck1/kernel/sched.c	2003-07-19 01:56:41.000000000 +1000
@@ -76,7 +76,6 @@
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
-#define SLEEP_BUFFER		(HZ/100)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
@@ -391,11 +390,11 @@ static inline void activate_task(task_t 
 
 	if (sleep_time > 0) {
 		/*
-		 * Tasks that sleep a long time are categorised as idle and
+		 * User tasks that sleep a long time are categorised as idle and
 		 * will get just under interactive status with a small runtime
 		 * to allow them to become interactive or non-interactive rapidly
 		 */
-		if (sleep_time > MIN_SLEEP_AVG){
+		if (sleep_time > MIN_SLEEP_AVG && p->mm){
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
 				MAX_BONUS;
@@ -421,13 +420,8 @@ static inline void activate_task(task_t 
 			 */
 			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime / MAX_BONUS;
 
-			/*
-			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
-			 * prevent fully interactive tasks from becoming
-			 * lower priority with small bursts of cpu usage.
-			 */
-			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
-				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
+			if (p->sleep_avg > MAX_SLEEP_AVG)
+				p->sleep_avg = MAX_SLEEP_AVG;
 		}
 
 		if (unlikely(p->avg_start > jiffies)){
@@ -1310,10 +1304,12 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
-	} else if (p->prio < effective_prio(p)){
+	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %
+		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG)))){
 		/*
-		 * Tasks that have lowered their priority are put to the end
-		 * of the active array with their remaining timeslice
+		 * Running user tasks get requeued with their remaining timeslice
+		 * after a period proportional to how cpu intensive they are to
+		 * minimise the duration one interactive task can starve another
 		 */
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);

