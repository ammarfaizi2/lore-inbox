Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946412AbWJST5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946412AbWJST5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946413AbWJST5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:57:14 -0400
Received: from deeprooted.net ([216.254.16.51]:20367 "EHLO paris.hilman.org")
	by vger.kernel.org with ESMTP id S1946412AbWJST5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:57:13 -0400
From: Kevin Hilman <khilman@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] slab debug and ARCH_SLAB_MINALIGN don't get along
Date: Thu, 19 Oct 2006 12:57:12 -0700
Message-Id: <11612878321443-git-send-email-khilman@mvista.com>
X-Mailer: git-send-email 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SLAB_DEBUG is used in combination with ARCH_SLAB_MINALIGN,
some debug flags should be disabled which depend on BYTES_PER_WORD
alignment.

The disabling of these debug flags is not properly handled when
BYTES_PER_WORD < ARCH_SLAB_MEMALIGN < cache_line_size()

This patch fixes that and also adds an alignment check to
cache_alloc_debugcheck_after() when ARCH_SLAB_MINALIGN is used.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 mm/slab.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 266449d..5b71267 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2197,18 +2197,17 @@ #endif
 	if (flags & SLAB_RED_ZONE || flags & SLAB_STORE_USER)
 		ralign = BYTES_PER_WORD;
 
-	/* 2) arch mandated alignment: disables debug if necessary */
+	/* 2) arch mandated alignment */
 	if (ralign < ARCH_SLAB_MINALIGN) {
 		ralign = ARCH_SLAB_MINALIGN;
-		if (ralign > BYTES_PER_WORD)
-			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
-	/* 3) caller mandated alignment: disables debug if necessary */
+	/* 3) caller mandated alignment */
 	if (ralign < align) {
 		ralign = align;
-		if (ralign > BYTES_PER_WORD)
-			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
+	/* disable deubg if necessary */
+	if (ralign > BYTES_PER_WORD)
+		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	/*
 	 * 4) Store it.
 	 */
@@ -3063,6 +3062,12 @@ #endif
 
 		cachep->ctor(objp, cachep, ctor_flags);
 	}
+#if ARCH_SLAB_MINALIGN
+	if ((u32)objp & (ARCH_SLAB_MINALIGN-1)) {
+		printk(KERN_ERR "0x%p: not aligned to ARCH_SLAB_MINALIGN=%d\n",
+		       objp, ARCH_SLAB_MINALIGN);
+	}
+#endif
 	return objp;
 }
 #else
-- 
1.4.2

