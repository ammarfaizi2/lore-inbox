Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164345AbWLHBO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164345AbWLHBO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164343AbWLHBOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47197 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164340AbWLHBN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:57 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:07 +1100
Message-Id: <1061208011407.30663@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 18] knfsd: nfsd4: pass saved and current fh together into nfsd4 operations.
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Pass the saved and current filehandles together into all the nfsd4 compound
operations.

I want a unified interface to these operations so we can just call them by
pointer and throw out the huge switch statement.

Also I'll eventually want a structure like this--that holds the state used
during compound processing--for deferral.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c        |  348 +++++++++++++++++++++++++-------------------
 ./fs/nfsd/nfs4state.c       |   68 +++++---
 ./include/linux/nfsd/xdr4.h |   22 +-
 3 files changed, 259 insertions(+), 179 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:08:12.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:27.000000000 +1100
@@ -162,7 +162,8 @@ do_open_fhandle(struct svc_rqst *rqstp, 
 
 
 static inline __be32
-nfsd4_open(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, struct nfs4_stateowner **replay_owner)
+nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   struct nfsd4_open *open, struct nfs4_stateowner **replay_owner)
 {
 	__be32 status;
 	dprintk("NFSD: nfsd4_open filename %.*s op_stateowner %p\n",
@@ -179,11 +180,11 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 	status = nfsd4_process_open1(open);
 	if (status == nfserr_replay_me) {
 		struct nfs4_replay *rp = &open->op_stateowner->so_replay;
-		fh_put(current_fh);
-		current_fh->fh_handle.fh_size = rp->rp_openfh_len;
-		memcpy(&current_fh->fh_handle.fh_base, rp->rp_openfh,
+		fh_put(&cstate->current_fh);
+		cstate->current_fh.fh_handle.fh_size = rp->rp_openfh_len;
+		memcpy(&cstate->current_fh.fh_handle.fh_base, rp->rp_openfh,
 				rp->rp_openfh_len);
-		status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
+		status = fh_verify(rqstp, &cstate->current_fh, 0, MAY_NOP);
 		if (status)
 			dprintk("nfsd4_open: replay failed"
 				" restoring previous filehandle\n");
@@ -215,7 +216,8 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 			 * (3) set open->op_truncate if the file is to be
 			 * truncated after opening, (4) do permission checking.
 			 */
-			status = do_open_lookup(rqstp, current_fh, open);
+			status = do_open_lookup(rqstp, &cstate->current_fh,
+						open);
 			if (status)
 				goto out;
 			break;
@@ -227,7 +229,8 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 			 * open->op_truncate if the file is to be truncated
 			 * after opening, (3) do permission checking.
 			*/
-			status = do_open_fhandle(rqstp, current_fh, open);
+			status = do_open_fhandle(rqstp, &cstate->current_fh,
+						 open);
 			if (status)
 				goto out;
 			break;
@@ -248,7 +251,7 @@ nfsd4_open(struct svc_rqst *rqstp, struc
 	 * successful, it (1) truncates the file if open->op_truncate was
 	 * set, (2) sets open->op_stateid, (3) sets open->op_delegation.
 	 */
-	status = nfsd4_process_open2(rqstp, current_fh, open);
+	status = nfsd4_process_open2(rqstp, &cstate->current_fh, open);
 out:
 	if (open->op_stateowner) {
 		nfs4_get_stateowner(open->op_stateowner);
@@ -262,52 +265,54 @@ out:
  * filehandle-manipulating ops.
  */
 static inline __be32
-nfsd4_getfh(struct svc_fh *current_fh, struct svc_fh **getfh)
+nfsd4_getfh(struct nfsd4_compound_state *cstate, struct svc_fh **getfh)
 {
-	if (!current_fh->fh_dentry)
+	if (!cstate->current_fh.fh_dentry)
 		return nfserr_nofilehandle;
 
-	*getfh = current_fh;
+	*getfh = &cstate->current_fh;
 	return nfs_ok;
 }
 
 static inline __be32
-nfsd4_putfh(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_putfh *putfh)
+nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct nfsd4_putfh *putfh)
 {
-	fh_put(current_fh);
-	current_fh->fh_handle.fh_size = putfh->pf_fhlen;
-	memcpy(&current_fh->fh_handle.fh_base, putfh->pf_fhval, putfh->pf_fhlen);
-	return fh_verify(rqstp, current_fh, 0, MAY_NOP);
+	fh_put(&cstate->current_fh);
+	cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
+	memcpy(&cstate->current_fh.fh_handle.fh_base, putfh->pf_fhval,
+	       putfh->pf_fhlen);
+	return fh_verify(rqstp, &cstate->current_fh, 0, MAY_NOP);
 }
 
 static inline __be32
-nfsd4_putrootfh(struct svc_rqst *rqstp, struct svc_fh *current_fh)
+nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate)
 {
 	__be32 status;
 
-	fh_put(current_fh);
-	status = exp_pseudoroot(rqstp->rq_client, current_fh,
+	fh_put(&cstate->current_fh);
+	status = exp_pseudoroot(rqstp->rq_client, &cstate->current_fh,
 			      &rqstp->rq_chandle);
 	return status;
 }
 
 static inline __be32
-nfsd4_restorefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
+nfsd4_restorefh(struct nfsd4_compound_state *cstate)
 {
-	if (!save_fh->fh_dentry)
+	if (!cstate->save_fh.fh_dentry)
 		return nfserr_restorefh;
 
-	fh_dup2(current_fh, save_fh);
+	fh_dup2(&cstate->current_fh, &cstate->save_fh);
 	return nfs_ok;
 }
 
 static inline __be32
-nfsd4_savefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
+nfsd4_savefh(struct nfsd4_compound_state *cstate)
 {
-	if (!current_fh->fh_dentry)
+	if (!cstate->current_fh.fh_dentry)
 		return nfserr_nofilehandle;
 
-	fh_dup2(save_fh, current_fh);
+	fh_dup2(&cstate->save_fh, &cstate->current_fh);
 	return nfs_ok;
 }
 
@@ -315,17 +320,20 @@ nfsd4_savefh(struct svc_fh *current_fh, 
  * misc nfsv4 ops
  */
 static inline __be32
-nfsd4_access(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_access *access)
+nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_access *access)
 {
 	if (access->ac_req_access & ~NFS3_ACCESS_FULL)
 		return nfserr_inval;
 
 	access->ac_resp_access = access->ac_req_access;
-	return nfsd_access(rqstp, current_fh, &access->ac_resp_access, &access->ac_supported);
+	return nfsd_access(rqstp, &cstate->current_fh, &access->ac_resp_access,
+			   &access->ac_supported);
 }
 
 static inline __be32
-nfsd4_commit(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_commit *commit)
+nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_commit *commit)
 {
 	__be32 status;
 
@@ -333,14 +341,16 @@ nfsd4_commit(struct svc_rqst *rqstp, str
 	*p++ = nfssvc_boot.tv_sec;
 	*p++ = nfssvc_boot.tv_usec;
 
-	status = nfsd_commit(rqstp, current_fh, commit->co_offset, commit->co_count);
+	status = nfsd_commit(rqstp, &cstate->current_fh, commit->co_offset,
+			     commit->co_count);
 	if (status == nfserr_symlink)
 		status = nfserr_inval;
 	return status;
 }
 
 static __be32
-nfsd4_create(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_create *create)
+nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_create *create)
 {
 	struct svc_fh resfh;
 	__be32 status;
@@ -348,7 +358,7 @@ nfsd4_create(struct svc_rqst *rqstp, str
 
 	fh_init(&resfh, NFS4_FHSIZE);
 
-	status = fh_verify(rqstp, current_fh, S_IFDIR, MAY_CREATE);
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, MAY_CREATE);
 	if (status == nfserr_symlink)
 		status = nfserr_notdir;
 	if (status)
@@ -365,9 +375,10 @@ nfsd4_create(struct svc_rqst *rqstp, str
 		 */
 		create->cr_linkname[create->cr_linklen] = 0;
 
-		status = nfsd_symlink(rqstp, current_fh, create->cr_name,
-				      create->cr_namelen, create->cr_linkname,
-				      create->cr_linklen, &resfh, &create->cr_iattr);
+		status = nfsd_symlink(rqstp, &cstate->current_fh,
+				      create->cr_name, create->cr_namelen,
+				      create->cr_linkname, create->cr_linklen,
+				      &resfh, &create->cr_iattr);
 		break;
 
 	case NF4BLK:
@@ -375,9 +386,9 @@ nfsd4_create(struct svc_rqst *rqstp, str
 		if (MAJOR(rdev) != create->cr_specdata1 ||
 		    MINOR(rdev) != create->cr_specdata2)
 			return nfserr_inval;
-		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr,
-				     S_IFBLK, rdev, &resfh);
+		status = nfsd_create(rqstp, &cstate->current_fh,
+				     create->cr_name, create->cr_namelen,
+				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
 		break;
 
 	case NF4CHR:
@@ -385,28 +396,28 @@ nfsd4_create(struct svc_rqst *rqstp, str
 		if (MAJOR(rdev) != create->cr_specdata1 ||
 		    MINOR(rdev) != create->cr_specdata2)
 			return nfserr_inval;
-		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr,
-				     S_IFCHR, rdev, &resfh);
+		status = nfsd_create(rqstp, &cstate->current_fh,
+				     create->cr_name, create->cr_namelen,
+				     &create->cr_iattr,S_IFCHR, rdev, &resfh);
 		break;
 
 	case NF4SOCK:
-		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr,
-				     S_IFSOCK, 0, &resfh);
+		status = nfsd_create(rqstp, &cstate->current_fh,
+				     create->cr_name, create->cr_namelen,
+				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
 		break;
 
 	case NF4FIFO:
-		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr,
-				     S_IFIFO, 0, &resfh);
+		status = nfsd_create(rqstp, &cstate->current_fh,
+				     create->cr_name, create->cr_namelen,
+				     &create->cr_iattr, S_IFIFO, 0, &resfh);
 		break;
 
 	case NF4DIR:
 		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
-		status = nfsd_create(rqstp, current_fh, create->cr_name,
-				     create->cr_namelen, &create->cr_iattr,
-				     S_IFDIR, 0, &resfh);
+		status = nfsd_create(rqstp, &cstate->current_fh,
+				     create->cr_name, create->cr_namelen,
+				     &create->cr_iattr, S_IFDIR, 0, &resfh);
 		break;
 
 	default:
@@ -414,9 +425,9 @@ nfsd4_create(struct svc_rqst *rqstp, str
 	}
 
 	if (!status) {
-		fh_unlock(current_fh);
-		set_change_info(&create->cr_cinfo, current_fh);
-		fh_dup2(current_fh, &resfh);
+		fh_unlock(&cstate->current_fh);
+		set_change_info(&create->cr_cinfo, &cstate->current_fh);
+		fh_dup2(&cstate->current_fh, &resfh);
 	}
 
 	fh_put(&resfh);
@@ -424,11 +435,12 @@ nfsd4_create(struct svc_rqst *rqstp, str
 }
 
 static inline __be32
-nfsd4_getattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_getattr *getattr)
+nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	      struct nfsd4_getattr *getattr)
 {
 	__be32 status;
 
-	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
+	status = fh_verify(rqstp, &cstate->current_fh, 0, MAY_NOP);
 	if (status)
 		return status;
 
@@ -438,26 +450,27 @@ nfsd4_getattr(struct svc_rqst *rqstp, st
 	getattr->ga_bmval[0] &= NFSD_SUPPORTED_ATTRS_WORD0;
 	getattr->ga_bmval[1] &= NFSD_SUPPORTED_ATTRS_WORD1;
 
-	getattr->ga_fhp = current_fh;
+	getattr->ga_fhp = &cstate->current_fh;
 	return nfs_ok;
 }
 
 static inline __be32
-nfsd4_link(struct svc_rqst *rqstp, struct svc_fh *current_fh,
-	   struct svc_fh *save_fh, struct nfsd4_link *link)
+nfsd4_link(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   struct nfsd4_link *link)
 {
 	__be32 status = nfserr_nofilehandle;
 
-	if (!save_fh->fh_dentry)
+	if (!cstate->save_fh.fh_dentry)
 		return status;
-	status = nfsd_link(rqstp, current_fh, link->li_name, link->li_namelen, save_fh);
+	status = nfsd_link(rqstp, &cstate->current_fh,
+			   link->li_name, link->li_namelen, &cstate->save_fh);
 	if (!status)
-		set_change_info(&link->li_cinfo, current_fh);
+		set_change_info(&link->li_cinfo, &cstate->current_fh);
 	return status;
 }
 
 static __be32
-nfsd4_lookupp(struct svc_rqst *rqstp, struct svc_fh *current_fh)
+nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate)
 {
 	struct svc_fh tmp_fh;
 	__be32 ret;
@@ -466,22 +479,27 @@ nfsd4_lookupp(struct svc_rqst *rqstp, st
 	if((ret = exp_pseudoroot(rqstp->rq_client, &tmp_fh,
 			      &rqstp->rq_chandle)) != 0)
 		return ret;
-	if (tmp_fh.fh_dentry == current_fh->fh_dentry) {
+	if (tmp_fh.fh_dentry == cstate->current_fh.fh_dentry) {
 		fh_put(&tmp_fh);
 		return nfserr_noent;
 	}
 	fh_put(&tmp_fh);
-	return nfsd_lookup(rqstp, current_fh, "..", 2, current_fh);
+	return nfsd_lookup(rqstp, &cstate->current_fh,
+			   "..", 2, &cstate->current_fh);
 }
 
 static inline __be32
-nfsd4_lookup(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lookup *lookup)
+nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_lookup *lookup)
 {
-	return nfsd_lookup(rqstp, current_fh, lookup->lo_name, lookup->lo_len, current_fh);
+	return nfsd_lookup(rqstp, &cstate->current_fh,
+			   lookup->lo_name, lookup->lo_len,
+			   &cstate->current_fh);
 }
 
 static inline __be32
-nfsd4_read(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_read *read)
+nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   struct nfsd4_read *read)
 {
 	__be32 status;
 
@@ -493,7 +511,8 @@ nfsd4_read(struct svc_rqst *rqstp, struc
 
 	nfs4_lock_state();
 	/* check stateid */
-	if ((status = nfs4_preprocess_stateid_op(current_fh, &read->rd_stateid,
+	if ((status = nfs4_preprocess_stateid_op(&cstate->current_fh,
+				&read->rd_stateid,
 				CHECK_FH | RD_STATE, &read->rd_filp))) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -504,12 +523,13 @@ nfsd4_read(struct svc_rqst *rqstp, struc
 out:
 	nfs4_unlock_state();
 	read->rd_rqstp = rqstp;
-	read->rd_fhp = current_fh;
+	read->rd_fhp = &cstate->current_fh;
 	return status;
 }
 
 static inline __be32
-nfsd4_readdir(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readdir *readdir)
+nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	      struct nfsd4_readdir *readdir)
 {
 	u64 cookie = readdir->rd_cookie;
 	static const nfs4_verifier zeroverf;
@@ -527,48 +547,51 @@ nfsd4_readdir(struct svc_rqst *rqstp, st
 		return nfserr_bad_cookie;
 
 	readdir->rd_rqstp = rqstp;
-	readdir->rd_fhp = current_fh;
+	readdir->rd_fhp = &cstate->current_fh;
 	return nfs_ok;
 }
 
 static inline __be32
-nfsd4_readlink(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readlink *readlink)
+nfsd4_readlink(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       struct nfsd4_readlink *readlink)
 {
 	readlink->rl_rqstp = rqstp;
-	readlink->rl_fhp = current_fh;
+	readlink->rl_fhp = &cstate->current_fh;
 	return nfs_ok;
 }
 
 static inline __be32
-nfsd4_remove(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_remove *remove)
+nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_remove *remove)
 {
 	__be32 status;
 
 	if (nfs4_in_grace())
 		return nfserr_grace;
-	status = nfsd_unlink(rqstp, current_fh, 0, remove->rm_name, remove->rm_namelen);
+	status = nfsd_unlink(rqstp, &cstate->current_fh, 0,
+			     remove->rm_name, remove->rm_namelen);
 	if (status == nfserr_symlink)
 		return nfserr_notdir;
 	if (!status) {
-		fh_unlock(current_fh);
-		set_change_info(&remove->rm_cinfo, current_fh);
+		fh_unlock(&cstate->current_fh);
+		set_change_info(&remove->rm_cinfo, &cstate->current_fh);
 	}
 	return status;
 }
 
 static inline __be32
-nfsd4_rename(struct svc_rqst *rqstp, struct svc_fh *current_fh,
-	     struct svc_fh *save_fh, struct nfsd4_rename *rename)
+nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_rename *rename)
 {
 	__be32 status = nfserr_nofilehandle;
 
-	if (!save_fh->fh_dentry)
+	if (!cstate->save_fh.fh_dentry)
 		return status;
-	if (nfs4_in_grace() && !(save_fh->fh_export->ex_flags
+	if (nfs4_in_grace() && !(cstate->save_fh.fh_export->ex_flags
 					& NFSEXP_NOSUBTREECHECK))
 		return nfserr_grace;
-	status = nfsd_rename(rqstp, save_fh, rename->rn_sname,
-			     rename->rn_snamelen, current_fh,
+	status = nfsd_rename(rqstp, &cstate->save_fh, rename->rn_sname,
+			     rename->rn_snamelen, &cstate->current_fh,
 			     rename->rn_tname, rename->rn_tnamelen);
 
 	/* the underlying filesystem returns different error's than required
@@ -576,27 +599,28 @@ nfsd4_rename(struct svc_rqst *rqstp, str
 	if (status == nfserr_isdir)
 		status = nfserr_exist;
 	else if ((status == nfserr_notdir) &&
-                  (S_ISDIR(save_fh->fh_dentry->d_inode->i_mode) &&
-                   S_ISDIR(current_fh->fh_dentry->d_inode->i_mode)))
+                  (S_ISDIR(cstate->save_fh.fh_dentry->d_inode->i_mode) &&
+                   S_ISDIR(cstate->current_fh.fh_dentry->d_inode->i_mode)))
 		status = nfserr_exist;
 	else if (status == nfserr_symlink)
 		status = nfserr_notdir;
 
 	if (!status) {
-		set_change_info(&rename->rn_sinfo, current_fh);
-		set_change_info(&rename->rn_tinfo, save_fh);
+		set_change_info(&rename->rn_sinfo, &cstate->current_fh);
+		set_change_info(&rename->rn_tinfo, &cstate->save_fh);
 	}
 	return status;
 }
 
 static inline __be32
-nfsd4_setattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_setattr *setattr)
+nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	      struct nfsd4_setattr *setattr)
 {
 	__be32 status = nfs_ok;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		nfs4_lock_state();
-		status = nfs4_preprocess_stateid_op(current_fh,
+		status = nfs4_preprocess_stateid_op(&cstate->current_fh,
 			&setattr->sa_stateid, CHECK_FH | WR_STATE, NULL);
 		nfs4_unlock_state();
 		if (status) {
@@ -606,16 +630,18 @@ nfsd4_setattr(struct svc_rqst *rqstp, st
 	}
 	status = nfs_ok;
 	if (setattr->sa_acl != NULL)
-		status = nfsd4_set_nfs4_acl(rqstp, current_fh, setattr->sa_acl);
+		status = nfsd4_set_nfs4_acl(rqstp, &cstate->current_fh,
+					    setattr->sa_acl);
 	if (status)
 		return status;
-	status = nfsd_setattr(rqstp, current_fh, &setattr->sa_iattr,
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
 				0, (time_t)0);
 	return status;
 }
 
 static inline __be32
-nfsd4_write(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_write *write)
+nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct nfsd4_write *write)
 {
 	stateid_t *stateid = &write->wr_stateid;
 	struct file *filp = NULL;
@@ -628,7 +654,7 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 		return nfserr_inval;
 
 	nfs4_lock_state();
-	status = nfs4_preprocess_stateid_op(current_fh, stateid,
+	status = nfs4_preprocess_stateid_op(&cstate->current_fh, stateid,
 					CHECK_FH | WR_STATE, &filp);
 	if (filp)
 		get_file(filp);
@@ -645,9 +671,9 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 	*p++ = nfssvc_boot.tv_sec;
 	*p++ = nfssvc_boot.tv_usec;
 
-	status =  nfsd_write(rqstp, current_fh, filp, write->wr_offset,
-			rqstp->rq_vec, write->wr_vlen, write->wr_buflen,
-			&write->wr_how_written);
+	status =  nfsd_write(rqstp, &cstate->current_fh, filp,
+			     write->wr_offset, rqstp->rq_vec, write->wr_vlen,
+			     write->wr_buflen, &write->wr_how_written);
 	if (filp)
 		fput(filp);
 
@@ -662,13 +688,14 @@ nfsd4_write(struct svc_rqst *rqstp, stru
  * to NFS_OK after the call; NVERIFY by mapping NFSERR_NOT_SAME to NFS_OK.
  */
 static __be32
-nfsd4_verify(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_verify *verify)
+nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_verify *verify)
 {
 	__be32 *buf, *p;
 	int count;
 	__be32 status;
 
-	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
+	status = fh_verify(rqstp, &cstate->current_fh, 0, MAY_NOP);
 	if (status)
 		return status;
 
@@ -689,8 +716,9 @@ nfsd4_verify(struct svc_rqst *rqstp, str
 	if (!buf)
 		return nfserr_resource;
 
-	status = nfsd4_encode_fattr(current_fh, current_fh->fh_export,
-				    current_fh->fh_dentry, buf,
+	status = nfsd4_encode_fattr(&cstate->current_fh,
+				    cstate->current_fh.fh_export,
+				    cstate->current_fh.fh_dentry, buf,
 				    &count, verify->ve_bmval,
 				    rqstp);
 
@@ -727,6 +755,26 @@ static inline void nfsd4_increment_op_st
 		nfsdstats.nfs4_opcount[opnum]++;
 }
 
+static void cstate_free(struct nfsd4_compound_state *cstate)
+{
+	if (cstate == NULL)
+		return;
+	fh_put(&cstate->current_fh);
+	fh_put(&cstate->save_fh);
+	kfree(cstate);
+}
+
+static struct nfsd4_compound_state *cstate_alloc(void)
+{
+	struct nfsd4_compound_state *cstate;
+
+	cstate = kmalloc(sizeof(struct nfsd4_compound_state), GFP_KERNEL);
+	if (cstate == NULL)
+		return NULL;
+	fh_init(&cstate->current_fh, NFS4_FHSIZE);
+	fh_init(&cstate->save_fh, NFS4_FHSIZE);
+	return cstate;
+}
 
 /*
  * COMPOUND call.
@@ -737,21 +785,15 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		    struct nfsd4_compoundres *resp)
 {
 	struct nfsd4_op	*op;
-	struct svc_fh	*current_fh = NULL;
-	struct svc_fh	*save_fh = NULL;
+	struct nfsd4_compound_state *cstate = NULL;
 	struct nfs4_stateowner *replay_owner = NULL;
 	int		slack_bytes;
 	__be32		status;
 
 	status = nfserr_resource;
-	current_fh = kmalloc(sizeof(*current_fh), GFP_KERNEL);
-	if (current_fh == NULL)
-		goto out;
-	fh_init(current_fh, NFS4_FHSIZE);
-	save_fh = kmalloc(sizeof(*save_fh), GFP_KERNEL);
-	if (save_fh == NULL)
+	cstate = cstate_alloc();
+	if (cstate == NULL)
 		goto out;
-	fh_init(save_fh, NFS4_FHSIZE);
 
 	resp->xbuf = &rqstp->rq_res;
 	resp->p = rqstp->rq_res.head[0].iov_base + rqstp->rq_res.head[0].iov_len;
@@ -802,7 +844,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		* SETCLIENTID_CONFIRM, PUTFH and PUTROOTFH
 		* require a valid current filehandle
 		*/
-		if (!current_fh->fh_dentry) {
+		if (!cstate->current_fh.fh_dentry) {
 			if (!((op->opnum == OP_PUTFH) ||
 			      (op->opnum == OP_PUTROOTFH) ||
 			      (op->opnum == OP_SETCLIENTID) ||
@@ -817,7 +859,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		/* Check must be done at start of each operation, except
 		 * for GETATTR and ops not listed as returning NFS4ERR_MOVED
 		 */
-		else if (current_fh->fh_export->ex_fslocs.migrated &&
+		else if (cstate->current_fh.fh_export->ex_fslocs.migrated &&
 			 !((op->opnum == OP_GETATTR) ||
 			   (op->opnum == OP_PUTROOTFH) ||
 			   (op->opnum == OP_PUTPUBFH) ||
@@ -829,90 +871,110 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		}
 		switch (op->opnum) {
 		case OP_ACCESS:
-			op->status = nfsd4_access(rqstp, current_fh, &op->u.access);
+			op->status = nfsd4_access(rqstp, cstate,
+						  &op->u.access);
 			break;
 		case OP_CLOSE:
-			op->status = nfsd4_close(rqstp, current_fh, &op->u.close, &replay_owner);
+			op->status = nfsd4_close(rqstp, cstate,
+						 &op->u.close, &replay_owner);
 			break;
 		case OP_COMMIT:
-			op->status = nfsd4_commit(rqstp, current_fh, &op->u.commit);
+			op->status = nfsd4_commit(rqstp, cstate,
+						  &op->u.commit);
 			break;
 		case OP_CREATE:
-			op->status = nfsd4_create(rqstp, current_fh, &op->u.create);
+			op->status = nfsd4_create(rqstp, cstate,
+						  &op->u.create);
 			break;
 		case OP_DELEGRETURN:
-			op->status = nfsd4_delegreturn(rqstp, current_fh, &op->u.delegreturn);
+			op->status = nfsd4_delegreturn(rqstp, cstate,
+						       &op->u.delegreturn);
 			break;
 		case OP_GETATTR:
-			op->status = nfsd4_getattr(rqstp, current_fh, &op->u.getattr);
+			op->status = nfsd4_getattr(rqstp, cstate,
+						   &op->u.getattr);
 			break;
 		case OP_GETFH:
-			op->status = nfsd4_getfh(current_fh, &op->u.getfh);
+			op->status = nfsd4_getfh(cstate, &op->u.getfh);
 			break;
 		case OP_LINK:
-			op->status = nfsd4_link(rqstp, current_fh, save_fh, &op->u.link);
+			op->status = nfsd4_link(rqstp, cstate, &op->u.link);
 			break;
 		case OP_LOCK:
-			op->status = nfsd4_lock(rqstp, current_fh, &op->u.lock, &replay_owner);
+			op->status = nfsd4_lock(rqstp, cstate, &op->u.lock,
+						&replay_owner);
 			break;
 		case OP_LOCKT:
-			op->status = nfsd4_lockt(rqstp, current_fh, &op->u.lockt);
+			op->status = nfsd4_lockt(rqstp, cstate, &op->u.lockt);
 			break;
 		case OP_LOCKU:
-			op->status = nfsd4_locku(rqstp, current_fh, &op->u.locku, &replay_owner);
+			op->status = nfsd4_locku(rqstp, cstate, &op->u.locku,
+						 &replay_owner);
 			break;
 		case OP_LOOKUP:
-			op->status = nfsd4_lookup(rqstp, current_fh, &op->u.lookup);
+			op->status = nfsd4_lookup(rqstp, cstate,
+						  &op->u.lookup);
 			break;
 		case OP_LOOKUPP:
-			op->status = nfsd4_lookupp(rqstp, current_fh);
+			op->status = nfsd4_lookupp(rqstp, cstate);
 			break;
 		case OP_NVERIFY:
-			op->status = nfsd4_verify(rqstp, current_fh, &op->u.nverify);
+			op->status = nfsd4_verify(rqstp, cstate,
+						  &op->u.nverify);
 			if (op->status == nfserr_not_same)
 				op->status = nfs_ok;
 			break;
 		case OP_OPEN:
-			op->status = nfsd4_open(rqstp, current_fh, &op->u.open, &replay_owner);
+			op->status = nfsd4_open(rqstp, cstate,
+						&op->u.open, &replay_owner);
 			break;
 		case OP_OPEN_CONFIRM:
-			op->status = nfsd4_open_confirm(rqstp, current_fh, &op->u.open_confirm, &replay_owner);
+			op->status = nfsd4_open_confirm(rqstp, cstate,
+							&op->u.open_confirm,
+							&replay_owner);
 			break;
 		case OP_OPEN_DOWNGRADE:
-			op->status = nfsd4_open_downgrade(rqstp, current_fh, &op->u.open_downgrade, &replay_owner);
+			op->status = nfsd4_open_downgrade(rqstp, cstate,
+							 &op->u.open_downgrade,
+							 &replay_owner);
 			break;
 		case OP_PUTFH:
-			op->status = nfsd4_putfh(rqstp, current_fh, &op->u.putfh);
+			op->status = nfsd4_putfh(rqstp, cstate, &op->u.putfh);
 			break;
 		case OP_PUTROOTFH:
-			op->status = nfsd4_putrootfh(rqstp, current_fh);
+			op->status = nfsd4_putrootfh(rqstp, cstate);
 			break;
 		case OP_READ:
-			op->status = nfsd4_read(rqstp, current_fh, &op->u.read);
+			op->status = nfsd4_read(rqstp, cstate, &op->u.read);
 			break;
 		case OP_READDIR:
-			op->status = nfsd4_readdir(rqstp, current_fh, &op->u.readdir);
+			op->status = nfsd4_readdir(rqstp, cstate,
+						   &op->u.readdir);
 			break;
 		case OP_READLINK:
-			op->status = nfsd4_readlink(rqstp, current_fh, &op->u.readlink);
+			op->status = nfsd4_readlink(rqstp, cstate,
+						    &op->u.readlink);
 			break;
 		case OP_REMOVE:
-			op->status = nfsd4_remove(rqstp, current_fh, &op->u.remove);
+			op->status = nfsd4_remove(rqstp, cstate,
+						  &op->u.remove);
 			break;
 		case OP_RENAME:
-			op->status = nfsd4_rename(rqstp, current_fh, save_fh, &op->u.rename);
+			op->status = nfsd4_rename(rqstp, cstate,
+						  &op->u.rename);
 			break;
 		case OP_RENEW:
 			op->status = nfsd4_renew(&op->u.renew);
 			break;
 		case OP_RESTOREFH:
-			op->status = nfsd4_restorefh(current_fh, save_fh);
+			op->status = nfsd4_restorefh(cstate);
 			break;
 		case OP_SAVEFH:
-			op->status = nfsd4_savefh(current_fh, save_fh);
+			op->status = nfsd4_savefh(cstate);
 			break;
 		case OP_SETATTR:
-			op->status = nfsd4_setattr(rqstp, current_fh, &op->u.setattr);
+			op->status = nfsd4_setattr(rqstp, cstate,
+						   &op->u.setattr);
 			break;
 		case OP_SETCLIENTID:
 			op->status = nfsd4_setclientid(rqstp, &op->u.setclientid);
@@ -921,12 +983,13 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 			op->status = nfsd4_setclientid_confirm(rqstp, &op->u.setclientid_confirm);
 			break;
 		case OP_VERIFY:
-			op->status = nfsd4_verify(rqstp, current_fh, &op->u.verify);
+			op->status = nfsd4_verify(rqstp, cstate,
+						  &op->u.verify);
 			if (op->status == nfserr_same)
 				op->status = nfs_ok;
 			break;
 		case OP_WRITE:
-			op->status = nfsd4_write(rqstp, current_fh, &op->u.write);
+			op->status = nfsd4_write(rqstp, cstate, &op->u.write);
 			break;
 		case OP_RELEASE_LOCKOWNER:
 			op->status = nfsd4_release_lockowner(rqstp, &op->u.release_lockowner);
@@ -958,12 +1021,7 @@ encode_op:
 
 out:
 	nfsd4_release_compoundargs(args);
-	if (current_fh)
-		fh_put(current_fh);
-	kfree(current_fh);
-	if (save_fh)
-		fh_put(save_fh);
-	kfree(save_fh);
+	cstate_free(cstate);
 	return status;
 }
 

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-12-08 12:07:57.000000000 +1100
+++ ./fs/nfsd/nfs4state.c	2006-12-08 12:09:27.000000000 +1100
@@ -2242,24 +2242,26 @@ check_replay:
 }
 
 __be32
-nfsd4_open_confirm(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open_confirm *oc, struct nfs4_stateowner **replay_owner)
+nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		   struct nfsd4_open_confirm *oc,
+		   struct nfs4_stateowner **replay_owner)
 {
 	__be32 status;
 	struct nfs4_stateowner *sop;
 	struct nfs4_stateid *stp;
 
 	dprintk("NFSD: nfsd4_open_confirm on file %.*s\n",
-			(int)current_fh->fh_dentry->d_name.len,
-			current_fh->fh_dentry->d_name.name);
+			(int)cstate->current_fh.fh_dentry->d_name.len,
+			cstate->current_fh.fh_dentry->d_name.name);
 
-	status = fh_verify(rqstp, current_fh, S_IFREG, 0);
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
 	if (status)
 		return status;
 
 	nfs4_lock_state();
 
-	if ((status = nfs4_preprocess_seqid_op(current_fh, oc->oc_seqid,
-					&oc->oc_req_stateid,
+	if ((status = nfs4_preprocess_seqid_op(&cstate->current_fh,
+					oc->oc_seqid, &oc->oc_req_stateid,
 					CHECK_FH | CONFIRM | OPEN_STATE,
 					&oc->oc_stateowner, &stp, NULL)))
 		goto out; 
@@ -2311,22 +2313,26 @@ reset_union_bmap_deny(unsigned long deny
 }
 
 __be32
-nfsd4_open_downgrade(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open_downgrade *od, struct nfs4_stateowner **replay_owner)
+nfsd4_open_downgrade(struct svc_rqst *rqstp,
+		     struct nfsd4_compound_state *cstate,
+		     struct nfsd4_open_downgrade *od,
+		     struct nfs4_stateowner **replay_owner)
 {
 	__be32 status;
 	struct nfs4_stateid *stp;
 	unsigned int share_access;
 
 	dprintk("NFSD: nfsd4_open_downgrade on file %.*s\n", 
-			(int)current_fh->fh_dentry->d_name.len,
-			current_fh->fh_dentry->d_name.name);
+			(int)cstate->current_fh.fh_dentry->d_name.len,
+			cstate->current_fh.fh_dentry->d_name.name);
 
 	if (!access_valid(od->od_share_access)
 			|| !deny_valid(od->od_share_deny))
 		return nfserr_inval;
 
 	nfs4_lock_state();
-	if ((status = nfs4_preprocess_seqid_op(current_fh, od->od_seqid, 
+	if ((status = nfs4_preprocess_seqid_op(&cstate->current_fh,
+					od->od_seqid,
 					&od->od_stateid, 
 					CHECK_FH | OPEN_STATE, 
 					&od->od_stateowner, &stp, NULL)))
@@ -2366,18 +2372,20 @@ out:
  * nfs4_unlock_state() called after encode
  */
 __be32
-nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_close *close, struct nfs4_stateowner **replay_owner)
+nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct nfsd4_close *close, struct nfs4_stateowner **replay_owner)
 {
 	__be32 status;
 	struct nfs4_stateid *stp;
 
 	dprintk("NFSD: nfsd4_close on file %.*s\n", 
-			(int)current_fh->fh_dentry->d_name.len,
-			current_fh->fh_dentry->d_name.name);
+			(int)cstate->current_fh.fh_dentry->d_name.len,
+			cstate->current_fh.fh_dentry->d_name.name);
 
 	nfs4_lock_state();
 	/* check close_lru for replay */
-	if ((status = nfs4_preprocess_seqid_op(current_fh, close->cl_seqid, 
+	if ((status = nfs4_preprocess_seqid_op(&cstate->current_fh,
+					close->cl_seqid,
 					&close->cl_stateid, 
 					CHECK_FH | OPEN_STATE | CLOSE_STATE,
 					&close->cl_stateowner, &stp, NULL)))
@@ -2405,15 +2413,17 @@ out:
 }
 
 __be32
-nfsd4_delegreturn(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_delegreturn *dr)
+nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		  struct nfsd4_delegreturn *dr)
 {
 	__be32 status;
 
-	if ((status = fh_verify(rqstp, current_fh, S_IFREG, 0)))
+	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		goto out;
 
 	nfs4_lock_state();
-	status = nfs4_preprocess_stateid_op(current_fh, &dr->dr_stateid, DELEG_RET, NULL);
+	status = nfs4_preprocess_stateid_op(&cstate->current_fh,
+					    &dr->dr_stateid, DELEG_RET, NULL);
 	nfs4_unlock_state();
 out:
 	return status;
@@ -2636,7 +2646,8 @@ check_lock_length(u64 offset, u64 length
  *  LOCK operation 
  */
 __be32
-nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lock *lock, struct nfs4_stateowner **replay_owner)
+nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   struct nfsd4_lock *lock, struct nfs4_stateowner **replay_owner)
 {
 	struct nfs4_stateowner *open_sop = NULL;
 	struct nfs4_stateowner *lock_sop = NULL;
@@ -2655,7 +2666,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
 
-	if ((status = fh_verify(rqstp, current_fh, S_IFREG, MAY_LOCK))) {
+	if ((status = fh_verify(rqstp, &cstate->current_fh,
+				S_IFREG, MAY_LOCK))) {
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
@@ -2676,7 +2688,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 			goto out;
 
 		/* validate and update open stateid and open seqid */
-		status = nfs4_preprocess_seqid_op(current_fh, 
+		status = nfs4_preprocess_seqid_op(&cstate->current_fh,
 				        lock->lk_new_open_seqid,
 		                        &lock->lk_new_open_stateid,
 		                        CHECK_FH | OPEN_STATE,
@@ -2703,7 +2715,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 			goto out;
 	} else {
 		/* lock (lock owner + lock stateid) already exists */
-		status = nfs4_preprocess_seqid_op(current_fh,
+		status = nfs4_preprocess_seqid_op(&cstate->current_fh,
 				       lock->lk_old_lock_seqid, 
 				       &lock->lk_old_lock_stateid, 
 				       CHECK_FH | LOCK_STATE, 
@@ -2795,7 +2807,8 @@ out:
  * LOCKT operation
  */
 __be32
-nfsd4_lockt(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lockt *lockt)
+nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct nfsd4_lockt *lockt)
 {
 	struct inode *inode;
 	struct file file;
@@ -2816,14 +2829,14 @@ nfsd4_lockt(struct svc_rqst *rqstp, stru
 	if (STALE_CLIENTID(&lockt->lt_clientid))
 		goto out;
 
-	if ((status = fh_verify(rqstp, current_fh, S_IFREG, 0))) {
+	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0))) {
 		dprintk("NFSD: nfsd4_lockt: fh_verify() failed!\n");
 		if (status == nfserr_symlink)
 			status = nfserr_inval;
 		goto out;
 	}
 
-	inode = current_fh->fh_dentry->d_inode;
+	inode = cstate->current_fh.fh_dentry->d_inode;
 	locks_init_lock(&file_lock);
 	switch (lockt->lt_type) {
 		case NFS4_READ_LT:
@@ -2862,7 +2875,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, stru
 	 * only the dentry:inode set.
 	 */
 	memset(&file, 0, sizeof (struct file));
-	file.f_path.dentry = current_fh->fh_dentry;
+	file.f_path.dentry = cstate->current_fh.fh_dentry;
 
 	status = nfs_ok;
 	if (posix_test_lock(&file, &file_lock, &conflock)) {
@@ -2875,7 +2888,8 @@ out:
 }
 
 __be32
-nfsd4_locku(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_locku *locku, struct nfs4_stateowner **replay_owner)
+nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct nfsd4_locku *locku, struct nfs4_stateowner **replay_owner)
 {
 	struct nfs4_stateid *stp;
 	struct file *filp = NULL;
@@ -2892,7 +2906,7 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 
 	nfs4_lock_state();
 									        
-	if ((status = nfs4_preprocess_seqid_op(current_fh, 
+	if ((status = nfs4_preprocess_seqid_op(&cstate->current_fh,
 					locku->lu_seqid, 
 					&locku->lu_stateid, 
 					CHECK_FH | LOCK_STATE, 

diff .prev/include/linux/nfsd/xdr4.h ./include/linux/nfsd/xdr4.h
--- .prev/include/linux/nfsd/xdr4.h	2006-12-08 12:07:22.000000000 +1100
+++ ./include/linux/nfsd/xdr4.h	2006-12-08 12:09:27.000000000 +1100
@@ -44,6 +44,11 @@
 #define NFSD4_MAX_TAGLEN	128
 #define XDR_LEN(n)                     (((n) + 3) & ~3)
 
+struct nfsd4_compound_state {
+	struct svc_fh current_fh;
+	struct svc_fh save_fh;
+};
+
 struct nfsd4_change_info {
 	u32		atomic;
 	u32		before_ctime_sec;
@@ -437,20 +442,23 @@ extern __be32 nfsd4_process_open1(struct
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
 		struct svc_fh *current_fh, struct nfsd4_open *open);
 extern __be32 nfsd4_open_confirm(struct svc_rqst *rqstp,
-		struct svc_fh *current_fh, struct nfsd4_open_confirm *oc,
+		struct nfsd4_compound_state *, struct nfsd4_open_confirm *oc,
 		struct nfs4_stateowner **);
-extern __be32 nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+extern __be32 nfsd4_close(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_close *close,
 		struct nfs4_stateowner **replay_owner);
 extern __be32 nfsd4_open_downgrade(struct svc_rqst *rqstp,
-		struct svc_fh *current_fh, struct nfsd4_open_downgrade *od,
+		struct nfsd4_compound_state *, struct nfsd4_open_downgrade *od,
 		struct nfs4_stateowner **replay_owner);
-extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
 		struct nfsd4_lock *lock,
 		struct nfs4_stateowner **replay_owner);
-extern __be32 nfsd4_lockt(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+extern __be32 nfsd4_lockt(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_lockt *lockt);
-extern __be32 nfsd4_locku(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+extern __be32 nfsd4_locku(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_locku *locku,
 		struct nfs4_stateowner **replay_owner);
 extern __be32
@@ -458,7 +466,7 @@ nfsd4_release_lockowner(struct svc_rqst 
 		struct nfsd4_release_lockowner *rlockowner);
 extern void nfsd4_release_compoundargs(struct nfsd4_compoundargs *);
 extern __be32 nfsd4_delegreturn(struct svc_rqst *rqstp,
-		struct svc_fh *current_fh, struct nfsd4_delegreturn *dr);
+		struct nfsd4_compound_state *, struct nfsd4_delegreturn *dr);
 #endif
 
 /*
