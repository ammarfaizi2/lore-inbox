Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311583AbSCXFsk>; Sun, 24 Mar 2002 00:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311586AbSCXFsX>; Sun, 24 Mar 2002 00:48:23 -0500
Received: from air-2.osdl.org ([65.201.151.6]:33804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S311583AbSCXFsI>;
	Sun, 24 Mar 2002 00:48:08 -0500
Date: Sat, 23 Mar 2002 21:47:35 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: [patch 2.5] seq_file for /proc/partitions (take 2)
In-Reply-To: <Pine.LNX.4.33.0203232049240.23956-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0203232143380.5047-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002 rddunlap@osdl.org wrote:

| On Sat, 23 Mar 2002, Alexander Viro wrote:
|
| | Erm...  Actually that _is_ wrong - what you want is
| |
| | 	return ((struct gendisk)v)->next;
|
| Will repost patch after testing.

OK, here's the tested fixup.

Dave, please add to 2.5.7-dj.

Alan, I have 2.4.18 patch for this, but 2.4.19-pre3-ac6
includes more (sard ?) partition stats.
Are those going to 2.5 also?
Do you want me to merge partition stats and seq_file?

-- 
~Randy


--- ./drivers/block/genhd.c.PART	Mon Mar 18 12:37:14 2002
+++ ./drivers/block/genhd.c	Sat Mar 23 20:44:25 2002
@@ -22,6 +22,7 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>


 static rwlock_t gendisk_lock;
@@ -142,39 +143,58 @@
 }

 #ifdef CONFIG_PROC_FS
-int
-get_partition_list(char *page, char **start, off_t offset, int count)
+/* iterator */
+static void *part_start(struct seq_file *part, loff_t *pos)
 {
-	struct gendisk *gp;
-	char buf[64];
-	int len, n;
+	loff_t k = *pos;
+	struct gendisk *sgp;

-	len = sprintf(page, "major minor  #blocks  name\n\n");
 	read_lock(&gendisk_lock);
-	for (gp = gendisk_head; gp; gp = gp->next) {
-		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
-			if (gp->part[n].nr_sects == 0)
-				continue;
-
-			len += snprintf(page + len, 63,
-					"%4d  %4d %10d %s\n",
-					gp->major, n, gp->sizes[n],
-					disk_name(gp, n, buf));
-			if (len < offset)
-				offset -= len, len = 0;
-			else if (len >= offset + count)
-				goto out;
-		}
+	for (sgp = gendisk_head; sgp; sgp = sgp->next) {
+		if (!k--)
+			return sgp;
 	}
+	return NULL;
+}

-out:
+static void *part_next(struct seq_file *part, void *v, loff_t *pos)
+{
+	++*pos;
+	return ((struct gendisk *)v)->next;
+}
+
+static void part_stop(struct seq_file *part, void *v)
+{
 	read_unlock(&gendisk_lock);
-	*start = page + offset;
-	len -= offset;
-	if (len < 0)
-		len = 0;
-	return len > count ? count : len;
 }
+
+static int show_partition(struct seq_file *part, void *v)
+{
+	struct gendisk *sgp = v;
+	int n;
+	char buf[64];
+
+	if (sgp == gendisk_head)
+		seq_puts(part, "major minor  #blocks  name\n\n");
+
+	/* show all non-0 size partitions of this disk */
+	for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
+		if (sgp->part[n].nr_sects == 0)
+			continue;
+		seq_printf(part, "%4d  %4d %10d %s\n",
+			sgp->major, n, sgp->sizes[n],
+			disk_name(sgp, n, buf));
+	}
+
+	return 0;
+}
+
+struct seq_operations partitions_op = {
+	start:	part_start,
+	next:	part_next,
+	stop:	part_stop,
+	show:	show_partition
+};
 #endif


--- ./fs/proc/proc_misc.c.PART	Mon Mar 18 12:37:06 2002
+++ ./fs/proc/proc_misc.c	Sat Mar 23 16:34:07 2002
@@ -51,7 +51,6 @@
  * wrappers, but this needs further analysis wrt potential overflows.
  */
 extern int get_device_list(char *);
-extern int get_partition_list(char *, char **, off_t, int);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
 extern int get_dma_list(char *);
@@ -199,6 +198,18 @@
 	release:	seq_release,
 };

+extern struct seq_operations partitions_op;
+static int partitions_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &partitions_op);
+}
+static struct file_operations proc_partitions_operations = {
+	open:		partitions_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 #ifdef CONFIG_MODULES
 extern struct seq_operations modules_op;
 static int modules_open(struct inode *inode, struct file *file)
@@ -323,14 +334,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

-static int partitions_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_partition_list(page, start, off, count);
-	if (len < count) *eof = 1;
-	return len;
-}
-
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
 	return NULL + (*pos == 0);
@@ -538,7 +541,6 @@
 		{"version",	version_read_proc},
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
-		{"partitions",	partitions_read_proc},
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
 		{"ioports",	ioports_read_proc},
@@ -562,6 +564,7 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES




