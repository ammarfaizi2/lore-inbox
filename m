Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSJPTFz>; Wed, 16 Oct 2002 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSJPTFx>; Wed, 16 Oct 2002 15:05:53 -0400
Received: from ra.abo.fi ([130.232.213.1]:56041 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S261335AbSJPTFN>;
	Wed, 16 Oct 2002 15:05:13 -0400
Date: Wed, 16 Oct 2002 22:11:07 +0300 (EEST)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [patch, 2.5] highmem.c HASHED_PAGE_VIRTUAL unnecessary pool_lock
Message-ID: <Pine.LNX.4.44.0210162157051.14143-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pool_lock is equivalent to kmap_lock, so remove pool_lock.

When kmap_lock is taken, so will pool_lock be taken in 
set_page_address => we are already protected by kmap_lock. 
set_page_address must be made static due to this, but this is no 
problem since all callers are in highmem.c anyway.

Note, flush_all_zero_pkmaps and especially map_new_virtual are a bit 
slow due to linear scanning of pkmap_count. map_new_virtual could be 
done in O(1). But perhaps it's not worth the trouble to create two 
sets of very different highmem.c routines for some speedup in the 
HASHED_PAGE_VIRTUAL configuration...

Marcus


diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.43/include/linux/mm.h msa-2.5.43/include/linux/mm.h
--- linus-2.5.43/include/linux/mm.h	Wed Oct 16 16:31:16 2002
+++ msa-2.5.43/include/linux/mm.h	Wed Oct 16 17:55:58 2002
@@ -308,7 +308,6 @@
 
 #if defined(HASHED_PAGE_VIRTUAL)
 void *page_address(struct page *page);
-void set_page_address(struct page *page, void *virtual);
 void page_address_init(void);
 #endif
 
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.43/mm/highmem.c msa-2.5.43/mm/highmem.c
--- linus-2.5.43/mm/highmem.c	Mon Oct  7 22:25:30 2002
+++ msa-2.5.43/mm/highmem.c	Wed Oct 16 18:51:35 2002
@@ -48,9 +48,18 @@
  *    since the last TLB flush - so we can't use it.
  *  n means that there are (n-1) current users of it.
  */
+
+#if defined(HASHED_PAGE_VIRTUAL)
+void set_page_address(struct page *page, void *virtual);
+#endif
+
 #ifdef CONFIG_HIGHMEM
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
+/*
+ * protects pkmap_count
+ * protects page_address_pool if hashed virtual pages
+ */
 static spinlock_t kmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 pte_t * pkmap_page_table;
@@ -503,7 +512,6 @@
  * page_address_map freelist, allocated from page_address_maps.
  */
 static struct list_head page_address_pool;	/* freelist */
-static spinlock_t pool_lock;			/* protects page_address_pool */
 
 /*
  * Hash table bucket
@@ -545,7 +553,7 @@
 	return ret;
 }
 
-void set_page_address(struct page *page, void *virtual)
+static void set_page_address(struct page *page, void *virtual)
 {
 	unsigned long flags;
 	struct page_address_slot *pas;
@@ -557,11 +565,9 @@
 	if (virtual) {		/* Add */
 		BUG_ON(list_empty(&page_address_pool));
 
-		spin_lock_irqsave(&pool_lock, flags);
 		pam = list_entry(page_address_pool.next,
 				struct page_address_map, list);
 		list_del(&pam->list);
-		spin_unlock_irqrestore(&pool_lock, flags);
 
 		pam->page = page;
 		pam->virtual = virtual;
@@ -575,9 +581,7 @@
 			if (pam->page == page) {
 				list_del(&pam->list);
 				spin_unlock_irqrestore(&pas->lock, flags);
-				spin_lock_irqsave(&pool_lock, flags);
 				list_add_tail(&pam->list, &page_address_pool);
-				spin_unlock_irqrestore(&pool_lock, flags);
 				goto done;
 			}
 		}
@@ -600,7 +604,6 @@
 		INIT_LIST_HEAD(&page_address_htable[i].lh);
 		spin_lock_init(&page_address_htable[i].lock);
 	}
-	spin_lock_init(&pool_lock);
 }
 
 #endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */

