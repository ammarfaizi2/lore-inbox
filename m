Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265618AbTFSNvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbTFSNvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:51:39 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:28110 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265618AbTFSNvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:51:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] sleep_decay for interactivity 2.5.72 - testers needed
Date: Fri, 20 Jun 2003 00:05:18 +1000
User-Agent: KMail/1.5.2
Cc: Andreas Boman <aboman@midgaard.us>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eMc8+mhpQ4OACA/"
Message-Id: <200306200005.18005.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eMc8+mhpQ4OACA/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hidden at the end of a thread titled "[PATCH] 2.5.72 O(1) interactivity 
bugfix" was a much improved patch for interactivity against 2.5.72 which 
seemed to be swallowed and never appeared on lkml so here it is again.

If a task is interactive it will declare itself in a short period and the 
max_sleep_avg being 10 seconds is too long for a task to be detected as such. 
Unfortunately decreasing the max_sleep_avg will quickly put a task onto the 
expired array if the task uses sustained cpu for a period. This makes X slow 
down after a little usage when the machine is under heavy load. 

This patch uses two settings to determine a task's interactivity, the old 
max_sleep_avg is now more of a sleep_avg "attack" and the new 
best_sleep_decay is the decay. Initially these have been set to 1 and 60 
seconds. Audio skipping is eliminated in my testing at heavy loads, and X 
does not slow down during sustained usage under very heavy load. Unlike my 
previous patch this one does not reset the sleep_avg of new forked processes.

Included as an attachment to prevent mailer mangling.

Testers required. A version for -ck will be created soon.

Con

--Boundary-00=_eMc8+mhpQ4OACA/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-sleep_decay"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-sleep_decay"

diff -Naurp linux-2.5.72/kernel/sched.c linux-2.5.72-test/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-19 22:23:33.000000000 +1000
@@ -72,7 +72,8 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(HZ)
+#define BEST_SLEEP_DECAY	(60 * HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -318,7 +319,7 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*(p->best_sleep_avg/BEST_SLEEP_DECAY)/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -371,6 +372,8 @@ static inline void activate_task(task_t 
 			sleep_avg = MAX_SLEEP_AVG;
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
+			if ((sleep_avg * BEST_SLEEP_DECAY) > p->best_sleep_avg)
+				p->best_sleep_avg = sleep_avg * BEST_SLEEP_DECAY;
 			p->prio = effective_prio(p);
 		}
 	}
@@ -551,6 +554,7 @@ void wake_up_forked_process(task_t * p)
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->best_sleep_avg = p->sleep_avg * BEST_SLEEP_DECAY;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -1200,6 +1204,8 @@ void scheduler_tick(int user_ticks, int 
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
+	if (p->best_sleep_avg)
+		p->best_sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
diff -Naurp linux-2.5.72/include/linux/sched.h linux-2.5.72-test/include/linux/sched.h
--- linux-2.5.72/include/linux/sched.h	2003-06-18 22:47:19.000000000 +1000
+++ linux-2.5.72-test/include/linux/sched.h	2003-06-19 20:56:18.000000000 +1000
@@ -332,6 +332,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long best_sleep_avg;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;

--Boundary-00=_eMc8+mhpQ4OACA/--

