Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWJJDPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWJJDPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWJJDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:14:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32941 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964927AbWJJDNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:52 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] nfsd: nfs4 code returns error values in net-endian
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83z-0004Gz-Ai@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4proc.c         |   83 ++++++++++++------------
 fs/nfsd/nfs4recover.c      |   14 ++--
 fs/nfsd/nfs4state.c        |   96 ++++++++++++++--------------
 fs/nfsd/nfs4xdr.c          |  150 ++++++++++++++++++++++----------------------
 include/linux/nfsd/state.h |   10 +--
 include/linux/nfsd/xdr4.h  |   30 ++++-----
 6 files changed, 192 insertions(+), 191 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d0a8ee2..9f403a6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -67,10 +67,11 @@ fh_dup2(struct svc_fh *dst, struct svc_f
 	*dst = *src;
 }
 
-static int
+static __be32
 do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {
-	int accmode, status;
+	int accmode;
+	__be32 status;
 
 	if (open->op_truncate &&
 		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
@@ -88,11 +89,11 @@ do_open_permission(struct svc_rqst *rqst
 	return status;
 }
 
-static int
+static __be32
 do_open_lookup(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {
 	struct svc_fh resfh;
-	int status;
+	__be32 status;
 
 	fh_init(&resfh, NFS4_FHSIZE);
 	open->op_truncate = 0;
@@ -131,10 +132,10 @@ do_open_lookup(struct svc_rqst *rqstp, s
 	return status;
 }
 
-static int
+static __be32
 do_open_fhandle(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {
-	int status;
+	__be32 status;
 
 	/* Only reclaims from previously confirmed clients are valid */
 	if ((status = nfs4_check_open_reclaim(&open->op_clientid)))
@@ -161,10 +162,10 @@ do_open_fhandle(struct svc_rqst *rqstp, 
 }
 
 
-static inline int
+static inline __be32
 nfsd4_open(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, struct nfs4_stateowner **replay_owner)
 {
-	int status;
+	__be32 status;
 	dprintk("NFSD: nfsd4_open filename %.*s op_stateowner %p\n",
 		(int)open->op_fname.len, open->op_fname.data,
 		open->op_stateowner);
@@ -261,7 +262,7 @@ out:
 /*
  * filehandle-manipulating ops.
  */
-static inline int
+static inline __be32
 nfsd4_getfh(struct svc_fh *current_fh, struct svc_fh **getfh)
 {
 	if (!current_fh->fh_dentry)
@@ -271,7 +272,7 @@ nfsd4_getfh(struct svc_fh *current_fh, s
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfsd4_putfh(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_putfh *putfh)
 {
 	fh_put(current_fh);
@@ -280,10 +281,10 @@ nfsd4_putfh(struct svc_rqst *rqstp, stru
 	return fh_verify(rqstp, current_fh, 0, MAY_NOP);
 }
 
-static inline int
+static inline __be32
 nfsd4_putrootfh(struct svc_rqst *rqstp, struct svc_fh *current_fh)
 {
-	int status;
+	__be32 status;
 
 	fh_put(current_fh);
 	status = exp_pseudoroot(rqstp->rq_client, current_fh,
@@ -291,7 +292,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, 
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_restorefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
 {
 	if (!save_fh->fh_dentry)
@@ -301,7 +302,7 @@ nfsd4_restorefh(struct svc_fh *current_f
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfsd4_savefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
 {
 	if (!current_fh->fh_dentry)
@@ -314,7 +315,7 @@ nfsd4_savefh(struct svc_fh *current_fh, 
 /*
  * misc nfsv4 ops
  */
-static inline int
+static inline __be32
 nfsd4_access(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_access *access)
 {
 	if (access->ac_req_access & ~NFS3_ACCESS_FULL)
@@ -324,10 +325,10 @@ nfsd4_access(struct svc_rqst *rqstp, str
 	return nfsd_access(rqstp, current_fh, &access->ac_resp_access, &access->ac_supported);
 }
 
-static inline int
+static inline __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_commit *commit)
 {
-	int status;
+	__be32 status;
 
 	u32 *p = (u32 *)commit->co_verf.data;
 	*p++ = nfssvc_boot.tv_sec;
@@ -339,11 +340,11 @@ nfsd4_commit(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static int
+static __be32
 nfsd4_create(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_create *create)
 {
 	struct svc_fh resfh;
-	int status;
+	__be32 status;
 	dev_t rdev;
 
 	fh_init(&resfh, NFS4_FHSIZE);
@@ -423,10 +424,10 @@ nfsd4_create(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_getattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_getattr *getattr)
 {
-	int status;
+	__be32 status;
 
 	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
 	if (status)
@@ -442,11 +443,11 @@ nfsd4_getattr(struct svc_rqst *rqstp, st
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfsd4_link(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 	   struct svc_fh *save_fh, struct nfsd4_link *link)
 {
-	int status = nfserr_nofilehandle;
+	__be32 status = nfserr_nofilehandle;
 
 	if (!save_fh->fh_dentry)
 		return status;
@@ -456,11 +457,11 @@ nfsd4_link(struct svc_rqst *rqstp, struc
 	return status;
 }
 
-static int
+static __be32
 nfsd4_lookupp(struct svc_rqst *rqstp, struct svc_fh *current_fh)
 {
 	struct svc_fh tmp_fh;
-	int ret;
+	__be32 ret;
 
 	fh_init(&tmp_fh, NFS4_FHSIZE);
 	if((ret = exp_pseudoroot(rqstp->rq_client, &tmp_fh,
@@ -474,16 +475,16 @@ nfsd4_lookupp(struct svc_rqst *rqstp, st
 	return nfsd_lookup(rqstp, current_fh, "..", 2, current_fh);
 }
 
-static inline int
+static inline __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lookup *lookup)
 {
 	return nfsd_lookup(rqstp, current_fh, lookup->lo_name, lookup->lo_len, current_fh);
 }
 
-static inline int
+static inline __be32
 nfsd4_read(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_read *read)
 {
-	int status;
+	__be32 status;
 
 	/* no need to check permission - this will be done in nfsd_read() */
 
@@ -508,7 +509,7 @@ out:
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_readdir(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readdir *readdir)
 {
 	u64 cookie = readdir->rd_cookie;
@@ -531,7 +532,7 @@ nfsd4_readdir(struct svc_rqst *rqstp, st
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfsd4_readlink(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readlink *readlink)
 {
 	readlink->rl_rqstp = rqstp;
@@ -539,10 +540,10 @@ nfsd4_readlink(struct svc_rqst *rqstp, s
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfsd4_remove(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_remove *remove)
 {
-	int status;
+	__be32 status;
 
 	if (nfs4_in_grace())
 		return nfserr_grace;
@@ -556,11 +557,11 @@ nfsd4_remove(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_rename(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 	     struct svc_fh *save_fh, struct nfsd4_rename *rename)
 {
-	int status = nfserr_nofilehandle;
+	__be32 status = nfserr_nofilehandle;
 
 	if (!save_fh->fh_dentry)
 		return status;
@@ -589,10 +590,10 @@ nfsd4_rename(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_setattr *setattr)
 {
-	int status = nfs_ok;
+	__be32 status = nfs_ok;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		nfs4_lock_state();
@@ -614,13 +615,13 @@ nfsd4_setattr(struct svc_rqst *rqstp, st
 	return status;
 }
 
-static inline int
+static inline __be32
 nfsd4_write(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_write *write)
 {
 	stateid_t *stateid = &write->wr_stateid;
 	struct file *filp = NULL;
 	u32 *p;
-	int status = nfs_ok;
+	__be32 status = nfs_ok;
 
 	/* no need to check permission - this will be done in nfsd_write() */
 
@@ -661,12 +662,12 @@ nfsd4_write(struct svc_rqst *rqstp, stru
  * attributes matched.  VERIFY is implemented by mapping NFSERR_SAME
  * to NFS_OK after the call; NVERIFY by mapping NFSERR_NOT_SAME to NFS_OK.
  */
-static int
+static __be32
 nfsd4_verify(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_verify *verify)
 {
 	__be32 *buf, *p;
 	int count;
-	int status;
+	__be32 status;
 
 	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
 	if (status)
@@ -741,7 +742,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 	struct svc_fh	*save_fh = NULL;
 	struct nfs4_stateowner *replay_owner = NULL;
 	int		slack_space;    /* in words, not bytes! */
-	int		status;
+	__be32		status;
 
 	status = nfserr_resource;
 	current_fh = kmalloc(sizeof(*current_fh), GFP_KERNEL);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 1cbd2e4..e9d0770 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -83,13 +83,13 @@ md5_to_hex(char *out, char *md5)
 	*out = '\0';
 }
 
-int
+__be32
 nfs4_make_rec_clidname(char *dname, struct xdr_netobj *clname)
 {
 	struct xdr_netobj cksum;
 	struct hash_desc desc;
 	struct scatterlist sg[1];
-	int status = nfserr_resource;
+	__be32 status = nfserr_resource;
 
 	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
 			clname->len, clname->data);
@@ -193,7 +193,7 @@ nfsd4_build_dentrylist(void *arg, const 
 	struct dentry_list *child;
 
 	if (name && isdotent(name, namlen))
-		return nfs_ok;
+		return 0;
 	dentry = lookup_one_len(name, parent, namlen);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
@@ -333,14 +333,14 @@ purge_old(struct dentry *parent, struct 
 	int status;
 
 	if (nfs4_has_reclaimed_state(child->d_name.name))
-		return nfs_ok;
+		return 0;
 
 	status = nfsd4_clear_clid_dir(parent, child);
 	if (status)
 		printk("failed to remove client recovery directory %s\n",
 				child->d_name.name);
 	/* Keep trying, success or failure: */
-	return nfs_ok;
+	return 0;
 }
 
 void
@@ -365,10 +365,10 @@ load_recdir(struct dentry *parent, struc
 		printk("nfsd4: illegal name %s in recovery directory\n",
 				child->d_name.name);
 		/* Keep trying; maybe the others are OK: */
-		return nfs_ok;
+		return 0;
 	}
 	nfs4_client_to_reclaim(child->d_name.name);
-	return nfs_ok;
+	return 0;
 }
 
 int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ebcf226..e5ca6d7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -710,7 +710,7 @@ out_err:
  *		as described above.
  *
  */
-int
+__be32
 nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_setclientid *setclid)
 {
 	u32 			ip_addr = rqstp->rq_addr.sin_addr.s_addr;
@@ -721,7 +721,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 	nfs4_verifier		clverifier = setclid->se_verf;
 	unsigned int 		strhashval;
 	struct nfs4_client	*conf, *unconf, *new;
-	int 			status;
+	__be32 			status;
 	char                    dname[HEXDIR_LEN];
 	
 	if (!check_name(clname))
@@ -875,14 +875,14 @@ out:
  *
  * NOTE: callback information will be processed here in a future patch
  */
-int
+__be32
 nfsd4_setclientid_confirm(struct svc_rqst *rqstp, struct nfsd4_setclientid_confirm *setclientid_confirm)
 {
 	u32 ip_addr = rqstp->rq_addr.sin_addr.s_addr;
 	struct nfs4_client *conf, *unconf;
 	nfs4_verifier confirm = setclientid_confirm->sc_confirm; 
 	clientid_t * clid = &setclientid_confirm->sc_clientid;
-	int status;
+	__be32 status;
 
 	if (STALE_CLIENTID(clid))
 		return nfserr_stale_clientid;
@@ -1280,13 +1280,13 @@ test_share(struct nfs4_stateid *stp, str
  * Called to check deny when READ with all zero stateid or
  * WRITE with all zero or all one stateid
  */
-static int
+static __be32
 nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 {
 	struct inode *ino = current_fh->fh_dentry->d_inode;
 	struct nfs4_file *fp;
 	struct nfs4_stateid *stp;
-	int ret;
+	__be32 ret;
 
 	dprintk("NFSD: nfs4_share_conflict\n");
 
@@ -1444,7 +1444,7 @@ static struct lock_manager_operations nf
 };
 
 
-int
+__be32
 nfsd4_process_open1(struct nfsd4_open *open)
 {
 	clientid_t *clientid = &open->op_clientid;
@@ -1501,7 +1501,7 @@ renew:
 	return nfs_ok;
 }
 
-static inline int
+static inline __be32
 nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
 {
 	if ((flags & WR_STATE) && (dp->dl_type == NFS4_OPEN_DELEGATE_READ))
@@ -1522,12 +1522,12 @@ find_delegation_file(struct nfs4_file *f
 	return NULL;
 }
 
-static int
+static __be32
 nfs4_check_deleg(struct nfs4_file *fp, struct nfsd4_open *open,
 		struct nfs4_delegation **dp)
 {
 	int flags;
-	int status = nfserr_bad_stateid;
+	__be32 status = nfserr_bad_stateid;
 
 	*dp = find_delegation_file(fp, &open->op_delegate_stateid);
 	if (*dp == NULL)
@@ -1546,11 +1546,11 @@ out:
 	return nfs_ok;
 }
 
-static int
+static __be32
 nfs4_check_open(struct nfs4_file *fp, struct nfsd4_open *open, struct nfs4_stateid **stpp)
 {
 	struct nfs4_stateid *local;
-	int status = nfserr_share_denied;
+	__be32 status = nfserr_share_denied;
 	struct nfs4_stateowner *sop = open->op_stateowner;
 
 	list_for_each_entry(local, &fp->fi_stateids, st_perfile) {
@@ -1575,7 +1575,7 @@ nfs4_alloc_stateid(void)
 	return kmem_cache_alloc(stateid_slab, GFP_KERNEL);
 }
 
-static int
+static __be32
 nfs4_new_open(struct svc_rqst *rqstp, struct nfs4_stateid **stpp,
 		struct nfs4_delegation *dp,
 		struct svc_fh *cur_fh, int flags)
@@ -1590,7 +1590,7 @@ nfs4_new_open(struct svc_rqst *rqstp, st
 		get_file(dp->dl_vfs_file);
 		stp->st_vfs_file = dp->dl_vfs_file;
 	} else {
-		int status;
+		__be32 status;
 		status = nfsd_open(rqstp, cur_fh, S_IFREG, flags,
 				&stp->st_vfs_file);
 		if (status) {
@@ -1604,7 +1604,7 @@ nfs4_new_open(struct svc_rqst *rqstp, st
 	return 0;
 }
 
-static inline int
+static inline __be32
 nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		struct nfsd4_open *open)
 {
@@ -1619,22 +1619,22 @@ nfsd4_truncate(struct svc_rqst *rqstp, s
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time_t)0);
 }
 
-static int
+static __be32
 nfs4_upgrade_open(struct svc_rqst *rqstp, struct svc_fh *cur_fh, struct nfs4_stateid *stp, struct nfsd4_open *open)
 {
 	struct file *filp = stp->st_vfs_file;
 	struct inode *inode = filp->f_dentry->d_inode;
 	unsigned int share_access, new_writer;
-	int status;
+	__be32 status;
 
 	set_access(&share_access, stp->st_access_bmap);
 	new_writer = (~share_access) & open->op_share_access
 			& NFS4_SHARE_ACCESS_WRITE;
 
 	if (new_writer) {
-		status = get_write_access(inode);
-		if (status)
-			return nfserrno(status);
+		int err = get_write_access(inode);
+		if (err)
+			return nfserrno(err);
 	}
 	status = nfsd4_truncate(rqstp, cur_fh, open);
 	if (status) {
@@ -1738,14 +1738,14 @@ out:
 /*
  * called with nfs4_lock_state() held.
  */
-int
+__be32
 nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {
 	struct nfs4_file *fp = NULL;
 	struct inode *ino = current_fh->fh_dentry->d_inode;
 	struct nfs4_stateid *stp = NULL;
 	struct nfs4_delegation *dp = NULL;
-	int status;
+	__be32 status;
 
 	status = nfserr_inval;
 	if (!access_valid(open->op_share_access)
@@ -1833,11 +1833,11 @@ static struct work_struct laundromat_wor
 static void laundromat_main(void *);
 static DECLARE_WORK(laundromat_work, laundromat_main, NULL);
 
-int 
+__be32
 nfsd4_renew(clientid_t *clid)
 {
 	struct nfs4_client *clp;
-	int status;
+	__be32 status;
 
 	nfs4_lock_state();
 	dprintk("process_renew(%08x/%08x): starting\n", 
@@ -1996,9 +1996,9 @@ access_permit_write(unsigned long access
 }
 
 static
-int nfs4_check_openmode(struct nfs4_stateid *stp, int flags)
+__be32 nfs4_check_openmode(struct nfs4_stateid *stp, int flags)
 {
-        int status = nfserr_openmode;
+        __be32 status = nfserr_openmode;
 
 	if ((flags & WR_STATE) && (!access_permit_write(stp->st_access_bmap)))
                 goto out;
@@ -2009,7 +2009,7 @@ out:
 	return status;
 }
 
-static inline int
+static inline __be32
 check_special_stateids(svc_fh *current_fh, stateid_t *stateid, int flags)
 {
 	/* Trying to call delegreturn with a special stateid? Yuch: */
@@ -2043,14 +2043,14 @@ io_during_grace_disallowed(struct inode 
 /*
 * Checks for stateid operations
 */
-int
+__be32
 nfs4_preprocess_stateid_op(struct svc_fh *current_fh, stateid_t *stateid, int flags, struct file **filpp)
 {
 	struct nfs4_stateid *stp = NULL;
 	struct nfs4_delegation *dp = NULL;
 	stateid_t *stidp;
 	struct inode *ino = current_fh->fh_dentry->d_inode;
-	int status;
+	__be32 status;
 
 	dprintk("NFSD: preprocess_stateid_op: stateid = (%08x/%08x/%08x/%08x)\n",
 		stateid->si_boot, stateid->si_stateownerid, 
@@ -2125,7 +2125,7 @@ setlkflg (int type)
 /* 
  * Checks for sequence id mutating operations. 
  */
-static int
+static __be32
 nfs4_preprocess_seqid_op(struct svc_fh *current_fh, u32 seqid, stateid_t *stateid, int flags, struct nfs4_stateowner **sopp, struct nfs4_stateid **stpp, struct nfsd4_lock *lock)
 {
 	struct nfs4_stateid *stp;
@@ -2169,7 +2169,7 @@ nfs4_preprocess_seqid_op(struct svc_fh *
 		clientid_t *lockclid = &lock->v.new.clientid;
 		struct nfs4_client *clp = sop->so_client;
 		int lkflg = 0;
-		int status;
+		__be32 status;
 
 		lkflg = setlkflg(lock->lk_type);
 
@@ -2241,10 +2241,10 @@ check_replay:
 	return nfserr_bad_seqid;
 }
 
-int
+__be32
 nfsd4_open_confirm(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open_confirm *oc, struct nfs4_stateowner **replay_owner)
 {
-	int status;
+	__be32 status;
 	struct nfs4_stateowner *sop;
 	struct nfs4_stateid *stp;
 
@@ -2310,10 +2310,10 @@ reset_union_bmap_deny(unsigned long deny
 	}
 }
 
-int
+__be32
 nfsd4_open_downgrade(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open_downgrade *od, struct nfs4_stateowner **replay_owner)
 {
-	int status;
+	__be32 status;
 	struct nfs4_stateid *stp;
 	unsigned int share_access;
 
@@ -2365,10 +2365,10 @@ out:
 /*
  * nfs4_unlock_state() called after encode
  */
-int
+__be32
 nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_close *close, struct nfs4_stateowner **replay_owner)
 {
-	int status;
+	__be32 status;
 	struct nfs4_stateid *stp;
 
 	dprintk("NFSD: nfsd4_close on file %.*s\n", 
@@ -2404,10 +2404,10 @@ out:
 	return status;
 }
 
-int
+__be32
 nfsd4_delegreturn(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_delegreturn *dr)
 {
-	int status;
+	__be32 status;
 
 	if ((status = fh_verify(rqstp, current_fh, S_IFREG, 0)))
 		goto out;
@@ -2635,7 +2635,7 @@ check_lock_length(u64 offset, u64 length
 /*
  *  LOCK operation 
  */
-int
+__be32
 nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lock *lock, struct nfs4_stateowner **replay_owner)
 {
 	struct nfs4_stateowner *open_sop = NULL;
@@ -2644,7 +2644,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	struct file *filp;
 	struct file_lock file_lock;
 	struct file_lock conflock;
-	int status = 0;
+	__be32 status = 0;
 	unsigned int strhashval;
 
 	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
@@ -2793,14 +2793,14 @@ out:
 /*
  * LOCKT operation
  */
-int
+__be32
 nfsd4_lockt(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lockt *lockt)
 {
 	struct inode *inode;
 	struct file file;
 	struct file_lock file_lock;
 	struct file_lock conflock;
-	int status;
+	__be32 status;
 
 	if (nfs4_in_grace())
 		return nfserr_grace;
@@ -2873,13 +2873,13 @@ out:
 	return status;
 }
 
-int
+__be32
 nfsd4_locku(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_locku *locku, struct nfs4_stateowner **replay_owner)
 {
 	struct nfs4_stateid *stp;
 	struct file *filp = NULL;
 	struct file_lock file_lock;
-	int status;
+	__be32 status;
 						        
 	dprintk("NFSD: nfsd4_locku: start=%Ld length=%Ld\n",
 		(long long) locku->lu_offset,
@@ -2965,7 +2965,7 @@ out:
 	return status;
 }
 
-int
+__be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp, struct nfsd4_release_lockowner *rlockowner)
 {
 	clientid_t *clid = &rlockowner->rl_clientid;
@@ -2974,7 +2974,7 @@ nfsd4_release_lockowner(struct svc_rqst 
 	struct xdr_netobj *owner = &rlockowner->rl_owner;
 	struct list_head matches;
 	int i;
-	int status;
+	__be32 status;
 
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
@@ -3111,7 +3111,7 @@ nfs4_find_reclaim_client(clientid_t *cli
 /*
 * Called from OPEN. Look for clientid in reclaim list.
 */
-int
+__be32
 nfs4_check_open_reclaim(clientid_t *clid)
 {
 	return nfs4_find_reclaim_client(clid) ? nfs_ok : nfserr_reclaim_bad;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3419d99..d7b630f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -68,8 +68,8 @@ #define NFSDDBG_FACILITY		NFSDDBG_XDR
 #define NFS4_REFERRAL_FSID_MAJOR	0x8000000ULL
 #define NFS4_REFERRAL_FSID_MINOR	0x8000000ULL
 
-static int
-check_filename(char *str, int len, int err)
+static __be32
+check_filename(char *str, int len, __be32 err)
 {
 	int i;
 
@@ -95,7 +95,7 @@ check_filename(char *str, int len, int e
  */
 #define DECODE_HEAD				\
 	__be32 *p;				\
-	int status
+	__be32 status
 #define DECODE_TAIL				\
 	status = 0;				\
 out:						\
@@ -217,7 +217,7 @@ static char *savemem(struct nfsd4_compou
 }
 
 
-static int
+static __be32
 nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 {
 	u32 bmlen;
@@ -240,7 +240,7 @@ nfsd4_decode_bitmap(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval, struct iattr *iattr,
     struct nfs4_acl **acl)
 {
@@ -418,7 +418,7 @@ out_nfserr:
 	goto out;
 }
 
-static int
+static __be32
 nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
 {
 	DECODE_HEAD;
@@ -429,7 +429,7 @@ nfsd4_decode_access(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
 	DECODE_HEAD;
@@ -444,7 +444,7 @@ nfsd4_decode_close(struct nfsd4_compound
 }
 
 
-static int
+static __be32
 nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
 {
 	DECODE_HEAD;
@@ -456,7 +456,7 @@ nfsd4_decode_commit(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
 {
 	DECODE_HEAD;
@@ -496,7 +496,7 @@ nfsd4_decode_create(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static inline int
+static inline __be32
 nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
 {
 	DECODE_HEAD;
@@ -508,13 +508,13 @@ nfsd4_decode_delegreturn(struct nfsd4_co
 	DECODE_TAIL;
 }
 
-static inline int
+static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
 	return nfsd4_decode_bitmap(argp, getattr->ga_bmval);
 }
 
-static int
+static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
 	DECODE_HEAD;
@@ -529,7 +529,7 @@ nfsd4_decode_link(struct nfsd4_compounda
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
 	DECODE_HEAD;
@@ -568,7 +568,7 @@ nfsd4_decode_lock(struct nfsd4_compounda
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
 	DECODE_HEAD;
@@ -587,7 +587,7 @@ nfsd4_decode_lockt(struct nfsd4_compound
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 {
 	DECODE_HEAD;
@@ -606,7 +606,7 @@ nfsd4_decode_locku(struct nfsd4_compound
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
 {
 	DECODE_HEAD;
@@ -621,7 +621,7 @@ nfsd4_decode_lookup(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {
 	DECODE_HEAD;
@@ -699,7 +699,7 @@ nfsd4_decode_open(struct nfsd4_compounda
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
 {
 	DECODE_HEAD;
@@ -713,7 +713,7 @@ nfsd4_decode_open_confirm(struct nfsd4_c
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
 {
 	DECODE_HEAD;
@@ -729,7 +729,7 @@ nfsd4_decode_open_downgrade(struct nfsd4
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 {
 	DECODE_HEAD;
@@ -744,7 +744,7 @@ nfsd4_decode_putfh(struct nfsd4_compound
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	DECODE_HEAD;
@@ -758,7 +758,7 @@ nfsd4_decode_read(struct nfsd4_compounda
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
 {
 	DECODE_HEAD;
@@ -774,7 +774,7 @@ nfsd4_decode_readdir(struct nfsd4_compou
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
 {
 	DECODE_HEAD;
@@ -789,7 +789,7 @@ nfsd4_decode_remove(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
 {
 	DECODE_HEAD;
@@ -809,7 +809,7 @@ nfsd4_decode_rename(struct nfsd4_compoun
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
 {
 	DECODE_HEAD;
@@ -820,7 +820,7 @@ nfsd4_decode_renew(struct nfsd4_compound
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
 {
 	DECODE_HEAD;
@@ -834,7 +834,7 @@ nfsd4_decode_setattr(struct nfsd4_compou
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid *setclientid)
 {
 	DECODE_HEAD;
@@ -859,7 +859,7 @@ nfsd4_decode_setclientid(struct nfsd4_co
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
 {
 	DECODE_HEAD;
@@ -872,7 +872,7 @@ nfsd4_decode_setclientid_confirm(struct 
 }
 
 /* Also used for NVERIFY */
-static int
+static __be32
 nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
 {
 #if 0
@@ -908,7 +908,7 @@ #endif
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
 	int avail;
@@ -959,7 +959,7 @@ nfsd4_decode_write(struct nfsd4_compound
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_release_lockowner *rlockowner)
 {
 	DECODE_HEAD;
@@ -973,7 +973,7 @@ nfsd4_decode_release_lockowner(struct nf
 	DECODE_TAIL;
 }
 
-static int
+static __be32
 nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 {
 	DECODE_HEAD;
@@ -1234,7 +1234,7 @@ #define ENCODE_SEQID_OP_TAIL(stateowner)
 /* Encode as an array of strings the string given with components
  * seperated @sep.
  */
-static int nfsd4_encode_components(char sep, char *components,
+static __be32 nfsd4_encode_components(char sep, char *components,
 				   __be32 **pp, int *buflen)
 {
 	__be32 *p = *pp;
@@ -1271,10 +1271,10 @@ static int nfsd4_encode_components(char 
 /*
  * encode a location element of a fs_locations structure
  */
-static int nfsd4_encode_fs_location4(struct nfsd4_fs_location *location,
+static __be32 nfsd4_encode_fs_location4(struct nfsd4_fs_location *location,
 				    __be32 **pp, int *buflen)
 {
-	int status;
+	__be32 status;
 	__be32 *p = *pp;
 
 	status = nfsd4_encode_components(':', location->hosts, &p, buflen);
@@ -1292,7 +1292,7 @@ static int nfsd4_encode_fs_location4(str
  * Returned string is safe to use as long as the caller holds a reference
  * to @exp.
  */
-static char *nfsd4_path(struct svc_rqst *rqstp, struct svc_export *exp, u32 *stat)
+static char *nfsd4_path(struct svc_rqst *rqstp, struct svc_export *exp, __be32 *stat)
 {
 	struct svc_fh tmp_fh;
 	char *path, *rootpath;
@@ -1318,11 +1318,11 @@ static char *nfsd4_path(struct svc_rqst 
 /*
  *  encode a fs_locations structure
  */
-static int nfsd4_encode_fs_locations(struct svc_rqst *rqstp,
+static __be32 nfsd4_encode_fs_locations(struct svc_rqst *rqstp,
 				     struct svc_export *exp,
 				     __be32 **pp, int *buflen)
 {
-	u32 status;
+	__be32 status;
 	int i;
 	__be32 *p = *pp;
 	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
@@ -1353,7 +1353,7 @@ static u32 nfs4_ftypes[16] = {
         NF4SOCK, NF4BAD,  NF4LNK, NF4BAD,
 };
 
-static int
+static __be32
 nfsd4_encode_name(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
 			__be32 **p, int *buflen)
 {
@@ -1375,19 +1375,19 @@ nfsd4_encode_name(struct svc_rqst *rqstp
 	return 0;
 }
 
-static inline int
+static inline __be32
 nfsd4_encode_user(struct svc_rqst *rqstp, uid_t uid, __be32 **p, int *buflen)
 {
 	return nfsd4_encode_name(rqstp, NFS4_ACL_WHO_NAMED, uid, 0, p, buflen);
 }
 
-static inline int
+static inline __be32
 nfsd4_encode_group(struct svc_rqst *rqstp, uid_t gid, __be32 **p, int *buflen)
 {
 	return nfsd4_encode_name(rqstp, NFS4_ACL_WHO_NAMED, gid, 1, p, buflen);
 }
 
-static inline int
+static inline __be32
 nfsd4_encode_aclname(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
 		__be32 **p, int *buflen)
 {
@@ -1398,7 +1398,7 @@ #define WORD0_ABSENT_FS_ATTRS (FATTR4_WO
 			      FATTR4_WORD0_RDATTR_ERROR)
 #define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
 
-static int fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *rdattr_err)
+static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *rdattr_err)
 {
 	/* As per referral draft:  */
 	if (*bmval0 & ~WORD0_ABSENT_FS_ATTRS ||
@@ -1421,7 +1421,7 @@ static int fattr_handle_absent_fs(u32 *b
  * @countp is the buffer size in _words_; upon successful return this becomes
  * replaced with the number of words written.
  */
-int
+__be32
 nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 		struct dentry *dentry, __be32 *buffer, int *countp, u32 *bmval,
 		struct svc_rqst *rqstp)
@@ -1437,7 +1437,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	u64 dummy64;
 	u32 rdattr_err = 0;
 	__be32 *p = buffer;
-	int status;
+	__be32 status;
 	int aclsupport = 0;
 	struct nfs4_acl *acl = NULL;
 
@@ -1829,13 +1829,13 @@ out_serverfault:
 	goto out;
 }
 
-static int
+static __be32
 nfsd4_encode_dirent_fattr(struct nfsd4_readdir *cd,
 		const char *name, int namlen, __be32 *p, int *buflen)
 {
 	struct svc_export *exp = cd->rd_fhp->fh_export;
 	struct dentry *dentry;
-	int nfserr;
+	__be32 nfserr;
 
 	dentry = lookup_one_len(name, cd->rd_fhp->fh_dentry, namlen);
 	if (IS_ERR(dentry))
@@ -1865,7 +1865,7 @@ out_put:
 }
 
 static __be32 *
-nfsd4_encode_rdattr_error(__be32 *p, int buflen, int nfserr)
+nfsd4_encode_rdattr_error(__be32 *p, int buflen, __be32 nfserr)
 {
 	__be32 *attrlenp;
 
@@ -1888,7 +1888,7 @@ nfsd4_encode_dirent(struct readdir_cd *c
 	struct nfsd4_readdir *cd = container_of(ccd, struct nfsd4_readdir, common);
 	int buflen;
 	__be32 *p = cd->buffer;
-	int nfserr = nfserr_toosmall;
+	__be32 nfserr = nfserr_toosmall;
 
 	/* In nfsv4, "." and ".." never make it onto the wire.. */
 	if (name && isdotent(name, namlen)) {
@@ -1944,7 +1944,7 @@ fail:
 }
 
 static void
-nfsd4_encode_access(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_access *access)
+nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_access *access)
 {
 	ENCODE_HEAD;
 
@@ -1957,7 +1957,7 @@ nfsd4_encode_access(struct nfsd4_compoun
 }
 
 static void
-nfsd4_encode_close(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_close *close)
+nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_close *close)
 {
 	ENCODE_SEQID_OP_HEAD;
 
@@ -1972,7 +1972,7 @@ nfsd4_encode_close(struct nfsd4_compound
 
 
 static void
-nfsd4_encode_commit(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_commit *commit)
+nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_commit *commit)
 {
 	ENCODE_HEAD;
 
@@ -1984,7 +1984,7 @@ nfsd4_encode_commit(struct nfsd4_compoun
 }
 
 static void
-nfsd4_encode_create(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_create *create)
+nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_create *create)
 {
 	ENCODE_HEAD;
 
@@ -1998,8 +1998,8 @@ nfsd4_encode_create(struct nfsd4_compoun
 	}
 }
 
-static int
-nfsd4_encode_getattr(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_getattr *getattr)
+static __be32
+nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getattr *getattr)
 {
 	struct svc_fh *fhp = getattr->ga_fhp;
 	int buflen;
@@ -2017,7 +2017,7 @@ nfsd4_encode_getattr(struct nfsd4_compou
 }
 
 static void
-nfsd4_encode_getfh(struct nfsd4_compoundres *resp, int nfserr, struct svc_fh *fhp)
+nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct svc_fh *fhp)
 {
 	unsigned int len;
 	ENCODE_HEAD;
@@ -2057,7 +2057,7 @@ nfsd4_encode_lock_denied(struct nfsd4_co
 }
 
 static void
-nfsd4_encode_lock(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_lock *lock)
+nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lock *lock)
 {
 	ENCODE_SEQID_OP_HEAD;
 
@@ -2073,14 +2073,14 @@ nfsd4_encode_lock(struct nfsd4_compoundr
 }
 
 static void
-nfsd4_encode_lockt(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_lockt *lockt)
+nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lockt *lockt)
 {
 	if (nfserr == nfserr_denied)
 		nfsd4_encode_lock_denied(resp, &lockt->lt_denied);
 }
 
 static void
-nfsd4_encode_locku(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_locku *locku)
+nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_locku *locku)
 {
 	ENCODE_SEQID_OP_HEAD;
 
@@ -2096,7 +2096,7 @@ nfsd4_encode_locku(struct nfsd4_compound
 
 
 static void
-nfsd4_encode_link(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_link *link)
+nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_link *link)
 {
 	ENCODE_HEAD;
 
@@ -2109,7 +2109,7 @@ nfsd4_encode_link(struct nfsd4_compoundr
 
 
 static void
-nfsd4_encode_open(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open *open)
+nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open *open)
 {
 	ENCODE_SEQID_OP_HEAD;
 
@@ -2174,7 +2174,7 @@ out:
 }
 
 static void
-nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open_confirm *oc)
+nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_confirm *oc)
 {
 	ENCODE_SEQID_OP_HEAD;
 				        
@@ -2189,7 +2189,7 @@ nfsd4_encode_open_confirm(struct nfsd4_c
 }
 
 static void
-nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open_downgrade *od)
+nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_downgrade *od)
 {
 	ENCODE_SEQID_OP_HEAD;
 				        
@@ -2203,8 +2203,8 @@ nfsd4_encode_open_downgrade(struct nfsd4
 	ENCODE_SEQID_OP_TAIL(od->od_stateowner);
 }
 
-static int
-nfsd4_encode_read(struct nfsd4_compoundres *resp, int nfserr,
+static __be32
+nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_read *read)
 {
 	u32 eof;
@@ -2268,8 +2268,8 @@ nfsd4_encode_read(struct nfsd4_compoundr
 	return 0;
 }
 
-static int
-nfsd4_encode_readlink(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_readlink *readlink)
+static __be32
+nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readlink *readlink)
 {
 	int maxcount;
 	char *page;
@@ -2316,8 +2316,8 @@ nfsd4_encode_readlink(struct nfsd4_compo
 	return 0;
 }
 
-static int
-nfsd4_encode_readdir(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_readdir *readdir)
+static __be32
+nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readdir *readdir)
 {
 	int maxcount;
 	loff_t offset;
@@ -2396,7 +2396,7 @@ err_no_verf:
 }
 
 static void
-nfsd4_encode_remove(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_remove *remove)
+nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_remove *remove)
 {
 	ENCODE_HEAD;
 
@@ -2408,7 +2408,7 @@ nfsd4_encode_remove(struct nfsd4_compoun
 }
 
 static void
-nfsd4_encode_rename(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_rename *rename)
+nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_rename *rename)
 {
 	ENCODE_HEAD;
 
@@ -2425,7 +2425,7 @@ nfsd4_encode_rename(struct nfsd4_compoun
  * regardless of the error status.
  */
 static void
-nfsd4_encode_setattr(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_setattr *setattr)
+nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setattr *setattr)
 {
 	ENCODE_HEAD;
 
@@ -2444,7 +2444,7 @@ nfsd4_encode_setattr(struct nfsd4_compou
 }
 
 static void
-nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_setclientid *scd)
+nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setclientid *scd)
 {
 	ENCODE_HEAD;
 
@@ -2463,7 +2463,7 @@ nfsd4_encode_setclientid(struct nfsd4_co
 }
 
 static void
-nfsd4_encode_write(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_write *write)
+nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_write *write)
 {
 	ENCODE_HEAD;
 
@@ -2641,7 +2641,7 @@ void nfsd4_release_compoundargs(struct n
 int
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p, struct nfsd4_compoundargs *args)
 {
-	int status;
+	__be32 status;
 
 	args->p = p;
 	args->end = rqstp->rq_arg.head[0].iov_base + rqstp->rq_arg.head[0].iov_len;
diff --git a/include/linux/nfsd/state.h b/include/linux/nfsd/state.h
index 8bf23cf..a597e2e 100644
--- a/include/linux/nfsd/state.h
+++ b/include/linux/nfsd/state.h
@@ -164,7 +164,7 @@ #define NFSD4_REPLAY_ISIZE       112 
  * is cached. 
  */
 struct nfs4_replay {
-	u32			rp_status;
+	__be32			rp_status;
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	unsigned		intrp_allocated;
@@ -273,19 +273,19 @@ #define seqid_mutating_err(err)         
 	((err) != nfserr_stale_stateid) &&      \
 	((err) != nfserr_bad_stateid))
 
-extern int nfsd4_renew(clientid_t *clid);
-extern int nfs4_preprocess_stateid_op(struct svc_fh *current_fh, 
+extern __be32 nfsd4_renew(clientid_t *clid);
+extern __be32 nfs4_preprocess_stateid_op(struct svc_fh *current_fh,
 		stateid_t *stateid, int flags, struct file **filp);
 extern void nfs4_lock_state(void);
 extern void nfs4_unlock_state(void);
 extern int nfs4_in_grace(void);
-extern int nfs4_check_open_reclaim(clientid_t *clid);
+extern __be32 nfs4_check_open_reclaim(clientid_t *clid);
 extern void put_nfs4_client(struct nfs4_client *clp);
 extern void nfs4_free_stateowner(struct kref *kref);
 extern void nfsd4_probe_callback(struct nfs4_client *clp);
 extern void nfsd4_cb_recall(struct nfs4_delegation *dp);
 extern void nfs4_put_delegation(struct nfs4_delegation *dp);
-extern int nfs4_make_rec_clidname(char *clidname, struct xdr_netobj *clname);
+extern __be32 nfs4_make_rec_clidname(char *clidname, struct xdr_netobj *clname);
 extern void nfsd4_init_recdir(char *recdir_name);
 extern int nfsd4_recdir_load(void);
 extern void nfsd4_shutdown_recdir(void);
diff --git a/include/linux/nfsd/xdr4.h b/include/linux/nfsd/xdr4.h
index 003193f..45ca01b 100644
--- a/include/linux/nfsd/xdr4.h
+++ b/include/linux/nfsd/xdr4.h
@@ -334,7 +334,7 @@ struct nfsd4_write {
 
 struct nfsd4_op {
 	int					opnum;
-	int					status;
+	__be32					status;
 	union {
 		struct nfsd4_access		access;
 		struct nfsd4_close		close;
@@ -426,38 +426,38 @@ int nfs4svc_encode_compoundres(struct sv
 		struct nfsd4_compoundres *);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct nfsd4_compoundres *resp, struct nfsd4_op *op);
-int nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
-		       struct dentry *dentry, u32 *buffer, int *countp, 
+__be32 nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
+		       struct dentry *dentry, __be32 *buffer, int *countp,
 		       u32 *bmval, struct svc_rqst *);
-extern int nfsd4_setclientid(struct svc_rqst *rqstp, 
+extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_setclientid *setclid);
-extern int nfsd4_setclientid_confirm(struct svc_rqst *rqstp, 
+extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 		struct nfsd4_setclientid_confirm *setclientid_confirm);
-extern int nfsd4_process_open1(struct nfsd4_open *open);
-extern int nfsd4_process_open2(struct svc_rqst *rqstp, 
+extern __be32 nfsd4_process_open1(struct nfsd4_open *open);
+extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
 		struct svc_fh *current_fh, struct nfsd4_open *open);
-extern int nfsd4_open_confirm(struct svc_rqst *rqstp, 
+extern __be32 nfsd4_open_confirm(struct svc_rqst *rqstp,
 		struct svc_fh *current_fh, struct nfsd4_open_confirm *oc,
 		struct nfs4_stateowner **);
-extern  int nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh, 
+extern __be32 nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 		struct nfsd4_close *close,
 		struct nfs4_stateowner **replay_owner);
-extern int nfsd4_open_downgrade(struct svc_rqst *rqstp, 
+extern __be32 nfsd4_open_downgrade(struct svc_rqst *rqstp,
 		struct svc_fh *current_fh, struct nfsd4_open_downgrade *od,
 		struct nfs4_stateowner **replay_owner);
-extern int nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh, 
+extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 		struct nfsd4_lock *lock,
 		struct nfs4_stateowner **replay_owner);
-extern int nfsd4_lockt(struct svc_rqst *rqstp, struct svc_fh *current_fh, 
+extern __be32 nfsd4_lockt(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 		struct nfsd4_lockt *lockt);
-extern int nfsd4_locku(struct svc_rqst *rqstp, struct svc_fh *current_fh, 
+extern __be32 nfsd4_locku(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 		struct nfsd4_locku *locku,
 		struct nfs4_stateowner **replay_owner);
-extern int
+extern __be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		struct nfsd4_release_lockowner *rlockowner);
 extern void nfsd4_release_compoundargs(struct nfsd4_compoundargs *);
-extern int nfsd4_delegreturn(struct svc_rqst *rqstp,
+extern __be32 nfsd4_delegreturn(struct svc_rqst *rqstp,
 		struct svc_fh *current_fh, struct nfsd4_delegreturn *dr);
 #endif
 
-- 
1.4.2.GIT


