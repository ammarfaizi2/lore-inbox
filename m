Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290659AbSAYMaq>; Fri, 25 Jan 2002 07:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290653AbSAYMaW>; Fri, 25 Jan 2002 07:30:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17305 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290655AbSAYM0q>;
	Fri, 25 Jan 2002 07:26:46 -0500
Date: Fri, 25 Jan 2002 15:24:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] cpu_logical_map fixes, balancing, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201251519460.7264-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch from James Bottomley fixes 1:1 phys/logical CPU ID
assumptions in the new scheduler.

the patch also cleans up an issue noticed by Mike Kravetz: load_balance()
should re-check the true runqueue length after acquiring the runqueue
lock.

(the two changes touch the same code areas so they are in a single patch.)

	Ingo

--- linux/kernel/fork.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/fork.c	Fri Jan 25 12:06:36 2002
@@ -647,11 +647,10 @@
 	{
 		int i;

-		p->cpu = smp_processor_id();
-
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < smp_num_cpus; i++)
-			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
+			p->per_cpu_utime[cpu_logical_map(i)] =
+				p->per_cpu_stime[cpu_logical_map(i)] = 0;
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -325,7 +346,7 @@
 	unsigned long i, sum = 0;

 	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(i)->nr_running;
+		sum += cpu_rq(cpu_logical_map(i))->nr_running;

 	return sum;
 }
@@ -335,12 +356,34 @@
 	unsigned long i, sum = 0;

 	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(i)->nr_switches;
+		sum += cpu_rq(cpu_logical_map(i))->nr_switches;

 	return sum;
 }

 /*
+ * Lock the busiest runqueue as well, this_rq is locked already.
+ * Recalculate nr_running if we have to drop the runqueue lock.
+ */
+static inline unsigned int double_lock_balance(runqueue_t *this_rq,
+	runqueue_t *busiest, int this_cpu, int idle, unsigned int nr_running)
+{
+	if (unlikely(!spin_trylock(&busiest->lock))) {
+		if (busiest < this_rq) {
+			spin_unlock(&this_rq->lock);
+			spin_lock(&busiest->lock);
+			spin_lock(&this_rq->lock);
+			/* Need to recalculate nr_running */
+			if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+				nr_running = this_rq->nr_running;
+			else
+				nr_running = this_rq->prev_nr_running[this_cpu];
+		} else
+			spin_lock(&busiest->lock);
+	}
+	return nr_running;
+}
+/*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
  * busiest runqueue(s).
@@ -350,8 +393,8 @@
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, nr_running, load, prev_max_load,
-		max_load, idx, i, this_cpu = smp_processor_id();
+	int imbalance, nr_running, load, max_load,
+		idx, i, this_cpu = smp_processor_id();
 	task_t *next = this_rq->idle, *tmp;
 	runqueue_t *busiest, *rq_src;
 	prio_array_t *array;
@@ -383,20 +426,18 @@
 		nr_running = this_rq->nr_running;
 	else
 		nr_running = this_rq->prev_nr_running[this_cpu];
-	prev_max_load = 1000000000;

 	busiest = NULL;
-	max_load = 0;
+	max_load = 1;
 	for (i = 0; i < smp_num_cpus; i++) {
-		rq_src = cpu_rq(i);
+		rq_src = cpu_rq(cpu_logical_map(i));
 		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
 			load = rq_src->nr_running;
 		else
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;

-		if ((load > max_load) && (load < prev_max_load) &&
-						(rq_src != this_rq)) {
+		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
 			max_load = load;
 		}
@@ -407,32 +448,16 @@

 	imbalance = (max_load - nr_running) / 2;

-	/*
-	 * It needs an at least ~25% imbalance to trigger balancing.
-	 *
-	 * prev_max_load makes sure that we do not try to balance
-	 * ad infinitum - certain tasks might be impossible to be
-	 * pulled into this runqueue.
-	 */
+	/* It needs an at least ~25% imbalance to trigger balancing. */
 	if (!idle && (imbalance < (max_load + 3)/4))
 		return;
-	prev_max_load = max_load;

-	/*
-	 * Ok, lets do some actual balancing:
-	 */
-
-	if (busiest < this_rq) {
-		spin_unlock(&this_rq->lock);
-		spin_lock(&busiest->lock);
-		spin_lock(&this_rq->lock);
-	} else
-		spin_lock(&busiest->lock);
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
 	/*
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
 	 */
-	if (busiest->nr_running <= nr_running + 1)
+	if (busiest->nr_running <= this_rq->nr_running + 1)
 		goto out_unlock;

 	/*




