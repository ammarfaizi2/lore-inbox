Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJ2Fdy>; Tue, 29 Oct 2002 00:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSJ2Fdy>; Tue, 29 Oct 2002 00:33:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261585AbSJ2Fdu>;
	Tue, 29 Oct 2002 00:33:50 -0500
Date: Mon, 28 Oct 2002 21:36:44 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] use seq_file for /proc/swaps
Message-ID: <Pine.LNX.4.33L2.0210282132000.13581-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch to 2.5.44 converts /proc/swaps to use seq_file.

It's basically the same patch that I posted a few days ago
with locking added [using swap_list_lock() and
swap_list_unlock(), as directed by Al].

Any comments on this version?

Thanks,
-- 
~Randy



--- ./fs/proc/proc_misc.c%swaps	Fri Oct 18 21:01:14 2002
+++ ./fs/proc/proc_misc.c	Mon Oct 21 20:11:48 2002
@@ -295,6 +295,18 @@
 	.release	= seq_release,
 };

+extern struct seq_operations swaps_op;
+static int swaps_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &swaps_op);
+}
+static struct file_operations proc_swaps_operations = {
+	.open		= swaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 #ifdef CONFIG_MODULES
 extern struct seq_operations modules_op;
 static int modules_open(struct inode *inode, struct file *file)
@@ -503,13 +515,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

-static int swaps_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_swaparea_info(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int memory_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -616,7 +621,6 @@
 		{"rtc",		ds1286_read_proc},
 #endif
 		{"locks",	locks_read_proc},
-		{"swaps",	swaps_read_proc},
 		{"iomem",	memory_read_proc},
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
@@ -632,6 +636,7 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
+	create_seq_entry("swaps", 0, &proc_swaps_operations);
 #if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 #endif
--- ./mm/swapfile.c%swaps	Fri Oct 18 21:01:17 2002
+++ ./mm/swapfile.c	Mon Oct 28 19:59:11 2002
@@ -15,6 +15,7 @@
 #include <linux/shm.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
+#include <linux/seq_file.h>

 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -1041,45 +1042,91 @@
 	return err;
 }

-int get_swaparea_info(char *buf)
+#ifdef CONFIG_PROC_FS
+/* iterator */
+static void *swap_start(struct seq_file *swap, loff_t *pos)
 {
-	char * page = (char *) __get_free_page(GFP_KERNEL);
 	struct swap_info_struct *ptr = swap_info;
-	int i, len;
+	int i;
+	loff_t l = *pos;
+	char * page = (char *) __get_free_page(GFP_KERNEL);

-	if (!page)
-		return -ENOMEM;
+	swap->private = page;	/* save for swap_show */
+	swap_list_lock();

-	len = sprintf(buf, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
-	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
-		int j, usedswap;
-		struct file *file;
-		char *path;
+	if (!page)
+		return ERR_PTR(-ENOMEM);

+	for (i = 0; i < nr_swapfiles; i++, ptr++) {
 		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
 			continue;
+		if (!l--)
+			return ptr;
+	}

-		file = ptr->swap_file;
-		path = d_path(file->f_dentry, file->f_vfsmnt, page, PAGE_SIZE);
-		for (j = 0,usedswap = 0; j < ptr->max; ++j)
-			switch (ptr->swap_map[j]) {
-				case SWAP_MAP_BAD:
-				case 0:
-					continue;
-				default:
-					usedswap++;
-			}
-		len += sprintf(buf + len, "%-39s %s\t%d\t%d\t%d\n",
-			       path,
-			       S_ISBLK(file->f_dentry->d_inode->i_mode) ?
-					"partition" : "file\t",
-			       ptr->pages << (PAGE_SHIFT - 10),
-			       usedswap << (PAGE_SHIFT - 10),
-			       ptr->prio);
+	return NULL;
+}
+
+static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
+{
+	struct swap_info_struct *ptr = v;
+	void *endptr = (void *) swap_info + nr_swapfiles * sizeof(struct swap_info_struct);
+
+	for (++ptr; ptr < (struct swap_info_struct *) endptr; ptr++) {
+		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
+			continue;
+		++*pos;
+		return ptr;
 	}
-	free_page((unsigned long) page);
-	return len;
+
+	return NULL;
+}
+
+static void swap_stop(struct seq_file *swap, void *v)
+{
+	swap_list_unlock();
+	free_page((unsigned long) swap->private);
+	swap->private = NULL;
+}
+
+static int swap_show(struct seq_file *swap, void *v)
+{
+	struct swap_info_struct *ptr = v;
+	int j, usedswap;
+	struct file *file;
+	char *path;
+
+	if (v == swap_info)
+		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+
+	file = ptr->swap_file;
+	path = d_path(file->f_dentry, file->f_vfsmnt, swap->private, PAGE_SIZE);
+
+	for (j = 0, usedswap = 0; j < ptr->max; ++j)
+		switch (ptr->swap_map[j]) {
+			case SWAP_MAP_BAD:
+			case 0:
+				continue;
+			default:
+				usedswap++;
+		}
+	seq_printf(swap, "%-39s %s\t%d\t%d\t%d\n",
+		       path,
+		       S_ISBLK(file->f_dentry->d_inode->i_mode) ?
+				"partition" : "file\t",
+		       ptr->pages << (PAGE_SHIFT - 10),
+		       usedswap << (PAGE_SHIFT - 10),
+		       ptr->prio);
+	return 0;
 }
+
+struct seq_operations swaps_op = {
+	.start =	swap_start,
+	.next =		swap_next,
+	.stop =		swap_stop,
+	.show =		swap_show
+};
+#endif

 /*
  * Written 01/25/92 by Simmule Turner, heavily changed by Linus.

