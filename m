Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVATD1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVATD1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVATDZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:25:26 -0500
Received: from cantor.suse.de ([195.135.220.2]:31955 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262032AbVATDX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:28 -0500
Message-Id: <20050120032510.917200000@suse.de>
References: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 5/5] Disallow in-inode attributes for reserved inodes
Content-Disposition: inline; filename=ea-xattr-reserved-inodes.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a filesystem with inodes bigger than 128 bytes, mke2fs
fails to clear out bytes beyond EXT3_GOOD_OLD_INODE_SIZE in all inodes
it creates (the journal, the filesystem root, and lost+found). We would
require a zeroed-out i_extra_isize field but we don't get it, so
disallow in-inode attributes for those inodes.

Add an i_extra_isize sanity check.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/inode.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/inode.c
+++ linux-2.6.11-latest/fs/ext3/inode.c
@@ -2493,15 +2493,30 @@ void ext3_read_inode(struct inode * inod
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
 
-	ei->i_extra_isize =
-		(EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) ?
-		le16_to_cpu(raw_inode->i_extra_isize) : 0;
-	if (ei->i_extra_isize) {
-		__le32 *magic = (void *)raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
-				ei->i_extra_isize;
-		if (le32_to_cpu(*magic))
-			 ei->i_state |= EXT3_STATE_XATTR;
-	}
+	if (inode->i_ino >= EXT3_FIRST_INO(inode->i_sb) + 1 &&
+	    EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
+		/*
+		 * When mke2fs creates big inodes it does not zero out
+		 * the unused bytes above EXT3_GOOD_OLD_INODE_SIZE,
+		 * so ignore those first few inodes.
+		 */
+		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
+		if (EXT3_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
+		    EXT3_INODE_SIZE(inode->i_sb))
+			goto bad_inode;
+		if (ei->i_extra_isize == 0) {
+			/* The extra space is currently unused. Use it. */
+			ei->i_extra_isize = sizeof(struct ext3_inode) -
+					    EXT3_GOOD_OLD_INODE_SIZE;
+		} else {
+			__le32 *magic = (void *)raw_inode +
+					EXT3_GOOD_OLD_INODE_SIZE +
+					ei->i_extra_isize;
+			if (*magic == cpu_to_le32(EXT3_XATTR_MAGIC))
+				 ei->i_state |= EXT3_STATE_XATTR;
+		}
+	} else
+		ei->i_extra_isize = 0;
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext3_file_inode_operations;

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

