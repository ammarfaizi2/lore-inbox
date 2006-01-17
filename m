Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWAQStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWAQStk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAQStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:49:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:55229 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932365AbWAQStj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:49:39 -0500
Date: Tue, 17 Jan 2006 10:48:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <1137523571.5245.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601171047090.27764@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de> 
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com> 
 <20060114181949.GA27382@wotan.suse.de>  <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
  <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com> 
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com> 
 <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
 <1137523571.5245.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Lee Schermerhorn wrote:

> > +	if (page->mapping)
> should this be "if (!page->mapping)" ???

Correct. Thanks. Fixed up patch follows:



Explain the complicated check in migrate_page_add by putting the logic
into a separate function migration_check. This way any enhancements can
be easily added.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/mempolicy.c
===================================================================
--- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:28.000000000 -0800
+++ linux-2.6.15/mm/mempolicy.c	2006-01-17 10:47:48.000000000 -0800
@@ -551,6 +551,37 @@ out:
 	return rc;
 }
 
+static inline int migration_check(struct mm_struct *mm, struct page *page)
+{
+	/*
+	 * If the page has no mapping then we do not track reverse mappings.
+	 * Thus the page is not mapped by other mms, so its safe to move.
+	 */
+	if (!page->mapping)
+		return 1;
+
+	/*
+	 * We cannot determine "ownership" of anonymous pages.
+	 * However, this is the primary set of pages a user would like
+	 * to move. So move the page regardless of sharing.
+	 */
+	if (PageAnon(page))
+		return 1;
+
+	/*
+	 * If the mapping is writable then its reasonable to assume that
+	 * it is okay to move the page.
+	 */
+	if (mapping_writably_mapped(page->mapping))
+		return 1;
+
+	/*
+	 * Its a read only file backed mapping. Only migrate the page
+	 * if we are the only process mapping that file.
+	 */
+	return single_mm_mapping(mm, page->mapping);
+}
+
 /*
  * Add a page to be migrated to the pagelist
  */
@@ -558,11 +589,17 @@ static void migrate_page_add(struct vm_a
 	struct page *page, struct list_head *pagelist, unsigned long flags)
 {
 	/*
-	 * Avoid migrating a page that is shared by others and not writable.
+	 * MPOL_MF_MOVE_ALL migrates all pages. However, migrating all
+	 * pages may also move commonly shared pages (like for example glibc
+	 * pages referenced by all processes). If these are included in
+	 * migration then these pages may be uselessly moved back and
+	 * forth. Migration may also affect the performance of other
+	 * processes.
+	 *
+	 * If MPOL_MF_MOVE_ALL is not set then we try to avoid migrating
+	 * these shared pages.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
-	    mapping_writably_mapped(page->mapping) ||
-	    single_mm_mapping(vma->vm_mm, page->mapping))
+	if ((flags & MPOL_MF_MOVE_ALL) || migration_check(vma->vm_mm, page))
 		if (isolate_lru_page(page) == 1)
 			list_add(&page->lru, pagelist);
 }
