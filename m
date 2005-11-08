Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVKHVEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVKHVEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVKHVEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:04:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46767 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030351AbVKHVEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:04:09 -0500
Date: Tue, 8 Nov 2005 13:03:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051108210347.31330.19192.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/8] Direct Migration V2: remove_from_swap() to remove swap ptes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add remove_from_swap

remove_from_swap() allows the restoration of the pte entries that existed
before page migration occurred for anonymous pages by walking the reverse
maps. This reduces swap use and establishes regular pte's without the need
for page faults.

It may also fix a leak of swap entries that could occur if a page
is freed without locking it first (zap_pte_range?) while migration occurs.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/swap.h	2005-11-08 10:15:02.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/swap.h	2005-11-08 10:16:58.000000000 -0800
@@ -266,6 +266,7 @@ extern int remove_exclusive_swap_page(st
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
+extern int unuse_vma(struct vm_area_struct *vma, swp_entry_t entry, struct page *page);
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
Index: linux-2.6.14-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swapfile.c	2005-11-08 10:15:00.000000000 -0800
+++ linux-2.6.14-mm1/mm/swapfile.c	2005-11-08 10:16:58.000000000 -0800
@@ -477,7 +477,7 @@ static inline int unuse_pud_range(struct
 	return 0;
 }
 
-static int unuse_vma(struct vm_area_struct *vma,
+int unuse_vma(struct vm_area_struct *vma,
 				swp_entry_t entry, struct page *page)
 {
 	pgd_t *pgd;
Index: linux-2.6.14-mm1/mm/rmap.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/rmap.c	2005-11-07 11:48:08.000000000 -0800
+++ linux-2.6.14-mm1/mm/rmap.c	2005-11-08 10:16:58.000000000 -0800
@@ -206,6 +206,25 @@ out:
 }
 
 /*
+ * Remove an anonymous page from swap replacing the swap pte's
+ * through real pte's pointing to valid pages.
+ */
+void remove_from_swap(struct page *page)
+{
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *vma;
+
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
+		return;
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+		swp_entry_t entry = { .val = page_private(page) };
+
+		unuse_vma(vma, entry, page);
+	}
+}
+
+/*
  * At what user virtual address is page expected in vma?
  */
 static inline unsigned long
Index: linux-2.6.14-mm1/include/linux/rmap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/rmap.h	2005-11-07 11:48:08.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/rmap.h	2005-11-08 10:16:58.000000000 -0800
@@ -91,6 +91,7 @@ static inline void page_dup_rmap(struct 
  */
 int page_referenced(struct page *, int is_locked, int ignore_token);
 int try_to_unmap(struct page *);
+void remove_from_swap(struct page *page);
 
 /*
  * Called from mm/filemap_xip.c to unmap empty zero page
Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-08 10:16:53.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-08 10:16:58.000000000 -0800
@@ -959,12 +959,15 @@ next:
 
 		else if (rc) {
 			/* Permanent failure to migrate the page */
+			remove_from_swap(page);
 			list_move(&page->lru, failed);
 			nr_failed++;
 		}
-		else if (newpage) {
-			/* Successful migration. Return new page to LRU */
-			move_to_lru(newpage);
+		else {
+			if (newpage) {
+				remove_from_swap(newpage);
+				move_to_lru(newpage);
+			}
 			list_move(&page->lru, moved);
 		}
 	}
