Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWJJDOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWJJDOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWJJDOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:14:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34477 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964921AbWJJDOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:12 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] nfsd: NFSv4 errno endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX84J-0004Ha-CG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:14:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


don't use the same variable to store NFS and host error values

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4state.c |   15 +++++++++------
 fs/nfsd/nfs4xdr.c   |   42 ++++++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e5ca6d7..ae1d477 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2646,6 +2646,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	struct file_lock conflock;
 	__be32 status = 0;
 	unsigned int strhashval;
+	int err;
 
 	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
 		(long long) lock->lk_offset,
@@ -2758,13 +2759,14 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	 * locks_copy_lock: */
 	conflock.fl_ops = NULL;
 	conflock.fl_lmops = NULL;
-	status = posix_lock_file_conf(filp, &file_lock, &conflock);
+	err = posix_lock_file_conf(filp, &file_lock, &conflock);
 	dprintk("NFSD: nfsd4_lock: posix_lock_file_conf status %d\n",status);
-	switch (-status) {
+	switch (-err) {
 	case 0: /* success! */
 		update_stateid(&lock_stp->st_stateid);
 		memcpy(&lock->lk_resp_stateid, &lock_stp->st_stateid, 
 				sizeof(stateid_t));
+		status = 0;
 		break;
 	case (EAGAIN):		/* conflock holds conflicting lock */
 		status = nfserr_denied;
@@ -2775,7 +2777,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 		status = nfserr_deadlock;
 		break;
 	default:        
-		dprintk("NFSD: nfsd4_lock: posix_lock_file_conf() failed! status %d\n",status);
+		dprintk("NFSD: nfsd4_lock: posix_lock_file_conf() failed! status %d\n",err);
 		status = nfserr_resource;
 		break;
 	}
@@ -2880,6 +2882,7 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 	struct file *filp = NULL;
 	struct file_lock file_lock;
 	__be32 status;
+	int err;
 						        
 	dprintk("NFSD: nfsd4_locku: start=%Ld length=%Ld\n",
 		(long long) locku->lu_offset,
@@ -2917,8 +2920,8 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 	/*
 	*  Try to unlock the file in the VFS.
 	*/
-	status = posix_lock_file(filp, &file_lock); 
-	if (status) {
+	err = posix_lock_file(filp, &file_lock);
+	if (err) {
 		dprintk("NFSD: nfs4_locku: posix_lock_file failed!\n");
 		goto out_nfserr;
 	}
@@ -2937,7 +2940,7 @@ out:
 	return status;
 
 out_nfserr:
-	status = nfserrno(status);
+	status = nfserrno(err);
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d7b630f..f3f239d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -247,6 +247,7 @@ nfsd4_decode_fattr(struct nfsd4_compound
 	int expected_len, len = 0;
 	u32 dummy32;
 	char *buf;
+	int host_err;
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
@@ -280,7 +281,7 @@ nfsd4_decode_fattr(struct nfsd4_compound
 
 		*acl = nfs4_acl_new();
 		if (*acl == NULL) {
-			status = -ENOMEM;
+			host_err = -ENOMEM;
 			goto out_nfserr;
 		}
 		defer_free(argp, (void (*)(const void *))nfs4_acl_free, *acl);
@@ -295,20 +296,20 @@ nfsd4_decode_fattr(struct nfsd4_compound
 			len += XDR_QUADLEN(dummy32) << 2;
 			READMEM(buf, dummy32);
 			ace.whotype = nfs4_acl_get_whotype(buf, dummy32);
-			status = 0;
+			host_err = 0;
 			if (ace.whotype != NFS4_ACL_WHO_NAMED)
 				ace.who = 0;
 			else if (ace.flag & NFS4_ACE_IDENTIFIER_GROUP)
-				status = nfsd_map_name_to_gid(argp->rqstp,
+				host_err = nfsd_map_name_to_gid(argp->rqstp,
 						buf, dummy32, &ace.who);
 			else
-				status = nfsd_map_name_to_uid(argp->rqstp,
+				host_err = nfsd_map_name_to_uid(argp->rqstp,
 						buf, dummy32, &ace.who);
-			if (status)
+			if (host_err)
 				goto out_nfserr;
-			status = nfs4_acl_add_ace(*acl, ace.type, ace.flag,
+			host_err = nfs4_acl_add_ace(*acl, ace.type, ace.flag,
 				 ace.access_mask, ace.whotype, ace.who);
-			if (status)
+			if (host_err)
 				goto out_nfserr;
 		}
 	} else
@@ -327,7 +328,7 @@ nfsd4_decode_fattr(struct nfsd4_compound
 		READ_BUF(dummy32);
 		len += (XDR_QUADLEN(dummy32) << 2);
 		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
+		if ((host_err = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
 			goto out_nfserr;
 		iattr->ia_valid |= ATTR_UID;
 	}
@@ -338,7 +339,7 @@ nfsd4_decode_fattr(struct nfsd4_compound
 		READ_BUF(dummy32);
 		len += (XDR_QUADLEN(dummy32) << 2);
 		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
+		if ((host_err = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
 			goto out_nfserr;
 		iattr->ia_valid |= ATTR_GID;
 	}
@@ -414,7 +415,7 @@ nfsd4_decode_fattr(struct nfsd4_compound
 	DECODE_TAIL;
 
 out_nfserr:
-	status = nfserrno(status);
+	status = nfserrno(host_err);
 	goto out;
 }
 
@@ -1438,6 +1439,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	u32 rdattr_err = 0;
 	__be32 *p = buffer;
 	__be32 status;
+	int err;
 	int aclsupport = 0;
 	struct nfs4_acl *acl = NULL;
 
@@ -1451,14 +1453,14 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 			goto out;
 	}
 
-	status = vfs_getattr(exp->ex_mnt, dentry, &stat);
-	if (status)
+	err = vfs_getattr(exp->ex_mnt, dentry, &stat);
+	if (err)
 		goto out_nfserr;
 	if ((bmval0 & (FATTR4_WORD0_FILES_FREE | FATTR4_WORD0_FILES_TOTAL)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
-		status = vfs_statfs(dentry, &statfs);
-		if (status)
+		err = vfs_statfs(dentry, &statfs);
+		if (err)
 			goto out_nfserr;
 	}
 	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
@@ -1470,15 +1472,15 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	}
 	if (bmval0 & (FATTR4_WORD0_ACL | FATTR4_WORD0_ACLSUPPORT
 			| FATTR4_WORD0_SUPPORTED_ATTRS)) {
-		status = nfsd4_get_nfs4_acl(rqstp, dentry, &acl);
-		aclsupport = (status == 0);
+		err = nfsd4_get_nfs4_acl(rqstp, dentry, &acl);
+		aclsupport = (err == 0);
 		if (bmval0 & FATTR4_WORD0_ACL) {
-			if (status == -EOPNOTSUPP)
+			if (err == -EOPNOTSUPP)
 				bmval0 &= ~FATTR4_WORD0_ACL;
-			else if (status == -EINVAL) {
+			else if (err == -EINVAL) {
 				status = nfserr_attrnotsupp;
 				goto out;
-			} else if (status != 0)
+			} else if (err != 0)
 				goto out_nfserr;
 		}
 	}
@@ -1818,7 +1820,7 @@ out:
 		fh_put(&tempfh);
 	return status;
 out_nfserr:
-	status = nfserrno(status);
+	status = nfserrno(err);
 	goto out;
 out_resource:
 	*countp = 0;
-- 
1.4.2.GIT


