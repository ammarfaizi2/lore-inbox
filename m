Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269879AbTGKKhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269880AbTGKKhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:37:40 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:65190 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S269879AbTGKKhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:37:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Fri, 11 Jul 2003 20:53:38 +1000
User-Agent: KMail/1.5.2
Cc: Daniel Phillips <phillips@arcor.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [RFC][PATCH] SCHED_ISO for interactivity
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ycpD/PyPw4utzLz"
Message-Id: <200307112053.55880.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ycpD/PyPw4utzLz
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After the recent discussions about the limitations on real time tasks and=20
normal users...

Wli coined the term "isochronous" (greek for same time) for a real time tas=
k=20
that was limited in it's timeslice but still guaranteed to run. I've decide=
d=20
to abuse this term and use it to name this new policy in this patch. This i=
s=20
neither real time, nor guaranteed.

What this patch does is introduce a new scheduler policy, SCHED_ISO. SI tas=
ks=20
get the maximum interactive bonus so they always get a dynamic priority of =
5=20
better than their static priority, but are penalised by having a smaller=20
timeslice. Most interactive tasks don't use up their full timeslice anyway.

Since most users and applications are not going to be altering scheduler=20
policies, this patch uses the current semantics in patches up to the O4int=
=20
patch I have posted previously (and in 2.5.75-mm1) to dynamically allocate=
=20
tasks as SI. This happens when their sleep avg hits MAX_SLEEP_AVG which is=
=20
extremely unlikely to happen for the wrong task. Unfortunately it also mean=
s=20
it takes at least 10 seconds. There are semantics in place to stop it=20
happening to idle tasks, tasks forking, and new children.

Anyway it's pretty rough around the edges since I slapped it together more =
to=20
prove it works, but appears to work as planned. The O*int patches appear to=
=20
be hitting a ceiling to their ability and this can help them further but I=
=20
need some feedback about it's usefulness, and appropriateness.=20

Without further feedback about the O*int patches I can't do much to develop=
=20
them further.

akpm: obviously this one is not to be included in -mm=20

Enough talk. The patch is attached below and available at:
http://kernel.kolivas.org/2.5
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/DpcyF6dfvkL3i1gRAjp9AJ9S30i7ZQjpM7ETsxchKuLnDaL8GgCfb9OU
xl8PGFqY5BXEWPs83OaUCLY=3D
=3DcUdC
=2D----END PGP SIGNATURE-----

--Boundary-00=_ycpD/PyPw4utzLz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-SI-0307111938"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-SI-0307111938"

--- linux-2.5.74-mm3/include/linux/sched.h	2003-07-10 10:23:14.000000000 +1000
+++ linux-2.5.74-test/include/linux/sched.h	2003-07-11 19:35:37.000000000 +1000
@@ -125,6 +125,7 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_ISO		3
 
 struct sched_param {
 	int sched_priority;
--- linux-2.5.74-mm3/kernel/exit.c	2003-07-10 10:23:14.000000000 +1000
+++ linux-2.5.74-test/kernel/exit.c	2003-07-11 19:35:37.000000000 +1000
@@ -223,7 +223,7 @@ void reparent_to_init(void)
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL || current->policy == SCHED_ISO) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
--- linux-2.5.74-mm3/kernel/sched.c	2003-07-11 19:43:34.000000000 +1000
+++ linux-2.5.74-test/kernel/sched.c	2003-07-11 19:38:09.000000000 +1000
@@ -76,7 +76,6 @@
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
-#define SLEEP_BUFFER		(HZ/20)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
 
@@ -118,6 +117,8 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define iso_task(p)		((p)->policy == SCHED_ISO)
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -134,7 +135,10 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	if (iso_task(p))
+		return (BASE_TIMESLICE(p) / 5 ? : 1);
+	else
+		return BASE_TIMESLICE(p);
 }
 
 /*
@@ -319,6 +323,10 @@ static inline void normalise_sleep(task_
 
 	p->sleep_avg = p->sleep_avg * MIN_SLEEP_AVG / old_avg_time;
 	p->avg_start = jiffies - MIN_SLEEP_AVG;
+
+	if (iso_task(p))
+		p->policy = SCHED_NORMAL;
+
 }
 
 /*
@@ -343,26 +351,32 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	sleep_period = jiffies - p->avg_start;
+	if (!iso_task(p)){
+		sleep_period = jiffies - p->avg_start;
 
-	if (unlikely(!sleep_period))
-		return p->static_prio;
+		if (unlikely(!sleep_period))
+			return p->static_prio;
 
-	if (sleep_period > MAX_SLEEP_AVG)
-		sleep_period = MAX_SLEEP_AVG;
+		if (sleep_period > MAX_SLEEP_AVG)
+			sleep_period = MAX_SLEEP_AVG;
 
-	if (p->sleep_avg > sleep_period)
-		sleep_period = p->sleep_avg;
+		if (p->sleep_avg > sleep_period)
+			sleep_period = p->sleep_avg;
 
-	/*
-	 * The bonus is determined according to the accumulated
-	 * sleep avg over the duration the task has been running
-	 * until it reaches MAX_SLEEP_AVG. -ck
-	 */
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+		/*
+		 * The bonus is determined according to the accumulated
+		 * sleep avg over the duration the task has been running
+		 * until it reaches MAX_SLEEP_AVG. -ck
+		 */
+		bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
+				MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+
+	} else
+		bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO/100 -
+				MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
+
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
@@ -401,6 +415,8 @@ static inline void activate_task(task_t 
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
 				MAX_BONUS;
+			if (iso_task(p))
+				p->policy = SCHED_NORMAL;
 		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -422,13 +438,11 @@ static inline void activate_task(task_t 
 					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
 					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
 
-			/*
-			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
-			 * prevent fully interactive tasks from becoming
-			 * lower priority with small bursts of cpu usage.
-			 */
-			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
-				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
+			if (p->sleep_avg > MAX_SLEEP_AVG){
+				if (p->policy == SCHED_NORMAL)
+					p->policy = SCHED_ISO;
+				p->sleep_avg = MAX_SLEEP_AVG;
+			}
 		}
 
 		if (unlikely(p->avg_start > jiffies)){
@@ -1813,7 +1827,7 @@ static int setscheduler(pid_t pid, int p
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+				policy != SCHED_NORMAL && policy != SCHED_ISO)
 			goto out_unlock;
 	}
 
@@ -1824,7 +1838,7 @@ static int setscheduler(pid_t pid, int p
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL || policy == SCHED_ISO) != (lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -1846,7 +1860,7 @@ static int setscheduler(pid_t pid, int p
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	oldprio = p->prio;
-	if (policy != SCHED_NORMAL)
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2147,6 +2161,9 @@ asmlinkage long sys_sched_get_priority_m
 	case SCHED_NORMAL:
 		ret = 0;
 		break;
+	case SCHED_ISO:
+		ret = 0;
+		break;
 	}
 	return ret;
 }
@@ -2169,6 +2186,8 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 		ret = 0;
+	case SCHED_ISO:
+		ret = 0;
 	}
 	return ret;
 }

--Boundary-00=_ycpD/PyPw4utzLz--

