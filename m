Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWGKSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWGKSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGKSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:30:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751178AbWGKSaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:30:00 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>
Date: Tue, 11 Jul 2006 20:29:50 +0200
Message-Id: <20060711182950.31293.14820.sendpatchset@lappy>
In-Reply-To: <20060711182936.31293.58306.sendpatchset@lappy>
References: <20060711182936.31293.58306.sendpatchset@lappy>
Subject: [PATCH 2/2] mm: refault histogram
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Adds a refault histogram on top of the nonresident code.
Based on ideas and code from Rik van Riel.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl

 fs/proc/proc_misc.c |   23 ++++++++++
 mm/Kconfig          |    5 ++
 mm/Makefile         |    1 
 mm/nonresident.c    |   15 +++++-
 mm/refault.c        |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 3 deletions(-)

Index: linux-2.6/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.orig/fs/proc/proc_misc.c	2006-07-11 18:06:58.000000000 +0200
+++ linux-2.6/fs/proc/proc_misc.c	2006-07-11 18:07:03.000000000 +0200
@@ -224,6 +224,26 @@ static struct file_operations fragmentat
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_MM_REFAULT
+extern struct seq_operations refault_op;
+static int refault_open(struct inode *inode, struct file *file)
+{
+	(void)inode;
+	return seq_open(file, &refault_op);
+}
+
+extern ssize_t refault_write(struct file *, const char __user *buf,
+		             size_t count, loff_t *);
+
+static struct file_operations refault_file_operations = {
+	.open           = refault_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+	.write		= refault_write,
+};
+#endif
+
 extern struct seq_operations zoneinfo_op;
 static int zoneinfo_open(struct inode *inode, struct file *file)
 {
@@ -696,6 +716,9 @@ void __init proc_misc_init(void)
 #endif
 #endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
+#ifdef CONFIG_MM_REFAULT
+	create_seq_entry("refault",S_IRUGO, &refault_file_operations);
+#endif
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
Index: linux-2.6/mm/Kconfig
===================================================================
--- linux-2.6.orig/mm/Kconfig	2006-07-11 18:07:03.000000000 +0200
+++ linux-2.6/mm/Kconfig	2006-07-11 18:07:03.000000000 +0200
@@ -156,3 +156,8 @@ config RESOURCES_64BIT
 config MM_NONRESIDENT
 	bool "Track nonresident pages"
 	def_bool y
+
+config MM_REFAULT
+	bool "Refault histogram"
+	def_bool y
+	depends on MM_NONRESIDENT
Index: linux-2.6/mm/nonresident.c
===================================================================
--- linux-2.6.orig/mm/nonresident.c	2006-07-11 18:07:03.000000000 +0200
+++ linux-2.6/mm/nonresident.c	2006-07-11 18:07:03.000000000 +0200
@@ -90,12 +90,21 @@ unsigned long nonresident_get(struct add
 			nr_bucket->page[i] = 0;
 			/* Return the distance between entry and clock hand. */
 			distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
-			distance %= NUM_NR;
-			return (distance << nonres_shift) + (nr_bucket - nonres_table);
+			distance = (distance % NUM_NR) << nonres_shift;
+			distance += (nr_bucket - nonres_table);
+			goto out;
 		}
 	}
 
-	return ~0UL;
+	distance = ~0UL;
+out:
+#ifdef CONFIG_MM_REFAULT
+	{
+		extern void nonresident_refault(unsigned long);
+		nonresident_refault(distance);
+	}
+#endif /* CONFIG_MM_REFAULT */
+	return distance;
 }
 
 u32 nonresident_put(struct address_space * mapping, unsigned long index)
Index: linux-2.6/mm/refault.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/mm/refault.c	2006-07-11 18:07:03.000000000 +0200
@@ -0,0 +1,114 @@
+#include <linux/config.h>
+#include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+#define BUCKETS 64
+
+DEFINE_PER_CPU(unsigned long[BUCKETS+1], refault_histogram);
+
+extern unsigned long nonresident_total(void);
+
+void nonresident_refault(unsigned long distance)
+{
+	unsigned long nonres_bucket = nonresident_total() / BUCKETS;
+	unsigned long bucket_id = distance / nonres_bucket;
+
+	if (bucket_id > BUCKETS)
+		bucket_id = BUCKETS;
+
+	__get_cpu_var(refault_histogram)[bucket_id]++;
+}
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos < 0 || *pos > BUCKETS)
+		return NULL;
+
+	m->private = (void *)(unsigned long)*pos;
+
+	return pos;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	if (*pos < BUCKETS) {
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
+	for_each_possible_cpu(cpu) {
+		total += per_cpu(refault_histogram, cpu)[index];
+	}
+	return total;
+}
+
+static int frag_show(struct seq_file *m, void *arg)
+{
+	unsigned long index = (unsigned long)m->private;
+	unsigned long nonres_bucket = nonresident_total() / BUCKETS;
+	unsigned long upper = ((unsigned long)index + 1) * nonres_bucket;
+	unsigned long lower = (unsigned long)index * nonres_bucket;
+	unsigned long hits = get_refault_stat(index);
+
+	if (index == 0)
+		seq_printf(m, "     Refault distance          Hits\n");
+
+	if (index < BUCKETS)
+		seq_printf(m, "%9lu - %9lu     %9lu\n", lower, upper, hits);
+	else
+		seq_printf(m, " New/Beyond %9lu     %9lu\n", lower, hits);
+
+	return 0;
+}
+
+struct seq_operations refault_op = {
+	.start  = frag_start,
+	.next   = frag_next,
+	.stop   = frag_stop,
+	.show   = frag_show,
+};
+
+static void refault_reset(void)
+{
+	int cpu;
+	int bucket_id;
+
+	for_each_possible_cpu(cpu) {
+		for (bucket_id = 0; bucket_id <= BUCKETS; ++bucket_id)
+			per_cpu(refault_histogram, cpu)[bucket_id] = 0;
+	}
+}
+
+ssize_t refault_write(struct file *file, const char __user *buf,
+		      size_t count, loff_t *ppos)
+{
+	if (count) {
+		char c;
+
+		if (get_user(c, buf))
+			return -EFAULT;
+		if (c == '0')
+			refault_reset();
+	}
+	return count;
+}
+
+#endif /* CONFIG_PROCFS */
+
Index: linux-2.6/mm/Makefile
===================================================================
--- linux-2.6.orig/mm/Makefile	2006-07-11 18:07:03.000000000 +0200
+++ linux-2.6/mm/Makefile	2006-07-11 18:07:03.000000000 +0200
@@ -14,6 +14,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_MM_NONRESIDENT) += nonresident.o
+obj-$(CONFIG_MM_REFAULT) += refault.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
