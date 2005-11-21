Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVKUOa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVKUOa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVKUOa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:30:26 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:387 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932312AbVKUOa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:30:26 -0500
Date: Mon, 21 Nov 2005 16:30:07 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       christoph@lameter.com
Subject: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
Message-ID: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of one if-else statement by moving current node allocation
check at the beginning of kmem_cache_alloc_node().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 7f80ec3..a05bbfe 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2881,7 +2881,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
+	if (nodeid == -1 || nodeid == numa_node_id())
 		return __cache_alloc(cachep, flags);
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
@@ -2892,10 +2892,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
-		ptr = ____cache_alloc(cachep, flags);
-	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
+	ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
 
