Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263723AbSIVKb1>; Sun, 22 Sep 2002 06:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264034AbSIVKb0>; Sun, 22 Sep 2002 06:31:26 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:58025 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S263723AbSIVKbK>; Sun, 22 Sep 2002 06:31:10 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Sun, 22 Sep 2002 12:35:13 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <597807912.1032600740@[10.10.2.3]> <598631797.1032601564@[10.10.2.3]>
In-Reply-To: <598631797.1032601564@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PE5U3HZWUFU82O7P5ERT"
Message-Id: <200209221235.13341.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_PE5U3HZWUFU82O7P5ERT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 21 September 2002 18:46, Martin J. Bligh wrote:
> > Hmmm .... well I ran the One True Benchmark (tm). The patch
> > *increased* my kernel compile time from about 20s to about 28s.
> > Not sure I like that idea ;-) Anything you'd like tweaked, or
> > more info? Both user and system time were up ... I'll grab a
> > profile of kernel stuff.
>
> From the below, I'd suggest you're getting pages off the wrong
> nodes: do_anonymous_page is page zeroing, and rmqueue the buddy
> allocator. Are you sure the current->node thing is getting set
> correctly? I'll try backing out your alloc_pages tweaking, and
> see what happens.

Could you please check in dmesg whether the CPU pools are initialised
correctly? Maybe something goes wrong for your platform.

The node_distance is most probably non-optimal for NUMAQ, that might
need some tuning. The default is set for maximum 8 nodes, nodes 1-4
and 5-8 being in separate supernodes, with the latency ratios 1:1.5:2.

You could use the attached patch for getting an idea about the load
distribution. It's a quick&dirty hack which creates files called
/proc/sched/load/rqNN  :load of RQs, including info on tasks not running
                        on their homenode
/proc/sched/history/ilbNN : history of last 25 initial load balancing
                            decisions for runqueue NN
/proc/sched/history/lbNN  : last 25 load balancing decisions on rq NN.

It should be possible to find the reason for the poor performance by
looking at the nr_homenode entries in /proc/sched/load/rqNN.

Thanks,
best regards,
Erich
--------------Boundary-00=_PE5U3HZWUFU82O7P5ERT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="proc_sched_hist_2.5.37.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="proc_sched_hist_2.5.37.patch"

diff -urNp 2.5.37-node-affine/kernel/sched.c 2.5.37-node-affine-mon/kernel/sched.c
--- 2.5.37-node-affine/kernel/sched.c	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-mon/kernel/sched.c	Sun Sep 22 11:29:26 2002
@@ -677,6 +677,175 @@ static inline unsigned int double_lock_b
 	return nr_running;
 }
 
+#define HISTORY_RING_SIZE 25
+/* load balancing history entry */
+struct lb_hist_entry {
+	unsigned long time;	/* jiffy */
+	int pid;		/* stolen task (0 if none) */
+	int busiest_cpu;	/* busiest RQ */
+};
+/* load balancing history ring */
+struct lb_hist_ring {
+	int curr;	/* current pointer */
+	struct lb_hist_entry data[HISTORY_RING_SIZE];
+} ____cacheline_aligned;
+/* per CPU history ring array */
+struct lb_hist_ring lb_ring[NR_CPUS];
+
+/* initial load balancing decision entry */
+struct ilb_hist_entry {
+	unsigned long time;	/* jiffy */
+	int pid;
+	int node;		/* selected homenode */
+	int load[NR_NODES];	/* node loads at decision time */
+};
+/* initial load balancing history ring */
+struct ilb_hist_ring {
+	int curr;	/* current pointer */
+	struct ilb_hist_entry data[HISTORY_RING_SIZE];
+} ____cacheline_aligned;
+/* per CPU history ring array */
+struct ilb_hist_ring ilb_ring[NR_CPUS];
+
+/* add entry to lb_ring */
+void lb_ring_add(int cpu, int pid, int busiest_cpu)
+{
+	int next=(lb_ring[cpu].curr + 1 ) % HISTORY_RING_SIZE;
+
+	lb_ring[cpu].data[next].time = jiffies;
+	lb_ring[cpu].data[next].pid = pid;
+	lb_ring[cpu].data[next].busiest_cpu = busiest_cpu;
+	lb_ring[cpu].curr = next;
+}
+
+/* add entry to ilb_ring */
+void ilb_ring_add(int cpu, int pid, int node, int *load)
+{
+	int i, next=(ilb_ring[cpu].curr + 1 ) % HISTORY_RING_SIZE;
+
+	ilb_ring[cpu].data[next].time = jiffies;
+	ilb_ring[cpu].data[next].pid  = pid;
+	ilb_ring[cpu].data[next].node = node;
+	for (i=0; i<numpools; i++)
+		ilb_ring[cpu].data[next].load[i] = load[i];
+	ilb_ring[cpu].curr = next;
+}
+
+/* print lb history ring buffer */
+int lb_ring_read_proc(char *page, char **start, off_t off, 
+			int count, int *eof, void *data)
+{
+	int i, len, entry;
+	char *buff=page;
+	int cpu=(int)data;
+
+	buff += sprintf(buff,"     tick      pid  from_cpu\n");
+	entry = lb_ring[cpu].curr;
+	for (i=0; i<HISTORY_RING_SIZE; i++) {
+		entry = (entry + 1) % HISTORY_RING_SIZE;
+		buff += sprintf(buff,"%12ld %6d %2d\n",
+				lb_ring[cpu].data[entry].time,
+				lb_ring[cpu].data[entry].pid,
+				lb_ring[cpu].data[entry].busiest_cpu);
+	}
+	len = buff-page;
+	if (len <= off+count) *eof = 1;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+/* print initial lb history ring buffer */
+int ilb_ring_read_proc(char *page, char **start, off_t off, 
+			int count, int *eof, void *data)
+{
+	int i, j, len, entry;
+	char *buff=page;
+	int cpu=(int)data;
+
+	buff += sprintf(buff,"     tick      pid node node_loads\n");
+	entry = ilb_ring[cpu].curr;
+	for (i=0; i<HISTORY_RING_SIZE; i++) {
+		entry = (entry + 1) % HISTORY_RING_SIZE;
+		buff += sprintf(buff,"%12ld %6d %2d",
+				ilb_ring[cpu].data[entry].time,
+				ilb_ring[cpu].data[entry].pid,
+				ilb_ring[cpu].data[entry].node);
+		for (j=0; j<numpools; j++)
+			buff += sprintf(buff," %3d",
+					ilb_ring[cpu].data[entry].load[j]);
+		buff += sprintf(buff,"\n");
+	}
+	len = buff-page;
+	if (len <= off+count) *eof = 1;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+/* print runqueue load */
+int rq_load_read_proc(char *page, char **start, off_t off, 
+			int count, int *eof, void *data)
+{
+	int i, len;
+	runqueue_t *rq;
+	char *buff=page;
+	int cpu=(int)data;
+
+	rq=cpu_rq(cpu);
+	buff += sprintf(buff,"cpu %d : ",cpu);
+	buff += sprintf(buff,"curr: %d %s\n",rq->curr->pid,rq->curr->comm);
+	buff += sprintf(buff,"running uninter nr_homenode\n");
+	buff += sprintf(buff,"%7d %7d",rq->nr_running,rq->nr_uninterruptible);
+	for (i=0; i<numpools; i++)
+		buff += sprintf(buff," %4d",rq->nr_homenode[i]);
+	buff += sprintf(buff,"\n");
+
+	len = buff-page;
+	if (len <= off+count) *eof = 1;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+#include <linux/proc_fs.h>
+/* initialize /proc entries */
+void init_sched_proc(void)
+{
+	int i;
+	char name[12];
+	struct proc_dir_entry *p, *hist, *sched, *load;
+
+	sched = proc_mkdir("sched",&proc_root);
+	hist = proc_mkdir("history",sched);
+	for (i=0; i<smp_num_cpus; i++) {
+		sprintf(name,"lb%02d",i);
+		p = create_proc_entry(name,S_IRUGO,hist);
+		if (p) {
+			p->read_proc = lb_ring_read_proc;
+			p->data = (long)i;
+		}
+		sprintf(name,"ilb%02d",i);
+		p = create_proc_entry(name,S_IRUGO,hist);
+		if (p) {
+			p->read_proc = ilb_ring_read_proc;
+			p->data = (long)i;
+		}
+	}
+	load = proc_mkdir("load",sched);
+	for (i=0; i<smp_num_cpus; i++) {
+		sprintf(name,"rq%02d",i);
+		p = create_proc_entry(name,S_IRUGO,load);
+		if (p) {
+			p->read_proc = rq_load_read_proc;
+			p->data = (long)i;
+		}
+	}
+}
+
 /*
  * Calculate load of a CPU pool, store results in data[][NR_CPUS].
  * Return the index of the most loaded runqueue.
@@ -961,6 +1130,7 @@ static void load_balance(runqueue_t *thi
 	tmp = task_to_steal(busiest, this_cpu);
 	if (!tmp)
 		goto out_unlock;
+	lb_ring_add(smp_processor_id(), tmp->pid, tmp->thread_info->cpu);
 	pull_task(busiest, tmp->array, tmp, this_rq, this_cpu);
 out_unlock:
 	spin_unlock(&busiest->lock);
@@ -2051,7 +2221,7 @@ static int sched_best_cpu(struct task_st
  */
 static int sched_best_node(struct task_struct *p, int flag)
 {
-	int n, best_node=0, min_load, pool_load, min_pool=p->node;
+	int n, best_node=0, min_load, min_pool=p->node;
 	int pool, load[NR_NODES];
 	unsigned long mask = p->cpus_allowed & cpu_online_map;
 
@@ -2079,13 +2249,14 @@ static int sched_best_node(struct task_s
 	min_load = 100000000;
 	for (n = 0; n < numpools; n++) {
 		pool = (best_node + n) % numpools;
-		pool_load = (100*load[pool])/pool_nr_cpus[pool];
-		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
-			min_load = pool_load;
+		load[pool] = (100*load[pool])/pool_nr_cpus[pool];
+		if ((load[pool] < min_load) && (pool_mask[pool] & mask)) {
+			min_load = load[pool];
 			min_pool = pool;
 		}
 	}
 	atomic_set(&sched_node, min_pool);
+	ilb_ring_add(smp_processor_id(), p->pid, min_pool, load);
 	return min_pool;
 }
 
@@ -2282,6 +2453,7 @@ void bld_pools(void)
 	find_node_levels(numpools);
 	init_pool_weight();
 	init_pool_delay();
+	init_sched_proc();
 }
 
 void set_task_node(task_t *p, int node)

--------------Boundary-00=_PE5U3HZWUFU82O7P5ERT--

