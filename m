Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbULQSit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbULQSit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbULQSit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:38:49 -0500
Received: from almesberger.net ([63.105.73.238]:35335 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262112AbULQSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:38:03 -0500
Date: Fri, 17 Dec 2004 15:37:57 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] prio_tree: roll call to prio_tree_first into prio_tree_next
Message-ID: <20041217153757.A21393@almesberger.net>
References: <20041217153602.D31842@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217153602.D31842@almesberger.net>; from werner@almesberger.net on Fri, Dec 17, 2004 at 03:36:02PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow prio_tree_next to be used as the only function for tree
traversal, similar to how vma_prio_tree_next works.

This patch isn't needed for the generalization, but since it
affects the API, it's better to include it first.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.10-rc3-bk10/include/linux/prio_tree.h.orig	Fri Dec 17 01:05:14 2004
+++ linux-2.6.10-rc3-bk10/include/linux/prio_tree.h	Fri Dec 17 00:38:47 2004
@@ -29,6 +29,7 @@ static inline void prio_tree_iter_init(s
 	iter->root = root;
 	iter->r_index = r_index;
 	iter->h_index = h_index;
+	iter->cur = NULL;
 }
 
 #define INIT_PRIO_TREE_ROOT(ptr)	\
--- linux-2.6.10-rc3-bk10/mm/prio_tree.c.orig	Fri Dec 17 01:05:29 2004
+++ linux-2.6.10-rc3-bk10/mm/prio_tree.c	Fri Dec 17 00:39:02 2004
@@ -457,6 +457,9 @@ static struct prio_tree_node *prio_tree_
 {
 	unsigned long r_index, h_index;
 
+	if (iter->cur == NULL)
+		return prio_tree_first(iter);
+
 repeat:
 	while (prio_tree_left(iter, &r_index, &h_index))
 		if (overlap(iter, r_index, h_index))
@@ -620,7 +623,7 @@ struct vm_area_struct *vma_prio_tree_nex
 		/*
 		 * First call is with NULL vma
 		 */
-		ptr = prio_tree_first(iter);
+		ptr = prio_tree_next(iter);
 		if (ptr) {
 			next = prio_tree_entry(ptr, struct vm_area_struct,
 						shared.prio_tree_node);

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
