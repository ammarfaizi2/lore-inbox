Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSJOOeY>; Tue, 15 Oct 2002 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263302AbSJOOeY>; Tue, 15 Oct 2002 10:34:24 -0400
Received: from ns.suse.de ([213.95.15.193]:33037 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263342AbSJOOeW>;
	Tue, 15 Oct 2002 10:34:22 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Add extended attributes to ext2/3
Date: Tue, 15 Oct 2002 16:40:15 +0200
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3321LJUL5DMFFQTA0OCA"
Message-Id: <200210151640.15581.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_3321LJUL5DMFFQTA0OCA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Here are two fixes as incrementals to the xattr/acl patches:

fix-xattr.diff: The bad_block bug Andreas Dilger has reported
fix-acl.diff: Make change in ext[23]_new_inode() less intrusive.

--------------Boundary-00=_3321LJUL5DMFFQTA0OCA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix-acl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-acl.diff"

--- linux-2.4.19.old/fs/ext3/ialloc.c	2002-10-15 14:18:59.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/ialloc.c	2002-10-15 14:16:34.000000000 +0200
@@ -510,7 +510,9 @@
 	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
 
 	inode->u.ext3_i.i_state = EXT3_STATE_NEW;
-
+	err = ext3_mark_inode_dirty(handle, inode);
+	if (err) goto fail;
+	
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
@@ -522,12 +524,6 @@
 		DQUOT_FREE_INODE(inode);
 		goto fail2;
 	}
-	err = ext3_mark_inode_dirty(handle, inode);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
-
 	ext3_debug ("allocating inode %lu\n", inode->i_ino);
 	return inode;
 
diff -Nur --exclude='*.orig' linux-2.4.19.old/fs/ext2/ialloc.c linux-2.4.19.new/fs/ext2/ialloc.c
--- linux-2.4.19.old/fs/ext2/ialloc.c	2002-10-15 15:32:24.000000000 +0200
+++ linux-2.4.19.new/fs/ext2/ialloc.c	2002-10-15 15:32:16.000000000 +0200
@@ -410,7 +410,6 @@
 		DQUOT_FREE_INODE(inode);
 		goto fail3;
 	}
-	mark_inode_dirty(inode);
 
 	ext2_debug ("allocating inode %lu\n", inode->i_ino);
 	return inode;

--------------Boundary-00=_3321LJUL5DMFFQTA0OCA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix-xattr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-xattr.diff"

--- linux-2.4.19.old/fs/ext2/xattr.c	2002-10-15 13:57:44.000000000 +0200
+++ linux-2.4.19.new/fs/ext2/xattr.c	2002-10-15 13:59:57.000000000 +0200
@@ -587,6 +587,7 @@
 	struct ext2_xattr_header *header = NULL;
 	struct ext2_xattr_entry *here, *last;
 	unsigned int name_len;
+	int block = EXT2_I(inode)->i_file_acl;
 	int min_offs = sb->s_blocksize, not_found = 1, free, error;
 	char *end;
 	
@@ -618,9 +619,8 @@
 		return -ERANGE;
 	ext2_xattr_lock();
 
-	if (EXT2_I(inode)->i_file_acl) {
+	if (block) {
 		/* The inode already has an extended attribute block. */
-		int block = EXT2_I(inode)->i_file_acl;
 
 		bh = sb_bread(sb, block);
 		error = -EIO;
--- linux-2.4.19.old/fs/ext3/xattr.c	2002-10-15 14:24:10.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/xattr.c	2002-10-15 14:24:01.000000000 +0200
@@ -587,6 +587,7 @@
 	struct ext3_xattr_header *header = NULL;
 	struct ext3_xattr_entry *here, *last;
 	unsigned int name_len;
+	int block = EXT3_I(inode)->i_file_acl;
 	int min_offs = sb->s_blocksize, not_found = 1, free, error;
 	char *end;
 	
@@ -618,10 +619,8 @@
 		return -ERANGE;
 	ext3_xattr_lock();
 
-	if (EXT3_I(inode)->i_file_acl) {
+	if (block) {
 		/* The inode already has an extended attribute block. */
-		int block = EXT3_I(inode)->i_file_acl;
-
 		bh = sb_bread(sb, block);
 		error = -EIO;
 		if (!bh)

--------------Boundary-00=_3321LJUL5DMFFQTA0OCA--

