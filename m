Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVATDXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVATDXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATDXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:23:43 -0500
Received: from mail.suse.de ([195.135.220.2]:26067 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262025AbVATDXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:23 -0500
Message-Id: <20050120032510.612744000@suse.de>
References: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 1/5] No lock needed when freeing inode
Content-Disposition: inline; filename=ea-xattr-nolock.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3_xattr_delete_inode is called from ext3_free_inode which always
has exclusive access to the inode, so there is no need to take the
xattr semaphore.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/xattr.c
+++ linux-2.6.11-latest/fs/ext3/xattr.c
@@ -1066,7 +1066,6 @@ ext3_xattr_delete_inode(handle_t *handle
 {
 	struct buffer_head *bh = NULL;
 
-	down_write(&EXT3_I(inode)->xattr_sem);
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
@@ -1088,7 +1087,6 @@ ext3_xattr_delete_inode(handle_t *handle
 
 cleanup:
 	brelse(bh);
-	up_write(&EXT3_I(inode)->xattr_sem);
 }
 
 /*

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

