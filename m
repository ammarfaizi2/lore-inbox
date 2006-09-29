Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWI2DKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWI2DKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWI2DJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11961 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161303AbWI2DJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:09:29 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:09:23 +1000
Message-Id: <1060929030923.24132@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 8] knfsd: nfsd4: actually use all the pieces to implement referrals
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Use all the pieces set up so far to implement referral support, allowing
return of NFS4ERR_MOVED and fs_locations attribute.

Signed-off-by: Manoj Naik <manoj@almaden.ibm.com>
Signed-off-by: Fred Isaman <iisaman@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c        |   30 +++++++++++++++++++------
 ./fs/nfsd/nfs4xdr.c         |   51 ++++++++++++++++++++++++++++++++++++++------
 ./include/linux/nfsd/nfsd.h |    1 
 3 files changed, 69 insertions(+), 13 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-09-29 12:57:26.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-09-29 13:05:03.000000000 +1000
@@ -802,13 +802,29 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		* SETCLIENTID_CONFIRM, PUTFH and PUTROOTFH
 		* require a valid current filehandle
 		*/
-		if ((!current_fh->fh_dentry) &&
-		   !((op->opnum == OP_PUTFH) || (op->opnum == OP_PUTROOTFH) ||
-		   (op->opnum == OP_SETCLIENTID) ||
-		   (op->opnum == OP_SETCLIENTID_CONFIRM) ||
-		   (op->opnum == OP_RENEW) || (op->opnum == OP_RESTOREFH) ||
-		   (op->opnum == OP_RELEASE_LOCKOWNER))) {
-			op->status = nfserr_nofilehandle;
+		if (!current_fh->fh_dentry) {
+			if (!((op->opnum == OP_PUTFH) ||
+			      (op->opnum == OP_PUTROOTFH) ||
+			      (op->opnum == OP_SETCLIENTID) ||
+			      (op->opnum == OP_SETCLIENTID_CONFIRM) ||
+			      (op->opnum == OP_RENEW) ||
+			      (op->opnum == OP_RESTOREFH) ||
+			      (op->opnum == OP_RELEASE_LOCKOWNER))) {
+				op->status = nfserr_nofilehandle;
+				goto encode_op;
+			}
+		}
+		/* Check must be done at start of each operation, except
+		 * for GETATTR and ops not listed as returning NFS4ERR_MOVED
+		 */
+		else if (current_fh->fh_export->ex_fslocs.migrated &&
+			 !((op->opnum == OP_GETATTR) ||
+			   (op->opnum == OP_PUTROOTFH) ||
+			   (op->opnum == OP_PUTPUBFH) ||
+			   (op->opnum == OP_RENEW) ||
+			   (op->opnum == OP_SETCLIENTID) ||
+			   (op->opnum == OP_RELEASE_LOCKOWNER))) {
+			op->status = nfserr_moved;
 			goto encode_op;
 		}
 		switch (op->opnum) {

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-09-29 13:04:07.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-09-29 13:05:03.000000000 +1000
@@ -60,6 +60,14 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
+/*
+ * As per referral draft, the fsid for a referral MUST be different from the fsid of the containing
+ * directory in order to indicate to the client that a filesystem boundary is present
+ * We use a fixed fsid for a referral
+ */
+#define NFS4_REFERRAL_FSID_MAJOR	0x8000000ULL
+#define NFS4_REFERRAL_FSID_MINOR	0x8000000ULL
+
 static int
 check_filename(char *str, int len, int err)
 {
@@ -1386,6 +1394,25 @@ nfsd4_encode_aclname(struct svc_rqst *rq
 	return nfsd4_encode_name(rqstp, whotype, id, group, p, buflen);
 }
 
+#define WORD0_ABSENT_FS_ATTRS (FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_FSID | \
+			      FATTR4_WORD0_RDATTR_ERROR)
+#define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
+
+static int fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *rdattr_err)
+{
+	/* As per referral draft:  */
+	if (*bmval0 & ~WORD0_ABSENT_FS_ATTRS ||
+	    *bmval1 & ~WORD1_ABSENT_FS_ATTRS) {
+		if (*bmval0 & FATTR4_WORD0_RDATTR_ERROR ||
+	            *bmval0 & FATTR4_WORD0_FS_LOCATIONS)
+			*rdattr_err = NFSERR_MOVED;
+		else
+			return nfserr_moved;
+	}
+	*bmval0 &= WORD0_ABSENT_FS_ATTRS;
+	*bmval1 &= WORD1_ABSENT_FS_ATTRS;
+	return 0;
+}
 
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
@@ -1408,6 +1435,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	u32 *attrlenp;
 	u32 dummy;
 	u64 dummy64;
+	u32 rdattr_err = 0;
 	u32 *p = buffer;
 	int status;
 	int aclsupport = 0;
@@ -1417,6 +1445,12 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	BUG_ON(bmval0 & ~NFSD_SUPPORTED_ATTRS_WORD0);
 	BUG_ON(bmval1 & ~NFSD_SUPPORTED_ATTRS_WORD1);
 
+	if (exp->ex_fslocs.migrated) {
+		status = fattr_handle_absent_fs(&bmval0, &bmval1, &rdattr_err);
+		if (status)
+			goto out;
+	}
+
 	status = vfs_getattr(exp->ex_mnt, dentry, &stat);
 	if (status)
 		goto out_nfserr;
@@ -1462,12 +1496,15 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	attrlenp = p++;                /* to be backfilled later */
 
 	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
+		u32 word0 = NFSD_SUPPORTED_ATTRS_WORD0;
 		if ((buflen -= 12) < 0)
 			goto out_resource;
+		if (!aclsupport)
+			word0 &= ~FATTR4_WORD0_ACL;
+		if (!exp->ex_fslocs.locations)
+			word0 &= ~FATTR4_WORD0_FS_LOCATIONS;
 		WRITE32(2);
-		WRITE32(aclsupport ?
-			NFSD_SUPPORTED_ATTRS_WORD0 :
-			NFSD_SUPPORTED_ATTRS_WORD0 & ~FATTR4_WORD0_ACL);
+		WRITE32(word0);
 		WRITE32(NFSD_SUPPORTED_ATTRS_WORD1);
 	}
 	if (bmval0 & FATTR4_WORD0_TYPE) {
@@ -1521,7 +1558,10 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	if (bmval0 & FATTR4_WORD0_FSID) {
 		if ((buflen -= 16) < 0)
 			goto out_resource;
-		if (is_fsid(fhp, rqstp->rq_reffh)) {
+		if (exp->ex_fslocs.migrated) {
+			WRITE64(NFS4_REFERRAL_FSID_MAJOR);
+			WRITE64(NFS4_REFERRAL_FSID_MINOR);
+		} else if (is_fsid(fhp, rqstp->rq_reffh)) {
 			WRITE64((u64)exp->ex_fsid);
 			WRITE64((u64)0);
 		} else {
@@ -1544,7 +1584,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR) {
 		if ((buflen -= 4) < 0)
 			goto out_resource;
-		WRITE32(0);
+		WRITE32(rdattr_err);
 	}
 	if (bmval0 & FATTR4_WORD0_ACL) {
 		struct nfs4_ace *ace;
@@ -1971,7 +2011,6 @@ nfsd4_encode_getattr(struct nfsd4_compou
 	nfserr = nfsd4_encode_fattr(fhp, fhp->fh_export, fhp->fh_dentry,
 				    resp->p, &buflen, getattr->ga_bmval,
 				    resp->rqstp);
-
 	if (!nfserr)
 		resp->p += buflen;
 	return nfserr;

diff .prev/include/linux/nfsd/nfsd.h ./include/linux/nfsd/nfsd.h
--- .prev/include/linux/nfsd/nfsd.h	2006-09-29 13:04:07.000000000 +1000
+++ ./include/linux/nfsd/nfsd.h	2006-09-29 13:05:03.000000000 +1000
@@ -216,6 +216,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_clid_inuse	__constant_htonl(NFSERR_CLID_INUSE)
 #define	nfserr_stale_clientid	__constant_htonl(NFSERR_STALE_CLIENTID)
 #define	nfserr_resource		__constant_htonl(NFSERR_RESOURCE)
+#define	nfserr_moved		__constant_htonl(NFSERR_MOVED)
 #define	nfserr_nofilehandle	__constant_htonl(NFSERR_NOFILEHANDLE)
 #define	nfserr_minor_vers_mismatch	__constant_htonl(NFSERR_MINOR_VERS_MISMATCH)
 #define nfserr_share_denied	__constant_htonl(NFSERR_SHARE_DENIED)
