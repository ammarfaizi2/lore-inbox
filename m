Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbTBNVQ2>; Fri, 14 Feb 2003 16:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbTBNVPu>; Fri, 14 Feb 2003 16:15:50 -0500
Received: from mail.mplayerhq.hu ([192.190.173.45]:40649 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S268168AbTBNVPI>; Fri, 14 Feb 2003 16:15:08 -0500
Date: Fri, 14 Feb 2003 22:35:11 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] radix-tree.c
Message-ID: <Pine.LNX.4.33.0302142233370.16839-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the following patch maxindex is taken from an array instead of
recalculating it all the time.

Comments?

Bye,
Szabi


--- linux-2.5.60/lib/radix-tree.c.orig	Sat Jan 25 19:28:22 2003
+++ linux-2.5.60/lib/radix-tree.c	Fri Feb 14 22:16:34 2003
@@ -46,6 +46,8 @@
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
 #define RADIX_TREE_MAX_PATH (RADIX_TREE_INDEX_BITS/RADIX_TREE_MAP_SHIFT + 2)

+static unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH];
+
 /*
  * Radix tree node cache.
  */
@@ -126,12 +128,9 @@
  */
 static inline unsigned long radix_tree_maxindex(unsigned int height)
 {
-	unsigned int tmp = height * RADIX_TREE_MAP_SHIFT;
-	unsigned long index = (~0UL >> (RADIX_TREE_INDEX_BITS - tmp - 1)) >> 1;
-
-	if (tmp >= RADIX_TREE_INDEX_BITS)
-		index = ~0UL;
-	return index;
+	if (unlikely(height >= RADIX_TREE_MAX_PATH))
+		return ~0UL;
+	return height_to_maxindex[height];
 }

 /*
@@ -402,6 +401,24 @@
 	memset(node, 0, sizeof(struct radix_tree_node));
 }

+static __init unsigned long __maxindex(unsigned int height)
+{
+	unsigned int tmp = height * RADIX_TREE_MAP_SHIFT;
+	unsigned long index = (~0UL >> (RADIX_TREE_INDEX_BITS - tmp - 1)) >> 1;
+
+	if (tmp >= RADIX_TREE_INDEX_BITS)
+		index = ~0UL;
+	return index;
+}
+
+static __init void radix_tree_init_maxindex(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < RADIX_TREE_MAX_PATH; i++)
+		height_to_maxindex[i] = __maxindex(i);
+}
+
 void __init radix_tree_init(void)
 {
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
@@ -409,4 +426,5 @@
 			0, radix_tree_node_ctor, NULL);
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
+	radix_tree_init_maxindex();
 }

