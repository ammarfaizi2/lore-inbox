Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVLSTlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVLSTlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVLSTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:41:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:57315 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964894AbVLSTlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:41:22 -0500
Date: Mon, 19 Dec 2005 11:41:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, lhms-devel@lists.sourceforge.net,
       Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051219194113.20715.9061.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
References: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Direct Migration V8: PageSwapCache checks
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

Index: linux-2.6.15-rc5-mm3/mm/memory.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/memory.c	2005-12-15 11:06:30.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/memory.c	2005-12-15 11:08:56.000000000 -0800
@@ -1870,6 +1870,7 @@ static int do_swap_page(struct mm_struct
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
+again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1893,6 +1894,12 @@ static int do_swap_page(struct mm_struct
 
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
Index: linux-2.6.15-rc5-mm3/mm/shmem.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/shmem.c	2005-12-15 11:06:30.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/shmem.c	2005-12-15 11:08:56.000000000 -0800
@@ -1028,6 +1028,14 @@ repeat:
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
Index: linux-2.6.15-rc5-mm3/mm/swapfile.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/swapfile.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/swapfile.c	2005-12-15 11:08:56.000000000 -0800
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
