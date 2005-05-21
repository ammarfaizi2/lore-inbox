Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVEUFB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVEUFB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 01:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVEUFB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 01:01:27 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:53936 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261655AbVEUFAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 01:00:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] SCHED: Implement nice support across physical cpus on SMP
Date: Sat, 21 May 2005 15:00:39 +1000
User-Agent: KMail/1.8
Cc: ck@vds.kolivas.org, Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <20050518113016.GL1399@nysv.org> <200505182345.22614.kernel@kolivas.org>
In-Reply-To: <200505182345.22614.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2372724.TEyfic6Ykm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505211500.42527.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2372724.TEyfic6Ykm
Content-Type: multipart/mixed;
  boundary="Boundary-01=_4BsjCyHJpzWbIc4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_4BsjCyHJpzWbIc4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok I've respun the smp nice support for the cpu scheduler modifications tha=
t=20
are in current -mm. Tested on 2.6.12-rc4-mm2 on 4x and seems to work fine.

Con
=2D--


--Boundary-01=_4BsjCyHJpzWbIc4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-implement_smp_nice_support.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-implement_smp_nice_support.diff"

This patch implements 'nice' support across physical cpus on SMP.

It introduces an extra runqueue variable prio_bias which is the sum of the
(inverted) static priorities of all the tasks on the runqueue. This is then=
 used
to bias busy rebalancing between runqueues to obtain good distribution of t=
asks
of different nice values. By biasing the balancing only during busy rebalan=
cing
we can avoid having any significant loss of throughput by not affecting the
carefully tuned idle balancing already in place. If all tasks are running a=
t the
same nice level this code should also have minimal effect. The code is opti=
mised
out in the !CONFIG_SMP case.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc4-mm2/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc4-mm2.orig/kernel/sched.c	2005-05-21 11:14:49.00000000=
0 +1000
+++ linux-2.6.12-rc4-mm2/kernel/sched.c	2005-05-21 14:25:07.000000000 +1000
@@ -208,6 +208,7 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
+	unsigned long prio_bias;
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -657,13 +658,45 @@ static int effective_prio(task_t *p)
 	return prio;
 }
=20
+#ifdef CONFIG_SMP
+static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+{
+	rq->prio_bias +=3D MAX_PRIO - static_prio;
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+{
+	rq->prio_bias -=3D MAX_PRIO - static_prio;
+}
+#else
+static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+{
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+{
+}
+#endif
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	inc_prio_bias(rq, p->static_prio);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	dec_prio_bias(rq, p->static_prio);
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
=2D	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
=20
 /*
@@ -672,7 +705,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
=2D	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
=20
 static void recalc_task_prio(task_t *p, unsigned long long now)
@@ -791,7 +824,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
=2D	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array =3D NULL;
 }
@@ -928,27 +961,54 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
=2Dstatic inline unsigned long source_load(int cpu, int type)
+static inline unsigned long __source_load(int cpu, int type, enum idle_typ=
e idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load =3D rq->cpu_load[type-1],
+		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+
+	if (idle =3D=3D NOT_IDLE) {
+		/*
+		 * If we are balancing busy runqueues the load is biased by
+		 * priority to create 'nice' support across cpus.
+		 */
+		cpu_load *=3D rq->prio_bias;
+		load_now *=3D rq->prio_bias;
+	}
+
 	if (type =3D=3D 0)
 		return load_now;
=20
=2D	return min(rq->cpu_load[type-1], load_now);
+	return min(cpu_load, load_now);
+}
+
+static inline unsigned long source_load(int cpu, int type)
+{
+	return __source_load(cpu, type, NOT_IDLE);
 }
=20
 /*
  * Return a high guess at the load of a migration-target cpu
  */
=2Dstatic inline unsigned long target_load(int cpu, int type)
+static inline unsigned long __target_load(int cpu, int type, enum idle_typ=
e idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load =3D rq->cpu_load[type-1],
+		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+
 	if (type =3D=3D 0)
 		return load_now;
=20
=2D	return max(rq->cpu_load[type-1], load_now);
+	if (idle =3D=3D NOT_IDLE) {
+		cpu_load *=3D rq->prio_bias;
+		load_now *=3D rq->prio_bias;
+	}
+	return max(cpu_load, load_now);
+}
+
+static inline unsigned long target_load(int cpu, int type)
+{
+	return __target_load(cpu, type, NOT_IDLE);
 }
=20
 /*
@@ -1389,7 +1449,7 @@ void fastcall wake_up_new_task(task_t *=20
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array =3D current->array;
 				p->array->nr_active++;
=2D				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1733,9 +1793,9 @@ void pull_task(runqueue_t *src_rq, prio_
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
 	dequeue_task(p, src_array);
=2D	src_rq->nr_running--;
+	dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
=2D	this_rq->nr_running++;
+	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
 	p->timestamp =3D (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1909,9 +1969,9 @@ find_busiest_group(struct sched_domain *
 		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
=2D				load =3D target_load(i, load_idx);
+				load =3D __target_load(i, load_idx, idle);
 			else
=2D				load =3D source_load(i, load_idx);
+				load =3D __source_load(i, load_idx, idle);
=20
 			avg_load +=3D load;
 		}
@@ -2012,14 +2072,15 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
=2Dstatic runqueue_t *find_busiest_queue(struct sched_group *group)
+static runqueue_t *find_busiest_queue(struct sched_group *group,
+	enum idle_type idle)
 {
 	unsigned long load, max_load =3D 0;
 	runqueue_t *busiest =3D NULL;
 	int i;
=20
 	for_each_cpu_mask(i, group->cpumask) {
=2D		load =3D source_load(i, 0);
+		load =3D __source_load(i, 0, idle);
=20
 		if (load > max_load) {
 			max_load =3D load;
@@ -2060,7 +2121,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
=20
=2D	busiest =3D find_busiest_queue(group);
+	busiest =3D find_busiest_queue(group, idle);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2168,7 +2229,7 @@ static int load_balance_newidle(int this
 		goto out_balanced;
 	}
=20
=2D	busiest =3D find_busiest_queue(group);
+	busiest =3D find_busiest_queue(group, NEWLY_IDLE);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -3338,7 +3399,9 @@ void set_user_nice(task_t *p, long nice)
 	 * not SCHED_NORMAL:
 	 */
 	if (rt_task(p)) {
+		dec_prio_bias(rq, p->static_prio);
 		p->static_prio =3D NICE_TO_PRIO(nice);
+		inc_prio_bias(rq, p->static_prio);
 		goto out_unlock;
 	}
 	array =3D p->array;
@@ -3348,7 +3411,9 @@ void set_user_nice(task_t *p, long nice)
 	old_prio =3D p->prio;
 	new_prio =3D NICE_TO_PRIO(nice);
 	delta =3D new_prio - old_prio;
+	dec_prio_bias(rq, p->static_prio);
 	p->static_prio =3D NICE_TO_PRIO(nice);
+	inc_prio_bias(rq, p->static_prio);
 	p->prio +=3D delta;
=20
 	if (array) {

--Boundary-01=_4BsjCyHJpzWbIc4--

--nextPart2372724.TEyfic6Ykm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCjsB6ZUg7+tp6mRURAt2uAKCVEE7PZoxHJN4OaiBhNnIFGhhsnACgiN32
QhzHpW0uOy/Oh2zVUvYyrx4=
=Yrag
-----END PGP SIGNATURE-----

--nextPart2372724.TEyfic6Ykm--
