Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWGSOJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWGSOJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWGSOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:09:45 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58518 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964828AbWGSOJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:09:45 -0400
Date: Wed, 19 Jul 2006 17:09:21 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libfs: remove page up-to-date check from simple_readpage
Message-ID: <Pine.LNX.4.58.0607191708250.22875@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes the unnecessary PageUptodate check from simple_readpage.
The only two callers for ->readpage that don't have explicit PageUptodate
check are read_cache_pages and page_cache_read which operate on newly
allocated pages which don't have the flag set.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 fs/libfs.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ac02ea6..b8e5cec 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -319,15 +319,10 @@ int simple_readpage(struct file *file, s
 {
 	void *kaddr;
 
-	if (PageUptodate(page))
-		goto out;
-
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
 	kunmap_atomic(kaddr, KM_USER0);
 	flush_dcache_page(page);
-	SetPageUptodate(page);
-out:
 	unlock_page(page);
 	return 0;
 }
-- 
1.4.1

