Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbVJ3F3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbVJ3F3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVJ3F3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:29:02 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:27480 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932721AbVJ3F3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:29:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=TPfAYdXWwkWRf430u56XLBGLztDXP0UEIivIevedduP6HG+/JitU7VkHeRVAVlNHPqW1AKwbG63Nua3Pk6HSdu4qGqXb0C6Rplxg6u+ZhYvLlsc10M5FDrhDJ0RQvp9i47M1iW2Btl1N+9SWiZkQjN7PEaWAPMfmf7EBtgpCelg=  ;
Message-ID: <4364186F.60206@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:48:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Hans Reiser <reiser@namesys.com>
Subject: [patche 1/5] radix tree: lookup_slot
References: <436416AD.3050709@yahoo.com.au>
In-Reply-To: <436416AD.3050709@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000502070701030500080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502070701030500080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/5

-- 
SUSE Labs, Novell Inc.


--------------000502070701030500080505
Content-Type: text/plain;
 name="radix-tree-lookup_slot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-lookup_slot.patch"

From: Hans Reiser <reiser@namesys.com>

Reiser4 uses radix trees to solve a trouble reiser4_readdir has serving nfs
requests.

Unfortunately, radix tree api lacks an operation suitable for modifying
existing entry.  This patch adds radix_tree_lookup_slot which returns pointer
to found item within the tree.  That location can be then updated.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -46,6 +46,7 @@ do {									\
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
+void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -281,35 +281,60 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-/**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
- *	@root:		radix tree root
- *	@index:		index key
- *
- *	Lookup the item at the position @index in the radix tree @root.
- */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+static inline void **__lookup_slot(struct radix_tree_root *root,
+				   unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node *slot;
+	struct radix_tree_node **slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
+	slot = &root->rnode;
 
 	while (height > 0) {
-		if (slot == NULL)
+		if (*slot == NULL)
 			return NULL;
 
-		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
+		slot = (struct radix_tree_node **)
+			((*slot)->slots +
+				((index >> shift) & RADIX_TREE_MAP_MASK));
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return slot;
+	return (void **)slot;
+}
+
+/**
+ *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the slot corresponding to the position @index in the radix tree
+ *	@root. This is useful for update-if-exists operations.
+ */
+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
+{
+	return __lookup_slot(root, index);
+}
+EXPORT_SYMBOL(radix_tree_lookup_slot);
+
+/**
+ *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+{
+	void **slot;
+
+	slot = __lookup_slot(root, index);
+	return slot != NULL ? *slot : NULL;
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 

--------------000502070701030500080505--
Send instant messages to your online friends http://au.messenger.yahoo.com 
