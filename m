Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHPC2H>; Thu, 15 Aug 2002 22:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHPC2H>; Thu, 15 Aug 2002 22:28:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6281 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318047AbSHPC2D>;
	Thu, 15 Aug 2002 22:28:03 -0400
Message-ID: <3D5C6410.1020706@us.ibm.com>
Date: Thu, 15 Aug 2002 19:31:44 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: [PATCH] add buddyinfo /proc entry
Content-Type: multipart/mixed;
 boundary="------------090404050305010601040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090404050305010601040306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Not _another_ proc entry!

The following patch originally by Martin Bligh exports some 
information about the buddy allocator.

Each column of numbers represents the number of pages of that order 
which are available.  In this case, there are 5 chunks of 
2^2*PAGE_SIZE available in ZONE_DMA, and 101 chunks of 2^4*PAGE_SIZE 
availble in ZONE_NORMAL, etc...  This information can give you a good 
idea about how fragmented memory is and give you a clue as to how big 
of an area you can safely allocate.

Node 0, zone      DMA      0      4      5      4      4      3 ...
Node 0, zone   Normal      1      0      0      1    101      8 ...
Node 0, zone  HighMem      2      0      0      1      1      0 ...

-- 
Dave Hansen
haveblue@us.ibm.com

--------------090404050305010601040306
Content-Type: text/plain;
 name="buddyinfo-2.5.31+bk-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="buddyinfo-2.5.31+bk-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.549   -> 1.550  
#	     mm/page_alloc.c	1.88    -> 1.89   
#	 fs/proc/proc_misc.c	1.34    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	haveblue@nighthawk.sr71.net	1.550
# This small patch creates /proc/buddyinfo, which
# shows how many of each order page groups are available.
# 
# Port from -aa.
# --------------------------------------------
#
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Thu Aug 15 14:56:23 2002
+++ b/fs/proc/proc_misc.c	Thu Aug 15 14:56:23 2002
@@ -190,6 +190,20 @@
 #undef K
 }
 
+extern struct seq_operations fragmentation_op;
+static int fragmentation_open(struct inode *inode, struct file *file)
+{
+	(void)inode;
+	return seq_open(file, &fragmentation_op);
+}
+
+static struct file_operations fragmentation_file_operations = {
+	open:		fragmentation_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -606,6 +620,7 @@
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Thu Aug 15 14:56:23 2002
+++ b/mm/page_alloc.c	Thu Aug 15 14:56:23 2002
@@ -924,3 +924,74 @@
 }
 
 __setup("memfrac=", setup_mem_frac);
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	pg_data_t *pgdat;
+	loff_t node = *pos;
+
+	(void)m;
+
+	for (pgdat = pgdat_list; pgdat && node; pgdat = pgdat->pgdat_next)
+		--node;
+
+	return pgdat;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	(void)m;
+	(*pos)++;
+	return pgdat->pgdat_next;
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+	(void)m;
+	(void)arg;
+}
+
+/* 
+ * This walks the freelist for each zone. Whilst this is slow, I'd rather 
+ * be slow here than slow down the fast path by keeping stats - mjbligh
+ */
+static int frag_show(struct seq_file *m, void *arg)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+	zone_t *zone, *node_zones = pgdat->node_zones;
+	unsigned long flags;
+	int order;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		if (!zone->size)
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
+		for (order = 0; order < MAX_ORDER; ++order) {
+			unsigned long nr_bufs = 0;
+			list_t *elem;
+			list_for_each(elem, &zone->free_area[order].free_list)
+				++nr_bufs;
+			seq_printf(m, "%6lu ", nr_bufs);
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+struct seq_operations fragmentation_op = {
+	start:	frag_start,
+	next:	frag_next,
+	stop:	frag_stop,
+	show:	frag_show,
+};
+
+#endif /* CONFIG_PROC_FS */

--------------090404050305010601040306--

