Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSLTPJc>; Fri, 20 Dec 2002 10:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSLTPJc>; Fri, 20 Dec 2002 10:09:32 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:32531 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262392AbSLTPJ3>; Fri, 20 Dec 2002 10:09:29 -0500
Date: Fri, 20 Dec 2002 15:17:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.52] NUMA scheduler (1/2)
Message-ID: <20021220151721.A636@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <200211191726.07214.efocht@ess.nec.de> <200212021629.39060.efocht@ess.nec.de> <200212181721.39434.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212181721.39434.efocht@ess.nec.de>; from efocht@ess.nec.de on Wed, Dec 18, 2002 at 05:21:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	2002-12-16 03:07:56.000000000 +0100
+++ b/arch/i386/kernel/smpboot.c	2002-12-18 16:53:12.000000000 +0100
@@ -1202,6 +1202,9 @@
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif

I think it would be much nicer if you had a proper stub for !CONFIG_NUMA..

@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
+#include <asm/topology.h>

Another header in sched.h??  And it doesn't look like it's used at all.

 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -446,6 +447,9 @@
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void build_node_data(void);
+#endif

The ifdef is superflous.

diff -urN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2002-12-16 03:08:14.000000000 +0100
+++ b/kernel/sched.c	2002-12-18 16:53:13.000000000 +0100
@@ -158,6 +158,10 @@
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
+
+	unsigned long wait_time;
+	int wait_node;
+

Here OTOH a #if CONFIG_MUA could help to avoid a little bit of bloat.

 } ____cacheline_aligned;
 
+#define cpu_to_node(cpu) __cpu_to_node(cpu)

I wonder why we don't have a proper cpu_to_node() yet, but as long
as it doesn't exist please use __cpu_to_node() directly.

+#define LOADSCALE 128

Any explanation?

+#ifdef CONFIG_NUMA

sched.c uses #if CONFIG_FOO, not #ifdef CONFIG_FOO, it would be cool
if you could follow the style of existing source files.

+/* Number of CPUs per node: sane values until all CPUs are up */
+int _node_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = NR_CPUS };
+int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus are sorted!)*/
+#define node_ncpus(node)  _node_nr_cpus[node]

Parametrized macros and variables aren't in the ßame namespace, what about
just node_nr_cpus for the macro, too.  And should these be static?

+
+#define NODE_DELAY_IDLE  (1*HZ/1000)
+#define NODE_DELAY_BUSY  (20*HZ/1000)

Comments, please..

+/* the following macro implies that logical CPUs are sorted by node number */
+#define loop_over_node(cpu,node) \
+	for(cpu=node_ptr[node]; cpu<node_ptr[node+1]; cpu++)

Move to asm/topology.h?

+	ptr=0;
+	for (n=0; n<numnodes; n++) {

You need to add lots of space to match Documentation/odingStyle.. :)

+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;

And linebreaks..

Btw, what about a for_each_cpu that has the cpu_online check in topology.h?

+	/* Wait longer before stealing if own node's load is average. */
+	if (NODES_BALANCED(avg_load,nd[this_node].average_load))

Shouldn't NODES_BALANCED shout less and be an inline called nodes_balanced?

+		this_rq->wait_node = busiest_node;
+		this_rq->wait_time = jiffies;
+		goto out;
+	} else
+	/* old most loaded node: check if waited enough */
+		if (jiffies - this_rq->wait_time < steal_delay)
+			goto out;

That indentation looks really strange, why not just

	/* old most loaded node: check if waited enough */
	} else if (jiffies - this_rq->wait_time < steal_delay)
		goto out;

+
+	if ((!CPUS_BALANCED(nd[busiest_node].busiest_cpu_load,*nr_running))) {

Dito, the name shouts a bit too much

+#endif

#endif /* CONFIG_NUMA */

-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)

And explanation why you changed that constant?

 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+

This looks like a bugfix valid without the rest of the patch.
