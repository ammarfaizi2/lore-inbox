Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVHKMZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVHKMZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHKMZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:25:23 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:25721 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932428AbVHKMZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:25:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=r/+yeOBuM4QEcHsqOaNGktGXM0e1jt2+k8kFh0ooV9bmriyw5DVzK9ixEhcg6V8Ef5/NqOFO7gLN03VsfMt9trx3CDtgRyoKyFTEXeCG8oAQ+H61Qtd3Tgn+SchnkkzeWan1oXm5vT8ThsaVz9jYjoLqChhm9j3XhDdMwNVuuKQ=  ;
Message-ID: <42FB43A8.8060902@yahoo.com.au>
Date: Thu, 11 Aug 2005 22:25:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul McKenney <paul.mckenney@us.ibm.com>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 4/7] radix-tree: lookup_slot
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au> <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>
In-Reply-To: <42FB4311.2070807@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060909090306000901090508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909090306000901090508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/7

Required by lockless pagecache in order to get a pointer
to a pagecache struct page.

-- 
SUSE Labs, Novell Inc.


--------------060909090306000901090508
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
 

--------------060909090306000901090508--
Send instant messages to your online friends http://au.messenger.yahoo.com 
