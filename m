Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319325AbSHNUt5>; Wed, 14 Aug 2002 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319323AbSHNUsu>; Wed, 14 Aug 2002 16:48:50 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:35799 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319282AbSHNUrs>; Wed, 14 Aug 2002 16:47:48 -0400
Date: Wed, 14 Aug 2002 16:51:39 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 31/38: SERVER: tweak nfsd_create_v3() for NFSv4
Message-ID: <Pine.SOL.4.44.0208141651160.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


File creation in NFSv4 is almost the same as in NFSv3, with one minor
difference.  If an UNCHECKED create is done, and the file exists, we
don't set any attributes.  Exception: If size==0 is specified as part
of the attributes, then we do truncate the file, but only after processing
the rest of the OPEN.  (File creation is always part of an OPEN request.)

This patch defines a new argument *truncp to nfsd_create_v3(), which
will be NULL for v3 requests.  For v4 requests, it will point to a
variable which should be set to 1 if file truncation is still needed.

The logic in nfsd_create_v3() is changed as follows: If
  - *truncp is not NULL
  - the create is UNCHECKED
  - the file exists
then nfsd_create_v3() returns immediately.  If size==0 is specified,
then *truncp is set to 1.

This is kind of a hack, but the only alternative I could see was creating
a new routine nfsd_create_v4(), which would be identical to nfsd_create_v3()
except for this point.

--- old/fs/nfsd/nfs3proc.c	Thu Aug  1 16:16:20 2002
+++ new/fs/nfsd/nfs3proc.c	Sun Aug 11 23:08:49 2002
@@ -267,7 +267,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp
 	/* Now create the file and set attributes */
 	nfserr = nfsd_create_v3(rqstp, dirfhp, argp->name, argp->len,
 				attr, newfhp,
-				argp->createmode, argp->verf);
+				argp->createmode, argp->verf, NULL);

 	RETURN_STATUS(nfserr);
 }
--- old/fs/nfsd/vfs.c	Sun Aug 11 23:08:29 2002
+++ new/fs/nfsd/vfs.c	Sun Aug 11 23:08:49 2002
@@ -907,7 +907,8 @@ out_nfserr:
 int
 nfsd_create_v3(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
-		struct svc_fh *resfhp, int createmode, u32 *verifier)
+		struct svc_fh *resfhp, int createmode, u32 *verifier,
+	        int *truncp)
 {
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
@@ -969,6 +970,16 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 		case NFS3_CREATE_UNCHECKED:
 			if (! S_ISREG(dchild->d_inode->i_mode))
 				err = nfserr_exist;
+			else if (truncp) {
+				/* in nfsv4, we need to treat this case a little
+				 * differently.  we don't want to truncate the
+				 * file now; this would be wrong if the OPEN
+				 * fails for some other reason.  furthermore,
+				 * if the size is nonzero, we should ignore it
+				 * according to spec!
+				 */
+				*truncp = (iap->ia_valid & ATTR_SIZE) && !iap->ia_size;
+			}
 			else {
 				iap->ia_valid &= ATTR_SIZE;
 				goto set_attr;
--- old/include/linux/nfsd/nfsd.h	Sun Aug 11 22:52:04 2002
+++ new/include/linux/nfsd/nfsd.h	Sun Aug 11 23:08:49 2002
@@ -90,7 +90,7 @@ int		nfsd_access(struct svc_rqst *, stru
 int		nfsd_create_v3(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
-				u32 *verifier);
+				u32 *verifier, int *truncp);
 int		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				off_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */

