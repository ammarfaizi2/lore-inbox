Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVJ3AsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVJ3AsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVJ3AsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:48:15 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:49040 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932607AbVJ3AsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:48:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=c6PcttihawROTh6UQ7cU/VqhE2H88DOFkNx/81maQwgu0JPk8H7uFYCvmtc7J89ew1bciKczDx5lxwEg1s9HJJR8jttbMu1Lq5aoTyMNq6ER1YY0APK3294DG5HRxUC9unnY0IB4fPnTKM0Q6gT6AI9YVclYnxrH/DYi/RnQU6A=  ;
Message-ID: <436418A8.9000505@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:49:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 2/5] radix tree: use prealloc
References: <436416AD.3050709@yahoo.com.au> <4364186F.60206@yahoo.com.au>
In-Reply-To: <4364186F.60206@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030504090708030507000603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504090708030507000603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/5

-- 
SUSE Labs, Novell Inc.


--------------030504090708030507000603
Content-Type: text/plain;
 name="radix-tree-use-prealloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-use-prealloc.patch"

Prefer radix_tree_preloads to kmem_cache_alloc. If we've allocated them,
why not use them? They're also faster because they needn't turn off
interrupts, so using them in radix tree critical sections is a good idea.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -82,20 +82,18 @@ DEFINE_PER_CPU(struct radix_tree_preload
 static struct radix_tree_node *
 radix_tree_node_alloc(struct radix_tree_root *root)
 {
-	struct radix_tree_node *ret;
-
-	ret = kmem_cache_alloc(radix_tree_node_cachep, root->gfp_mask);
-	if (ret == NULL && !(root->gfp_mask & __GFP_WAIT)) {
-		struct radix_tree_preload *rtp;
+	struct radix_tree_preload *rtp;
 
-		rtp = &__get_cpu_var(radix_tree_preloads);
-		if (rtp->nr) {
-			ret = rtp->nodes[rtp->nr - 1];
-			rtp->nodes[rtp->nr - 1] = NULL;
-			rtp->nr--;
-		}
+	rtp = &__get_cpu_var(radix_tree_preloads);
+	if (rtp->nr) {
+		struct radix_tree_node *ret;
+		ret = rtp->nodes[rtp->nr - 1];
+		rtp->nodes[rtp->nr - 1] = NULL;
+		rtp->nr--;
+		return ret;
 	}
-	return ret;
+
+	return kmem_cache_alloc(radix_tree_node_cachep, root->gfp_mask);
 }
 
 static inline void

--------------030504090708030507000603--
Send instant messages to your online friends http://au.messenger.yahoo.com 
