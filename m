Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSKOQUd>; Fri, 15 Nov 2002 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbSKOQUd>; Fri, 15 Nov 2002 11:20:33 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3838 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266435AbSKOQU3>;
	Fri, 15 Nov 2002 11:20:29 -0500
Date: Fri, 15 Nov 2002 22:03:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU statistics 2.5.47
Message-ID: <20021115220319.A8215@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This patch makes some basic statistics for RCU available in /proc/rcu.
The statistics made available by this patch are very generic in
nature - # of RCU requests and # of actual RCU updates for each
CPU. This will allow us to monitor the health of the RCU
subsystem and such things have been extremely useful for me to
investigate problems. For example, if a CPU looping in kernel
stops RCU grace period from completing, we would be easily able
to detect it by looking at these counters. This is a rediff of
an earlier version published in lkml and included in -mm.

[dipankar@llm04 dipankar]$ cat /proc/rcu
CPU : 0
RCU requests : 0
RCU updates : 0

CPU : 1
RCU requests : 0
RCU updates : 0

CPU : 2
RCU requests : 0
RCU updates : 0

CPU : 3
RCU requests : 0
RCU updates : 0

Please apply.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -urN linux-2.5.47-base/Documentation/filesystems/proc.txt linux-2.5.47-rcu_stats/Documentation/filesystems/proc.txt
--- linux-2.5.47-base/Documentation/filesystems/proc.txt	Tue Nov  5 21:58:17 2002
+++ linux-2.5.47-rcu_stats/Documentation/filesystems/proc.txt	Fri Nov 15 21:37:32 2002
@@ -222,6 +222,7 @@
  partitions  Table of partitions known to the system           
  pci	     Depreciated info of PCI bus (new way -> /proc/bus/pci/, 
              decoupled by lspci					(2.4)
+ rcu	     Read-Copy Update information			(2.5)
  rtc         Real time clock                                   
  scsi        SCSI info (see text)                              
  slabinfo    Slab pool info                                    
@@ -346,6 +347,9 @@
 ZONE_DMA, 4 chunks of 2^1*PAGE_SIZE in ZONE_DMA, 101 chunks of 2^4*PAGE_SIZE 
 availble in ZONE_NORMAL, etc... 
 
+The rcu file gives information about Read-Copy Update synchronization
+primitive. It indicates the number for RCU requests and actual
+updates for every CPU.
 
 1.3 IDE devices in /proc/ide
 ----------------------------
diff -urN linux-2.5.47-base/fs/proc/proc_misc.c linux-2.5.47-rcu_stats/fs/proc/proc_misc.c
--- linux-2.5.47-base/fs/proc/proc_misc.c	Mon Nov 11 21:03:00 2002
+++ linux-2.5.47-rcu_stats/fs/proc/proc_misc.c	Fri Nov 15 21:37:32 2002
@@ -242,6 +242,18 @@
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
@@ -595,6 +607,7 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("rcu", 0, &proc_rcu_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 #if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
diff -urN linux-2.5.47-base/include/linux/rcupdate.h linux-2.5.47-rcu_stats/include/linux/rcupdate.h
--- linux-2.5.47-base/include/linux/rcupdate.h	Fri Nov  1 13:10:34 2002
+++ linux-2.5.47-rcu_stats/include/linux/rcupdate.h	Fri Nov 15 21:37:32 2002
@@ -95,6 +95,8 @@
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+ 	long		nr_rcureqs;
+ 	long		nr_rcupdates;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -105,6 +107,8 @@
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_nr_rcureqs(cpu) 	(per_cpu(rcu_data, (cpu)).nr_rcureqs)
+#define RCU_nr_rcupdates(cpu) 	(per_cpu(rcu_data, (cpu)).nr_rcupdates)
 
 #define RCU_QSCTR_INVALID	0
 
diff -urN linux-2.5.47-base/kernel/rcupdate.c linux-2.5.47-rcu_stats/kernel/rcupdate.c
--- linux-2.5.47-base/kernel/rcupdate.c	Fri Nov  1 13:10:34 2002
+++ linux-2.5.47-rcu_stats/kernel/rcupdate.c	Fri Nov 15 21:37:32 2002
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 
@@ -75,6 +76,7 @@
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 	list_add_tail(&head->list, &RCU_nxtlist(cpu));
+	RCU_nr_rcureqs(cpu)++;
 	local_irq_restore(flags);
 }
 
@@ -82,7 +84,7 @@
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(struct list_head *list)
+static void rcu_do_batch(int cpu, struct list_head *list)
 {
 	struct list_head *entry;
 	struct rcu_head *head;
@@ -92,6 +94,7 @@
 		list_del(entry);
 		head = list_entry(entry, struct rcu_head, list);
 		head->func(head->arg);
+		RCU_nr_rcupdates(cpu)++;
 	}
 }
 
@@ -187,7 +190,7 @@
 	}
 	rcu_check_quiescent_state();
 	if (!list_empty(&list))
-		rcu_do_batch(&list);
+		rcu_do_batch(cpu, &list);
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -266,3 +269,44 @@
 
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
+	seq_printf(m, "CPU : %d\n", cpu);
+	seq_printf(m, "RCU requests : %ld\n", RCU_nr_rcureqs(cpu));
+	seq_printf(m, "RCU updates : %ld\n\n", RCU_nr_rcupdates(cpu));
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
