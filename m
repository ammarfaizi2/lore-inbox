Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161539AbWAMKXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539AbWAMKXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWAMKXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:23:18 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:25576 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161538AbWAMKXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:23:16 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] sched-cleanup_task_activated.patch
Date: Fri, 13 Jan 2006 21:22:59 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 4888
Content-Type: multipart/signed;
  boundary="nextPart2440201.Y0TQYkgF8u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132123.01338.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2440201.Y0TQYkgF8u
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The activated flag in task_struct is used to track different sleep types
and its usage is somewhat obfuscated. Convert the variable to an enum with
more descriptive names without altering the function.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/sched.h |    9 ++++++++-
 kernel/sched.c        |   24 +++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

Index: linux-2.6.15/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/include/linux/sched.h
+++ linux-2.6.15/include/linux/sched.h
@@ -683,6 +683,13 @@ static inline void prefetch_stack(struct
 struct audit_context;		/* See audit.c */
 struct mempolicy;
=20
+enum sleep_type {
+	SLEEP_NORMAL,
+	SLEEP_NONINTERACTIVE,
+	SLEEP_INTERACTIVE,
+	SLEEP_INTERRUPTED,
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -704,7 +711,7 @@ struct task_struct {
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
=2D	int activated;
+	enum sleep_type sleep_type;
=20
 	unsigned long policy;
 	cpumask_t cpus_allowed;
Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -751,7 +751,7 @@ static int recalc_task_prio(task_t *p, u
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
=2D		if (p->mm && p->activated !=3D -1 &&
+		if (p->mm && p->sleep_type !=3D SLEEP_NONINTERACTIVE &&
 			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
@@ -767,7 +767,7 @@ static int recalc_task_prio(task_t *p, u
 			 * limited in their sleep_avg rise as they
 			 * are likely to be waiting on I/O
 			 */
=2D			if (p->activated =3D=3D -1 && p->mm) {
+			if (p->sleep_type =3D=3D SLEEP_NONINTERACTIVE && p->mm) {
 				if (p->sleep_avg >=3D INTERACTIVE_SLEEP(p))
 					sleep_time =3D 0;
 				else if (p->sleep_avg + sleep_time >=3D
@@ -822,7 +822,7 @@ static void activate_task(task_t *p, run
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
=2D	if (!p->activated) {
+	if (p->sleep_type =3D=3D SLEEP_NORMAL) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -831,13 +831,13 @@ static void activate_task(task_t *p, run
 		 * on a CPU, first time around:
 		 */
 		if (in_interrupt())
=2D			p->activated =3D 2;
+			p->sleep_type =3D SLEEP_INTERRUPTED;
 		else {
 			/*
 			 * Normal first-time wakeups get a credit too for
 			 * on-runqueue time, but it will be weighted down:
 			 */
=2D			p->activated =3D 1;
+			p->sleep_type =3D SLEEP_INTERACTIVE;
 		}
 	}
 	p->timestamp =3D now;
@@ -1359,7 +1359,7 @@ out_activate:
 		 * Tasks on involuntary sleep don't earn
 		 * sleep_avg beyond just interactive state.
 		 */
=2D		p->activated =3D -1;
+		p->sleep_type =3D SLEEP_NONINTERACTIVE;
 	}
=20
 	/*
@@ -2938,6 +2938,12 @@ EXPORT_SYMBOL(sub_preempt_count);
=20
 #endif
=20
+static inline int interactive_sleep(enum sleep_type sleep_type)
+{
+	return (sleep_type =3D=3D SLEEP_INTERACTIVE ||
+		sleep_type =3D=3D SLEEP_INTERRUPTED);
+}
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -3063,12 +3069,12 @@ go_idle:
 	queue =3D array->queue + idx;
 	next =3D list_entry(queue->next, task_t, run_list);
=20
=2D	if (!rt_task(next) && next->activated > 0) {
+	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
 		unsigned long long delta =3D now - next->timestamp;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta =3D 0;
=20
=2D		if (next->activated =3D=3D 1)
+		if (next->sleep_type =3D=3D SLEEP_INTERACTIVE)
 			delta =3D delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
=20
 		array =3D next->array;
@@ -3081,7 +3087,7 @@ go_idle:
 		} else
 			requeue_task(next, array);
 	}
=2D	next->activated =3D 0;
+	next->sleep_type =3D SLEEP_NORMAL;
 switch_tasks:
 	if (next =3D=3D rq->idle)
 		schedstat_inc(rq, sched_goidle);

--nextPart2440201.Y0TQYkgF8u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx3+FZUg7+tp6mRURAtEsAJ9m0agiyshs4ZnIxJRciEd/kwXI+ACdFQLN
gZ1sJ3iTHdyWs6gR9r8mPSA=
=tCd9
-----END PGP SIGNATURE-----

--nextPart2440201.Y0TQYkgF8u--
