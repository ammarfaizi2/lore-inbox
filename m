Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbTBNXkZ>; Fri, 14 Feb 2003 18:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268143AbTBNXkY>; Fri, 14 Feb 2003 18:40:24 -0500
Received: from mail.mplayerhq.hu ([192.190.173.45]:2251 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S268086AbTBNXkP>; Fri, 14 Feb 2003 18:40:15 -0500
Date: Sat, 15 Feb 2003 01:00:10 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: Andrew Morton <akpm@digeo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] radix-tree.c
In-Reply-To: <20030214150128.5a28e7d5.akpm@digeo.com>
Message-ID: <Pine.LNX.4.33.0302150056390.20616-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Andrew Morton wrote:

> If you make height_to_maxindex[] a bit bigger, and fill it up with ~0UL's,
> this comparison can be removed too.
>
> I rather hope that height cannot be larger than RADIX_TREE_MAX_PATH anyway...

I simply removed the check, because the height can be larger than
RADIX_TREE_MAX_PATH only when the return value is compared against
a long long. If I'm right long long is never used in the kernel.

Bye,
Szabi

--- linux-2.5.60/lib/radix-tree.c.orig	Sat Jan 25 19:28:22 2003
+++ linux-2.5.60/lib/radix-tree.c	Sat Feb 15 00:28:04 2003
@@ -46,6 +46,8 @@
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
 #define RADIX_TREE_MAX_PATH (RADIX_TREE_INDEX_BITS/RADIX_TREE_MAP_SHIFT + 2)

+static unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH];
+
 /*
  * Radix tree node cache.
  */
@@ -126,12 +128,7 @@
  */
 static inline unsigned long radix_tree_maxindex(unsigned int height)
 {
-	unsigned int tmp = height * RADIX_TREE_MAP_SHIFT;
-	unsigned long index = (~0UL >> (RADIX_TREE_INDEX_BITS - tmp - 1)) >> 1;
-
-	if (tmp >= RADIX_TREE_INDEX_BITS)
-		index = ~0UL;
-	return index;
+	return height_to_maxindex[height];
 }

 /*
@@ -402,6 +399,24 @@
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
@@ -409,4 +424,5 @@
 			0, radix_tree_node_ctor, NULL);
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
+	radix_tree_init_maxindex();
 }

