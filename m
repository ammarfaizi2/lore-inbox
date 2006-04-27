Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWD0Rr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWD0Rr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWD0Rr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:47:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8065 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965005AbWD0Rr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:47:58 -0400
Subject: [PATCH] slab: redzone double-free detection
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Date: Thu, 27 Apr 2006 20:47:56 +0300
Message-Id: <1146160076.11272.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch adds double-free detection to redzone verification when freeing
an object. As explained by Manfred, when we are freeing an object, both
redzones should be RED_ACTIVE. However, if both are RED_INACTIVE, we are
trying to free an object that was already free'd.

Cc: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index e6ef9bd..7d982c1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2585,6 +2585,28 @@ static void kfree_debugcheck(const void 
 	}
 }
 
+static inline void verify_redzone_free(struct kmem_cache *cache, void *obj)
+{
+	unsigned long redzone1, redzone2;
+
+	redzone1 = *dbg_redzone1(cache, obj);
+	redzone2 = *dbg_redzone2(cache, obj);
+
+	/*
+	 * Redzone is ok.
+	 */
+	if (redzone1 == RED_ACTIVE && redzone2 == RED_ACTIVE)
+		return;
+
+	if (redzone1 == RED_INACTIVE && redzone2 == RED_INACTIVE)
+		slab_error(cache, "double free detected");
+	else
+		slab_error(cache, "memory outside object was overwritten");
+
+	printk(KERN_ERR "%p: redzone 1:0x%lx, redzone 2:0x%lx.\n",
+			obj, redzone1, redzone2);
+}
+
 static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 				   void *caller)
 {
@@ -2608,15 +2630,7 @@ static void *cache_free_debugcheck(struc
 	slabp = page_get_slab(page);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE ||
-				*dbg_redzone2(cachep, objp) != RED_ACTIVE) {
-			slab_error(cachep, "double free, or memory outside"
-						" object was overwritten");
-			printk(KERN_ERR "%p: redzone 1:0x%lx, "
-					"redzone 2:0x%lx.\n",
-			       objp, *dbg_redzone1(cachep, objp),
-			       *dbg_redzone2(cachep, objp));
-		}
+		verify_redzone_free(cachep, objp);
 		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
 	}


