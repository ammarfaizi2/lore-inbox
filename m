Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263013AbTCWKhu>; Sun, 23 Mar 2003 05:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263014AbTCWKhu>; Sun, 23 Mar 2003 05:37:50 -0500
Received: from verein.lst.de ([212.34.181.86]:57865 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263013AbTCWKhr>;
	Sun, 23 Mar 2003 05:37:47 -0500
Date: Sun, 23 Mar 2003 11:48:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't include swap.h in mm.h
Message-ID: <20030323114851.A28050@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap.h is basically the header for MM internals instead of the
public API (mm_internal.h would have been a better name..).  Stop
including it in mm.h - this only needs moving one function that
should be in swap.h anyway to the right place and fixing up a bunch
of places using it.


--- 1.159/drivers/block/ll_rw_blk.c	Sun Mar 23 01:14:13 2003
+++ edited/drivers/block/ll_rw_blk.c	Sun Mar 23 09:40:11 2003
@@ -26,6 +26,7 @@
 #include <linux/bootmem.h>	/* for max_pfn/max_low_pfn */
 #include <linux/completion.h>
 #include <linux/slab.h>
+#include <linux/swap.h>
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
--- 1.40/fs/bio.c	Tue Feb 25 12:18:00 2003
+++ edited/fs/bio.c	Sun Mar 23 09:40:11 2003
@@ -7,7 +7,6 @@
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
@@ -17,6 +16,7 @@
  *
  */
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/blk.h>
 #include <linux/slab.h>
--- 1.113/include/linux/mm.h	Sun Mar 23 01:14:57 2003
+++ edited/include/linux/mm.h	Sun Mar 23 09:40:11 2003
@@ -8,10 +8,8 @@
 
 #include <linux/config.h>
 #include <linux/gfp.h>
-#include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
-#include <linux/swap.h>
 #include <linux/rbtree.h>
 #include <linux/fs.h>
 
@@ -142,6 +140,7 @@
 /* forward declaration; pte_chain is meant to be internal to rmap.c */
 struct pte_chain;
 struct mmu_gather;
+struct inode;
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -490,10 +489,7 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
-#ifdef CONFIG_NUMA
 extern void si_meminfo_node(struct sysinfo *val, int nid);
-#endif
-extern void swapin_readahead(swp_entry_t);
 
 /* mmap.c */
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
--- 1.72/include/linux/swap.h	Sun Mar  2 21:14:31 2003
+++ edited/include/linux/swap.h	Sun Mar 23 09:40:11 2003
@@ -144,6 +144,9 @@
 /* linux/mm/oom_kill.c */
 extern void out_of_memory(void);
 
+/* linux/mm/memory.c */
+extern void swapin_readahead(swp_entry_t);
+
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
--- 1.38/kernel/sysctl.c	Fri Jan 17 09:49:15 2003
+++ edited/kernel/sysctl.c	Sun Mar 23 09:40:12 2003
@@ -20,6 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
--- 1.48/kernel/timer.c	Thu Mar 20 03:40:57 2003
+++ edited/kernel/timer.c	Sun Mar 23 09:40:12 2003
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
 #include <linux/time.h>
--- 1.185/mm/filemap.c	Sun Mar 23 01:14:49 2003
+++ edited/mm/filemap.c	Sun Mar 23 09:40:12 2003
@@ -17,6 +17,7 @@
 #include <linux/aio.h>
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
--- 1.6/mm/fremap.c	Sun Mar 23 01:14:57 2003
+++ edited/mm/fremap.c	Sun Mar 23 09:40:12 2003
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/file.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
--- 1.41/mm/highmem.c	Tue Mar 18 00:32:02 2003
+++ edited/mm/highmem.c	Sun Mar 23 09:40:12 2003
@@ -17,6 +17,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
--- 1.58/mm/page-writeback.c	Mon Mar 17 01:33:14 2003
+++ edited/mm/page-writeback.c	Sun Mar 23 09:40:12 2003
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
--- 1.21/mm/rmap.c	Sun Mar 23 01:06:03 2003
+++ edited/mm/rmap.c	Sun Mar 23 09:40:12 2003
@@ -22,6 +22,7 @@
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
