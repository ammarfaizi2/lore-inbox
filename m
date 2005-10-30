Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVJ3AtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVJ3AtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVJ3AtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:49:10 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:65410 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932607AbVJ3AtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:49:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=KI22o1IeoP845ACil/gxU/YXgUvvCUP1ZHXq613ojfBvcXuP0LLM48+oQAmN+b6NOxDQ6MBX+0OMLuirVv63t/TuxMB572fuohn3rJyKIf8B0yRmPWe2/FzOgi6IqOkeTuR4sVUIJwWz2hDZ6rPuLVkrdG0Kw8cb2d8q9CzTk/4=  ;
Message-ID: <436418D9.5050205@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:50:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 3/5] radix tree: cleanup
References: <436416AD.3050709@yahoo.com.au> <4364186F.60206@yahoo.com.au> <436418A8.9000505@yahoo.com.au>
In-Reply-To: <436418A8.9000505@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090702070008040006090804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702070008040006090804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/5

-- 
SUSE Labs, Novell Inc.


--------------090702070008040006090804
Content-Type: text/plain;
 name="radix-tree-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-cleanup.patch"

Introduce helper tag_get_any_node rather than repeat the same code
sequence 4 times.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -150,6 +150,20 @@ static inline int tag_get(struct radix_t
 }
 
 /*
+ * Returns 1 if any slot in the node has this tag set.
+ * Otherwise returns 0.
+ */
+static inline int tag_get_any_node(struct radix_tree_node *node, int tag)
+{
+	int idx;
+	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
+		if (node->tags[tag][idx])
+			return 1;
+	}
+	return 0;
+}
+
+/*
  *	Return the maximum key which can be store into a
  *	radix tree with height HEIGHT.
  */
@@ -183,15 +197,9 @@ static int radix_tree_extend(struct radi
 	 * into the newly-pushed top-level node(s)
 	 */
 	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
-		int idx;
-
 		tags[tag] = 0;
-		for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-			if (root->rnode->tags[tag][idx]) {
-				tags[tag] = 1;
-				break;
-			}
-		}
+		if (tag_get_any_node(root->rnode, tag))
+			tags[tag] = 1;
 	}
 
 	do {
@@ -425,13 +433,9 @@ void *radix_tree_tag_clear(struct radix_
 		goto out;
 
 	do {
-		int idx;
-
 		tag_clear(pathp->node, tag, pathp->offset);
-		for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-			if (pathp->node->tags[tag][idx])
-				goto out;
-		}
+		if (tag_get_any_node(pathp->node, tag))
+			goto out;
 		pathp--;
 	} while (pathp->node);
 out:
@@ -727,19 +731,14 @@ void *radix_tree_delete(struct radix_tre
 
 		nr_cleared_tags = RADIX_TREE_TAGS;
 		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
-			int idx;
-
 			if (tags[tag])
 				continue;
 
 			tag_clear(pathp->node, tag, pathp->offset);
 
-			for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-				if (pathp->node->tags[tag][idx]) {
-					tags[tag] = 1;
-					nr_cleared_tags--;
-					break;
-				}
+			if (tag_get_any_node(pathp->node, tag)) {
+				tags[tag] = 1;
+				nr_cleared_tags--;
 			}
 		}
 		pathp--;
@@ -768,15 +767,11 @@ EXPORT_SYMBOL(radix_tree_delete);
  */
 int radix_tree_tagged(struct radix_tree_root *root, int tag)
 {
-	int idx;
-
-	if (!root->rnode)
-		return 0;
-	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-		if (root->rnode->tags[tag][idx])
-			return 1;
-	}
-	return 0;
+  	struct radix_tree_node *rnode;
+  	rnode = root->rnode;
+  	if (!rnode)
+  		return 0;
+	return tag_get_any_node(rnode, tag);
 }
 EXPORT_SYMBOL(radix_tree_tagged);
 

--------------090702070008040006090804--
Send instant messages to your online friends http://au.messenger.yahoo.com 
