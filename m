Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932964AbWJJDLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWJJDLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWJJDLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:11:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46752 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932964AbWJJDLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:02 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/25] lockd endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX81E-0004AO-V4@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/lockd/clntlock.c         |    4 +-
 fs/lockd/mon.c              |   12 +++---
 fs/lockd/svc4proc.c         |    4 +-
 fs/lockd/svclock.c          |   10 +++--
 fs/lockd/svcproc.c          |    8 ++--
 fs/lockd/svcshare.c         |    4 +-
 fs/lockd/svcsubs.c          |    4 +-
 fs/lockd/xdr.c              |   76 ++++++++++++++++++++---------------------
 fs/lockd/xdr4.c             |   80 ++++++++++++++++++++++---------------------
 include/linux/lockd/lockd.h |   12 +++---
 include/linux/lockd/share.h |    4 +-
 include/linux/lockd/xdr.h   |   26 +++++++-------
 include/linux/lockd/xdr4.h  |   26 +++++++-------
 13 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index e8c7765..b85a0ad 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -100,12 +100,12 @@ int nlmclnt_block(struct nlm_wait *block
 /*
  * The server lockd has called us back to tell us the lock was granted
  */
-u32 nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *lock)
+__be32 nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *lock)
 {
 	const struct file_lock *fl = &lock->fl;
 	const struct nfs_fh *fh = &lock->fh;
 	struct nlm_wait	*block;
-	u32 res = nlm_lck_denied;
+	__be32 res = nlm_lck_denied;
 
 	/*
 	 * Look up blocked request based on arguments. 
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index e0179f8..eb243ed 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -148,8 +148,8 @@ nsm_create(void)
  * XDR functions for NSM.
  */
 
-static u32 *
-xdr_encode_common(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+static __be32 *
+xdr_encode_common(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	char	buffer[20], *name;
 
@@ -176,7 +176,7 @@ xdr_encode_common(struct rpc_rqst *rqstp
 }
 
 static int
-xdr_encode_mon(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+xdr_encode_mon(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	p = xdr_encode_common(rqstp, p, argp);
 	if (IS_ERR(p))
@@ -192,7 +192,7 @@ xdr_encode_mon(struct rpc_rqst *rqstp, u
 }
 
 static int
-xdr_encode_unmon(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+xdr_encode_unmon(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	p = xdr_encode_common(rqstp, p, argp);
 	if (IS_ERR(p))
@@ -202,7 +202,7 @@ xdr_encode_unmon(struct rpc_rqst *rqstp,
 }
 
 static int
-xdr_decode_stat_res(struct rpc_rqst *rqstp, u32 *p, struct nsm_res *resp)
+xdr_decode_stat_res(struct rpc_rqst *rqstp, __be32 *p, struct nsm_res *resp)
 {
 	resp->status = ntohl(*p++);
 	resp->state = ntohl(*p++);
@@ -212,7 +212,7 @@ xdr_decode_stat_res(struct rpc_rqst *rqs
 }
 
 static int
-xdr_decode_stat(struct rpc_rqst *rqstp, u32 *p, struct nsm_res *resp)
+xdr_decode_stat(struct rpc_rqst *rqstp, __be32 *p, struct nsm_res *resp)
 {
 	resp->state = ntohl(*p++);
 	return 0;
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 6ec7dbe..106f120 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -24,14 +24,14 @@ #define NLMDBG_FACILITY		NLMDBG_CLIENT
 /*
  * Obtain client and file from arguments
  */
-static u32
+static __be32
 nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 			struct nlm_host **hostp, struct nlm_file **filp)
 {
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
-	u32			error = 0;
+	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
 	if (!nlmsvc_ops)
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 814c606..7e219b9 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -334,13 +334,13 @@ static void nlmsvc_freegrantargs(struct 
  * Attempt to establish a lock, and if it can't be granted, block it
  * if required.
  */
-u32
+__be32
 nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			struct nlm_lock *lock, int wait, struct nlm_cookie *cookie)
 {
 	struct nlm_block	*block, *newblock = NULL;
 	int			error;
-	u32			ret;
+	__be32			ret;
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
 				file->f_file->f_dentry->d_inode->i_sb->s_id,
@@ -415,7 +415,7 @@ out:
 /*
  * Test for presence of a conflicting lock.
  */
-u32
+__be32
 nlmsvc_testlock(struct nlm_file *file, struct nlm_lock *lock,
 				       struct nlm_lock *conflock)
 {
@@ -448,7 +448,7 @@ nlmsvc_testlock(struct nlm_file *file, s
  * afterwards. In this case the block will still be there, and hence
  * must be removed.
  */
-u32
+__be32
 nlmsvc_unlock(struct nlm_file *file, struct nlm_lock *lock)
 {
 	int	error;
@@ -476,7 +476,7 @@ nlmsvc_unlock(struct nlm_file *file, str
  * be in progress.
  * The calling procedure must check whether the file can be closed.
  */
-u32
+__be32
 nlmsvc_cancel_blocked(struct nlm_file *file, struct nlm_lock *lock)
 {
 	struct nlm_block	*block;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 98f1818..19ccba3 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -22,8 +22,8 @@ #include <linux/lockd/sm_inter.h>
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 #ifdef CONFIG_LOCKD_V4
-static u32
-cast_to_nlm(u32 status, u32 vers)
+static __be32
+cast_to_nlm(__be32 status, u32 vers)
 {
 	/* Note: status is assumed to be in network byte order !!! */
 	if (vers != 4){
@@ -52,14 +52,14 @@ #endif
 /*
  * Obtain client and file from arguments
  */
-static u32
+static __be32
 nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 			struct nlm_host **hostp, struct nlm_file **filp)
 {
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
-	u32			error;
+	__be32			error;
 
 	/* nfsd callbacks must have been installed for this procedure */
 	if (!nlmsvc_ops)
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index b9926ce..6220dc2 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -23,7 +23,7 @@ nlm_cmp_owner(struct nlm_share *share, s
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
-u32
+__be32
 nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 			struct nlm_args *argp)
 {
@@ -64,7 +64,7 @@ update:
 /*
  * Delete a share.
  */
-u32
+__be32
 nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 			struct nlm_args *argp)
 {
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 514f5f2..d3b1d51 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -78,14 +78,14 @@ static inline unsigned int file_hash(str
  * This is not quite right, but for now, we assume the client performs
  * the proper R/W checking.
  */
-u32
+__be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 					struct nfs_fh *f)
 {
 	struct hlist_node *pos;
 	struct nlm_file	*file;
 	unsigned int	hash;
-	u32		nfserr;
+	__be32		nfserr;
 
 	nlm_debug_print_fh("nlm_file_lookup", f);
 
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 61c46fa..b7c9492 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -43,7 +43,7 @@ loff_t_to_s32(loff_t offset)
 /*
  * XDR functions for basic NLM types
  */
-static u32 *nlm_decode_cookie(u32 *p, struct nlm_cookie *c)
+static __be32 *nlm_decode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	unsigned int	len;
 
@@ -69,8 +69,8 @@ static u32 *nlm_decode_cookie(u32 *p, st
 	return p;
 }
 
-static inline u32 *
-nlm_encode_cookie(u32 *p, struct nlm_cookie *c)
+static inline __be32 *
+nlm_encode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	*p++ = htonl(c->len);
 	memcpy(p, c->data, c->len);
@@ -78,8 +78,8 @@ nlm_encode_cookie(u32 *p, struct nlm_coo
 	return p;
 }
 
-static u32 *
-nlm_decode_fh(u32 *p, struct nfs_fh *f)
+static __be32 *
+nlm_decode_fh(__be32 *p, struct nfs_fh *f)
 {
 	unsigned int	len;
 
@@ -95,8 +95,8 @@ nlm_decode_fh(u32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32 *
-nlm_encode_fh(u32 *p, struct nfs_fh *f)
+static inline __be32 *
+nlm_encode_fh(__be32 *p, struct nfs_fh *f)
 {
 	*p++ = htonl(NFS2_FHSIZE);
 	memcpy(p, f->data, NFS2_FHSIZE);
@@ -106,20 +106,20 @@ nlm_encode_fh(u32 *p, struct nfs_fh *f)
 /*
  * Encode and decode owner handle
  */
-static inline u32 *
-nlm_decode_oh(u32 *p, struct xdr_netobj *oh)
+static inline __be32 *
+nlm_decode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_decode_netobj(p, oh);
 }
 
-static inline u32 *
-nlm_encode_oh(u32 *p, struct xdr_netobj *oh)
+static inline __be32 *
+nlm_encode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_encode_netobj(p, oh);
 }
 
-static u32 *
-nlm_decode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	s32			start, len, end;
@@ -153,8 +153,8 @@ nlm_decode_lock(u32 *p, struct nlm_lock 
 /*
  * Encode a lock as part of an NLM call
  */
-static u32 *
-nlm_encode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm_encode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s32			start, len;
@@ -184,8 +184,8 @@ nlm_encode_lock(u32 *p, struct nlm_lock 
 /*
  * Encode result of a TEST/TEST_MSG call
  */
-static u32 *
-nlm_encode_testres(u32 *p, struct nlm_res *resp)
+static __be32 *
+nlm_encode_testres(__be32 *p, struct nlm_res *resp)
 {
 	s32		start, len;
 
@@ -221,7 +221,7 @@ nlm_encode_testres(u32 *p, struct nlm_re
  * First, the server side XDR functions
  */
 int
-nlmsvc_decode_testargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -238,7 +238,7 @@ nlmsvc_decode_testargs(struct svc_rqst *
 }
 
 int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_testres(p, resp)))
 		return 0;
@@ -246,7 +246,7 @@ nlmsvc_encode_testres(struct svc_rqst *r
 }
 
 int
-nlmsvc_decode_lockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -266,7 +266,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *
 }
 
 int
-nlmsvc_decode_cancargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -282,7 +282,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *
 }
 
 int
-nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	if (!(p = nlm_decode_cookie(p, &argp->cookie))
 	 || !(p = nlm_decode_lock(p, &argp->lock)))
@@ -292,7 +292,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst
 }
 
 int
-nlmsvc_decode_shareargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -313,7 +313,7 @@ nlmsvc_decode_shareargs(struct svc_rqst 
 }
 
 int
-nlmsvc_encode_shareres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_shareres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -323,7 +323,7 @@ nlmsvc_encode_shareres(struct svc_rqst *
 }
 
 int
-nlmsvc_encode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -332,7 +332,7 @@ nlmsvc_encode_res(struct svc_rqst *rqstp
 }
 
 int
-nlmsvc_decode_notify(struct svc_rqst *rqstp, u32 *p, struct nlm_args *argp)
+nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p, struct nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -344,7 +344,7 @@ nlmsvc_decode_notify(struct svc_rqst *rq
 }
 
 int
-nlmsvc_decode_reboot(struct svc_rqst *rqstp, u32 *p, struct nlm_reboot *argp)
+nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p, struct nlm_reboot *argp)
 {
 	if (!(p = xdr_decode_string_inplace(p, &argp->mon, &argp->len, SM_MAXSTRLEN)))
 		return 0;
@@ -357,7 +357,7 @@ nlmsvc_decode_reboot(struct svc_rqst *rq
 }
 
 int
-nlmsvc_decode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return 0;
@@ -366,13 +366,13 @@ nlmsvc_decode_res(struct svc_rqst *rqstp
 }
 
 int
-nlmsvc_decode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
 int
-nlmsvc_encode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
@@ -389,7 +389,7 @@ nlmclt_decode_void(struct rpc_rqst *req,
 #endif
 
 static int
-nlmclt_encode_testargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_testargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -403,7 +403,7 @@ nlmclt_encode_testargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_decode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_decode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -438,7 +438,7 @@ nlmclt_decode_testres(struct rpc_rqst *r
 
 
 static int
-nlmclt_encode_lockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_lockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -455,7 +455,7 @@ nlmclt_encode_lockargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_encode_cancargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_cancargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -470,7 +470,7 @@ nlmclt_encode_cancargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_encode_unlockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_unlockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -483,7 +483,7 @@ nlmclt_encode_unlockargs(struct rpc_rqst
 }
 
 static int
-nlmclt_encode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_encode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -493,7 +493,7 @@ nlmclt_encode_res(struct rpc_rqst *req, 
 }
 
 static int
-nlmclt_encode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_encode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_testres(p, resp)))
 		return -EIO;
@@ -502,7 +502,7 @@ nlmclt_encode_testres(struct rpc_rqst *r
 }
 
 static int
-nlmclt_decode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_decode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return -EIO;
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 36eb175..f4c0b2b 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -44,8 +44,8 @@ loff_t_to_s64(loff_t offset)
 /*
  * XDR functions for basic NLM types
  */
-static u32 *
-nlm4_decode_cookie(u32 *p, struct nlm_cookie *c)
+static __be32 *
+nlm4_decode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	unsigned int	len;
 
@@ -71,8 +71,8 @@ nlm4_decode_cookie(u32 *p, struct nlm_co
 	return p;
 }
 
-static u32 *
-nlm4_encode_cookie(u32 *p, struct nlm_cookie *c)
+static __be32 *
+nlm4_encode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	*p++ = htonl(c->len);
 	memcpy(p, c->data, c->len);
@@ -80,8 +80,8 @@ nlm4_encode_cookie(u32 *p, struct nlm_co
 	return p;
 }
 
-static u32 *
-nlm4_decode_fh(u32 *p, struct nfs_fh *f)
+static __be32 *
+nlm4_decode_fh(__be32 *p, struct nfs_fh *f)
 {
 	memset(f->data, 0, sizeof(f->data));
 	f->size = ntohl(*p++);
@@ -95,8 +95,8 @@ nlm4_decode_fh(u32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(f->size);
 }
 
-static u32 *
-nlm4_encode_fh(u32 *p, struct nfs_fh *f)
+static __be32 *
+nlm4_encode_fh(__be32 *p, struct nfs_fh *f)
 {
 	*p++ = htonl(f->size);
 	if (f->size) p[XDR_QUADLEN(f->size)-1] = 0; /* don't leak anything */
@@ -107,20 +107,20 @@ nlm4_encode_fh(u32 *p, struct nfs_fh *f)
 /*
  * Encode and decode owner handle
  */
-static u32 *
-nlm4_decode_oh(u32 *p, struct xdr_netobj *oh)
+static __be32 *
+nlm4_decode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_decode_netobj(p, oh);
 }
 
-static u32 *
-nlm4_encode_oh(u32 *p, struct xdr_netobj *oh)
+static __be32 *
+nlm4_encode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_encode_netobj(p, oh);
 }
 
-static u32 *
-nlm4_decode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s64			len, start, end;
@@ -153,8 +153,8 @@ nlm4_decode_lock(u32 *p, struct nlm_lock
 /*
  * Encode a lock as part of an NLM call
  */
-static u32 *
-nlm4_encode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm4_encode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s64			start, len;
@@ -185,8 +185,8 @@ nlm4_encode_lock(u32 *p, struct nlm_lock
 /*
  * Encode result of a TEST/TEST_MSG call
  */
-static u32 *
-nlm4_encode_testres(u32 *p, struct nlm_res *resp)
+static __be32 *
+nlm4_encode_testres(__be32 *p, struct nlm_res *resp)
 {
 	s64		start, len;
 
@@ -227,7 +227,7 @@ nlm4_encode_testres(u32 *p, struct nlm_r
  * First, the server side XDR functions
  */
 int
-nlm4svc_decode_testargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -244,7 +244,7 @@ nlm4svc_decode_testargs(struct svc_rqst 
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_testres(p, resp)))
 		return 0;
@@ -252,7 +252,7 @@ nlm4svc_encode_testres(struct svc_rqst *
 }
 
 int
-nlm4svc_decode_lockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -272,7 +272,7 @@ nlm4svc_decode_lockargs(struct svc_rqst 
 }
 
 int
-nlm4svc_decode_cancargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -288,7 +288,7 @@ nlm4svc_decode_cancargs(struct svc_rqst 
 }
 
 int
-nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
 	 || !(p = nlm4_decode_lock(p, &argp->lock)))
@@ -298,7 +298,7 @@ nlm4svc_decode_unlockargs(struct svc_rqs
 }
 
 int
-nlm4svc_decode_shareargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -319,7 +319,7 @@ nlm4svc_decode_shareargs(struct svc_rqst
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -329,7 +329,7 @@ nlm4svc_encode_shareres(struct svc_rqst 
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -338,7 +338,7 @@ nlm4svc_encode_res(struct svc_rqst *rqst
 }
 
 int
-nlm4svc_decode_notify(struct svc_rqst *rqstp, u32 *p, struct nlm_args *argp)
+nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p, struct nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -350,7 +350,7 @@ nlm4svc_decode_notify(struct svc_rqst *r
 }
 
 int
-nlm4svc_decode_reboot(struct svc_rqst *rqstp, u32 *p, struct nlm_reboot *argp)
+nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p, struct nlm_reboot *argp)
 {
 	if (!(p = xdr_decode_string_inplace(p, &argp->mon, &argp->len, SM_MAXSTRLEN)))
 		return 0;
@@ -363,7 +363,7 @@ nlm4svc_decode_reboot(struct svc_rqst *r
 }
 
 int
-nlm4svc_decode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return 0;
@@ -372,13 +372,13 @@ nlm4svc_decode_res(struct svc_rqst *rqst
 }
 
 int
-nlm4svc_decode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
 int
-nlm4svc_encode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
@@ -388,14 +388,14 @@ nlm4svc_encode_void(struct svc_rqst *rqs
  */
 #ifdef NLMCLNT_SUPPORT_SHARES
 static int
-nlm4clt_decode_void(struct rpc_rqst *req, u32 *p, void *ptr)
+nlm4clt_decode_void(struct rpc_rqst *req, __be32 *p, void *ptr)
 {
 	return 0;
 }
 #endif
 
 static int
-nlm4clt_encode_testargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_testargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -409,7 +409,7 @@ nlm4clt_encode_testargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_decode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_decode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -444,7 +444,7 @@ nlm4clt_decode_testres(struct rpc_rqst *
 
 
 static int
-nlm4clt_encode_lockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_lockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -461,7 +461,7 @@ nlm4clt_encode_lockargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_encode_cancargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_cancargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -476,7 +476,7 @@ nlm4clt_encode_cancargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_encode_unlockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_unlockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -489,7 +489,7 @@ nlm4clt_encode_unlockargs(struct rpc_rqs
 }
 
 static int
-nlm4clt_encode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_encode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -499,7 +499,7 @@ nlm4clt_encode_res(struct rpc_rqst *req,
 }
 
 static int
-nlm4clt_encode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_encode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_testres(p, resp)))
 		return -EIO;
@@ -508,7 +508,7 @@ nlm4clt_encode_testres(struct rpc_rqst *
 }
 
 static int
-nlm4clt_decode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_decode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return -EIO;
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 2909619..862d973 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -154,7 +154,7 @@ int		  nlm_async_reply(struct nlm_rqst *
 struct nlm_wait * nlmclnt_prepare_block(struct nlm_host *host, struct file_lock *fl);
 void		  nlmclnt_finish_block(struct nlm_wait *block);
 int		  nlmclnt_block(struct nlm_wait *block, struct nlm_rqst *req, long timeout);
-u32		  nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *);
+__be32		  nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *);
 void		  nlmclnt_recovery(struct nlm_host *);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
 void		  nlmclnt_next_cookie(struct nlm_cookie *);
@@ -184,12 +184,12 @@ typedef int	  (*nlm_host_match_fn_t)(str
 /*
  * Server-side lock handling
  */
-u32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
+__be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
 					struct nlm_lock *, int, struct nlm_cookie *);
-u32		  nlmsvc_unlock(struct nlm_file *, struct nlm_lock *);
-u32		  nlmsvc_testlock(struct nlm_file *, struct nlm_lock *,
+__be32		  nlmsvc_unlock(struct nlm_file *, struct nlm_lock *);
+__be32		  nlmsvc_testlock(struct nlm_file *, struct nlm_lock *,
 					struct nlm_lock *);
-u32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
+__be32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
 unsigned long	  nlmsvc_retry_blocked(void);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
@@ -198,7 +198,7 @@ void		  nlmsvc_grant_reply(struct nlm_co
 /*
  * File handling for the server personality
  */
-u32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
+__be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
 					struct nfs_fh *);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_mark_resources(void);
diff --git a/include/linux/lockd/share.h b/include/linux/lockd/share.h
index cd7816e..630c5bf 100644
--- a/include/linux/lockd/share.h
+++ b/include/linux/lockd/share.h
@@ -21,9 +21,9 @@ struct nlm_share {
 	u32			s_mode;		/* deny mode */
 };
 
-u32	nlmsvc_share_file(struct nlm_host *, struct nlm_file *,
+__be32	nlmsvc_share_file(struct nlm_host *, struct nlm_file *,
 					       struct nlm_args *);
-u32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
+__be32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
 					       struct nlm_args *);
 void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
 					       nlm_host_match_fn_t);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index bb0a0f1..742623b 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -86,19 +86,19 @@ struct nlm_reboot {
  */
 #define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
 
-int	nlmsvc_decode_testargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_testres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_lockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_cancargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_unlockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_encode_void(struct svc_rqst *, u32 *, void *);
-int	nlmsvc_decode_void(struct svc_rqst *, u32 *, void *);
-int	nlmsvc_decode_shareargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_shareres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_notify(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_reboot(struct svc_rqst *, u32 *, struct nlm_reboot *);
+int	nlmsvc_decode_testargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_lockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_cancargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_unlockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_encode_void(struct svc_rqst *, __be32 *, void *);
+int	nlmsvc_decode_void(struct svc_rqst *, __be32 *, void *);
+int	nlmsvc_decode_shareargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_notify(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_reboot(struct svc_rqst *, __be32 *, struct nlm_reboot *);
 /*
 int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
 int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 3cc1ae2..dd12b4c 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -23,19 +23,19 @@ #define	nlm4_failed		__constant_htonl(NL
 
 
 
-int	nlm4svc_decode_testargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_testres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_lockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_cancargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_unlockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_encode_void(struct svc_rqst *, u32 *, void *);
-int	nlm4svc_decode_void(struct svc_rqst *, u32 *, void *);
-int	nlm4svc_decode_shareargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_shareres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_notify(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_reboot(struct svc_rqst *, u32 *, struct nlm_reboot *);
+int	nlm4svc_decode_testargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_lockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_cancargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_unlockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_encode_void(struct svc_rqst *, __be32 *, void *);
+int	nlm4svc_decode_void(struct svc_rqst *, __be32 *, void *);
+int	nlm4svc_decode_shareargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_notify(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_reboot(struct svc_rqst *, __be32 *, struct nlm_reboot *);
 /*
 int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
 int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-- 
1.4.2.GIT


