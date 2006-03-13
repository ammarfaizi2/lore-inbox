Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWCMWnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWCMWnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWCMWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:43:45 -0500
Received: from vena.lwn.net ([206.168.112.25]:37514 "HELO lwn.net")
	by vger.kernel.org with SMTP id S964825AbWCMWno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:43:44 -0500
Message-ID: <20060313224344.9173.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: RFC: radix tree safety
From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 13 Mar 2006 15:43:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been digging through the radix tree code, and I noticed that the
tag functions have an interesting limitation.  The tag is given as an
integer value, but, in reality, the only values that work are zero and
one.  Anything else will return random results or (when setting tags)
corrupt unrelated memory.

The number of radix tree users is small, so it's not hard to confirm
that all tag values currently in use are legal.  But the interface would
seem to invite mistakes.

The following patch puts in checks for out-of-range tag values.  I've
elected to have the relevant call fail; one could argue that it should
BUG instead.  Either seems better than silently doing weird stuff.  Not
2.6.16 material, obviously, but maybe suitable thereafter.

jon

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- 2.6.16-rc6/lib/radix-tree.c.orig	2006-03-13 14:42:48.000000000 -0700
+++ 2.6.16-rc6/lib/radix-tree.c	2006-03-13 15:33:35.000000000 -0700
@@ -364,6 +364,8 @@ void *radix_tree_tag_set(struct radix_tr
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
+	if (tag < 0 || tag >= RADIX_TREE_TAGS)
+		return NULL;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
@@ -408,6 +410,8 @@ void *radix_tree_tag_clear(struct radix_
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		goto out;
+	if (tag < 0 || tag >= RADIX_TREE_TAGS)
+		goto out;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	pathp->node = NULL;
@@ -468,6 +472,8 @@ int radix_tree_tag_get(struct radix_tree
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return 0;
+	if (tag < 0 || tag >= RADIX_TREE_TAGS)
+		return 0;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
@@ -660,6 +666,9 @@ radix_tree_gang_lookup_tag(struct radix_
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
 
+	if (tag < 0 || tag >= RADIX_TREE_TAGS)
+		return 0;
+
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
@@ -807,6 +816,8 @@ int radix_tree_tagged(struct radix_tree_
   	rnode = root->rnode;
   	if (!rnode)
   		return 0;
+	if (tag < 0 || tag >= RADIX_TREE_TAGS)
+		return 0;
 	return any_tag_set(rnode, tag);
 }
 EXPORT_SYMBOL(radix_tree_tagged);
