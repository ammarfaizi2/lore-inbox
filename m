Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268192AbTBXG30>; Mon, 24 Feb 2003 01:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTBXG30>; Mon, 24 Feb 2003 01:29:26 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:1421 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S268190AbTBXG3V>; Mon, 24 Feb 2003 01:29:21 -0500
Message-ID: <3E59BDA1.AE4D483A@verizon.net>
Date: Sun, 23 Feb 2003 22:37:21 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.62 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] convert /proc/io{mem,ports} to seq_file
Content-Type: multipart/mixed;
 boundary="------------37017881617B97331FD0FEB1"
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [4.64.238.61] at Mon, 24 Feb 2003 00:39:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------37017881617B97331FD0FEB1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch is to Linux 2.5.62.

This converts /proc/io{mem,ports} to the seq_file interface
(single_open).

Please apply.

Thanks,
~Randy
--------------37017881617B97331FD0FEB1
Content-Type: text/plain; charset=us-ascii;
 name="seq1-iorescom-2562.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seq1-iorescom-2562.patch"

patch_name:	seq1-iorescom-2562.patch
patch_version:	2003-02-23.22:27:41
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	convert /proc/io{ports,mem} to seq_file (single_open)
product:	Linux
product_versions: linux-2562
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 fs/proc/proc_misc.c    |   16 ------
 include/linux/ioport.h |    3 -
 kernel/resource.c      |  118 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 91 insertions(+), 46 deletions(-)


diff -Naur ./include/linux/ioport.h%SEQIO ./include/linux/ioport.h
--- ./include/linux/ioport.h%SEQIO	Mon Feb 17 14:56:00 2003
+++ ./include/linux/ioport.h	Sat Feb 22 15:31:27 2003
@@ -111,7 +111,4 @@
 extern int __deprecated __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
 
-#define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
-#define get_mem_list(buf)	get_resource_list(&iomem_resource, buf, PAGE_SIZE)
-
 #endif	/* _LINUX_IOPORT_H */
diff -Naur ./fs/proc/proc_misc.c%SEQIO ./fs/proc/proc_misc.c
--- ./fs/proc/proc_misc.c%SEQIO	Mon Feb 17 14:55:56 2003
+++ ./fs/proc/proc_misc.c	Sat Feb 22 15:31:27 2003
@@ -424,13 +424,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int ioports_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_ioport_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int cmdline_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -469,13 +462,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int memory_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_mem_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 /*
  * This function accesses profiling information. The returned data is
  * binary: the sampling step and the actual contents of the profile
@@ -569,13 +555,11 @@
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
-		{"ioports",	ioports_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286
 		{"rtc",		ds1286_read_proc},
 #endif
 		{"locks",	locks_read_proc},
-		{"iomem",	memory_read_proc},
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};
diff -Naur ./kernel/resource.c%SEQIO ./kernel/resource.c
--- ./kernel/resource.c%SEQIO	Mon Feb 17 14:56:22 2003
+++ ./kernel/resource.c	Sun Feb 23 22:26:00 2003
@@ -7,61 +7,125 @@
  * Arbitrary resource management.
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <asm/io.h>
 
+
 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
 struct resource iomem_resource = { "PCI mem", 0x00000000, 0xffffffff, IORESOURCE_MEM };
 
 static rwlock_t resource_lock = RW_LOCK_UNLOCKED;
 
+#ifdef CONFIG_PROC_FS
+
+#define MAX_IORES_LEVEL		5
+
 /*
- * This generates reports for /proc/ioports and /proc/iomem
+ * do_resource_list():
+ * for reports of /proc/ioports and /proc/iomem;
+ * do current entry, then children, then siblings;
  */
-static char * do_resource_list(struct resource *entry, const char *fmt, int offset, char *buf, char *end)
+static int do_resource_list(struct seq_file *m, struct resource *res, const char *fmt, int level)
 {
-	if (offset < 0)
-		offset = 0;
+	while (res) {
+		const char *name;
 
-	while (entry) {
-		const char *name = entry->name;
-		unsigned long from, to;
-
-		if ((int) (end-buf) < 80)
-			return buf;
-
-		from = entry->start;
-		to = entry->end;
-		if (!name)
-			name = "<BAD>";
-
-		buf += sprintf(buf, fmt + offset, from, to, name);
-		if (entry->child)
-			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);
-		entry = entry->sibling;
+		name = res->name ? res->name : "<BAD>";
+		if (level > MAX_IORES_LEVEL)
+			level = MAX_IORES_LEVEL;
+		seq_printf (m, fmt + 2 * MAX_IORES_LEVEL - 2 * level,
+				res->start, res->end, name);
+
+		if (res->child)
+			do_resource_list(m, res->child, fmt, level + 1);
+
+		res = res->sibling;
 	}
 
-	return buf;
+	return 0;
 }
 
-int get_resource_list(struct resource *root, char *buf, int size)
+static int ioresources_show(struct seq_file *m, void *v)
 {
+	struct resource *root = m->private;
 	char *fmt;
 	int retval;
 
-	fmt = "        %08lx-%08lx : %s\n";
-	if (root->end < 0x10000)
-		fmt = "        %04lx-%04lx : %s\n";
+	fmt = root->end < 0x10000
+		? "          %04lx-%04lx : %s\n"
+		: "          %08lx-%08lx : %s\n";
 	read_lock(&resource_lock);
-	retval = do_resource_list(root->child, fmt, 8, buf, buf + size) - buf;
+	retval = do_resource_list(m, root->child, fmt, 0);
 	read_unlock(&resource_lock);
 	return retval;
-}	
+}
+
+static int ioresources_open(struct file *file, struct resource *root)
+{
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, ioresources_show, root);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = PAGE_SIZE;
+	} else
+		kfree(buf);
+	return res;
+}
+
+static int ioports_open(struct inode *inode, struct file *file)
+{
+	return ioresources_open(file, &ioport_resource);
+}
+
+static struct file_operations proc_ioports_operations = {
+	.open		= ioports_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int iomem_open(struct inode *inode, struct file *file)
+{
+	return ioresources_open(file, &iomem_resource);
+}
+
+static struct file_operations proc_iomem_operations = {
+	.open		= iomem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init ioresources_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("ioports", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_ioports_operations;
+	entry = create_proc_entry("iomem", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_iomem_operations;
+	return 0;
+}
+__initcall(ioresources_init);
+
+#endif /* CONFIG_PROC_FS */
 
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)

--------------37017881617B97331FD0FEB1--

