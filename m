Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319149AbSHMXIE>; Tue, 13 Aug 2002 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319140AbSHMXHX>; Tue, 13 Aug 2002 19:07:23 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:1789 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319101AbSHMXG3>; Tue, 13 Aug 2002 19:06:29 -0400
Date: Tue, 13 Aug 2002 19:10:17 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 32/38: SERVER: tweak nfsd_create_v3() for NFSv4
Message-ID: <Pine.SOL.4.44.0208131909530.25942-100000@rastan.gpcc.itd.umich.edu>
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

--- old/include/linux/nfsd/nfsd.h	Fri Aug  9 09:25:53 2002
+++ new/include/linux/nfsd/nfsd.h	Fri Aug  9 10:00:13 2002
@@ -90,7 +90,7 @@ int		nfsd_access(struct svc_rqst *, stru
 int		nfsd_create_v3(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
-				u32 *verifier);
+				u32 *verifier, int *truncp);
 int		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				off_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
--- old/fs/nfsd/vfs.c	Fri Aug  9 09:53:29 2002
+++ new/fs/nfsd/vfs.c	Fri Aug  9 09:32:36 2002
@@ -907,7 +912,8 @@ out_nfserr:
 int
 nfsd_create_v3(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
-		struct svc_fh *resfhp, int createmode, u32 *verifier)
+		struct svc_fh *resfhp, int createmode, u32 *verifier,
+	        int *truncp)
 {
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
@@ -969,6 +975,16 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
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
--- old/fs/nfsd/nfs3proc.c	Wed Jul 24 16:03:25 2002
+++ new/fs/nfsd/nfs3proc.c	Wed Aug  7 11:58:49 2002
@@ -267,7 +267,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp
 	/* Now create the file and set attributes */
 	nfserr = nfsd_create_v3(rqstp, dirfhp, argp->name, argp->len,
 				attr, newfhp,
-				argp->createmode, argp->verf);
+				argp->createmode, argp->verf, NULL);

 	RETURN_STATUS(nfserr);
 }

