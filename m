Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTBOXCQ>; Sat, 15 Feb 2003 18:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBOXCQ>; Sat, 15 Feb 2003 18:02:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:17358 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265378AbTBOXCO>;
	Sat, 15 Feb 2003 18:02:14 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Feb 2003 00:12:03 +0100 (MET)
Message-Id: <UTC200302152312.h1FNC3804597.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] nfsd patch
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MAX_BLKDEV from nfsd.

diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
--- a/fs/nfsd/nfs3proc.c	Fri Nov 22 22:40:29 2002
+++ b/fs/nfsd/nfs3proc.c	Sat Feb 15 21:16:14 2003
@@ -317,11 +317,10 @@
 	if (argp->ftype == 0 || argp->ftype >= NF3BAD)
 		RETURN_STATUS(nfserr_inval);
 	if (argp->ftype == NF3CHR || argp->ftype == NF3BLK) {
-		if ((argp->ftype == NF3CHR && argp->major >= MAX_CHRDEV)
-		    || (argp->ftype == NF3BLK && argp->major >= MAX_BLKDEV)
-		    || argp->minor > 0xFF)
-			RETURN_STATUS(nfserr_inval);
 		rdev = MKDEV(argp->major, argp->minor);
+		if (MAJOR(rdev) != argp->major ||
+		    MINOR(rdev) != argp->minor)
+			RETURN_STATUS(nfserr_inval);
 	} else
 		if (argp->ftype != NF3SOCK && argp->ftype != NF3FIFO)
 			RETURN_STATUS(nfserr_inval);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
--- a/fs/nfsd/nfs4proc.c	Thu Jan  9 18:07:16 2003
+++ b/fs/nfsd/nfs4proc.c	Sat Feb 15 21:25:43 2003
@@ -264,6 +264,7 @@
 {
 	struct svc_fh resfh;
 	int status;
+	dev_t rdev;
 
 	fh_init(&resfh, NFS4_FHSIZE);
 
@@ -288,21 +289,23 @@
 		break;
 
 	case NF4BLK:
-		if (create->cr_specdata1 >= MAX_BLKDEV || create->cr_specdata2 > 0xFF)
+		rdev = MKDEV(create->cr_specdata1, create->cr_specdata2);
+		if (MAJOR(rdev) != create->cr_specdata1 ||
+		    MINOR(rdev) != create->cr_specdata2)
 			return nfserr_inval;
 		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr, S_IFBLK,
-				     MKDEV(create->cr_specdata1, create->cr_specdata2),
-				     &resfh);
+				     create->cr_namelen, &create->cr_iattr,
+				     S_IFBLK, rdev, &resfh);
 		break;
 
 	case NF4CHR:
-		if (create->cr_specdata1 >= MAX_CHRDEV || create->cr_specdata2 > 0xFF)
+		rdev = MKDEV(create->cr_specdata1, create->cr_specdata2);
+		if (MAJOR(rdev) != create->cr_specdata1 ||
+		    MINOR(rdev) != create->cr_specdata2)
 			return nfserr_inval;
 		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr, S_IFCHR,
-				     MKDEV(create->cr_specdata1, create->cr_specdata2),
-				     &resfh);
+				     create->cr_namelen, &create->cr_iattr,
+				     S_IFCHR, rdev, &resfh);
 		break;
 
 	case NF4SOCK:
