Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933023AbWFWK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbWFWK5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932999AbWFWK4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10252 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933014AbWFWK4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:56:18 -0400
Date: Fri, 23 Jun 2006 12:56:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] mm/readahead.c: cleanups
Message-ID: <20060623105617.GS9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- rename the global variable debug_level (sic) to readahead_debug_level
- proper extern declaration for readahead_debug_level in 
  include/linux/mm.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/mm.h |    6 ++++++
 mm/filemap.c       |   12 +++---------
 mm/readahead.c     |   19 +++++++++----------
 3 files changed, 18 insertions(+), 19 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/mm.h.old	2006-06-22 22:04:21.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/mm.h	2006-06-22 22:09:13.000000000 +0200
@@ -1062,6 +1062,12 @@
 #endif
 }
 
+#ifdef CONFIG_DEBUG_READAHEAD
+extern u32 readahead_debug_level;
+#else
+#define readahead_debug_level 0
+#endif /* CONFIG_DEBUG_READAHEAD */
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.17-mm1-full/mm/readahead.c.old	2006-06-22 20:57:07.000000000 +0200
+++ linux-2.6.17-mm1-full/mm/readahead.c	2006-06-23 00:31:25.000000000 +0200
@@ -102,10 +102,10 @@
 };
 
 #ifdef CONFIG_DEBUG_READAHEAD
-u32 initial_ra_hit;
-u32 initial_ra_miss;
-u32 debug_level = 1;
-u32 disable_stateful_method = 0;
+static u32 initial_ra_hit;
+static u32 initial_ra_miss;
+u32 readahead_debug_level = 1;
+static u32 disable_stateful_method = 0;
 static const char * const ra_class_name[];
 static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages);
 #  define debug_inc(var)		do { var++; } while (0)
@@ -114,13 +114,12 @@
 #  define ra_account(ra, e, pages)	do { } while (0)
 #  define debug_inc(var)		do { } while (0)
 #  define debug_option(o)		(0)
-#  define debug_level 			(0)
 #endif /* CONFIG_DEBUG_READAHEAD */
 
 #define dprintk(args...) \
-	do { if (debug_level >= 2) printk(KERN_DEBUG args); } while(0)
+	do { if (readahead_debug_level >= 2) printk(KERN_DEBUG args); } while(0)
 #define ddprintk(args...) \
-	do { if (debug_level >= 3) printk(KERN_DEBUG args); } while(0)
+	do { if (readahead_debug_level >= 3) printk(KERN_DEBUG args); } while(0)
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -2011,7 +2010,7 @@
 {
 	enum ra_class c;
 
-	if (!debug_level)
+	if (!readahead_debug_level)
 		return;
 
 	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
@@ -2142,7 +2141,7 @@
 	return 1;
 }
 
-struct file_operations ra_events_fops = {
+static struct file_operations ra_events_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ra_events_open,
 	.write		= ra_events_write,
@@ -2168,7 +2167,7 @@
 	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_hit);
 	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_miss);
 
-	READAHEAD_DEBUGFS_ENTRY_U32(debug_level);
+	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);
 	READAHEAD_DEBUGFS_ENTRY_BOOL(disable_stateful_method);
 
 	return 0;
--- linux-2.6.17-mm1-full/mm/filemap.c.old	2006-06-22 22:03:34.000000000 +0200
+++ linux-2.6.17-mm1-full/mm/filemap.c	2006-06-22 22:06:37.000000000 +0200
@@ -45,12 +45,6 @@
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs);
 
-#ifdef CONFIG_DEBUG_READAHEAD
-extern u32 debug_level;
-#else
-#define debug_level 0
-#endif /* CONFIG_DEBUG_READAHEAD */
-
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -937,7 +931,7 @@
 	if (!isize)
 		goto out;
 
-	if (debug_level >= 5)
+	if (readahead_debug_level >= 5)
 		printk(KERN_DEBUG "read-file(ino=%lu, req=%lu+%lu)\n",
 			inode->i_ino, index, last_index - index);
 
@@ -995,7 +989,7 @@
 		if (prefer_adaptive_readahead())
 			readahead_cache_hit(&ra, page);
 
-		if (debug_level >= 7)
+		if (readahead_debug_level >= 7)
 			printk(KERN_DEBUG "read-page(ino=%lu, idx=%lu, io=%s)\n",
 				inode->i_ino, index,
 				PageUptodate(page) ? "hit" : "miss");
@@ -1524,7 +1518,7 @@
 	if (prefer_adaptive_readahead())
 		readahead_cache_hit(ra, page);
 
-	if (debug_level >= 6)
+	if (readahead_debug_level >= 6)
 		printk(KERN_DEBUG "read-mmap(ino=%lu, idx=%lu, hint=%s, io=%s)\n",
 			inode->i_ino, pgoff,
 			VM_RandomReadHint(area) ? "random" :

