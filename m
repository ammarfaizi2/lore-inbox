Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbTANQeN>; Tue, 14 Jan 2003 11:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTANQeM>; Tue, 14 Jan 2003 11:34:12 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:28045 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264743AbTANQeJ>; Tue, 14 Jan 2003 11:34:09 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2.5.58] new NUMA scheduler: fix
Date: Tue, 14 Jan 2003 17:43:25 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301141655.06660.efocht@ess.nec.de> <200301141723.29613.efocht@ess.nec.de>
In-Reply-To: <200301141723.29613.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DGQP1D0Z3DJER6OZAYHJ"
Message-Id: <200301141743.25513.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DGQP1D0Z3DJER6OZAYHJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Aargh, I should have gone home earlier...
For those who really care about patch 05, it's attached. It's all
untested as I don't have a ia32 NUMA machine running 2.5.58...

Erich


On Tuesday 14 January 2003 17:23, Erich Focht wrote:
> In the previous email the patch 02-initial-lb-2.5.58.patch had a bug
> and this was present in the numa-sched-2.5.58.patch and
> numa-sched-add-2.5.58.patch, too. Please use the patches attached to
> this email! Sorry for the silly mistake...
>
> Christoph, I used your way of coding nr_running_inc/dec now.
>
> Regards,
> Erich

--------------Boundary-00=_DGQP1D0Z3DJER6OZAYHJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="05-var-intnode-lb-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="05-var-intnode-lb-2.5.58.patch"

diff -urNp 2.5.58-ms-ilb-nb-sm/kernel/sched.c 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c
--- 2.5.58-ms-ilb-nb-sm/kernel/sched.c	2003-01-14 17:11:48.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c	2003-01-14 17:36:26.000000000 +0100
@@ -67,8 +67,9 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
-#define NODE_BALANCE_RATIO	10
 #define NODE_THRESHOLD          125
+#define NODE_BALANCE_MIN	10
+#define NODE_BALANCE_MAX	40
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -186,6 +187,8 @@ static struct runqueue runqueues[NR_CPUS
 #if CONFIG_NUMA
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+static int internode_lb[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = NODE_BALANCE_MAX};
 
 static inline void nr_running_inc(runqueue_t *rq)
 {
@@ -735,15 +738,18 @@ void sched_balance_exec(void)
 static int find_busiest_node(int this_node)
 {
 	int i, node = -1, load, this_load, maxload;
+	int avg_load;
 	
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
 		+ atomic_read(&node_nr_running[this_node]);
 	this_rq()->prev_node_load[this_node] = this_load;
+	avg_load = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
 			+ atomic_read(&node_nr_running[i]);
+		avg_load += load;
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload &&
 		    (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
@@ -751,10 +757,26 @@ static int find_busiest_node(int this_no
 			node = i;
 		}
 	}
-	if (maxload <= 4+2+1)
+	avg_load = avg_load / (numnodes ? numnodes : 1);
+	if (this_load < (avg_load / 2)) {
+		if (internode_lb[this_node] == NODE_BALANCE_MAX)
+			internode_lb[this_node] = NODE_BALANCE_MIN;
+	} else
+		if (internode_lb[this_node] == NODE_BALANCE_MIN)
+			internode_lb[this_node] = NODE_BALANCE_MAX;
+	if (maxload <= 4+2+1 || this_load >= avg_load)
 		node = -1;
 	return node;
 }
+
+static inline int remote_steal_factor(runqueue_t *rq)
+{
+	int cpu = __cpu_to_node(task_cpu(rq->curr));
+
+	return (cpu == __cpu_to_node(smp_processor_id())) ? 1 : 2;
+}
+#else
+#define remote_steal_factor(rq) 1
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -903,7 +925,7 @@ static void load_balance(runqueue_t *thi
 	/*
 	 * Avoid rebalancing between nodes too often.
 	 */
-	if (!(++(this_rq->nr_balanced) % NODE_BALANCE_RATIO)) {
+	if (!(++(this_rq->nr_balanced) % internode_lb[this_node])) {
 		int node = find_busiest_node(this_node);
 		if (node >= 0)
 			cpumask = __node_to_cpu_mask(node) | (1UL << this_cpu);
@@ -967,7 +989,7 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
+	if (!idle && ((--imbalance)/remote_steal_factor(busiest))) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------Boundary-00=_DGQP1D0Z3DJER6OZAYHJ--

