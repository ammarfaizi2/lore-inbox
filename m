Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWD1QNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWD1QNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWD1QNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:13:47 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:17598 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030499AbWD1QNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:13:46 -0400
Subject: [PATCH] buglet in radix_tree_tag_set
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 18:13:42 +0200
Message-Id: <1146240822.4932.3.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

The comment states: 'Setting a tag on a not-present item is a BUG.'
Hence if 'index' is larger than the maxindex; the item _cannot_
be presen; it should also be a BUG.

Also, this allows the following statement (assume a fresh tree):

  radix_tree_tag_set(root, 16, 1);

to fail silently, but when preceded by:

  radix_tree_insert(root, 32, item);

it would BUG, because the height has been extended by the insert.

In neither case was 16 present.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Nick Piggin <npiggin@suse.de>

 lib/radix-tree.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c	2006-04-07 10:54:43.000000000 +0200
+++ linux-2.6/lib/radix-tree.c	2006-04-28 17:56:14.000000000 +0200
@@ -365,8 +365,7 @@ void *radix_tree_tag_set(struct radix_tr
 	struct radix_tree_node *slot;
 
 	height = root->height;
-	if (index > radix_tree_maxindex(height))
-		return NULL;
+	BUG_ON(index > radix_tree_maxindex(height))
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;


