Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTANQm2>; Tue, 14 Jan 2003 11:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbTANQm2>; Tue, 14 Jan 2003 11:42:28 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:15884 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264745AbTANQmZ>; Tue, 14 Jan 2003 11:42:25 -0500
Date: Tue, 14 Jan 2003 16:51:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <20030114165108.A7033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301141214.12323.efocht@ess.nec.de> <200301141655.06660.efocht@ess.nec.de> <200301141723.29613.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301141723.29613.efocht@ess.nec.de>; from efocht@ess.nec.de on Tue, Jan 14, 2003 at 05:23:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#else
+#define sched_balance_exec() {}
+#endif

You accidentally (?) removed the stub for node_nr_running_init.
Also sched.h used # define inside ifdefs.

+#ifdef CONFIG_NUMA
+	atomic_t * node_ptr;

The name is still a bit non-descriptive and the * placed wrong :)
What about atomic_t *nr_running_at_node?


 
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+

I think my two comments here were pretty usefull :)

+static inline void nr_running_dec(runqueue_t *rq)
+{
+	atomic_dec(rq->node_ptr);
+	rq->nr_running--;
+}
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+}
+#else
+# define nr_running_init(rq)   do { } while (0)
+# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+#endif /* CONFIG_NUMA */
+
 /*
@@ -689,7 +811,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask) )

spurious whitespace before the closing brace.

 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
+	int this_node = __cpu_to_node(this_cpu);
+	unsigned long cpumask = __node_to_cpu_mask(this_node);

If that's not to much style nitpicking: put this_node on one line with all the
other local ints and initialize all three vars after the declarations (like
in my patch *duck*)

 
+#if CONFIG_NUMA
+		rq->node_ptr = &node_nr_running[0];
+#endif /* CONFIG_NUMA */

I had a nr_running_init() abstraction for this, but you only took it
partially. It would be nice to merge the last bit to get rid of this ifdef.

Else the patch looks really, really good and I'm looking forward to see
it in mainline real soon!
