Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTFVNaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTFVNaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:30:52 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:35564 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264982AbTFVNat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:30:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Boman <aboman@midgaard.us>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Sun, 22 Jun 2003 23:45:52 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306201229.55425.kernel@kolivas.org> <200306222335.10864.kernel@kolivas.org>
In-Reply-To: <200306222335.10864.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QMb9+fSN8ti4Udi"
Message-Id: <200306222345.52676.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QMb9+fSN8ti4Udi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 22 Jun 2003 23:35, Con Kolivas wrote:
> On Fri, 20 Jun 2003 12:29, Con Kolivas wrote:
> > On Fri, 20 Jun 2003 07:32, Andreas Boman wrote:
> > > Basicly, for normal usage this kernel is acting *very* well here.
> >
> > Great! Thanks for doing this testing. I've attached a patch with the
> > updated figures and cc'ed lkml for others to test.
>
> This is the latest state of play with this patch. I have been developing it
> for -ck and ported it to 2.5 if anyone is still interested. Basically it
> will make a task interactive faster than vanilla and will prevent a task
> losing it's interactivity status for longer.
>
> The added changes include a small workaround for integer division, and a
> new feature - non linear boosting.
>
> I have implemented a sigmoid curve shaped boost to the priority boost. This
> makes it harder for tasks to get the largest priority boost or the greatest
> penalty. Basically cpu hungry tasks that remain cpu hungry but fluctuate in
> their sleep time due to lots of other tasks running will get less priority
> boost and fluctuate less in that boost also.
>
> Feel free to test it and comment. Things to look for - the dreaded audio
> skip under load, and X remaining interactive during sustained use under
> load.

Woops my bad. Attached the correct one now.

Con

--Boundary-00=_QMb9+fSN8ti4Udi
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-sleep_decay-0306222343"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-sleep_decay-0306222343"

diff -Naurp linux-2.5.72/include/linux/sched.h linux-2.5.72-test/include/linux/sched.h
--- linux-2.5.72/include/linux/sched.h	2003-06-18 22:47:19.000000000 +1000
+++ linux-2.5.72-test/include/linux/sched.h	2003-06-19 20:56:18.000000000 +1000
@@ -332,6 +332,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long best_sleep_avg;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
diff -Naurp linux-2.5.72/kernel/sched.c linux-2.5.72-test/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-22 23:17:39.000000000 +1000
@@ -72,7 +72,8 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(2 * HZ)
+#define BEST_SLEEP_DECAY	(10)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -313,12 +314,22 @@ static inline void enqueue_task(struct t
  */
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int bonus, prio, neg_flag = 1, scale = MAX_SLEEP_AVG / 2;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	bonus = p->best_sleep_avg/BEST_SLEEP_DECAY;
+	if (bonus > MAX_SLEEP_AVG) bonus = MAX_SLEEP_AVG;
+
+	bonus -= scale;
+	if (bonus < 0) neg_flag = -1;
+	bonus *= bonus;
+	bonus /= scale;
+	bonus *= neg_flag;
+	bonus += scale;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*bonus/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -371,6 +382,8 @@ static inline void activate_task(task_t 
 			sleep_avg = MAX_SLEEP_AVG;
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
+			if ((sleep_avg * BEST_SLEEP_DECAY) > p->best_sleep_avg)
+				p->best_sleep_avg = sleep_avg * (BEST_SLEEP_DECAY + 1) - 1;
 			p->prio = effective_prio(p);
 		}
 	}
@@ -551,6 +564,7 @@ void wake_up_forked_process(task_t * p)
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->best_sleep_avg = p->sleep_avg * (BEST_SLEEP_DECAY + 1) - 1;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -1200,6 +1214,8 @@ void scheduler_tick(int user_ticks, int 
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
+	if (p->best_sleep_avg)
+		p->best_sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.

--Boundary-00=_QMb9+fSN8ti4Udi--

