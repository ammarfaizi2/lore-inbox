Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSHMW5O>; Tue, 13 Aug 2002 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319084AbSHMW4g>; Tue, 13 Aug 2002 18:56:36 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:39053 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319081AbSHMWzb>; Tue, 13 Aug 2002 18:55:31 -0400
Date: Tue, 13 Aug 2002 18:59:20 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 08/38: CLIENT: change hard limit on symlink length
Message-ID: <Pine.SOL.4.44.0208131858520.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In NFSv4, there is no hard limit on the length of symlink text.
This patch changes the -ENAMETOOLONG test in nfs_symlink() accordingly.

--- old/fs/nfs/dir.c	Mon Jul 29 22:54:08 2002
+++ new/fs/nfs/dir.c	Mon Jul 29 11:50:09 2002
@@ -898,15 +898,15 @@ nfs_symlink(struct inode *dir, struct de
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

