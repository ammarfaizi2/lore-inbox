Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLFIZA>; Wed, 6 Dec 2000 03:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbQLFIYt>; Wed, 6 Dec 2000 03:24:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1418 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129655AbQLFIYo>;
	Wed, 6 Dec 2000 03:24:44 -0500
Date: Wed, 6 Dec 2000 02:54:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012060250410.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	ext2_update_inode() marks the filesystems as having large files
if there the file becomes too large for old driver (2.2 one). Unfortunately,
it gets the limit wrong - it's not 2^32, it's 2^31. So we should check
for ->i_size_high being non zero _or_ ->i_size having bit 31 set. Please,
apply.

diff -urN rc12-pre6/fs/ext2/inode.c rc12-pre6-ext2-LFS/fs/ext2/inode.c
--- rc12-pre6/fs/ext2/inode.c	Tue Dec  5 02:03:14 2000
+++ rc12-pre6-ext2-LFS/fs/ext2/inode.c	Tue Dec  5 15:00:27 2000
@@ -1188,7 +1188,7 @@
 		raw_inode->i_dir_acl = cpu_to_le32(inode->u.ext2_i.i_dir_acl);
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
-		if (raw_inode->i_size_high) {
+		if (raw_inode->i_size_high || (inode->i_size & (1<<31))) {
 			struct super_block *sb = inode->i_sb;
 			struct ext2_super_block *es = sb->u.ext2_sb.s_es;
 			if (!(es->s_feature_ro_compat & cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE))) {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
