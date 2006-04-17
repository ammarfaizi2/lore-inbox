Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWDQXwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWDQXwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWDQXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:52:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30384 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932069AbWDQXwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:52:42 -0400
Date: Mon, 17 Apr 2006 16:52:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: migration_entry_wait: Use the pte lock instead of the anon_vma lock.
In-Reply-To: <Pine.LNX.4.64.0604141417170.22852@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0604171649570.31773@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org> <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
 <20060414113104.72a5059b.akpm@osdl.org> <Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
 <20060414121537.11134d26.akpm@osdl.org> <Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
 <20060414125320.72599c7e.akpm@osdl.org> <Pine.LNX.4.64.0604141417170.22852@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use of the pte lock allows for much finer grained locking and avoids
the complexity coming with locking via the anon_vma. It will also
make the fetching of the pte value cleaner. Add a couple of other 
improvements as well.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-14 14:47:37.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-17 16:23:50.000000000 -0700
@@ -1881,7 +1881,7 @@ static int do_swap_page(struct mm_struct
 	entry = pte_to_swp_entry(orig_pte);
 
 	if (is_migration_entry(entry)) {
-		migration_entry_wait(entry, page_table);
+		migration_entry_wait(mm, pmd, address);
 		goto out;
 	}
 
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-14 14:47:37.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-17 16:45:52.000000000 -0700
@@ -91,13 +91,15 @@ static inline struct page *migration_ent
 	return p;
 }
 
-extern void migration_entry_wait(swp_entry_t entry, pte_t *);
+extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+					unsigned long address);
 #else
 
 #define make_migration_entry(page) swp_entry(0, 0)
 #define is_migration_entry(swp) 0
 #define migration_entry_to_page(swp) NULL
-static inline void migration_entry_wait(swp_entry_t entry, pte_t *ptep) { }
+static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+					 unsigned long address) { }
 
 #endif
 
Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-14 14:47:37.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-17 16:46:45.000000000 -0700
@@ -180,48 +180,35 @@ out:
  *
  * This function is called from do_swap_page().
  */
-void migration_entry_wait(swp_entry_t entry, pte_t *ptep)
+void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long address)
 {
-	struct page *page = migration_entry_to_page(entry);
-	unsigned long mapping = (unsigned long)page->mapping;
-	struct anon_vma *anon_vma;
-	pte_t pte;
-
-	if (!mapping ||
-		(mapping & PAGE_MAPPING_ANON) == 0)
-			return;
-	/*
-	 * We hold the mmap_sem lock.
-	 */
-	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
+	pte_t *ptep, pte;
+	spinlock_t *ptl;
+	swp_entry_t entry;
+	struct page *page;
 
-	/*
-	 * The anon_vma lock is also taken while removing the migration
-	 * entries. Take the lock here to insure that the migration pte
-	 * is not modified while we increment the page count.
-	 * This is similar to find_get_page().
-	 */
-	spin_lock(&anon_vma->lock);
+	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
-	if (pte_present(pte) || pte_none(pte) || pte_file(pte)) {
-		spin_unlock(&anon_vma->lock);
-		return;
-	}
+	if (!is_swap_pte(pte))
+		goto out;
+
 	entry = pte_to_swp_entry(pte);
-	if (!is_migration_entry(entry) ||
-		migration_entry_to_page(entry) != page) {
-			/* Migration entry is gone */
-			spin_unlock(&anon_vma->lock);
-			return;
-	}
-	/* Pages with migration entries must be locked */
+	if (!is_migration_entry(entry))
+		goto out;
+
+	page = migration_entry_to_page(entry);
+
+	/* Pages with migration entries are always locked */
 	BUG_ON(!PageLocked(page));
 
-	/* Phew. Finally we can increment the refcount */
 	get_page(page);
-	spin_unlock(&anon_vma->lock);
+	pte_unmap_unlock(ptep, ptl);
 	wait_on_page_locked(page);
 	put_page(page);
+	return;
+out:
+	pte_unmap_unlock(ptep, ptl);
 }
 
 /*
