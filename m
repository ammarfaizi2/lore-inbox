Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHNUhD>; Wed, 14 Aug 2002 16:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHNUfw>; Wed, 14 Aug 2002 16:35:52 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:11737 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S315748AbSHNUf3>; Wed, 14 Aug 2002 16:35:29 -0400
Date: Wed, 14 Aug 2002 16:39:17 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 07/38: CLIENT: change hard limit on symlink length
Message-ID: <Pine.SOL.4.44.0208141639000.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In NFSv4, there is no hard limit on the length of symlink text.
This patch changes the -ENAMETOOLONG test in nfs_symlink() accordingly.

--- old/fs/nfs/dir.c	Sun Aug 11 20:26:56 2002
+++ new/fs/nfs/dir.c	Sun Aug 11 20:28:25 2002
@@ -1022,15 +1022,15 @@ nfs_symlink(struct inode *dir, struct de
 	struct nfs_fattr sym_attr;
 	struct nfs_fh sym_fh;
 	struct qstr qsymname;
-	unsigned int maxlen;
 	int error;

 	dfprintk(VFS, "NFS: symlink(%s/%ld, %s, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name, symname);

 	error = -ENAMETOOLONG;
-	maxlen = (NFS_PROTO(dir)->version==2) ? NFS2_MAXPATHLEN : NFS3_MAXPATHLEN;
-	if (strlen(symname) > maxlen)
+	if (NFS_PROTO(dir)->version == 2 && strlen(symname) > NFS2_MAXPATHLEN)
+		goto out;
+	else if (NFS_PROTO(dir)->version == 3 && strlen(symname) > NFS3_MAXPATHLEN)
 		goto out;

 #ifdef NFS_PARANOIA

