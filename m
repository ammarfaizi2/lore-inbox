Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVK3RzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVK3RzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVK3RzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:55:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52634 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751486AbVK3RzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:55:19 -0500
Date: Wed, 30 Nov 2005 09:55:11 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>
Subject: Re: [Lhms-devel] [PATCH 4/7] Direct Migration V5: migrate_pages()
 extension
In-Reply-To: <438DE141.3030206@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511300940310.19602@schroedinger.engr.sgi.com>
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
 <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com>
 <438D6427.8060003@jp.fujitsu.com> <Pine.LNX.4.62.0511300834010.19142@schroedinger.engr.sgi.com>
 <438DE141.3030206@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Kamezawa Hiroyuki wrote:

> Christoph Lameter wrote:
> > The current page migration functions in mempolicy.c do not migrate shmem
> > vmas to be safe. In the future we surely would like to support migration of
> > shmem. I'd be glad if you could make sure that this works.
> > 
> Okay, shmem is not problem now.

So I could allow VM_SHM migration? Patch attached.

> remove_from_page_cache(page) sets page->mapping == NULL.

Correct. So shmem_writepage actually removes a page. Hmm...

> Even if page->mapping == NULL, page_mapping() can return &swapper_space if
> PageSwapCache()
> is true. (Note: a shmem page here is not page-cache, not anon, but swap-cache)
> 
> I'm now considering to add a_ops->migrate_page() to shmem is sane way...
> But migration doesn't manage shmem, so this is just memory hot-remove's
> problem.

Do you think this patch would work? It allows migration of VM_SHM vmas and
switches from checking page->mapping to page_mapping() in 
migrate_page_remove_references.

Index: linux-2.6.15-rc3-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/mempolicy.c	2005-11-30 09:53:31.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/mempolicy.c	2005-11-30 09:53:32.000000000 -0800
@@ -294,7 +294,7 @@ static inline int check_pgd_range(struct
 static inline int vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (
-		VM_LOCKED|VM_IO|VM_RESERVED|VM_PFNMAP|VM_DENYWRITE|VM_SHM))
+		VM_LOCKED|VM_IO|VM_RESERVED|VM_PFNMAP|VM_DENYWRITE))
 		return 0;
 	return 1;
 }
Index: linux-2.6.15-rc3-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/vmscan.c	2005-11-30 09:53:31.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/vmscan.c	2005-11-30 09:53:41.000000000 -0800
@@ -742,7 +742,7 @@ int migrate_page_remove_references(struc
 						&mapping->page_tree,
 						page_index(page));
 
-	if (!page->mapping ||
+	if (!page_mapping(page) ||
 	    page_count(page) != nr_refs ||
 	    *radix_pointer != page) {
 		write_unlock_irq(&mapping->tree_lock);
