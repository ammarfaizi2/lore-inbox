Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUE3QLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUE3QLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbUE3QLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:11:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53513 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261937AbUE3QKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:10:41 -0400
Date: Sun, 30 May 2004 17:10:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Bjorn Wesen <bjorn.wesen@axis.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs surplus page miscounted
Message-ID: <Pine.LNX.4.44.0405301656500.2275-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Wesen reports BUG_ON(inode->i_blocks) after sendfile or loop has
primed page cache with a tmpfs page, but the subsequent shmem_readpage
or shmem_prepare_write failed because filesystem max size was exceeded:
the surplus page has not been accounted, yet truncation assumes it has.

The obvious fix, to check Page_Uptodate in shmem_removepage, does not
work: because it has anyway been cleared by the time that is called.
We could rearrange, but it might be safer to avoid subtle dependency,
and just fix this up within shmem.c: using the PageError flag instead.

This is not an issue for 2.6, which uses shmem_recalc_inode instead of
2.4's removepage method, and so is ready for nrpages to drift a little.

Hugh

--- 2.4.27-pre3/mm/shmem.c	2003-11-28 18:26:21.000000000 +0000
+++ linux/mm/shmem.c	2004-05-30 16:20:49.374589600 +0100
@@ -86,7 +86,7 @@ static void shmem_free_block(struct inod
 
 static void shmem_removepage(struct page *page)
 {
-	if (!PageLaunder(page))
+	if (!PageLaunder(page) && !PageError(page))
 		shmem_free_block(page->mapping->host);
 }
 
@@ -626,8 +626,11 @@ static int shmem_getpage(struct inode *i
 	swp_entry_t swap;
 	int error = 0;
 
-	if (idx >= SHMEM_MAX_INDEX)
-		return -EFBIG;
+	if (idx >= SHMEM_MAX_INDEX) {
+		error = -EFBIG;
+		goto failed;
+	}
+
 	/*
 	 * Normally, filepage is NULL on entry, and either found
 	 * uptodate immediately, or allocated and zeroed, or read
@@ -781,18 +784,24 @@ repeat:
 	}
 done:
 	if (!*pagep) {
-		if (filepage) {
+		if (filepage)
 			UnlockPage(filepage);
-			*pagep = filepage;
-		} else
-			*pagep = ZERO_PAGE(0);
+		else
+			filepage = ZERO_PAGE(0);
+		*pagep = filepage;
 	}
+	if (PageError(filepage))
+		ClearPageError(filepage);
 	return 0;
 
 failed:
-	if (*pagep != filepage) {
-		UnlockPage(filepage);
-		page_cache_release(filepage);
+	if (filepage) {
+		if (*pagep == filepage)
+			SetPageError(filepage);
+		else {
+			UnlockPage(filepage);
+			page_cache_release(filepage);
+		}
 	}
 	return error;
 }

