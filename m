Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTIXTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbTIXTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 15:42:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3980 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261508AbTIXTmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 15:42:51 -0400
Date: Wed, 24 Sep 2003 14:42:44 -0500 (CDT)
From: olof@austin.ibm.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.4] Re: /proc/ioports overrun patch
In-Reply-To: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva>
Message-ID: <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On Fri, 29 Aug 2003, Marcelo Tosatti wrote:

> Your change to do_resource_list() will avoid copying out of bound by
> truncating the resource output. Which means users might get truncated
> information (only information that fits in the buffer) and not the full
> information.
>
> Is that correct?
>
> If so, I would prefer to have a fix which outputs the full resource
> information. For that we would need seq_file().

I finally got some time to revisit this and convert /proc/ioports and
/proc/iomem to seq_file. See below patch -- it's backed against the
current BK tree.


Thanks,

Olof


Olof Johansson                                        Office: 4E002/905
pSeries Linux Development                             IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM



===== fs/proc/proc_misc.c 1.23 vs edited =====
--- 1.23/fs/proc/proc_misc.c	Fri Sep 12 08:44:05 2003
+++ edited/fs/proc/proc_misc.c	Wed Sep 24 12:35:00 2003
@@ -430,6 +430,53 @@
 };
 #endif /* !CONFIG_X86 */

+extern int show_ioports_resources(struct seq_file *p, void *v);
+extern int show_iomem_resources(struct seq_file *p, void *v);
+
+static int io_open(struct inode *inode, struct file *file,
+                   int (*f)(struct seq_file *, void*))
+{
+	unsigned size = PAGE_SIZE * (1 + smp_num_cpus / 8);
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, f, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+
+static int ioports_open(struct inode *inode, struct file *file)
+{
+	return io_open(inode, file, show_ioports_resources);
+}
+
+static int iomem_open(struct inode *inode, struct file *file)
+{
+	return io_open(inode, file, show_iomem_resources);
+}
+
+static struct file_operations proc_ioports_operations = {
+	.open		= ioports_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static struct file_operations proc_iomem_operations = {
+	.open		= iomem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -444,13 +491,6 @@
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
@@ -495,13 +535,6 @@
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
@@ -625,14 +658,12 @@
 #endif
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
-		{"ioports",	ioports_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286
 		{"rtc",		ds1286_read_proc},
 #endif
 		{"locks",	locks_read_proc},
 		{"swaps",	swaps_read_proc},
-		{"iomem",	memory_read_proc},
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};
@@ -649,6 +680,8 @@
 #if defined(CONFIG_X86)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 #endif
+	create_seq_entry("ioports", 0, &proc_ioports_operations);
+	create_seq_entry("iomem", 0, &proc_iomem_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES
===== include/linux/ioport.h 1.2 vs edited =====
--- 1.2/include/linux/ioport.h	Tue Sep 17 09:08:45 2002
+++ edited/include/linux/ioport.h	Wed Sep 24 12:38:30 2003
@@ -79,11 +79,16 @@
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)

+/* Just define it here instead of adding an include of seq_file. */
+
+struct seq_file;
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;

-extern int get_resource_list(struct resource *, char *buf, int size);
+extern int show_ioports_resources(struct seq_file *p, void *data);
+extern int show_iomem_resources(struct seq_file *p, void *data);

 extern int check_resource(struct resource *root, unsigned long, unsigned long);
 extern int request_resource(struct resource *root, struct resource *new);
@@ -110,9 +115,6 @@

 extern int __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
-
-#define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
-#define get_mem_list(buf)	get_resource_list(&iomem_resource, buf, PAGE_SIZE)

 #define HAVE_AUTOIRQ
 extern void autoirq_setup(int waittime);
===== kernel/resource.c 1.4 vs edited =====
--- 1.4/kernel/resource.c	Tue Sep 17 09:08:45 2002
+++ edited/kernel/resource.c	Wed Sep 24 12:41:32 2003
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>
 #include <asm/io.h>

 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
@@ -23,7 +24,7 @@
 /*
  * This generates reports for /proc/ioports and /proc/iomem
  */
-static char * do_resource_list(struct resource *entry, const char *fmt, int offset, char *buf, char *end)
+static int do_resource_list(struct resource *entry, const char *fmt, int offset, struct seq_file *p)
 {
 	if (offset < 0)
 		offset = 0;
@@ -32,24 +33,21 @@
 		const char *name = entry->name;
 		unsigned long from, to;

-		if ((int) (end-buf) < 80)
-			return buf;
-
 		from = entry->start;
 		to = entry->end;
 		if (!name)
 			name = "<BAD>";

-		buf += sprintf(buf, fmt + offset, from, to, name);
+		seq_printf(p, fmt + offset, from, to, name);
 		if (entry->child)
-			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);
+			do_resource_list(entry->child, fmt, offset-2, p);
 		entry = entry->sibling;
 	}

-	return buf;
+	return 0;
 }

-int get_resource_list(struct resource *root, char *buf, int size)
+static int show_io_resources(struct seq_file *p, struct resource *root)
 {
 	char *fmt;
 	int retval;
@@ -58,10 +56,20 @@
 	if (root->end < 0x10000)
 		fmt = "        %04lx-%04lx : %s\n";
 	read_lock(&resource_lock);
-	retval = do_resource_list(root->child, fmt, 8, buf, buf + size) - buf;
+	retval = do_resource_list(root->child, fmt, 8, p);
 	read_unlock(&resource_lock);
 	return retval;
 }
+
+int show_ioports_resources(struct seq_file *p, void *v)
+{
+	return show_io_resources(p, &ioport_resource);
+}
+
+int show_iomem_resources(struct seq_file *p, void *v)
+{
+	return show_io_resources(p, &iomem_resource);
+}

 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)

