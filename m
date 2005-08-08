Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVHHUWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVHHUWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHHUWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:22:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932260AbVHHUWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:22:18 -0400
Message-Id: <20050808202111.144010000@jumble.boston.redhat.com>
References: <20050808201416.450491000@jumble.boston.redhat.com>
Date: Mon, 08 Aug 2005 16:14:18 -0400
From: Rik van Riel <riel@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 2/3] non-resident page tracking
Content-Disposition: inline; filename=nonresident-stats
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prints a histogram of refaults in /proc/refaults.  This allows somebody
to estimate how much more memory a memory starved system would need to
run better.  

It can also help with the evaluation of page replacement algorithms,
since the algorithm that would need the least amount of extra memory
to fit a workload can be identified.

Signed-off-by: Rik van Riel <riel@redhat.com>

Index: linux-2.6.12-vm/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.12-vm.orig/fs/proc/proc_misc.c
+++ linux-2.6.12-vm/fs/proc/proc_misc.c
@@ -219,6 +219,20 @@ static struct file_operations fragmentat
 	.release	= seq_release,
 };
 
+extern struct seq_operations refaults_op;
+static int refaults_open(struct inode *inode, struct file *file)
+{
+	(void)inode;
+	return seq_open(file, &refaults_op);
+}
+
+static struct file_operations refaults_file_operations = {
+	.open		= refaults_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -588,6 +602,7 @@ void __init proc_misc_init(void)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
+	create_seq_entry("refaults",S_IRUGO, &refaults_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
 #ifdef CONFIG_MODULES
Index: linux-2.6.12-vm/mm/nonresident.c
===================================================================
--- linux-2.6.12-vm.orig/mm/nonresident.c
+++ linux-2.6.12-vm/mm/nonresident.c
@@ -24,6 +24,7 @@
 #include <linux/hash.h>
 #include <linux/prefetch.h>
 #include <linux/kernel.h>
+#include <linux/percpu.h>
 
 /* Number of non-resident pages per hash bucket */
 #define NUM_NR ((L1_CACHE_BYTES - sizeof(atomic_t))/sizeof(u32))
@@ -34,6 +35,9 @@ struct nr_bucket
 	u32 page[NUM_NR];
 } ____cacheline_aligned;
 
+/* Histogram for non-resident refault hits. [NUM_NR] means "not found". */
+DEFINE_PER_CPU(unsigned long[NUM_NR+1], refault_histogram);
+
 /* The non-resident page hash table. */
 static struct nr_bucket * nonres_table;
 static unsigned int nonres_shift;
@@ -81,11 +85,14 @@ int recently_evicted(struct address_spac
 			nr_bucket->page[i] = 0;
 			/* Return the distance between entry and clock hand. */
 			distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
-			distance = (distance % NUM_NR) + 1;
-			return distance * (1 << nonres_shift);
+			distance = distance % NUM_NR;
+			__get_cpu_var(refault_histogram)[distance]++;
+			return (distance + 1) * (1 << nonres_shift);
 		}
 	}
 
+	/* If this page was evicted, it was longer ago than our history. */
+	__get_cpu_var(refault_histogram)[NUM_NR]++;
 	return -1;
 }
 
@@ -155,3 +162,68 @@ static int __init set_nonresident_factor
 	return 1;
 }
 __setup("nonresident_factor=", set_nonresident_factor);
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos < 0 || *pos > NUM_NR)
+		return NULL;
+
+	m->private = (unsigned long)*pos;
+
+	return pos;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	if (*pos < NUM_NR) {
+		(*pos)++;
+		(unsigned long)m->private++;
+		return pos;
+	}
+	return NULL;
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+}
+
+unsigned long get_refault_stat(unsigned long index)
+{
+	unsigned long total = 0;
+	int cpu;
+
+	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++) {
+		total += per_cpu(refault_histogram, cpu)[index];
+	}
+	return total;
+}
+
+static int frag_show(struct seq_file *m, void *arg)
+{
+	unsigned long index = (unsigned long)m->private;
+	unsigned long upper = ((unsigned long)index + 1) << nonres_shift;
+	unsigned long lower = (unsigned long)index << nonres_shift;
+	unsigned long hits = get_refault_stat(index);
+
+	if (index == 0)
+		seq_printf(m, "     Refault distance          Hits\n");
+
+	if (index < NUM_NR)
+		seq_printf(m, "%9lu - %9lu     %9lu\n", lower, upper, hits);
+	else
+		seq_printf(m, " New/Beyond %9lu     %9lu\n", lower, hits);
+
+	return 0;
+}
+
+struct seq_operations refaults_op = {
+	.start  = frag_start,
+	.next   = frag_next,
+	.stop   = frag_stop,
+	.show   = frag_show,
+};
+#endif /* CONFIG_PROCFS */

--
-- 
All Rights Reversed
