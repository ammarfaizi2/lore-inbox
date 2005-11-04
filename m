Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVKDXhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKDXhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKDXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:37:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28567 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751107AbVKDXhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:37:46 -0500
Date: Fri, 4 Nov 2005 15:37:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       linux-mm@kvack.org, torvalds@osdl.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051104233722.5459.68575.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
References: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/7] Direct Migration V1: PageSwapCache checks
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

Index: linux-2.6.14-rc5-mm1/mm/memory.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/memory.c	2005-10-24 10:27:12.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/memory.c	2005-10-28 16:09:11.000000000 -0700
@@ -1665,6 +1665,7 @@ static int do_swap_page(struct mm_struct
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
+again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1688,6 +1689,12 @@ static int do_swap_page(struct mm_struct
 
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
Index: linux-2.6.14-rc5-mm1/mm/shmem.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/shmem.c	2005-10-24 10:27:12.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/shmem.c	2005-10-28 16:08:20.000000000 -0700
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
Index: linux-2.6.14-rc5-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/swapfile.c	2005-10-24 10:27:36.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/swapfile.c	2005-10-28 16:08:20.000000000 -0700
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
