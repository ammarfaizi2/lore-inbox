Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbTFSPwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbTFSPwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:52:16 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51151 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265813AbTFSPwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:52:00 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Fri, 20 Jun 2003 02:06:00 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Boman <aboman@midgaard.us>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306200202.37745.kernel@kolivas.org>
In-Reply-To: <200306200202.37745.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_o9d8+Xno5lG9ejc"
Message-Id: <200306200206.00548.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_o9d8+Xno5lG9ejc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 20 Jun 2003 02:02, Con Kolivas wrote:
> On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> > At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> > >Testers required. A version for -ck will be created soon.
> >
> > That idea definitely needs some refinement.
>
> Actually no it needs a bugfix even more than a refinement!
>
> The best_sleep_decay should be 60, NOT 60*Hz

Here's a fixed patch.

Con

--Boundary-00=_o9d8+Xno5lG9ejc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-sleep_decay-0306200203"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-sleep_decay-0306200203"

diff -Naurp linux-2.5.72/kernel/sched.c linux-2.5.72-test/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-19 22:23:33.000000000 +1000
@@ -72,7 +72,8 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(HZ)
+#define BEST_SLEEP_DECAY	(60)
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

--Boundary-00=_o9d8+Xno5lG9ejc--

