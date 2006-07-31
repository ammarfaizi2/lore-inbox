Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGaMtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGaMtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGaMtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:49:08 -0400
Received: from mx2.mail.ru ([194.67.23.122]:30304 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751091AbWGaMtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:49:07 -0400
Date: Mon, 31 Jul 2006 16:57:02 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH]: ufs: ufs_get_locked_patch race fix
Message-ID: <20060731125702.GA5094@rain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed earlier:
http://lkml.org/lkml/2006/6/28/136
this patch fixes such issue:
`ufs_get_locked_page' takes page from cache
after that `vmtruncate' takes page and deletes it from cache
`ufs_get_locked_page' locks page, and reports about EIO error.

Also because of find_lock_page always return valid page or NULL,
we have no need check it if page not NULL.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>


---


Index: linux-2.6.18-rc2-mm1/fs/ufs/util.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/fs/ufs/util.c
+++ linux-2.6.18-rc2-mm1/fs/ufs/util.c
@@ -257,6 +257,7 @@ try_again:
 		page = read_cache_page(mapping, index,
 				       (filler_t*)mapping->a_ops->readpage,
 				       NULL);
+
 		if (IS_ERR(page)) {
 			printk(KERN_ERR "ufs_change_blocknr: "
 			       "read_cache_page error: ino %lu, index: %lu\n",
@@ -266,6 +267,13 @@ try_again:
 
 		lock_page(page);
 
+		if (unlikely(page->mapping != mapping ||
+			     page->index != index)) {
+			unlock_page(page);
+			page_cache_release(page);
+			goto try_again;
+		}
+
 		if (!PageUptodate(page) || PageError(page)) {
 			unlock_page(page);
 			page_cache_release(page);
@@ -275,15 +283,8 @@ try_again:
 			       mapping->host->i_ino, index);
 
 			page = ERR_PTR(-EIO);
-			goto out;
 		}
 	}
-
-	if (unlikely(!page->mapping || !page_has_buffers(page))) {
-		unlock_page(page);
-		page_cache_release(page);
-		goto try_again;/*we really need these buffers*/
-	}
 out:
 	return page;
 }

-- 
/Evgeniy

