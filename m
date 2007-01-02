Return-Path: <linux-kernel-owner+w=401wt.eu-S1755355AbXABQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbXABQTG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbXABQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:19:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53572 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbXABQTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:19:04 -0500
Date: Tue, 2 Jan 2007 18:19:01 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: slab: remove broken PageSlab check from kfree_debugcheck
Message-ID: <Pine.LNX.4.64.0701021813590.24100@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

The PageSlab debug check in kfree_debugcheck() is broken for compound 
pages.  It is also redundant as we already do BUG_ON for non-slab pages in
page_get_cache() and page_get_slab() which are always called before we 
free any actual objects.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index 0d4e574..77d24eb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2814,19 +2814,11 @@ #if DEBUG
  */
 static void kfree_debugcheck(const void *objp)
 {
-	struct page *page;
-
 	if (!virt_addr_valid(objp)) {
 		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
 		       (unsigned long)objp);
 		BUG();
 	}
-	page = virt_to_page(objp);
-	if (!PageSlab(page)) {
-		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n",
-		       (unsigned long)objp);
-		BUG();
-	}
 }
 
 static inline void verify_redzone_free(struct kmem_cache *cache, void *obj)
