Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbTGABwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 21:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbTGABwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 21:52:47 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:12782 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265821AbTGABwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 21:52:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 12:10:31 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307010944.46971.kernel@kolivas.org> <200307010952.26595.kernel@kolivas.org> <20030701010412.GA21496@triplehelix.org>
In-Reply-To: <20030701010412.GA21496@triplehelix.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X2OA/GldomdZWNW"
Message-Id: <200307011210.31612.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_X2OA/GldomdZWNW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 1 Jul 2003 11:04, Joshua Kwan wrote:
> On Tue, 1 Jul 2003 09:44, Con Kolivas wrote:
> > Here is an evolution of the O1int design to minimise audio skips/smooth
> > X. I've been forced to work with even less sleep than usual because of
> > this but I'm getting quite happy with it now.
>
> [snip]
>
> > More thrashing please. I know these had been coming out frequently but I
> > needed to assess every small increment. I hope not to need to do too much
> > from here.
>
> Well, this doesn't quite work. It initially seemed to prevent audio
> skips, but now I can't launch a new Eterm (with translucency) with the
> music not skipping, no change from stock -mm. It seems to work better
> under heavy load (extracting a chroot tarball for example) than when
> nothing is happening, which kind of puzzles me. In both cases I launch
> a new Eterm while music is playing.
>
> Inexplicably, it sometimes prevents skipping entirely.

Well we're on the way. Sing with me... a tweaking we will go..
Here is a tweaked patch with small changes otherwise which should help.

P.S. Were you running 100Hz?
Con

--Boundary-00=_X2OA/GldomdZWNW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O1int-0307011154"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0307011154"

--- linux-2.5.73/include/linux/sched.h	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-07-01 11:53:11.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
--- linux-2.5.73/kernel/sched.c	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-07-01 11:54:22.000000000 +1000
@@ -73,6 +73,7 @@
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
+#define SLEEP_TAU		(MAX_SLEEP_AVG / 5)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -297,6 +298,17 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+static inline void normalise_sleep(task_t *p)
+{
+	int old_avg_time, new_avg_time;
+	new_avg_time = SLEEP_TAU;
+	old_avg_time = jiffies - p->avg_start;
+
+	if (old_avg_time < new_avg_time) return;
+	p->sleep_avg = p->sleep_avg * new_avg_time / old_avg_time;
+	p->avg_start = jiffies - new_avg_time;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -314,11 +326,23 @@ static inline void enqueue_task(struct t
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
+	long sleep_period;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	sleep_period = jiffies - p->avg_start;
+
+	if (!sleep_period)
+		return p->static_prio;
+
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+
+	if (p->sleep_avg > sleep_period)
+		sleep_period = p->sleep_avg;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -349,7 +373,6 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
 
 		/*
 		 * This code gives a bonus to interactive tasks.
@@ -359,7 +382,7 @@ static inline void activate_task(task_t 
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		p->sleep_avg += sleep_time;
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,12 +390,17 @@ static inline void activate_task(task_t 
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+		if (p->sleep_avg > MAX_SLEEP_AVG * 12/10)
+			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
+		if (sleep_time > SLEEP_TAU / 2){
+			p->avg_start = jiffies - SLEEP_TAU;
+			p->sleep_avg = SLEEP_TAU / 2;
 		}
+		if (unlikely(p->avg_start > jiffies)){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
+		}
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -550,6 +578,10 @@ void wake_up_forked_process(task_t * p)
 	 * from forking tasks that are max-interactive.
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+	p->avg_start = current->avg_start;
+	if (p->sleep_avg > MAX_SLEEP_AVG)
+		p->sleep_avg = MAX_SLEEP_AVG;
+	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());

--Boundary-00=_X2OA/GldomdZWNW--

