Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbTAPS0w>; Thu, 16 Jan 2003 13:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTAPS0w>; Thu, 16 Jan 2003 13:26:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:51915 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267151AbTAPS0u>; Thu, 16 Jan 2003 13:26:50 -0500
Date: Thu, 16 Jan 2003 10:28:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/3) Minimal NUMA scheduler
Message-ID: <3260000.1042741702@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Martin J. Bligh

This adds a small hook to the find_busiest_queue routine to allow us to
specify a mask of which CPUs to search over. In the NUMA case, it will
only balance inside the node (much cheaper to search, and stops tasks 
from bouncing across nodes, which is very costly). The cpus_to_balance
routine is conditionally defined to ensure no impact to non-NUMA machines.

This is a tiny NUMA scheduler, but it needs the assistance of the second
and third patches in order to spread tasks across nodes.

diff -urpN -X /home/fletch/.diff.exclude virgin/kernel/sched.c numasched1/kernel/sched.c
--- virgin/kernel/sched.c	Mon Jan 13 21:09:28 2003
+++ numasched1/kernel/sched.c	Wed Jan 15 19:52:07 2003
@@ -624,6 +624,22 @@ static inline void double_rq_unlock(runq
 		spin_unlock(&rq2->lock);
 }
 
+#ifdef CONFIG_NUMA
+
+static inline unsigned long cpus_to_balance(int this_cpu)
+{
+	return __node_to_cpu_mask(__cpu_to_node(this_cpu));
+}
+
+#else /* !CONFIG_NUMA */
+
+static inline unsigned long cpus_to_balance(int this_cpu)
+{
+	return cpu_online_map;
+}
+
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP
 
 /*
@@ -652,9 +668,9 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +705,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!((1UL << i) & cpumask))
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -764,7 +780,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+					cpus_to_balance(this_cpu));
 	if (!busiest)
 		goto out;
 

