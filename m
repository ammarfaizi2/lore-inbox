Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVKKWhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVKKWhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKKWhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:37:11 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:47542 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751281AbVKKWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:36:55 -0500
Date: Fri, 11 Nov 2005 14:36:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>, lhms-devel@lists.sourceforge.net
Message-Id: <20051111223642.21716.54448.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051111223632.21716.49021.sendpatchset@schroedinger.engr.sgi.com>
References: <20051111223632.21716.49021.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/8] Direct Migration V3: PageSwapCache checks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for PageSwapCache after looking up and locking a swap page.

The page migration code may change a swap pte to point to a different page
under lock_page().

If that happens then the vm must retry the lookup operation in the swap
space to find the correct page number. There are a couple of locations
in the VM where a lock_page() is done on a swap page. In these locations
we need to check afterwards if the page was migrated. If the page was migrated
then the old page that was looked up before was freed and no longer has the
PageSwapCache bit set.

Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@@sgi.com>

Index: linux-2.6.14-mm1/mm/memory.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/memory.c	2005-11-07 11:48:19.000000000 -0800
+++ linux-2.6.14-mm1/mm/memory.c	2005-11-07 11:55:08.000000000 -0800
@@ -1720,6 +1720,7 @@ static int do_swap_page(struct mm_struct
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
+again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1743,6 +1744,12 @@ static int do_swap_page(struct mm_struct
 
 	mark_page_accessed(page);
 	lock_page(page);
+	if (!PageSwapCache(page)) {
+		/* Page migration has occured */
+		unlock_page(page);
+		page_cache_release(page);
+		goto again;
+	}
 
 	/*
 	 * Back out if somebody else already faulted in this pte.
Index: linux-2.6.14-mm1/mm/shmem.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/shmem.c	2005-11-07 11:48:08.000000000 -0800
+++ linux-2.6.14-mm1/mm/shmem.c	2005-11-07 11:55:08.000000000 -0800
@@ -1013,6 +1013,14 @@ repeat:
 			page_cache_release(swappage);
 			goto repeat;
 		}
+		if (!PageSwapCache(swappage)) {
+			/* Page migration has occured */
+			shmem_swp_unmap(entry);
+			spin_unlock(&info->lock);
+			unlock_page(swappage);
+			page_cache_release(swappage);
+			goto repeat;
+		}
 		if (PageWriteback(swappage)) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
Index: linux-2.6.14-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swapfile.c	2005-11-07 11:48:49.000000000 -0800
+++ linux-2.6.14-mm1/mm/swapfile.c	2005-11-07 11:55:08.000000000 -0800
@@ -624,6 +624,7 @@ static int try_to_unuse(unsigned int typ
 		 */
 		swap_map = &si->swap_map[i];
 		entry = swp_entry(type, i);
+again:
 		page = read_swap_cache_async(entry, NULL, 0);
 		if (!page) {
 			/*
@@ -658,6 +659,12 @@ static int try_to_unuse(unsigned int typ
 		wait_on_page_locked(page);
 		wait_on_page_writeback(page);
 		lock_page(page);
+		if (!PageSwapCache(page)) {
+			/* Page migration has occured */
+			unlock_page(page);
+			page_cache_release(page);
+			goto again;
+		}
 		wait_on_page_writeback(page);
 
 		/*
