Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753371AbWKFQZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbWKFQZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKFQZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:25:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40414 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1753372AbWKFQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:25:00 -0500
Date: Mon, 6 Nov 2006 11:24:58 -0500
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: nfsv4@linux-nfs.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Neil Brown <neilb@suse.de>
Subject: [PATCH 2/2] nfsd4: fix open-create permissions
Message-ID: <20061106162458.GC12372@fieldses.org>
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com> <20061106161747.GA12372@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106161747.GA12372@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the case where an open creates the file, we shouldn't be rechecking
permissions to open the file; the open succeeds regardless of what the
new file's mode bits say.

This patch fixes the problem, but only by introducing yet another parameter
to nfsd_create_v3.  This is ugly.  This will be fixed by later patches.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 fs/nfsd/nfs3proc.c        |    2 +-
 fs/nfsd/nfs4proc.c        |    6 ++++--
 fs/nfsd/vfs.c             |    4 +++-
 include/linux/nfsd/nfsd.h |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 64db601..7f5bad0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -258,7 +258,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp
 	/* Now create the file and set attributes */
 	nfserr = nfsd_create_v3(rqstp, dirfhp, argp->name, argp->len,
 				attr, newfhp,
-				argp->createmode, argp->verf, NULL);
+				argp->createmode, argp->verf, NULL, NULL);
 
 	RETURN_STATUS(nfserr);
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4a73f5b..50bc942 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -93,6 +93,7 @@ do_open_lookup(struct svc_rqst *rqstp, s
 {
 	struct svc_fh resfh;
 	__be32 status;
+	int created = 0;
 
 	fh_init(&resfh, NFS4_FHSIZE);
 	open->op_truncate = 0;
@@ -105,7 +106,7 @@ do_open_lookup(struct svc_rqst *rqstp, s
 		status = nfsd_create_v3(rqstp, current_fh, open->op_fname.data,
 					open->op_fname.len, &open->op_iattr,
 					&resfh, open->op_createmode,
-					(u32 *)open->op_verf.data, &open->op_truncate);
+					(u32 *)open->op_verf.data, &open->op_truncate, &created);
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname.data, open->op_fname.len, &resfh);
@@ -122,7 +123,8 @@ do_open_lookup(struct svc_rqst *rqstp, s
 	memcpy(open->op_stateowner->so_replay.rp_openfh,
 			&resfh.fh_handle.fh_base, resfh.fh_handle.fh_size);
 
-	status = do_open_permission(rqstp, current_fh, open, MAY_NOP);
+	if (!created)
+		status = do_open_permission(rqstp, current_fh, open, MAY_NOP);
 
 out:
 	fh_put(&resfh);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f21e917..1a7ad8c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1237,7 +1237,7 @@ __be32
 nfsd_create_v3(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
 		struct svc_fh *resfhp, int createmode, u32 *verifier,
-	        int *truncp)
+	        int *truncp, int *created)
 {
 	struct dentry	*dentry, *dchild = NULL;
 	struct inode	*dirp;
@@ -1331,6 +1331,8 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	host_err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
 	if (host_err < 0)
 		goto out_nfserr;
+	if (created)
+		*created = 1;
 
 	if (EX_ISSYNC(fhp->fh_export)) {
 		err = nfserrno(nfsd_sync_dir(dentry));
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index eb23114..edb54c3 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -89,7 +89,7 @@ __be32		nfsd_access(struct svc_rqst *, s
 __be32		nfsd_create_v3(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
-				u32 *verifier, int *truncp);
+				u32 *verifier, int *truncp, int *created);
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
-- 
1.4.3.3.g01929

