Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVATD1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVATD1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATDYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:24:54 -0500
Received: from mail.suse.de ([195.135.220.2]:30931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262029AbVATDX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:27 -0500
Message-Id: <20050120032510.842459000@suse.de>
References: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 4/5] Fix i_extra_isize check
Content-Disposition: inline; filename=ea-xattr-no-extra_isize.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are checking for (EXT3_SB(inode->i_sb)->s_inode_size <=
EXT3_GOOD_OLD_INODE_SIZE) to find out if we can set in-inode attributes;
the test fails for inodes that have been created before the ea-in-inode
patch. Those inodes have (i_extra_isize == 0), so we end up with the
attributes overlapping the i_extra_isize field. Checking for
(i_extra_isize == 0) instead fixes this case.

The EXT3_STATE_XATTR flag is only set if (i_extra_isize > 0) and the
inodes has in-inode attributes, so that is enough in the first two
tests.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/xattr.c
+++ linux-2.6.11-latest/fs/ext3/xattr.c
@@ -272,8 +272,7 @@ ext3_xattr_ibody_get(struct inode *inode
 	void *end;
 	int error;
 
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE ||
-	    !(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
+	if (!(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
 		return -ENODATA;
 	error = ext3_get_inode_loc(inode, &iloc);
 	if (error)
@@ -399,8 +398,7 @@ ext3_xattr_ibody_list(struct inode *inod
 	void *end;
 	int error;
 
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE ||
-	    !(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
+	if (!(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
 		return 0;
 	error = ext3_get_inode_loc(inode, &iloc);
 	if (error)
@@ -865,7 +863,7 @@ ext3_xattr_ibody_find(struct inode *inod
 	struct ext3_inode *raw_inode;
 	int error;
 
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+	if (EXT3_I(inode)->i_extra_isize == 0)
 		return 0;
 	raw_inode = ext3_raw_inode(&is->iloc);
 	header = IHDR(inode, raw_inode);
@@ -896,7 +894,7 @@ ext3_xattr_ibody_set(handle_t *handle, s
 	struct ext3_xattr_search *s = &is->s;
 	int error;
 
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+	if (EXT3_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
 	error = ext3_xattr_set_entry(i, s);
 	if (error)

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

