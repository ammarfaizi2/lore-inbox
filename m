Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbVJ3AuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVJ3AuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVJ3AuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:50:04 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:60306 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932706AbVJ3AuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:50:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=Pq93GlLDhOmAa9aSdtoVEALbSHy9dPgyGe0fFy3E8kVh/V6gAile6F4FrTFv0lkLtLWEaUx6b3AXSt+onHnJ9NjIoGTiAv4aWYdXLEneAXdz4UPH6enSram0az6NWTtCBufjWZ3JC6Y3+KAz4FUkrN/akRpvE+nt9LnTwblJ8NU=  ;
Message-ID: <43641906.9030806@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:51:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 4/5] radix tree: clear_tags bail
References: <436416AD.3050709@yahoo.com.au> <4364186F.60206@yahoo.com.au> <436418A8.9000505@yahoo.com.au> <436418D9.5050205@yahoo.com.au>
In-Reply-To: <436418D9.5050205@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030700030706080406040701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700030706080406040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/5

-- 
SUSE Labs, Novell Inc.


--------------030700030706080406040701
Content-Type: text/plain;
 name="radix-tree-clear_tags-bail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-clear_tags-bail.patch"

Correctly determine the tags to be cleared in radix_tree_delete so we
don't keep moving up the tree clearing tags that we don't need to.

Also, tag_set was probably just made conditional so as not to dirty
too many cachelines high up in the radix tree. Instead, put this
logic into radix_tree_tag_set.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -135,18 +135,17 @@ out:
 
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
-	if (!test_bit(offset, &node->tags[tag][0]))
-		__set_bit(offset, &node->tags[tag][0]);
+	__set_bit(offset, node->tags[tag]);
 }
 
 static inline void tag_clear(struct radix_tree_node *node, int tag, int offset)
 {
-	__clear_bit(offset, &node->tags[tag][0]);
+	__clear_bit(offset, node->tags[tag]);
 }
 
 static inline int tag_get(struct radix_tree_node *node, int tag, int offset)
 {
-	return test_bit(offset, &node->tags[tag][0]);
+	return test_bit(offset, node->tags[tag]);
 }
 
 /*
@@ -373,7 +372,8 @@ void *radix_tree_tag_set(struct radix_tr
 		int offset;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		tag_set(slot, tag, offset);
+		if (!tag_get(slot, tag, offset))
+			tag_set(slot, tag, offset);
 		slot = slot->slots[offset];
 		BUG_ON(slot == NULL);
 		shift -= RADIX_TREE_MAP_SHIFT;
@@ -433,6 +433,8 @@ void *radix_tree_tag_clear(struct radix_
 		goto out;
 
 	do {
+		if (!tag_get(pathp->node, tag, pathp->offset))
+			goto out;
 		tag_clear(pathp->node, tag, pathp->offset);
 		if (tag_get_any_node(pathp->node, tag))
 			goto out;
@@ -693,6 +695,8 @@ void *radix_tree_delete(struct radix_tre
 	void *ret = NULL;
 	char tags[RADIX_TREE_TAGS];
 	int nr_cleared_tags;
+	int tag;
+	int offset;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
@@ -703,16 +707,14 @@ void *radix_tree_delete(struct radix_tre
 	slot = root->rnode;
 
 	for ( ; height > 0; height--) {
-		int offset;
-
 		if (slot == NULL)
 			goto out;
 
+		pathp++;
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		pathp[1].offset = offset;
-		pathp[1].node = slot;
+		pathp->offset = offset;
+		pathp->node = slot;
 		slot = slot->slots[offset];
-		pathp++;
 		shift -= RADIX_TREE_MAP_SHIFT;
 	}
 
@@ -725,24 +727,28 @@ void *radix_tree_delete(struct radix_tre
 	/*
 	 * Clear all tags associated with the just-deleted item
 	 */
-	memset(tags, 0, sizeof(tags));
-	do {
-		int tag;
+	nr_cleared_tags = 0;
+	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+		if (tag_get(pathp->node, tag, pathp->offset)) {
+			tag_clear(pathp->node, tag, pathp->offset);
+			tags[tag] = 0;
+			nr_cleared_tags++;
+		} else
+			tags[tag] = 1;
+	}
 
-		nr_cleared_tags = RADIX_TREE_TAGS;
+	for (pathp--; nr_cleared_tags && pathp->node; pathp--) {
 		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
 			if (tags[tag])
 				continue;
 
 			tag_clear(pathp->node, tag, pathp->offset);
-
 			if (tag_get_any_node(pathp->node, tag)) {
 				tags[tag] = 1;
 				nr_cleared_tags--;
 			}
 		}
-		pathp--;
-	} while (pathp->node && nr_cleared_tags);
+	}
 
 	/* Now free the nodes we do not need anymore */
 	for (pathp = orig_pathp; pathp->node; pathp--) {

--------------030700030706080406040701--
Send instant messages to your online friends http://au.messenger.yahoo.com 
