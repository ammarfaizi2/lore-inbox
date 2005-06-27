Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVF0GjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVF0GjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVF0Ghl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:37:41 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:13646 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261861AbVF0Gdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:33:35 -0400
Message-ID: <42BF9DBA.3000607@yahoo.com.au>
Date: Mon, 27 Jun 2005 16:33:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [patch 3] radix tree: lookup_slot
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au>
In-Reply-To: <42BF9D86.90204@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070401060205080306050100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401060205080306050100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
SUSE Labs, Novell Inc.

--------------070401060205080306050100
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

Signed-off-by: Andrew Morton <akpm@osdl.org>
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
@@ -276,14 +276,8 @@ int radix_tree_insert(struct radix_tree_
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
 	struct radix_tree_node **slot;
@@ -306,7 +300,36 @@ void *radix_tree_lookup(struct radix_tre
 		height--;
 	}
 
-	return *slot;
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
 

--------------070401060205080306050100--
Send instant messages to your online friends http://au.messenger.yahoo.com 
