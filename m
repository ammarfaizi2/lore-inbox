Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311505AbSCTECQ>; Tue, 19 Mar 2002 23:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311504AbSCTECN>; Tue, 19 Mar 2002 23:02:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:14863 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311505AbSCTEBE>; Tue, 19 Mar 2002 23:01:04 -0500
Message-ID: <3C980927.8D46B620@zip.com.au>
Date: Tue, 19 Mar 2002 19:59:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-120-try_to_free_pages_nozone
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The page reclaiming logic operates on a per-zone basis.  This patch
introduces a general try_to_free_pages_nozone() which just tries to
free 32 pages from *every* zone.

This function is only used from free_more_memory() in fs/buffer.c. 
When we're trying to grow buffers against a device for filesystem
metadata.

It seems to me that free_more_memory() simply is not needed - we're
already retrying the allocation over in buffer.c, and it seems that
this will do most everything which the call to try_to_free_pages()
would do?



=====================================

--- 2.4.19-pre3/fs/buffer.c~aa-120-try_to_free_pages_nozone	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/fs/buffer.c	Tue Mar 19 19:49:01 2002
@@ -731,12 +731,8 @@ void __invalidate_buffers(kdev_t dev, in
 
 static void free_more_memory(void)
 {
-	zone_t * zone = contig_page_data.node_zonelists[GFP_NOFS & GFP_ZONEMASK].zones[0];
-	
-	balance_dirty();
 	wakeup_bdflush();
-	try_to_free_pages(zone, GFP_NOFS, 0);
-	run_task_queue(&tq_disk);
+	try_to_free_pages_nozone(GFP_NOIO);
 	current->policy |= SCHED_YIELD;
 	__set_current_state(TASK_RUNNING);
 	schedule();
--- 2.4.19-pre3/include/linux/swap.h~aa-120-try_to_free_pages_nozone	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/include/linux/swap.h	Tue Mar 19 19:49:01 2002
@@ -113,6 +113,7 @@ extern void swap_setup(void);
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
 extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio;
+extern int FASTCALL(try_to_free_pages_nozone(unsigned int));
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
--- 2.4.19-pre3/mm/page_alloc.c~aa-120-try_to_free_pages_nozone	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/page_alloc.c	Tue Mar 19 19:49:13 2002
@@ -510,6 +510,30 @@ unsigned int nr_free_highpages (void)
 }
 #endif
 
+int try_to_free_pages_nozone(unsigned int gfp_mask)
+{
+	pg_data_t *pgdat = pgdat_list;
+	zonelist_t *zonelist;
+	zone_t **zonep;
+	int ret = 0;
+	unsigned long pf_free_pages;
+
+	pf_free_pages = current->flags & PF_FREE_PAGES;
+	current->flags &= ~PF_FREE_PAGES;
+
+	do {
+		zonelist = pgdat->node_zonelists + (gfp_mask & GFP_ZONEMASK);
+		zonep = zonelist->zones;
+
+		ret |= try_to_free_pages(*zonep, gfp_mask, 0);
+
+		pgdat = pgdat->node_next;
+	} while (pgdat);
+
+	current->flags |= pf_free_pages;
+	return ret;
+}
+
 #define K(x) ((x) << (PAGE_SHIFT-10))
 
 /*

-
