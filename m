Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbSJXFjN>; Thu, 24 Oct 2002 01:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSJXFjN>; Thu, 24 Oct 2002 01:39:13 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:54501 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S265319AbSJXFjK>; Thu, 24 Oct 2002 01:39:10 -0400
Message-ID: <3DB788B2.34A9946B@verizon.net>
Date: Wed, 23 Oct 2002 22:44:18 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] convert /proc/swaps to seq_file
Content-Type: multipart/mixed;
 boundary="------------0EF9EF4883C39D36025D0263"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [4.64.197.173] at Thu, 24 Oct 2002 00:45:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0EF9EF4883C39D36025D0263
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch to 2.5.44 make /proc/swaps use seq_file.

Question:  is any locking needed here?
The previous code didn't use any locking.

Any other feedback on it?

Thanks,
~Randy
~~~
--------------0EF9EF4883C39D36025D0263
Content-Type: text/plain; charset=us-ascii;
 name="swaps-seqfile-2544.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swaps-seqfile-2544.patch"

--- ./fs/proc/proc_misc.c.swaps	Fri Oct 18 21:01:14 2002
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
--- ./mm/swapfile.c.swaps	Fri Oct 18 21:01:17 2002
+++ ./mm/swapfile.c	Wed Oct 23 22:33:27 2002
@@ -15,6 +15,7 @@
 #include <linux/shm.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
+#include <linux/seq_file.h>
 
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -1041,45 +1042,89 @@
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
 
 	if (!page)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	len = sprintf(buf, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
-	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
-		int j, usedswap;
-		struct file *file;
-		char *path;
+	swap->private = page;	/* save for swap_show */
 
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
 }
+
+static void swap_stop(struct seq_file *swap, void *v)
+{
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
+}
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

--------------0EF9EF4883C39D36025D0263--

