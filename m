Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSLPH3f>; Mon, 16 Dec 2002 02:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSLPH3f>; Mon, 16 Dec 2002 02:29:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3815 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265657AbSLPH3b>;
	Mon, 16 Dec 2002 02:29:31 -0500
Date: Mon, 16 Dec 2002 13:08:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU statistics 2.5.52
Message-ID: <20021216073828.GA3422@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a re-transmit of the patch that adds some basic statistics to
RCU (/proc/rcu). The statistics made available by this patch are very generic
in nature - # of RCU requests and # of actual RCU updates for each
CPU. This will allow us to monitor the health of the RCU
subsystem and such things have been extremely useful for
investigating problems. For example, if a CPU looping in kernel
stops RCU grace period from completing, we would be easily able
to detect it by looking at these counters. Without these, that
becomes very difficult.

dipankar@llm04 dipankar]$ cat /proc/rcu
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

This patch has been in akpm's -mm tree for a long time now and would be nice
to have in your tree.

Thanks
Dipankar


 Documentation/filesystems/proc.txt |    4 +++
 fs/proc/proc_misc.c                |   13 ++++++++++
 include/linux/rcupdate.h           |    4 +++
 kernel/rcupdate.c                  |   48 +++++++++++++++++++++++++++++++++++--
 4 files changed, 67 insertions(+), 2 deletions(-)

diff -urN linux-2.5.52-base/Documentation/filesystems/proc.txt linux-2.5.52-rcu_stats/Documentation/filesystems/proc.txt
--- linux-2.5.52-base/Documentation/filesystems/proc.txt	2002-12-16 07:37:51.000000000 +0530
+++ linux-2.5.52-rcu_stats/Documentation/filesystems/proc.txt	2002-12-16 13:02:27.000000000 +0530
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
diff -urN linux-2.5.52-base/fs/proc/proc_misc.c linux-2.5.52-rcu_stats/fs/proc/proc_misc.c
--- linux-2.5.52-base/fs/proc/proc_misc.c	2002-12-16 07:37:46.000000000 +0530
+++ linux-2.5.52-rcu_stats/fs/proc/proc_misc.c	2002-12-16 13:02:27.000000000 +0530
@@ -243,6 +243,18 @@
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
@@ -586,6 +598,7 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("rcu", 0, &proc_rcu_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 #if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
diff -urN linux-2.5.52-base/include/linux/rcupdate.h linux-2.5.52-rcu_stats/include/linux/rcupdate.h
--- linux-2.5.52-base/include/linux/rcupdate.h	2002-12-16 07:37:50.000000000 +0530
+++ linux-2.5.52-rcu_stats/include/linux/rcupdate.h	2002-12-16 13:02:27.000000000 +0530
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
 
diff -urN linux-2.5.52-base/kernel/rcupdate.c linux-2.5.52-rcu_stats/kernel/rcupdate.c
--- linux-2.5.52-base/kernel/rcupdate.c	2002-12-16 07:37:43.000000000 +0530
+++ linux-2.5.52-rcu_stats/kernel/rcupdate.c	2002-12-16 13:02:27.000000000 +0530
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
