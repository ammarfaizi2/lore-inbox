Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWAQUPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWAQUPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWAQUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:15:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36040 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964817AbWAQUPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:15:44 -0500
Date: Tue, 17 Jan 2006 12:15:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.61.0601171805430.8030@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0601171207300.28161@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601171805430.8030@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Hugh Dickins wrote:

> Of course, page_mapcount may go up an instant later; but equally,
> another vma may get added to the prio_tree an instant later.

Right. The check does not have to be race free.

> It may be that, after much argument to and fro, the whole function will
> just reduce to checking "page_mapcount(page) == 1": if so, then I think
> you can go back to inlining it literally.

Oh. I love simplicity.... Sadly, one sometimes has these complicated 
notions in ones brain. Thanks.


Simplify migrate_page_add after feedback from Hugh.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/mempolicy.c
===================================================================
--- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:28.000000000 -0800
+++ linux-2.6.15/mm/mempolicy.c	2006-01-17 12:12:42.000000000 -0800
@@ -527,42 +527,13 @@ long do_get_mempolicy(int *policy, nodem
  * page migration
  */
 
-/* Check if we are the only process mapping the page in question */
-static inline int single_mm_mapping(struct mm_struct *mm,
-			struct address_space *mapping)
-{
-	struct vm_area_struct *vma;
-	struct prio_tree_iter iter;
-	int rc = 1;
-
-	spin_lock(&mapping->i_mmap_lock);
-	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 0, ULONG_MAX)
-		if (mm != vma->vm_mm) {
-			rc = 0;
-			goto out;
-		}
-	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
-		if (mm != vma->vm_mm) {
-			rc = 0;
-			goto out;
-		}
-out:
-	spin_unlock(&mapping->i_mmap_lock);
-	return rc;
-}
-
-/*
- * Add a page to be migrated to the pagelist
- */
 static void migrate_page_add(struct vm_area_struct *vma,
 	struct page *page, struct list_head *pagelist, unsigned long flags)
 {
 	/*
-	 * Avoid migrating a page that is shared by others and not writable.
+	 * Avoid migrating a page that is shared with others.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
-	    mapping_writably_mapped(page->mapping) ||
-	    single_mm_mapping(vma->vm_mm, page->mapping))
+	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) ==1)
 		if (isolate_lru_page(page) == 1)
 			list_add(&page->lru, pagelist);
 }

