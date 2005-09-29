Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVI2SRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVI2SRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVI2SQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:16:46 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:26949 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932319AbVI2SQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:24 -0400
Message-Id: <20050929181617.160771255@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:47 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 2/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-nonresident-stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds some /proc debugging output to the nonresident code.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 fs/proc/proc_misc.c |   15 +++++++++
 mm/nonresident.c    |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

Index: linux-2.6-git/fs/proc/proc_misc.c
===================================================================
--- linux-2.6-git.orig/fs/proc/proc_misc.c
+++ linux-2.6-git/fs/proc/proc_misc.c
@@ -233,6 +233,20 @@ static struct file_operations proc_zonei
 	.release	= seq_release,
 };
 
+extern struct seq_operations nonresident_op;
+static int nonresident_open(struct inode *inode, struct file *file)
+{
+       (void)inode;
+       return seq_open(file, &nonresident_op);
+}
+
+static struct file_operations nonresident_file_operations = {
+       .open           = nonresident_open,
+       .read           = seq_read,
+       .llseek         = seq_lseek,
+       .release        = seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -602,6 +616,7 @@ void __init proc_misc_init(void)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
+	create_seq_entry("nonresident",S_IRUGO, &nonresident_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
Index: linux-2.6-git/mm/nonresident.c
===================================================================
--- linux-2.6-git.orig/mm/nonresident.c
+++ linux-2.6-git/mm/nonresident.c
@@ -373,3 +373,83 @@ static int __init set_nonresident_factor
 }
 
 __setup("nonresident_factor=", set_nonresident_factor);
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *stats_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos < 0 || *pos >= (1 << nonres_shift))
+		return NULL;
+
+	m->private = (void*)(unsigned long)*pos;
+
+	return pos;
+}
+
+static void *stats_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	if (*pos < (1 << nonres_shift)-1) {
+		(*pos)++;
+		(unsigned long)m->private++;
+		return pos;
+	}
+	return NULL;
+}
+
+static void stats_stop(struct seq_file *m, void *arg)
+{
+}
+
+static void bucket_stats(struct nr_bucket * nr_bucket, int * b1, int * b2, int * free)
+{
+	unsigned long flags;
+	unsigned int i, b[3] = {0, 0, 0};
+
+	spin_lock_irqsave(&nr_bucket->lock, flags);
+	for (i = 0; i < 3; ++i) {
+		unsigned int j = nr_bucket->hand[i];
+		do
+		{
+			u32 *slot = &nr_bucket->slot[j];
+			if (GET_LISTID(*slot) != i)
+				break;
+			j = GET_INDEX(*slot);
+			++b[i];
+		} while (j != nr_bucket->hand[i]);
+	}
+	spin_unlock_irqrestore(&nr_bucket->lock, flags);
+
+	*b1=b[0];
+	*b2=b[1];
+	*free=b[2];
+}
+
+static int stats_show(struct seq_file *m, void *arg)
+{
+	unsigned int index = (unsigned long)m->private;
+	struct nr_bucket *nr_bucket = &nonres_table[index];
+	int b1, b2, free;
+
+	bucket_stats(nr_bucket, &b1, &b2, &free);
+	seq_printf(m, "%d\t%d\t%d", b1, b2, free);
+	if (index == 0) {
+		seq_printf(m, "\t%d\t%d\t%d",
+			   nonresident_count(NR_b1),
+			   nonresident_count(NR_b2),
+			   nonresident_count(NR_free));
+	}
+	seq_printf(m,"\n");
+
+	return 0;
+}
+
+struct seq_operations nonresident_op = {
+	.start = stats_start,
+	.next = stats_next,
+	.stop = stats_stop,
+	.show = stats_show,
+};
+
+#endif /* CONFIG_PROC_FS */

--
