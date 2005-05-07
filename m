Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVEGNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVEGNnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVEGNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:43:40 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:33202 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263131AbVEGNmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:42:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] implement nice support across physical cpus on SMP
Date: Sat, 7 May 2005 23:42:30 +1000
User-Agent: KMail/1.8
Cc: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3038576.50qBMZtnpv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505072342.32997.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3038576.50qBMZtnpv
Content-Type: multipart/mixed;
  boundary="Boundary-01=_GXMfCpNJnzScbEl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_GXMfCpNJnzScbEl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

SMP balancing is currently designed purely with throughput in mind. This=20
working patch implements a mechanism for supporting 'nice' across physical=
=20
cpus without impacting throughput.

This is a version for stable kernel 2.6.11.*

Carlos, if you could test this with your test case it would be appreciated.

Ingo, comments?

Cheers,
Con

--Boundary-01=_GXMfCpNJnzScbEl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cross_cpu_smp_nice_support.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="cross_cpu_smp_nice_support.diff"

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

Index: linux-2.6.11-smpnice/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.11-smpnice.orig/kernel/sched.c	2005-03-02 19:30:30.00000000=
0 +1100
+++ linux-2.6.11-smpnice/kernel/sched.c	2005-05-07 23:25:15.000000000 +1000
@@ -204,6 +204,7 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
+	unsigned long prio_bias;
 	unsigned long cpu_load;
 #endif
 	unsigned long long nr_switches;
@@ -628,13 +629,45 @@ static int effective_prio(task_t *p)
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
@@ -643,7 +676,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
=2D	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
=20
 static void recalc_task_prio(task_t *p, unsigned long long now)
@@ -761,7 +794,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
=2D	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array =3D NULL;
 }
@@ -909,23 +942,37 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
=2Dstatic inline unsigned long source_load(int cpu)
+static inline unsigned long source_load(int cpu, enum idle_type idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load =3D rq->cpu_load,
+		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
=20
=2D	return min(rq->cpu_load, load_now);
+	if (idle =3D=3D NOT_IDLE) {
+		/*
+		 * If we are balancing busy runqueues the load is biased by
+		 * priority to create 'nice' support across cpus.
+		 */
+		cpu_load +=3D rq->prio_bias;
+		load_now +=3D rq->prio_bias;
+	}
+	return min(cpu_load, load_now);
 }
=20
 /*
  * Return a high guess at the load of a migration-target cpu
  */
=2Dstatic inline unsigned long target_load(int cpu)
+static inline unsigned long target_load(int cpu, enum idle_type idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load =3D rq->cpu_load,
+		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
=20
=2D	return max(rq->cpu_load, load_now);
+	if (idle =3D=3D NOT_IDLE) {
+		cpu_load +=3D rq->prio_bias;
+		load_now +=3D rq->prio_bias;
+	}
+	return max(cpu_load, load_now);
 }
=20
 #endif
@@ -1015,8 +1062,8 @@ static int try_to_wake_up(task_t * p, un
 	if (cpu =3D=3D this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)=
))
 		goto out_set_cpu;
=20
=2D	load =3D source_load(cpu);
=2D	this_load =3D target_load(this_cpu);
+	load =3D source_load(cpu, SCHED_IDLE);
+	this_load =3D target_load(this_cpu, SCHED_IDLE);
=20
 	/*
 	 * If sync wakeup then subtract the (maximum possible) effect of
@@ -1240,7 +1287,7 @@ void fastcall wake_up_new_task(task_t *=20
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array =3D current->array;
 				p->array->nr_active++;
=2D				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1524,7 +1571,7 @@ static int find_idlest_cpu(struct task_s
 	cpus_and(mask, sd->span, p->cpus_allowed);
=20
 	for_each_cpu_mask(i, mask) {
=2D		load =3D target_load(i);
+		load =3D target_load(i, SCHED_IDLE);
=20
 		if (load < min_load) {
 			min_cpu =3D i;
@@ -1537,7 +1584,7 @@ static int find_idlest_cpu(struct task_s
 	}
=20
 	/* add +1 to account for the new task */
=2D	this_load =3D source_load(this_cpu) + SCHED_LOAD_SCALE;
+	this_load =3D source_load(this_cpu, SCHED_IDLE) + SCHED_LOAD_SCALE;
=20
 	/*
 	 * Would with the addition of the new task to the
@@ -1630,9 +1677,9 @@ void pull_task(runqueue_t *src_rq, prio_
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
@@ -1790,9 +1837,9 @@ find_busiest_group(struct sched_domain *
 		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
=2D				load =3D target_load(i);
+				load =3D target_load(i, idle);
 			else
=2D				load =3D source_load(i);
+				load =3D source_load(i, idle);
=20
 			nr_cpus++;
 			avg_load +=3D load;
@@ -1904,14 +1951,14 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
=2Dstatic runqueue_t *find_busiest_queue(struct sched_group *group)
+static runqueue_t *find_busiest_queue(struct sched_group *group, enum idle=
_type idle)
 {
 	unsigned long load, max_load =3D 0;
 	runqueue_t *busiest =3D NULL;
 	int i;
=20
 	for_each_cpu_mask(i, group->cpumask) {
=2D		load =3D source_load(i);
+		load =3D source_load(i, idle);
=20
 		if (load > max_load) {
 			max_load =3D load;
@@ -1945,7 +1992,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
=20
=2D	busiest =3D find_busiest_queue(group);
+	busiest =3D find_busiest_queue(group, idle);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2049,7 +2096,7 @@ static int load_balance_newidle(int this
 		goto out;
 	}
=20
=2D	busiest =3D find_busiest_queue(group);
+	busiest =3D find_busiest_queue(group, NEWLY_IDLE);
 	if (!busiest || busiest =3D=3D this_rq) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out;
@@ -3245,7 +3292,9 @@ void set_user_nice(task_t *p, long nice)
 	 * not SCHED_NORMAL:
 	 */
 	if (rt_task(p)) {
+		dec_prio_bias(rq, p->static_prio);
 		p->static_prio =3D NICE_TO_PRIO(nice);
+		inc_prio_bias(rq, p->static_prio);
 		goto out_unlock;
 	}
 	array =3D p->array;
@@ -3255,7 +3304,9 @@ void set_user_nice(task_t *p, long nice)
 	old_prio =3D p->prio;
 	new_prio =3D NICE_TO_PRIO(nice);
 	delta =3D new_prio - old_prio;
+	dec_prio_bias(rq, p->static_prio);
 	p->static_prio =3D NICE_TO_PRIO(nice);
+	inc_prio_bias(rq, p->static_prio);
 	p->prio +=3D delta;
=20
 	if (array) {

--Boundary-01=_GXMfCpNJnzScbEl--

--nextPart3038576.50qBMZtnpv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBCfMXIZUg7+tp6mRURAqW6AJY5OFMpr7Wad1ruDTTv/iBh9hxpAJ402kvU
c2LEiy072AIO3YzO2lsy7Q==
=7FG8
-----END PGP SIGNATURE-----

--nextPart3038576.50qBMZtnpv--
