Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWAJWli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWAJWli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWAJWli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:41:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:23497 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932600AbWAJWlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:41:37 -0500
Date: Tue, 10 Jan 2006 14:41:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>, lhms-devel@lists.sourceforge.net,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060110224119.19138.60116.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Direct Migration V9: PageSwapCache checks
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

Index: linux-2.6.15/mm/memory.c
===================================================================
--- linux-2.6.15.orig/mm/memory.c	2006-01-10 09:43:04.000000000 -0800
+++ linux-2.6.15/mm/memory.c	2006-01-10 14:31:39.000000000 -0800
@@ -1871,6 +1871,7 @@ static int do_swap_page(struct mm_struct
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
+again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1894,6 +1895,12 @@ static int do_swap_page(struct mm_struct
 
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
Index: linux-2.6.15/mm/shmem.c
===================================================================
--- linux-2.6.15.orig/mm/shmem.c	2006-01-10 09:43:04.000000000 -0800
+++ linux-2.6.15/mm/shmem.c	2006-01-10 14:31:39.000000000 -0800
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
Index: linux-2.6.15/mm/swapfile.c
===================================================================
--- linux-2.6.15.orig/mm/swapfile.c	2006-01-10 09:43:04.000000000 -0800
+++ linux-2.6.15/mm/swapfile.c	2006-01-10 14:31:39.000000000 -0800
@@ -644,6 +644,7 @@ static int try_to_unuse(unsigned int typ
 		 */
 		swap_map = &si->swap_map[i];
 		entry = swp_entry(type, i);
+again:
 		page = read_swap_cache_async(entry, NULL, 0);
 		if (!page) {
 			/*
@@ -678,6 +679,12 @@ static int try_to_unuse(unsigned int typ
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
