Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIEWrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIEWrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIEWpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:45:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47502 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267306AbUIEWn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:43:26 -0400
Date: Sun, 5 Sep 2004 23:43:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] shmem: rework majmin and ZERO_PAGE
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052341440.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very minor adjustments to shmem_getpage return path: I now prefer it to
return NULL and let do_shmem_file_read use ZERO_PAGE(0) in that case;
and we don't need a local majmin variable, do_no_page initializes *type
to VM_FAULT_MINOR already.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/shmem.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

--- shmem5/mm/shmem.c	2004-09-05 17:06:30.195820472 +0100
+++ shmem6/mm/shmem.c	2004-09-05 17:06:41.258138744 +0100
@@ -885,7 +885,7 @@ static int shmem_getpage(struct inode *i
 	struct page *swappage;
 	swp_entry_t *entry;
 	swp_entry_t swap;
-	int error, majmin = VM_FAULT_MINOR;
+	int error;
 
 	if (idx >= SHMEM_MAX_INDEX)
 		return -EFBIG;
@@ -923,9 +923,10 @@ repeat:
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			/* here we actually do the io */
-			if (majmin == VM_FAULT_MINOR && type)
+			if (type && *type == VM_FAULT_MINOR) {
 				inc_page_state(pgmajfault);
-			majmin = VM_FAULT_MAJOR;
+				*type = VM_FAULT_MAJOR;
+			}
 			swappage = shmem_swapin(info, swap, idx);
 			if (!swappage) {
 				spin_lock(&info->lock);
@@ -1077,15 +1078,10 @@ repeat:
 		SetPageUptodate(filepage);
 	}
 done:
-	if (!*pagep) {
-		if (filepage) {
-			unlock_page(filepage);
-			*pagep = filepage;
-		} else
-			*pagep = ZERO_PAGE(0);
+	if (*pagep != filepage) {
+		unlock_page(filepage);
+		*pagep = filepage;
 	}
-	if (type)
-		*type = majmin;
 	return 0;
 
 failed:
@@ -1442,13 +1438,14 @@ static void do_shmem_file_read(struct fi
 		if (index == end_index) {
 			nr = i_size & ~PAGE_CACHE_MASK;
 			if (nr <= offset) {
-				page_cache_release(page);
+				if (page)
+					page_cache_release(page);
 				break;
 			}
 		}
 		nr -= offset;
 
-		if (page != ZERO_PAGE(0)) {
+		if (page) {
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
@@ -1461,7 +1458,8 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (!offset)
 				mark_page_accessed(page);
-		}
+		} else
+			page = ZERO_PAGE(0);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so

