Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266240AbSKLG1k>; Tue, 12 Nov 2002 01:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266248AbSKLG1j>; Tue, 12 Nov 2002 01:27:39 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:12946 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266240AbSKLG0e>;
	Tue, 12 Nov 2002 01:26:34 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [3/4]: Ext2/3 updates: HTREE backwards compatibility patch
From: tytso@mit.edu
Message-Id: <E18BUbz-0005j1-00@snap.thunk.org>
Date: Tue, 12 Nov 2002 01:33:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HTREE backwards compatibility patch.

I thought (and assumed) this patch had been applied to both the ext2
and ext3 filesystems in the 2.4 kernel.  It turns out it had only made
it into the ext3 filesystem code.   This means that if an 
HTREE-enabled filesystem is mounted using ext2, it will corrupt 
the filesystem as far as e2fsck and an ext3 htree-enabled kernel is
concerned.  (The corruption won't cause any data loss, but it will
cause e2fsck and an ext3-htree kernel to omit a lot of warning
messages.)

dir.c    |    3 +++
ialloc.c |    2 +-
2 files changed, 4 insertions(+), 1 deletion(-)

diff -Nru a/fs/ext2/dir.c b/fs/ext2/dir.c
--- a/fs/ext2/dir.c	Tue Nov 12 01:14:00 2002
+++ b/fs/ext2/dir.c	Tue Nov 12 01:14:00 2002
@@ -420,6 +420,7 @@
 	err = ext2_commit_chunk(page, from, to);
 	ext2_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 }
 
@@ -509,6 +510,7 @@
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
@@ -556,6 +558,7 @@
 	dir->inode = 0;
 	err = ext2_commit_chunk(page, from, to);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
 out:
 	ext2_put_page(page);
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Tue Nov 12 01:14:00 2002
+++ b/fs/ext2/ialloc.c	Tue Nov 12 01:14:00 2002
@@ -514,7 +514,7 @@
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	memset(ei->i_data, 0, sizeof(ei->i_data));
-	ei->i_flags = EXT2_I(dir)->i_flags;
+	ei->i_flags = EXT2_I(dir)->i_flags & ~EXT2_BTREE_FL;
 	if (S_ISLNK(mode))
 		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	/* dirsync is only applied to directories */
