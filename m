Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDTUTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDTUTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDTUTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:19:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14474 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751251AbWDTUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:19:06 -0400
Date: Thu, 20 Apr 2006 13:18:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org
Subject: Read/Write migration entries: Make mprotect() convert write migration
 entries to read
In-Reply-To: <20060419123911.3bd22ab3.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604201317220.19049@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0604181119480.7814@schroedinger.engr.sgi.com>
 <20060419095044.d7333b21.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604181823590.9747@schroedinger.engr.sgi.com>
 <20060419123911.3bd22ab3.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Introduce a new function make_migration_entry() to
   isolate common code between copy_pte_range and change_pte_range.

2. Modify change_pte_range() to check for a migration entry.
   If a write migration entry is found and there is a request for
   a READ permissions then change the migration entry.

I am a bit concerned about the check of newprot. Are there other
values than PAGE_READONLY that indicate read only access?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm3/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/mm/memory.c	2006-04-18 11:09:23.252982000 -0700
+++ linux-2.6.17-rc1-mm3/mm/memory.c	2006-04-20 12:22:50.626800376 -0700
@@ -447,14 +447,11 @@
 			}
 			if (is_migration_entry(entry) &&
 					is_cow_mapping(vm_flags)) {
-				page = migration_entry_to_page(entry);
-
 				/*
 				 * COW mappings require pages in both parent
-				*  and child to be set to read.
+				 * and child to be set to read.
 				 */
-				entry = make_migration_entry(page,
-						SWP_MIGRATION_READ);
+				make_migration_entry_read(&entry);
 				pte = swp_entry_to_pte(entry);
 				set_pte_at(src_mm, addr, src_pte, pte);
 			}
Index: linux-2.6.17-rc1-mm3/mm/mprotect.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/mm/mprotect.c	2006-04-18 11:12:30.614603000 -0700
+++ linux-2.6.17-rc1-mm3/mm/mprotect.c	2006-04-20 12:17:03.771210036 -0700
@@ -19,6 +19,8 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -28,22 +30,35 @@
 static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
-	pte_t *pte;
+	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
-		if (pte_present(*pte)) {
+		oldpte = *pte;
+		if (pte_present(oldpte)) {
 			pte_t ptent;
 
 			/* Avoid an SMP race with hardware updated dirty/clean
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			ptent = pte_modify(ptep_get_and_clear(mm, addr, pte), newprot);
+			ptent = pte_modify(ptep_get_and_clear(mm, addr, pte),
+								newprot);
 			set_pte_at(mm, addr, pte, ptent);
 			lazy_mmu_prot_update(ptent);
+		} else
+		if (!pte_file(oldpte) && pgprot_val(newprot) ==
+						 pgprot_val(PAGE_READONLY)) {
+			swp_entry_t entry = pte_to_swp_entry(oldpte);
+
+			if (is_write_migration_entry(entry)) {
+				make_migration_entry_read(&entry);
+				set_pte_at(mm, addr, pte,
+					swp_entry_to_pte(entry));
+			}
 		}
+
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(pte - 1, ptl);
 }
Index: linux-2.6.17-rc1-mm3/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/linux/swapops.h	2006-04-18 10:58:33.675573000 -0700
+++ linux-2.6.17-rc1-mm3/include/linux/swapops.h	2006-04-20 12:00:29.279539838 -0700
@@ -98,6 +98,11 @@
 	return p;
 }
 
+static inline void make_migration_entry_read(swp_entry_t *entry)
+{
+	*entry = swp_entry(SWP_MIGRATION_READ, swp_offset(*entry));
+}
+
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #else
@@ -105,6 +110,7 @@
 #define make_migration_entry(page, write) swp_entry(0, 0)
 #define is_migration_entry(swp) 0
 #define migration_entry_to_page(swp) NULL
+static inline void make_migration_entry_read(entryp) { }
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 
