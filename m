Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSJWRsm>; Wed, 23 Oct 2002 13:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbSJWRsl>; Wed, 23 Oct 2002 13:48:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:29399 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265134AbSJWRs2>;
	Wed, 23 Oct 2002 13:48:28 -0400
Subject: [PATCH 2.5.44] Simple NUMA Scheduler rev4 (1/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Cc: Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-lInDP8kWV3HlK+CSnegB"
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 10:53:17 -0700
Message-Id: <1035395598.9367.1037.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lInDP8kWV3HlK+CSnegB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is my simple NUMA scheduler patch.  It has been split into
two separate patches, the first part is a modification to 
find_busiest_queue to favor runqueues for processors on the same
node.  Care was taken to ensure that the change to find_busiest_queue
would not change the selection criteria used for non-NUMA machines.

The second patch adds logic to exec to place the exec'd task on
the least loaded runqueue, thus avoiding the need to move the task
to a different (potentially off-node) runqueue in the immediate 
future.  This patch needs the first patch to apply, but could be
easily changed to apply to a kernel without the first patch.

There are no functional changes between these two patches and the
patch provided for 2.5.43.  As stated then:

On NUMA systems these two changes have shown performance gains 
in the 5 - 10% range depending on tests.  Some micro-benchmarks 
provided by Erich Focht which stress the memory subsystem show
a doubling in performance.

The simple NUMA scheduler patch has been included in the
linux-2.5.44dcl1 kernel so has seen additional testing with no
issues reported.  I would welcome additional testers or inclusion
in other 2.5 kernel trees.  

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-lInDP8kWV3HlK+CSnegB
Content-Disposition: attachment; filename=sched44rev4.part1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sched44rev4.part1; charset=ISO-8859-1

--- clean-2.5.44/kernel/sched.c	Wed Oct 23 09:25:06 2002
+++ linux-2.5.44/kernel/sched.c	Wed Oct 23 09:24:41 2002
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <asm/topology.h>
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -639,15 +640,35 @@ static inline unsigned int double_lock_b
  */
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this=
_cpu, int idle, int *imbalance)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+	int nr_running, load, max_load_on_node, max_load_off_node, i;
+	runqueue_t *busiest, *busiest_on_node, *busiest_off_node, *rq_src;
=20
 	/*
-	 * We search all runqueues to find the most busy one.
+	 * This routine is designed to work on NUMA systems.  For
+	 * non-NUMA systems, everything ends up being on the same
+	 * node and most of the NUMA specific logic is optimized
+	 * away by the compiler.
+	 *=20
+	 * We must look at each runqueue to update prev_nr_running.
+	 * As we do so, we find the busiest runqueue on the same
+	 * node, and the busiest runqueue off the node.  After
+	 * determining the busiest from each we first see if the
+	 * busiest runqueue on node meets the imbalance criteria.
+	 * If not, then we check the off queue runqueue.  Note that
+	 * we require a higher level of imbalance for choosing an
+	 * off node runqueue.
+	 *
+	 * For off-node, we only move at most one process, so imbalance
+	 * is always set to one for off-node runqueues.
+	 *=20
 	 * We do this lockless to reduce cache-bouncing overhead,
 	 * we re-check the 'best' source CPU later on again, with
 	 * the lock held.
 	 *
+	 * Note that this routine is called with the current runqueue
+	 * locked, and if a runqueue is found (return !=3D NULL), then
+	 * that runqueue is returned locked, also.
+	 *
 	 * We fend off statistical fluctuations in runqueue lengths by
 	 * saving the runqueue length during the previous load-balancing
 	 * operation and using the smaller one the current and saved lengths.
@@ -669,8 +690,12 @@ static inline runqueue_t *find_busiest_q
 	else
 		nr_running =3D this_rq->prev_nr_running[this_cpu];
=20
+	busiest_on_node =3D NULL;
+	busiest_off_node =3D NULL;
 	busiest =3D NULL;
-	max_load =3D 1;
+	max_load_on_node =3D 1;
+	max_load_off_node =3D 3;
+=09
 	for (i =3D 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
@@ -682,33 +707,44 @@ static inline runqueue_t *find_busiest_q
 			load =3D this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] =3D rq_src->nr_running;
=20
-		if ((load > max_load) && (rq_src !=3D this_rq)) {
-			busiest =3D rq_src;
-			max_load =3D load;
+		if (__cpu_to_node(i) =3D=3D __cpu_to_node(this_cpu)) {
+			if ((load > max_load_on_node) && (rq_src !=3D this_rq)) {
+				busiest_on_node =3D rq_src;
+				max_load_on_node =3D load;
+			}
+		} else {
+			if (load > max_load_off_node)  {
+				busiest_off_node =3D rq_src;
+				max_load_off_node =3D load;
+			}
 		}
 	}
-
-	if (likely(!busiest))
-		goto out;
-
-	*imbalance =3D (max_load - nr_running) / 2;
-
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest =3D NULL;
-		goto out;
+	if (busiest_on_node) {
+		/* on node balancing happens if there is > 125% difference */
+		*imbalance =3D (max_load_on_node - nr_running) / 2;
+		if (idle || (*imbalance >=3D  (max_load_on_node + 3)/4)) {
+			busiest =3D busiest_on_node;
+		}
 	}
-
-	nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_r=
unning);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <=3D nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest =3D NULL;
+	if (busiest_off_node && !busiest) {
+		/* off node balancing requires 400% difference */
+		/*if ((nr_running*4 >=3D max_load_off_node) && !idle) */
+		if (nr_running*4 >=3D max_load_off_node)=20
+			return NULL;
+		busiest =3D busiest_off_node;=20
+		*imbalance =3D 1;
+	}=20
+	if (busiest) {
+		nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_=
running);
+		/*
+		 * Make sure nothing changed since we checked the
+		 * runqueue length.
+		 */
+		if (busiest->nr_running <=3D nr_running + 1) {
+			spin_unlock(&busiest->lock);
+			busiest =3D NULL;
+		}
 	}
-out:
 	return busiest;
 }
=20

--=-lInDP8kWV3HlK+CSnegB--

