Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTAMHx2>; Mon, 13 Jan 2003 02:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAMHx2>; Mon, 13 Jan 2003 02:53:28 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:12303 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267153AbTAMHxZ>; Mon, 13 Jan 2003 02:53:25 -0500
Date: Mon, 13 Jan 2003 08:02:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: NUMA scheduler 2nd approach
Message-ID: <20030113080207.A9119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301101734.56182.efocht@ess.nec.de> <967810000.1042217859@titus> <200301130055.28005.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301130055.28005.efocht@ess.nec.de>; from efocht@ess.nec.de on Mon, Jan 13, 2003 at 12:55:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:55:28AM +0100, Erich Focht wrote:
> Hi Martin & Michael,
> 
> as discussed on the LSE call I played around with a cross-node
> balancer approach put on top of the miniature NUMA scheduler. The
> patches are attached and it seems to be clear that we can regain the
> good performance for hackbench by adding a cross-node balancer.

The changes look fine to me.  But I think there's some conding style
issues that need cleaning up (see below).  Also is there a reason
patches 2/3 and 4/5 aren't merged into one patch each?

 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_in_mask - find the busiest runqueue among the cpus in cpumask
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_in_mask(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)


	find_busiest_queue has just one caller in 2.5.56, I'd suggest just
	changing the prototype and updating that single caller to pass in
	the cpumask opencoded.


@@ -160,7 +160,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);

	I don't think you need this spurious whitespace change :)
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
+	rq->nr_running++
+#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
+	rq->nr_running--

	static inline void nr_running_inc(runqueue_t *rq)
	{
		atomic_inc(rq->node_ptr);
		rq->nr_running++
	}

	etc.. would look a bit nicer.

diff -urNp linux-2.5.55-ms/kernel/sched.c linux-2.5.55-ms-ilb/kernel/sched.c
--- linux-2.5.55-ms/kernel/sched.c	2003-01-10 23:01:02.000000000 +0100
+++ linux-2.5.55-ms-ilb/kernel/sched.c	2003-01-11 01:12:43.000000000 +0100
@@ -153,6 +153,7 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	atomic_t * node_ptr;

	atomic_t *node_ptr; would match the style above.

+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};

	Maybe wants some linewrapping after 80 chars?


+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+	}
+	return;
+}

	The braces and the return are superflous.  Also kernel/sched.c (or
	mingo codein general) seems to prefer array + i instead of &array[i]
	(not that I have a general preferences, but you should try to match
	the surrounding code)

+static void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	/* force the process onto the specified CPU */
+	set_cpus_allowed(p, 1UL << dest_cpu);
+
+	/* restore the cpus allowed mask */
+	set_cpus_allowed(p, old_mask);

	This double set_cpus_allowed doesn't look nice to me.  I don't
	have a better suggestion of-hand, though :(

+#define decl_numa_int(ctr) int ctr

	This is ugly as hell.  I'd prefer wasting one int in each runqueue
	or even an ifdef in the struct declaration over this obsfucation
	all the time.

@@ -816,6 +834,16 @@ out:
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
 {
 	unsigned long cpumask = __node_to_cpu_mask(__cpu_to_node(this_cpu));
+#if CONFIG_NUMA
+	int node;
+#       define INTERNODE_LB 10

	This wants to be put to the other magic constants in the scheduler
	and needs an explanation there.


 #define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
 	rq->nr_running--
 #define decl_numa_int(ctr) int ctr
+#define decl_numa_nodeint(v) int v[MAX_NUMNODES]

	Another one of those..  You should reall just stick the CONFIG_NUMA
	ifdef into the actual struct declaration.

+/*
+ * Find the busiest node. All previous node loads contribute with a geometrically
+ * deccaying weight to the load measure:

	Linewrapping again..


