Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVIRTcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVIRTcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 15:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVIRTcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 15:32:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:16520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932176AbVIRTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 15:32:07 -0400
X-Authenticated: #815883
Date: Sun, 18 Sep 2005 21:32:18 +0200
From: Christian Aichinger <Greek0@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] ext[23]: fix missing DQUOT_DROP in error paths
Message-ID: <20050918193218.GQ22403@orest.greek0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "Enable atomic inode security labeling" patches
(ac50960afa31877493add6d941d8402fa879c452 and
10f47e6a1b8b276323b652053945c87a63a5812d) missed to call
DQUOT_DROP() in ext[23]_new_inode() in their error path.

This patch unifies the error exits that need quota cleanup, and
fixes that problem along the way.

Signed-off-by: Christian Aichinger <Greek0@gmx.net>
---

 fs/ext2/ialloc.c |   18 +++++++++---------
 fs/ext3/ialloc.c |   22 ++++++++++------------
 2 files changed, 19 insertions(+), 21 deletions(-)

bae38e9a68f6b15350ea99a763f0d8d6c8f0ee0a
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -610,21 +610,21 @@ got:
 		goto fail2;
 	}
 	err = ext2_init_acl(inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail2_free;
+
 	err = ext2_init_security(inode,dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail2_free;
+
 	mark_inode_dirty(inode);
 	ext2_debug("allocating inode %lu\n", inode->i_ino);
 	ext2_preread_inode(inode);
 	return inode;
 
+fail2_free:
+	DQUOT_FREE_INODE(inode);
+	DQUOT_DROP(inode);
 fail2:
 	inode->i_flags |= S_NOQUOTA;
 	inode->i_nlink = 0;
diff --git a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c
+++ b/fs/ext3/ialloc.c
@@ -602,22 +602,17 @@ got:
 		goto fail2;
 	}
 	err = ext3_init_acl(handle, inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
-  	}
+	if (err)
+		goto fail2_free;
+
 	err = ext3_init_security(handle,inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail2_free;
+
 	err = ext3_mark_inode_dirty(handle, inode);
 	if (err) {
 		ext3_std_error(sb, err);
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
+		goto fail2_free;
 	}
 
 	ext3_debug("allocating inode %lu\n", inode->i_ino);
@@ -631,6 +626,9 @@ really_out:
 	brelse(bitmap_bh);
 	return ret;
 
+fail2_free:
+	DQUOT_FREE_INODE(inode);
+	DQUOT_DROP(inode);
 fail2:
 	inode->i_flags |= S_NOQUOTA;
 	inode->i_nlink = 0;
