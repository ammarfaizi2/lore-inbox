Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSJVQKI>; Tue, 22 Oct 2002 12:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSJVQKE>; Tue, 22 Oct 2002 12:10:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46847 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263366AbSJVQJo>;
	Tue, 22 Oct 2002 12:09:44 -0400
Date: Tue, 22 Oct 2002 21:51:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <20021022215143.A17644@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DB46DFA.DFEB2907@digeo.com> <308170000.1035234988@flay> <3DB472B6.BC5B8924@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB472B6.BC5B8924@digeo.com>; from akpm@digeo.com on Mon, Oct 21, 2002 at 09:34:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 09:34:56PM +0000, Andrew Morton wrote:
> "Martin J. Bligh" wrote:
> > 
> > >> My big NUMA box went OOM over the weekend and started killing things
> > >> for no good reason (2.5.43-mm2). Probably running some background
> > >> updatedb for locate thing, not doing any real work.
> > >>
> > >> meminfo:
> > >>
> > >
> > > Looks like a plain dentry leak to me.  Very weird.
> > >
> > > Did the machine recover and run normally?
> > 
> > Nope, kept OOMing and killing everything .
> 
> Something broke.

Yes, in RCU and ever since interrupt counters were changed to use
thread_info->preempt_count :)

There is a check in RCU for idle CPUs which signifies quiescent
state (and hence no reference to RCU protected data) which was
broken -

--- kernel/rcupdate.c	Sat Oct 19 09:31:07 2002
+++ /tmp/rcupdate.c.mod	Tue Oct 22 21:20:07 2002
@@ -192,7 +192,8 @@
 void rcu_check_callbacks(int cpu, int user)
 {
 	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
+	    (idle_cpu(cpu) && !in_softirq() && 
+				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
 		RCU_qsctr(cpu)++;
 	tasklet_schedule(&RCU_tasklet(cpu));
 }

Martin's machine with large number of CPUs which were idle was not
completing any RCU grace period because RCU was forever waiting
for idle CPUs to context switch. Had the idle check worked, this
would not have happened. With no RCU happening, the dentries were
getting "freed" (dentry stats showing that) but not getting returned
to slab. This would not show up in systems that are generally busy
as context switches then would happen in all CPUs and the per-CPU
quiescent state counter would get incremented during context switch.

I have included here a patch that adds statistics to RCU which are
very helpful in detecting problems. That patch also includes the
idle CPU check fix. The stats are in /proc/rcu. I still need to
check if seq_file access of a /proc file is serialized or not.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -ruN linux-2.5.44-base/fs/proc/proc_misc.c linux-2.5.44-rcu/fs/proc/proc_misc.c
--- linux-2.5.44-base/fs/proc/proc_misc.c	Sat Oct 19 09:31:14 2002
+++ linux-2.5.44-rcu/fs/proc/proc_misc.c	Tue Oct 22 18:47:00 2002
@@ -253,6 +253,18 @@
 	.release	= seq_release,
 };
 
+extern struct seq_operations rcu_op;
+static int rcu_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &rcu_op);
+}
+static struct file_operations proc_rcu_operations = {
+	.open		= rcu_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 extern struct seq_operations vmstat_op;
 static int vmstat_open(struct inode *inode, struct file *file)
 {
@@ -631,6 +643,7 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("rcu", 0, &proc_rcu_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 #if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
diff -ruN linux-2.5.44-base/include/linux/rcupdate.h linux-2.5.44-rcu/include/linux/rcupdate.h
--- linux-2.5.44-base/include/linux/rcupdate.h	Sat Oct 19 09:31:18 2002
+++ linux-2.5.44-rcu/include/linux/rcupdate.h	Tue Oct 22 18:47:00 2002
@@ -68,6 +68,7 @@
 	long		maxbatch;	/* Max requested batch number.        */
 	unsigned long	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
 					/* for current batch to proceed.      */
+	long		nr_batches;
 };
 
 /* Is batch a before batch b ? */
@@ -94,6 +95,10 @@
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+	long		nr_newreqs;
+	long		nr_curreqs;
+	long		nr_pendreqs;
+	long		nr_rcupdates;
 } ____cacheline_aligned_in_smp;
 
 extern struct rcu_data rcu_data[NR_CPUS];
@@ -104,6 +109,10 @@
 #define RCU_batch(cpu) 		(rcu_data[(cpu)].batch)
 #define RCU_nxtlist(cpu) 	(rcu_data[(cpu)].nxtlist)
 #define RCU_curlist(cpu) 	(rcu_data[(cpu)].curlist)
+#define RCU_nr_newreqs(cpu) 	(rcu_data[(cpu)].nr_newreqs)
+#define RCU_nr_curreqs(cpu) 	(rcu_data[(cpu)].nr_curreqs)
+#define RCU_nr_pendreqs(cpu) 	(rcu_data[(cpu)].nr_pendreqs)
+#define RCU_nr_rcupdates(cpu) 	(rcu_data[(cpu)].nr_rcupdates)
 
 #define RCU_QSCTR_INVALID	0
 
diff -ruN linux-2.5.44-base/kernel/rcupdate.c linux-2.5.44-rcu/kernel/rcupdate.c
--- linux-2.5.44-base/kernel/rcupdate.c	Sat Oct 19 09:31:07 2002
+++ linux-2.5.44-rcu/kernel/rcupdate.c	Tue Oct 22 18:54:04 2002
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
 #include <linux/rcupdate.h>
 
 /* Definition for rcupdate control block. */
@@ -74,6 +75,7 @@
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 	list_add_tail(&head->list, &RCU_nxtlist(cpu));
+	RCU_nr_newreqs(cpu)++;
 	local_irq_restore(flags);
 }
 
@@ -81,7 +83,7 @@
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(struct list_head *list)
+static void rcu_do_batch(int cpu, struct list_head *list)
 {
 	struct list_head *entry;
 	struct rcu_head *head;
@@ -91,7 +93,9 @@
 		list_del(entry);
 		head = list_entry(entry, struct rcu_head, list);
 		head->func(head->arg);
+		RCU_nr_rcupdates(cpu)++;
 	}
+	RCU_nr_pendreqs(cpu) = 0;
 }
 
 /*
@@ -99,7 +103,7 @@
  * active batch and the batch to be registered has not already occurred.
  * Caller must hold the rcu_ctrlblk lock.
  */
-static void rcu_start_batch(long newbatch)
+static void rcu_start_batch(int cpu, long newbatch)
 {
 	if (rcu_batch_before(rcu_ctrlblk.maxbatch, newbatch)) {
 		rcu_ctrlblk.maxbatch = newbatch;
@@ -109,6 +113,8 @@
 		return;
 	}
 	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+	RCU_nr_pendreqs(cpu) = RCU_nr_curreqs(cpu);
+	RCU_nr_curreqs(cpu) = 0;
 }
 
 /*
@@ -149,7 +155,8 @@
 		return;
 	}
 	rcu_ctrlblk.curbatch++;
-	rcu_start_batch(rcu_ctrlblk.maxbatch);
+	rcu_ctrlblk.nr_batches++;
+	rcu_start_batch(cpu, rcu_ctrlblk.maxbatch);
 	spin_unlock(&rcu_ctrlblk.mutex);
 }
 
@@ -172,6 +179,8 @@
 	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
 		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
 		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
+		RCU_nr_curreqs(cpu) = RCU_nr_newreqs(cpu);
+		RCU_nr_newreqs(cpu) = 0;
 		local_irq_enable();
 
 		/*
@@ -179,20 +188,21 @@
 		 */
 		spin_lock(&rcu_ctrlblk.mutex);
 		RCU_batch(cpu) = rcu_ctrlblk.curbatch + 1;
-		rcu_start_batch(RCU_batch(cpu));
+		rcu_start_batch(cpu, RCU_batch(cpu));
 		spin_unlock(&rcu_ctrlblk.mutex);
 	} else {
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state();
 	if (!list_empty(&list))
-		rcu_do_batch(&list);
+		rcu_do_batch(cpu, &list);
 }
 
 void rcu_check_callbacks(int cpu, int user)
 {
 	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
+	    (idle_cpu(cpu) && !in_softirq() && 
+				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
 		RCU_qsctr(cpu)++;
 	tasklet_schedule(&RCU_tasklet(cpu));
 }
@@ -240,3 +250,60 @@
 
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(synchronize_kernel);
+
+#ifdef	CONFIG_PROC_FS
+
+static void *rcu_start(struct seq_file *m, loff_t *pos)
+{
+	static int cpu;
+	cpu = *pos;
+	return *pos < NR_CPUS ? &cpu : NULL;
+}
+		
+static void *rcu_next(struct seq_file *m, void *v, loff_t *pos) 
+{
+	++*pos;
+	return rcu_start(m, pos);
+
+}
+
+static void rcu_stop(struct seq_file *m, void *v)
+{
+}
+
+static int show_rcu(struct seq_file *m, void *v)
+{
+	int cpu = *(int *)v;
+
+	if (!cpu_online(cpu))
+		return 0;
+	if (cpu == 0) {
+		seq_printf(m, "RCU Current Batch : %ld\n",
+				rcu_ctrlblk.curbatch);
+		seq_printf(m, "RCU Max Batch : %ld\n", 
+				rcu_ctrlblk.maxbatch);
+		seq_printf(m, "RCU Global Cpumask : 0x%lx\n",
+				rcu_ctrlblk.rcu_cpu_mask);
+		seq_printf(m, "RCU Total Batches : %ld\n\n\n", 
+				rcu_ctrlblk.nr_batches);
+	}
+	seq_printf(m, "CPU : %d\n", cpu);
+	seq_printf(m, "RCU qsctr : %ld\n", RCU_qsctr(cpu));
+	seq_printf(m, "RCU last qsctr : %ld\n", RCU_last_qsctr(cpu));
+	seq_printf(m, "RCU batch : %ld\n", RCU_batch(cpu));
+	seq_printf(m, "RCU new requests : %ld\n", RCU_nr_newreqs(cpu));
+	seq_printf(m, "RCU current requests : %ld\n", RCU_nr_curreqs(cpu));
+	seq_printf(m, "RCU pending requests : %ld\n", RCU_nr_pendreqs(cpu));
+	seq_printf(m, "RCU updated : %ld\n\n\n", RCU_nr_rcupdates(cpu));
+	return 0;
+}
+
+struct seq_operations rcu_op = {
+	.start	= rcu_start,
+	.next	= rcu_next,
+	.stop	= rcu_stop,
+	.show	= show_rcu,
+};
+
+#endif
+
