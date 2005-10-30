Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVJ3A4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVJ3A4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbVJ3A4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:56:23 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:9915 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932723AbVJ3A4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:56:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=A3eIdPnUjW8txHAYibiI6JqEloclXzm11ZJ2RHrzCSjrFzwoVaN6P4JTvOyOKkO09R1aYt3gADwMrwptjfLh2BiEifYY/Pd2Wub32fNbsWo9685AJQ9FYXx5rbuyvjKUSHXDsZtEI/v0CB8j7h2wsGk+BHQNvph71/NMO8/MQGQ=  ;
Message-ID: <43641A96.60007@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:57:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 5/5] radix tree: shrink
References: <436416AD.3050709@yahoo.com.au> <4364186F.60206@yahoo.com.au> <436418A8.9000505@yahoo.com.au> <436418D9.5050205@yahoo.com.au> <43641906.9030806@yahoo.com.au>
In-Reply-To: <43641906.9030806@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050006090508040809080308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006090508040809080308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/5

It always really bothered me that we don't shrink the tree when
truncating it. No actual performance results (though it wouldn't
be hard to concoct some brainless microbenchmark), but it is
simply nicer to do this IMO and will result in more consistent
performance in corner cases.

-- 
SUSE Labs, Novell Inc.


--------------050006090508040809080308
Content-Type: text/plain;
 name="radix-tree-shrink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-shrink.patch"

Actually shrink the height of a radix tree when it is truncated.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -251,7 +251,7 @@ int radix_tree_insert(struct radix_tree_
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	offset = 0;			/* uninitialised var warning */
-	while (height > 0) {
+	do {
 		if (slot == NULL) {
 			/* Have to add a child node.  */
 			if (!(slot = radix_tree_node_alloc(root)))
@@ -269,18 +269,16 @@ int radix_tree_insert(struct radix_tree_
 		slot = node->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
-	}
+	} while (height > 0);
 
 	if (slot != NULL)
 		return -EEXIST;
 
-	if (node) {
-		node->count++;
-		node->slots[offset] = item;
-		BUG_ON(tag_get(node, 0, offset));
-		BUG_ON(tag_get(node, 1, offset));
-	} else
-		root->rnode = item;
+	BUG_ON(!node);
+	node->count++;
+	node->slots[offset] = item;
+	BUG_ON(tag_get(node, 0, offset));
+	BUG_ON(tag_get(node, 1, offset));
 
 	return 0;
 }
@@ -678,6 +676,29 @@ radix_tree_gang_lookup_tag(struct radix_
 EXPORT_SYMBOL(radix_tree_gang_lookup_tag);
 
 /**
+ *	radix_tree_shrink    -    shrink height of a radix tree to minimal
+ *	@root		radix tree root
+ */
+static inline void radix_tree_shrink(struct radix_tree_root *root)
+{
+	/* try to shrink tree height */
+	while (root->height > 1 &&
+			root->rnode->count == 1 &&
+			root->rnode->slots[0]) {
+		struct radix_tree_node *to_free = root->rnode;
+
+		root->rnode = to_free->slots[0];
+		root->height--;
+		/* must only free zeroed nodes into the slab */
+		tag_clear(to_free, 0, 0);
+		tag_clear(to_free, 1, 0);
+		to_free->slots[0] = NULL;
+		to_free->count = 0;
+		radix_tree_node_free(to_free);
+	}
+}
+
+/**
  *	radix_tree_delete    -    delete an item from a radix tree
  *	@root:		radix tree root
  *	@index:		index key
@@ -753,8 +774,13 @@ void *radix_tree_delete(struct radix_tre
 	/* Now free the nodes we do not need anymore */
 	for (pathp = orig_pathp; pathp->node; pathp--) {
 		pathp->node->slots[pathp->offset] = NULL;
-		if (--pathp->node->count)
+		pathp->node->count--;
+
+		if (pathp->node->count) {
+			if (pathp->node == root->rnode)
+				radix_tree_shrink(root);
 			goto out;
+		}
 
 		/* Node with zero slots in use so free it */
 		radix_tree_node_free(pathp->node);

--------------050006090508040809080308--
Send instant messages to your online friends http://au.messenger.yahoo.com 
