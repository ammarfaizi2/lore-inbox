Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUGLVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUGLVzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGLVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:55:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20575 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263775AbUGLVyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:54:31 -0400
Date: Mon, 12 Jul 2004 22:54:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmaplock 5/6 unuse_process mmap_sem
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407122253290.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the mm lock ordering documentation drew attention to the fact
that we were wrong to blithely add down_read(&mm->mmap_sem) to swapoff's
unuse_process, while it holds swapcache page lock: not very likely, but
it could deadlock against, say, mlock faulting a page back in from swap.

But it looks like these days it's safe to drop and reacquire page lock
if down_read_trylock fails: the page lock is held to stop try_to_unmap
unmapping the page's ptes as fast as try_to_unuse is mapping them back
in; but the recent fix for get_user_pages works to prevent that too.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/rmap.c     |    4 ++++
 mm/swapfile.c |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

--- rmaplock4/mm/rmap.c	2004-07-12 18:20:48.025890256 +0100
+++ rmaplock5/mm/rmap.c	2004-07-12 18:21:02.456696440 +0100
@@ -526,6 +526,10 @@ static int try_to_unmap_one(struct page 
 	 * an exclusive swap page, do_wp_page will replace it by a copy
 	 * page, and the user never get to see the data GUP was holding
 	 * the original page for.
+	 *
+	 * This test is also useful for when swapoff (unuse_process) has
+	 * to drop page lock: its reference to the page stops existing
+	 * ptes from being unmapped, so swapoff can make progress.
 	 */
 	if (PageSwapCache(page) &&
 	    page_count(page) != page_mapcount(page) + 2) {
--- rmaplock4/mm/swapfile.c	2004-07-09 10:53:46.000000000 +0100
+++ rmaplock5/mm/swapfile.c	2004-07-12 18:21:02.458696136 +0100
@@ -548,7 +548,15 @@ static int unuse_process(struct mm_struc
 	/*
 	 * Go through process' page directory.
 	 */
-	down_read(&mm->mmap_sem);
+	if (!down_read_trylock(&mm->mmap_sem)) {
+		/*
+		 * Our reference to the page stops try_to_unmap_one from
+		 * unmapping its ptes, so swapoff can make progress.
+		 */
+		unlock_page(page);
+		down_read(&mm->mmap_sem);
+		lock_page(page);
+	}
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (!is_vm_hugetlb_page(vma)) {

