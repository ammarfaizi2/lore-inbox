Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVKRDvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVKRDvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVKRDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:51:50 -0500
Received: from ozlabs.org ([203.10.76.45]:14230 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932435AbVKRDvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:51:50 -0500
Date: Fri, 18 Nov 2005 14:51:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hugepage-dev@opensource.ibm.com
Subject: [PATCH] Fix hugetlbfs_statfs() reporting of block limits
Message-ID: <20051118035134.GA23760@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-hugepage-dev@opensource.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Currently, if a hugetlbfs is mounted without limits (the default),
statfs() will return -1 for max/free/used blocks.  This does not
appear to be in line with normal convention: simple_statfs() and
shmem_statfs() both return 0 in similar cases.  Worse, it confuses the
translation logic in put_compat_statfs(), causing it to return
-EOVERFLOW on such a mount.

This patch alters hugetlbfs_statfs() to return 0 for max/free/used
blocks on a mount without limits.  Note that we need the test in the
patch below, rather than just using 0 in the sbinfo structure, because
the -1 marked in the free blocks field is used internally to tell the
difference between a full filesystem and one with no limit.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2005-11-18 14:06:55.000000000 +1100
+++ working-2.6/fs/hugetlbfs/inode.c	2005-11-18 14:28:27.000000000 +1100
@@ -509,10 +509,14 @@
 	buf->f_bsize = HPAGE_SIZE;
 	if (sbinfo) {
 		spin_lock(&sbinfo->stat_lock);
-		buf->f_blocks = sbinfo->max_blocks;
-		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
-		buf->f_files = sbinfo->max_inodes;
-		buf->f_ffree = sbinfo->free_inodes;
+		/* If no limits set, just report 0 for max/free/used
+		 * blocks, like simple_statfs() */
+		if (sbinfo->max_blocks >= 0) {
+			buf->f_blocks = sbinfo->max_blocks;
+			buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
+			buf->f_files = sbinfo->max_inodes;
+			buf->f_ffree = sbinfo->free_inodes;
+		}
 		spin_unlock(&sbinfo->stat_lock);
 	}
 	buf->f_namelen = NAME_MAX;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

----- End forwarded message -----

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
