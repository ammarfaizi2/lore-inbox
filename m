Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319130AbSHMXFs>; Tue, 13 Aug 2002 19:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSHMXFQ>; Tue, 13 Aug 2002 19:05:16 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:17404 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319158AbSHMXCA>; Tue, 13 Aug 2002 19:02:00 -0400
Date: Tue, 13 Aug 2002 19:05:47 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 23/38: SERVER: type checking in fh_verify()
Message-ID: <Pine.SOL.4.44.0208131905210.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change the type checking in fh_verify().  This fixes a bug which
I reported on the mailing list a few days ago, and also adds a
new error code nfserr_symlink (v4 only).  This is returned whenever
an operation which is illegal for symlinks is attempted on a symlink,
and takes precedence over ERR_NOTDIR or ERR_INVAL.

--- old/fs/nfsd/nfsfh.c	Wed Jul 24 16:03:25 2002
+++ new/fs/nfsd/nfsfh.c	Mon Jul 29 12:39:43 2002
@@ -234,11 +234,23 @@ fh_verify(struct svc_rqst *rqstp, struct

 	/* Type can be negative when creating hardlinks - not to a dir */
 	if (type > 0 && (inode->i_mode & S_IFMT) != type) {
-		error = (type == S_IFDIR)? nfserr_notdir : nfserr_isdir;
+		if (rqstp->rq_vers == 4 && (inode->i_mode & S_IFMT) == S_IFLNK)
+			error = nfserr_symlink;
+		else if (type == S_IFDIR)
+			error = nfserr_notdir;
+		else if ((inode->i_mode & S_IFMT) == S_IFDIR)
+			error = nfserr_isdir;
+		else
+			error = nfserr_inval;
 		goto out;
 	}
 	if (type < 0 && (inode->i_mode & S_IFMT) == -type) {
-		error = (type == -S_IFDIR)? nfserr_notdir : nfserr_isdir;
+		if (rqstp->rq_vers == 4 && (inode->i_mode & S_IFMT) == S_IFLNK)
+			error = nfserr_symlink;
+		else if (type == -S_IFDIR)
+			error = nfserr_isdir;
+		else
+			error = nfserr_notdir;
 		goto out;
 	}


