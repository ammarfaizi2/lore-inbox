Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVATS3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVATS3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVATSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:25:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:60329 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261402AbVATSWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:22:36 -0500
Subject: Fix ea-in-inode default ACL creation
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106245344.15959.13.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 Jan 2005 19:22:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is another nastiness.

When a new inode is created, ext3_new_inode sets the EXT3_STATE_NEW
flag, which tells ext3_do_update_inode to zero out the inode before
filling in the inode's data. When a file is created in a directory with
a default acl, the new inode inherits the directory's default acl; this
generates attributes. The attributes are created before
ext3_do_update_inode is called to write out the inode. In case of
in-inode attributes, the new inode's attributes are written, and then
zeroed out again by ext3_do_update_inode. Bad thing.

Fix this by recognizing the EXT3_STATE_NEW case in
ext3_xattr_set_handle, and zeroing out the inode there already when
necessary.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/xattr.c
+++ linux-2.6.11-latest/fs/ext3/xattr.c
@@ -954,6 +954,13 @@ ext3_xattr_set_handle(handle_t *handle, 
 	error = ext3_get_inode_loc(inode, &is.iloc);
 	if (error)
 		goto cleanup;
+
+	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW) {
+		struct ext3_inode *raw_inode = ext3_raw_inode(&is.iloc);
+		memset(raw_inode, 0, EXT3_SB(inode->i_sb)->s_inode_size);
+		EXT3_I(inode)->i_state &= ~EXT3_STATE_NEW;
+	}
+
 	error = ext3_xattr_ibody_find(inode, &i, &is);
 	if (error)
 		goto cleanup;


-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

