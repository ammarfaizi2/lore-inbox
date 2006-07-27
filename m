Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWG0MPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWG0MPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWG0MPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:15:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3811 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751184AbWG0MPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:15:11 -0400
Date: Thu, 27 Jul 2006 15:15:09 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: heiko.carstens@de.ibm.com, clameter@sgi.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] slab: respect architecture and caller mandated alignment
Message-ID: <Pine.LNX.4.58.0607271514310.2172@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

As explained by Heiko, on s390 (32-bit) ARCH_KMALLOC_MINALIGN is set to eight
because their common I/O layer allocates data structures that need to have an
eight byte alignment. This does not work when CONFIG_SLAB_DEBUG is enabled
because kmem_cache_create will override alignment to BYTES_PER_WORD which is
four.

So change kmem_cache_create to ensure cache alignment is always at minimum
what the architecture or caller mandates even if slab debugging is enabled.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2097,6 +2097,15 @@ kmem_cache_create (const char *name, siz
 	} else {
 		ralign = BYTES_PER_WORD;
 	}
+
+	/*
+	 * Redzoning and user store require word alignment. Note this will be
+	 * overridden by architecture or caller mandated alignment if either
+	 * is greater than BYTES_PER_WORD.
+	 */
+	if (flags & SLAB_RED_ZONE || flags & SLAB_STORE_USER)
+		ralign = BYTES_PER_WORD;
+
 	/* 2) arch mandated alignment: disables debug if necessary */
 	if (ralign < ARCH_SLAB_MINALIGN) {
 		ralign = ARCH_SLAB_MINALIGN;
@@ -2110,8 +2119,7 @@ kmem_cache_create (const char *name, siz
 			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
 	/*
-	 * 4) Store it. Note that the debug code below can reduce
-	 *    the alignment to BYTES_PER_WORD.
+	 * 4) Store it.
 	 */
 	align = ralign;
 
@@ -2123,20 +2131,19 @@ kmem_cache_create (const char *name, siz
 #if DEBUG
 	cachep->obj_size = size;
 
+	/*
+	 * Both debugging options require word-alignment which is calculated
+	 * into align above.
+	 */
 	if (flags & SLAB_RED_ZONE) {
-		/* redzoning only works with word aligned caches */
-		align = BYTES_PER_WORD;
-
 		/* add space for red zone words */
 		cachep->obj_offset += BYTES_PER_WORD;
 		size += 2 * BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		/* user store requires word alignment and
-		 * one word storage behind the end of the real
-		 * object.
+		/* user store requires one word storage behind the end of
+		 * the real object.
 		 */
-		align = BYTES_PER_WORD;
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
