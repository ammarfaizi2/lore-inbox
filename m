Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbRF1EP0>; Thu, 28 Jun 2001 00:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265518AbRF1EPQ>; Thu, 28 Jun 2001 00:15:16 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:63759 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S265516AbRF1EO6>; Thu, 28 Jun 2001 00:14:58 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: torvalds@transmeta.com, alan@redhat.com
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory.c locking comments fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Jun 2001 21:14:45 -0700
Message-Id: <E15FTCX-0007IY-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some of the comments in and before handle_pte_fault() are obsolete or
misleading:

- page_table_lock has been pushed up into handle_mm_fault() and down
into the various do_xxx_page() handlers.

- mmap_sem protects the adding of vma structures to the vmlist, not
pages to the page tables.

Paul

--- linux/mm/memory.c	Fri Apr 27 14:23:25 2001
+++ linux.new/mm/memory.c	Wed Jun 27 20:57:48 2001
@@ -1280,14 +1280,10 @@
  * with external mmu caches can use to update those (ie the Sparc or
  * PowerPC hashed page tables that act as extended TLBs).
  *
- * Note the "page_table_lock". It is to protect against kswapd removing
- * pages from under us. Note that kswapd only ever _removes_ pages, never
- * adds them. As such, once we have noticed that the page is not present,
- * we can drop the lock early.
- *
- * The adding of pages is protected by the MM semaphore (which we hold),
- * so we don't need to worry about a page being suddenly been added into
- * our VM.
+ * The addition and removal of vma structures is protected by the MM
+ * semaphore (which we hold), so we don't need to worry about a vma
+ * being suddenly been added into our VM, or the vma that we hold
+ * becoming invalid.  
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1297,11 +1293,6 @@
 
 	entry = *pte;
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte);
 		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);


