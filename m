Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUKJVDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUKJVDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUKJVDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:03:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65496 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261992AbUKJVDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:03:45 -0500
Subject: [PATCH] bug in radix_tree_delete
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100120622.7468.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 15:03:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking through the radix tree code and came across what I think
is a bug in radix_tree_delete.

	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
		if (pathp[0].node->tags[tag][idx]) {
			tags[tag] = 1;
			nr_cleared_tags--;
			break;
		}
	}

The above loop should only be executed if tags[tag] is zero.  Otherwise,
when walking up the tree, we can decrement nr_cleared_tags twice or more
for the same value of tag, thus potentially exiting the outer loop too
early.

radix-tree: Ensure that nr_cleared_tags is only decremented once for each tag.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
diff -Nurp linux-2.6.10-rc1-mm4/lib/radix-tree.c linux/lib/radix-tree.c
--- linux-2.6.10-rc1-mm4/lib/radix-tree.c	2004-11-10 14:45:18.259269000 -0600
+++ linux/lib/radix-tree.c	2004-11-10 14:45:59.292031072 -0600
@@ -725,8 +725,10 @@ void *radix_tree_delete(struct radix_tre
 		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
 			int idx;
 
-			if (!tags[tag])
-				tag_clear(pathp[0].node, tag, pathp[0].offset);
+			if (tags[tag])
+				continue;
+
+			tag_clear(pathp[0].node, tag, pathp[0].offset);
 
 			for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
 				if (pathp[0].node->tags[tag][idx]) {


