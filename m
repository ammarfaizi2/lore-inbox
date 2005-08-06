Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263280AbVHFRLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbVHFRLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbVHFRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 13:11:42 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:29006 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263280AbVHFRLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 13:11:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=VEn0M5fzDbKBkv/kqMUEY6bxMhTM/Fn7G7kYunbP+foigs8dRukbCcB4Ov0Vp4eVxgo16v9nJWF2Npv3sDH21J4zomQrqXg4jBdg1VDlGUu7LHM7+R1BZWoEKzPmFREZ5kPD878tk3clZoKZDge8iivYKojZmW+HmO9AChSd3NY=
Date: Sat, 6 Aug 2005 21:19:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nfs/: add endian annotations
Message-ID: <20050806171952.GA32637@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of sparse warnings will disappear after similar patch to net/sunrpc/

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/nfs/callback.h       |    2 
 fs/nfs/callback_proc.c  |    4 
 fs/nfs/callback_xdr.c   |   86 ++++++++++----------
 fs/nfs/dir.c            |    6 -
 fs/nfs/nfs2xdr.c        |   86 ++++++++++----------
 fs/nfs/nfs3proc.c       |    2 
 fs/nfs/nfs3xdr.c        |  118 ++++++++++++++--------------
 fs/nfs/nfs4_fs.h        |    2 
 fs/nfs/nfs4proc.c       |   10 +-
 fs/nfs/nfs4xdr.c        |  202 ++++++++++++++++++++++++------------------------
 fs/nfs/proc.c           |    2 
 include/linux/nfs_xdr.h |    2 
 12 files changed, 263 insertions(+), 259 deletions(-)

Index: linux-sparse/fs/nfs/dir.c
===================================================================
--- linux-sparse.orig/fs/nfs/dir.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/dir.c	2005-08-06 17:44:10.000000000 +0400
@@ -137,12 +137,12 @@ nfs_opendir(struct inode *inode, struct 
 	return res;
 }
 
-typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
+typedef __be32 * (*decode_dirent_t)(__be32 *, struct nfs_entry *, int);
 typedef struct {
 	struct file	*file;
 	struct page	*page;
 	unsigned long	page_index;
-	u32		*ptr;
+	__be32		*ptr;
 	u64		*dir_cookie;
 	loff_t		current_index;
 	struct nfs_entry *entry;
@@ -209,7 +209,7 @@ int nfs_readdir_filler(nfs_readdir_descr
 static inline
 int dir_decode(nfs_readdir_descriptor_t *desc)
 {
-	u32	*p = desc->ptr;
+	__be32	*p = desc->ptr;
 	p = desc->decode(p, desc->entry, desc->plus);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
Index: linux-sparse/fs/nfs/nfs2xdr.c
===================================================================
--- linux-sparse.orig/fs/nfs/nfs2xdr.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs2xdr.c	2005-08-06 17:46:26.000000000 +0400
@@ -67,15 +67,15 @@ extern int			nfs_stat_to_errno(int stat)
 /*
  * Common NFS XDR functions as inlines
  */
-static inline u32 *
-xdr_encode_fhandle(u32 *p, struct nfs_fh *fhandle)
+static inline __be32 *
+xdr_encode_fhandle(__be32 *p, struct nfs_fh *fhandle)
 {
 	memcpy(p, fhandle->data, NFS2_FHSIZE);
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32 *
-xdr_decode_fhandle(u32 *p, struct nfs_fh *fhandle)
+static inline __be32 *
+xdr_decode_fhandle(__be32 *p, struct nfs_fh *fhandle)
 {
 	/* NFSv2 handles have a fixed length */
 	fhandle->size = NFS2_FHSIZE;
@@ -83,8 +83,8 @@ xdr_decode_fhandle(u32 *p, struct nfs_fh
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32*
-xdr_encode_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_encode_time(__be32 *p, struct timespec *timep)
 {
 	*p++ = htonl(timep->tv_sec);
 	/* Convert nanoseconds into microseconds */
@@ -92,8 +92,8 @@ xdr_encode_time(u32 *p, struct timespec 
 	return p;
 }
 
-static inline u32*
-xdr_encode_current_server_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_encode_current_server_time(__be32 *p, struct timespec *timep)
 {
 	/*
 	 * Passing the invalid value useconds=1000000 is a
@@ -109,8 +109,8 @@ xdr_encode_current_server_time(u32 *p, s
 	return p;
 }
 
-static inline u32*
-xdr_decode_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_decode_time(__be32 *p, struct timespec *timep)
 {
 	timep->tv_sec = ntohl(*p++);
 	/* Convert microseconds into nanoseconds */
@@ -118,8 +118,8 @@ xdr_decode_time(u32 *p, struct timespec 
 	return p;
 }
 
-static u32 *
-xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr)
+static __be32 *
+xdr_decode_fattr(__be32 *p, struct nfs_fattr *fattr)
 {
 	u32 rdev;
 	fattr->type = (enum nfs_ftype) ntohl(*p++);
@@ -148,9 +148,9 @@ xdr_decode_fattr(u32 *p, struct nfs_fatt
 }
 
 #define SATTR(p, attr, flag, field) \
-        *p++ = (attr->ia_valid & flag) ? htonl(attr->field) : ~(u32) 0
-static inline u32 *
-xdr_encode_sattr(u32 *p, struct iattr *attr)
+        *p++ = (attr->ia_valid & flag) ? htonl(attr->field) : htonl(~(u32) 0)
+static inline __be32 *
+xdr_encode_sattr(__be32 *p, struct iattr *attr)
 {
 	SATTR(p, attr, ATTR_MODE, ia_mode);
 	SATTR(p, attr, ATTR_UID, ia_uid);
@@ -162,8 +162,8 @@ xdr_encode_sattr(u32 *p, struct iattr *a
 	} else if (attr->ia_valid & ATTR_ATIME) {
 		p = xdr_encode_current_server_time(p, &attr->ia_atime);
 	} else {
-		*p++ = ~(u32) 0;
-		*p++ = ~(u32) 0;
+		*p++ = htonl(~(u32) 0);
+		*p++ = htonl(~(u32) 0);
 	}
 
 	if (attr->ia_valid & ATTR_MTIME_SET) {
@@ -171,8 +171,8 @@ xdr_encode_sattr(u32 *p, struct iattr *a
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		p = xdr_encode_current_server_time(p, &attr->ia_mtime);
 	} else {
-		*p++ = ~(u32) 0;	
-		*p++ = ~(u32) 0;
+		*p++ = htonl(~(u32) 0);
+		*p++ = htonl(~(u32) 0);
 	}
   	return p;
 }
@@ -186,7 +186,7 @@ xdr_encode_sattr(u32 *p, struct iattr *a
  * GETATTR, READLINK, STATFS
  */
 static int
-nfs_xdr_fhandle(struct rpc_rqst *req, u32 *p, struct nfs_fh *fh)
+nfs_xdr_fhandle(struct rpc_rqst *req, __be32 *p, struct nfs_fh *fh)
 {
 	p = xdr_encode_fhandle(p, fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -197,7 +197,7 @@ nfs_xdr_fhandle(struct rpc_rqst *req, u3
  * Encode SETATTR arguments
  */
 static int
-nfs_xdr_sattrargs(struct rpc_rqst *req, u32 *p, struct nfs_sattrargs *args)
+nfs_xdr_sattrargs(struct rpc_rqst *req, __be32 *p, struct nfs_sattrargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_sattr(p, args->sattr);
@@ -210,7 +210,7 @@ nfs_xdr_sattrargs(struct rpc_rqst *req, 
  * LOOKUP, REMOVE, RMDIR
  */
 static int
-nfs_xdr_diropargs(struct rpc_rqst *req, u32 *p, struct nfs_diropargs *args)
+nfs_xdr_diropargs(struct rpc_rqst *req, __be32 *p, struct nfs_diropargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -224,7 +224,7 @@ nfs_xdr_diropargs(struct rpc_rqst *req, 
  * exactly to the page we want to fetch.
  */
 static int
-nfs_xdr_readargs(struct rpc_rqst *req, u32 *p, struct nfs_readargs *args)
+nfs_xdr_readargs(struct rpc_rqst *req, __be32 *p, struct nfs_readargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -248,7 +248,7 @@ nfs_xdr_readargs(struct rpc_rqst *req, u
  * Decode READ reply
  */
 static int
-nfs_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
+nfs_xdr_readres(struct rpc_rqst *req, __be32 *p, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
 	int	status, count, recvd, hdrlen;
@@ -288,7 +288,7 @@ nfs_xdr_readres(struct rpc_rqst *req, u3
  * Write arguments. Splice the buffer to be written into the iovec.
  */
 static int
-nfs_xdr_writeargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs_xdr_writeargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_buf *sndbuf = &req->rq_snd_buf;
 	u32 offset = (u32)args->offset;
@@ -311,7 +311,7 @@ nfs_xdr_writeargs(struct rpc_rqst *req, 
  * CREATE, MKDIR
  */
 static int
-nfs_xdr_createargs(struct rpc_rqst *req, u32 *p, struct nfs_createargs *args)
+nfs_xdr_createargs(struct rpc_rqst *req, __be32 *p, struct nfs_createargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -324,7 +324,7 @@ nfs_xdr_createargs(struct rpc_rqst *req,
  * Encode RENAME arguments
  */
 static int
-nfs_xdr_renameargs(struct rpc_rqst *req, u32 *p, struct nfs_renameargs *args)
+nfs_xdr_renameargs(struct rpc_rqst *req, __be32 *p, struct nfs_renameargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -338,7 +338,7 @@ nfs_xdr_renameargs(struct rpc_rqst *req,
  * Encode LINK arguments
  */
 static int
-nfs_xdr_linkargs(struct rpc_rqst *req, u32 *p, struct nfs_linkargs *args)
+nfs_xdr_linkargs(struct rpc_rqst *req, __be32 *p, struct nfs_linkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_fhandle(p, args->tofh);
@@ -351,7 +351,7 @@ nfs_xdr_linkargs(struct rpc_rqst *req, u
  * Encode SYMLINK arguments
  */
 static int
-nfs_xdr_symlinkargs(struct rpc_rqst *req, u32 *p, struct nfs_symlinkargs *args)
+nfs_xdr_symlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs_symlinkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -365,7 +365,7 @@ nfs_xdr_symlinkargs(struct rpc_rqst *req
  * Encode arguments to readdir call
  */
 static int
-nfs_xdr_readdirargs(struct rpc_rqst *req, u32 *p, struct nfs_readdirargs *args)
+nfs_xdr_readdirargs(struct rpc_rqst *req, __be32 *p, struct nfs_readdirargs *args)
 {
 	struct rpc_task	*task = req->rq_task;
 	struct rpc_auth	*auth = task->tk_auth;
@@ -391,7 +391,7 @@ nfs_xdr_readdirargs(struct rpc_rqst *req
  * from nfs_readdir for each entry.
  */
 static int
-nfs_xdr_readdirres(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_readdirres(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -399,7 +399,7 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *end, *entry, *kaddr;
+	__be32 *end, *entry, *kaddr;
 
 	if ((status = ntohl(*p++)))
 		return -nfs_stat_to_errno(status);
@@ -419,8 +419,8 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
-	end = (u32 *)((char *)p + pglen);
+	kaddr = p = kmap_atomic(*page, KM_USER0);
+	end = (__be32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
 		if (p + 2 > end)
@@ -455,8 +455,8 @@ err_unmap:
 	goto out;
 }
 
-u32 *
-nfs_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
+__be32 *
+nfs_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	if (!*p++) {
 		if (!*p)
@@ -483,7 +483,7 @@ nfs_decode_dirent(u32 *p, struct nfs_ent
  * Decode simple status reply
  */
 static int
-nfs_xdr_stat(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_stat(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	int	status;
 
@@ -497,7 +497,7 @@ nfs_xdr_stat(struct rpc_rqst *req, u32 *
  * GETATTR, SETATTR, WRITE
  */
 static int
-nfs_xdr_attrstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs_xdr_attrstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -512,7 +512,7 @@ nfs_xdr_attrstat(struct rpc_rqst *req, u
  * LOOKUP, CREATE, MKDIR
  */
 static int
-nfs_xdr_diropres(struct rpc_rqst *req, u32 *p, struct nfs_diropok *res)
+nfs_xdr_diropres(struct rpc_rqst *req, __be32 *p, struct nfs_diropok *res)
 {
 	int	status;
 
@@ -527,7 +527,7 @@ nfs_xdr_diropres(struct rpc_rqst *req, u
  * Encode READLINK args
  */
 static int
-nfs_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs_readlinkargs *args)
+nfs_xdr_readlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -545,7 +545,7 @@ nfs_xdr_readlinkargs(struct rpc_rqst *re
  * Decode READLINK reply
  */
 static int
-nfs_xdr_readlinkres(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_readlinkres(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -588,7 +588,7 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
  * Decode WRITE reply
  */
 static int
-nfs_xdr_writeres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs_xdr_writeres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	res->verf->committed = NFS_FILE_SYNC;
 	return nfs_xdr_attrstat(req, p, res->fattr);
@@ -598,7 +598,7 @@ nfs_xdr_writeres(struct rpc_rqst *req, u
  * Decode STATFS reply
  */
 static int
-nfs_xdr_statfsres(struct rpc_rqst *req, u32 *p, struct nfs2_fsstat *res)
+nfs_xdr_statfsres(struct rpc_rqst *req, __be32 *p, struct nfs2_fsstat *res)
 {
 	int	status;
 
Index: linux-sparse/fs/nfs/nfs3proc.c
===================================================================
--- linux-sparse.orig/fs/nfs/nfs3proc.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs3proc.c	2005-08-06 17:46:48.000000000 +0400
@@ -727,7 +727,7 @@ nfs3_proc_pathconf(struct nfs_server *se
 	return status;
 }
 
-extern u32 *nfs3_decode_dirent(u32 *, struct nfs_entry *, int);
+extern __be32 *nfs3_decode_dirent(__be32 *, struct nfs_entry *, int);
 
 static void
 nfs3_read_done(struct rpc_task *task)
Index: linux-sparse/fs/nfs/nfs3xdr.c
===================================================================
--- linux-sparse.orig/fs/nfs/nfs3xdr.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs3xdr.c	2005-08-06 18:06:37.000000000 +0400
@@ -106,14 +106,14 @@ static struct {
 /*
  * Common NFS XDR functions as inlines
  */
-static inline u32 *
-xdr_encode_fhandle(u32 *p, struct nfs_fh *fh)
+static inline __be32 *
+xdr_encode_fhandle(__be32 *p, struct nfs_fh *fh)
 {
 	return xdr_encode_array(p, fh->data, fh->size);
 }
 
-static inline u32 *
-xdr_decode_fhandle(u32 *p, struct nfs_fh *fh)
+static inline __be32 *
+xdr_decode_fhandle(__be32 *p, struct nfs_fh *fh)
 {
 	if ((fh->size = ntohl(*p++)) <= NFS3_FHSIZE) {
 		memcpy(fh->data, p, fh->size);
@@ -125,24 +125,24 @@ xdr_decode_fhandle(u32 *p, struct nfs_fh
 /*
  * Encode/decode time.
  */
-static inline u32 *
-xdr_encode_time3(u32 *p, struct timespec *timep)
+static inline __be32 *
+xdr_encode_time3(__be32 *p, struct timespec *timep)
 {
 	*p++ = htonl(timep->tv_sec);
 	*p++ = htonl(timep->tv_nsec);
 	return p;
 }
 
-static inline u32 *
-xdr_decode_time3(u32 *p, struct timespec *timep)
+static inline __be32 *
+xdr_decode_time3(__be32 *p, struct timespec *timep)
 {
 	timep->tv_sec = ntohl(*p++);
 	timep->tv_nsec = ntohl(*p++);
 	return p;
 }
 
-static u32 *
-xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr)
+static __be32 *
+xdr_decode_fattr(__be32 *p, struct nfs_fattr *fattr)
 {
 	unsigned int	type, major, minor;
 	int		fmode;
@@ -178,8 +178,8 @@ xdr_decode_fattr(u32 *p, struct nfs_fatt
 	return p;
 }
 
-static inline u32 *
-xdr_encode_sattr(u32 *p, struct iattr *attr)
+static inline __be32 *
+xdr_encode_sattr(__be32 *p, struct iattr *attr)
 {
 	if (attr->ia_valid & ATTR_MODE) {
 		*p++ = xdr_one;
@@ -224,8 +224,8 @@ xdr_encode_sattr(u32 *p, struct iattr *a
 	return p;
 }
 
-static inline u32 *
-xdr_decode_wcc_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_wcc_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	p = xdr_decode_hyper(p, &fattr->pre_size);
 	p = xdr_decode_time3(p, &fattr->pre_mtime);
@@ -234,16 +234,16 @@ xdr_decode_wcc_attr(u32 *p, struct nfs_f
 	return p;
 }
 
-static inline u32 *
-xdr_decode_post_op_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_post_op_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	if (*p++)
 		p = xdr_decode_fattr(p, fattr);
 	return p;
 }
 
-static inline u32 *
-xdr_decode_pre_op_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_pre_op_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	if (*p++)
 		return xdr_decode_wcc_attr(p, fattr);
@@ -251,8 +251,8 @@ xdr_decode_pre_op_attr(u32 *p, struct nf
 }
 
 
-static inline u32 *
-xdr_decode_wcc_data(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_wcc_data(__be32 *p, struct nfs_fattr *fattr)
 {
 	p = xdr_decode_pre_op_attr(p, fattr);
 	return xdr_decode_post_op_attr(p, fattr);
@@ -266,7 +266,7 @@ xdr_decode_wcc_data(u32 *p, struct nfs_f
  * Encode file handle argument
  */
 static int
-nfs3_xdr_fhandle(struct rpc_rqst *req, u32 *p, struct nfs_fh *fh)
+nfs3_xdr_fhandle(struct rpc_rqst *req, __be32 *p, struct nfs_fh *fh)
 {
 	p = xdr_encode_fhandle(p, fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -277,7 +277,7 @@ nfs3_xdr_fhandle(struct rpc_rqst *req, u
  * Encode SETATTR arguments
  */
 static int
-nfs3_xdr_sattrargs(struct rpc_rqst *req, u32 *p, struct nfs3_sattrargs *args)
+nfs3_xdr_sattrargs(struct rpc_rqst *req, __be32 *p, struct nfs3_sattrargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_sattr(p, args->sattr);
@@ -292,7 +292,7 @@ nfs3_xdr_sattrargs(struct rpc_rqst *req,
  * Encode directory ops argument
  */
 static int
-nfs3_xdr_diropargs(struct rpc_rqst *req, u32 *p, struct nfs3_diropargs *args)
+nfs3_xdr_diropargs(struct rpc_rqst *req, __be32 *p, struct nfs3_diropargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -304,7 +304,7 @@ nfs3_xdr_diropargs(struct rpc_rqst *req,
  * Encode access() argument
  */
 static int
-nfs3_xdr_accessargs(struct rpc_rqst *req, u32 *p, struct nfs3_accessargs *args)
+nfs3_xdr_accessargs(struct rpc_rqst *req, __be32 *p, struct nfs3_accessargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	*p++ = htonl(args->access);
@@ -318,7 +318,7 @@ nfs3_xdr_accessargs(struct rpc_rqst *req
  * exactly to the page we want to fetch.
  */
 static int
-nfs3_xdr_readargs(struct rpc_rqst *req, u32 *p, struct nfs_readargs *args)
+nfs3_xdr_readargs(struct rpc_rqst *req, __be32 *p, struct nfs_readargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -340,7 +340,7 @@ nfs3_xdr_readargs(struct rpc_rqst *req, 
  * Write arguments. Splice the buffer to be written into the iovec.
  */
 static int
-nfs3_xdr_writeargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs3_xdr_writeargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_buf *sndbuf = &req->rq_snd_buf;
 	u32 count = args->count;
@@ -361,7 +361,7 @@ nfs3_xdr_writeargs(struct rpc_rqst *req,
  * Encode CREATE arguments
  */
 static int
-nfs3_xdr_createargs(struct rpc_rqst *req, u32 *p, struct nfs3_createargs *args)
+nfs3_xdr_createargs(struct rpc_rqst *req, __be32 *p, struct nfs3_createargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -381,7 +381,7 @@ nfs3_xdr_createargs(struct rpc_rqst *req
  * Encode MKDIR arguments
  */
 static int
-nfs3_xdr_mkdirargs(struct rpc_rqst *req, u32 *p, struct nfs3_mkdirargs *args)
+nfs3_xdr_mkdirargs(struct rpc_rqst *req, __be32 *p, struct nfs3_mkdirargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -394,7 +394,7 @@ nfs3_xdr_mkdirargs(struct rpc_rqst *req,
  * Encode SYMLINK arguments
  */
 static int
-nfs3_xdr_symlinkargs(struct rpc_rqst *req, u32 *p, struct nfs3_symlinkargs *args)
+nfs3_xdr_symlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_symlinkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -408,7 +408,7 @@ nfs3_xdr_symlinkargs(struct rpc_rqst *re
  * Encode MKNOD arguments
  */
 static int
-nfs3_xdr_mknodargs(struct rpc_rqst *req, u32 *p, struct nfs3_mknodargs *args)
+nfs3_xdr_mknodargs(struct rpc_rqst *req, __be32 *p, struct nfs3_mknodargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -427,7 +427,7 @@ nfs3_xdr_mknodargs(struct rpc_rqst *req,
  * Encode RENAME arguments
  */
 static int
-nfs3_xdr_renameargs(struct rpc_rqst *req, u32 *p, struct nfs3_renameargs *args)
+nfs3_xdr_renameargs(struct rpc_rqst *req, __be32 *p, struct nfs3_renameargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -441,7 +441,7 @@ nfs3_xdr_renameargs(struct rpc_rqst *req
  * Encode LINK arguments
  */
 static int
-nfs3_xdr_linkargs(struct rpc_rqst *req, u32 *p, struct nfs3_linkargs *args)
+nfs3_xdr_linkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_linkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_fhandle(p, args->tofh);
@@ -454,7 +454,7 @@ nfs3_xdr_linkargs(struct rpc_rqst *req, 
  * Encode arguments to readdir call
  */
 static int
-nfs3_xdr_readdirargs(struct rpc_rqst *req, u32 *p, struct nfs3_readdirargs *args)
+nfs3_xdr_readdirargs(struct rpc_rqst *req, __be32 *p, struct nfs3_readdirargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -483,7 +483,7 @@ nfs3_xdr_readdirargs(struct rpc_rqst *re
  * We just check for syntactical correctness.
  */
 static int
-nfs3_xdr_readdirres(struct rpc_rqst *req, u32 *p, struct nfs3_readdirres *res)
+nfs3_xdr_readdirres(struct rpc_rqst *req, __be32 *p, struct nfs3_readdirres *res)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -491,7 +491,7 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *entry, *end, *kaddr;
+	__be32 *entry, *end, *kaddr;
 
 	status = ntohl(*p++);
 	/* Decode post_op_attrs */
@@ -521,8 +521,8 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
-	end = (u32 *)((char *)p + pglen);
+	kaddr = p = kmap_atomic(*page, KM_USER0);
+	end = (__be32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
 		if (p + 3 > end)
@@ -581,8 +581,8 @@ err_unmap:
 	goto out;
 }
 
-u32 *
-nfs3_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
+__be32 *
+nfs3_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	struct nfs_entry old = *entry;
 
@@ -624,7 +624,7 @@ nfs3_decode_dirent(u32 *p, struct nfs_en
  * Encode COMMIT arguments
  */
 static int
-nfs3_xdr_commitargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs3_xdr_commitargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_hyper(p, args->offset);
@@ -638,7 +638,7 @@ nfs3_xdr_commitargs(struct rpc_rqst *req
  * Encode GETACL arguments
  */
 static int
-nfs3_xdr_getaclargs(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_getaclargs(struct rpc_rqst *req, __be32 *p,
 		    struct nfs3_getaclargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
@@ -662,7 +662,7 @@ nfs3_xdr_getaclargs(struct rpc_rqst *req
  * Encode SETACL arguments
  */
 static int
-nfs3_xdr_setaclargs(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_setaclargs(struct rpc_rqst *req, __be32 *p,
                    struct nfs3_setaclargs *args)
 {
 	struct xdr_buf *buf = &req->rq_snd_buf;
@@ -709,7 +709,7 @@ nfs3_xdr_setaclargs(struct rpc_rqst *req
  * Decode attrstat reply.
  */
 static int
-nfs3_xdr_attrstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_attrstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -724,7 +724,7 @@ nfs3_xdr_attrstat(struct rpc_rqst *req, 
  * SATTR, REMOVE, RMDIR
  */
 static int
-nfs3_xdr_wccstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_wccstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -738,7 +738,7 @@ nfs3_xdr_wccstat(struct rpc_rqst *req, u
  * Decode LOOKUP reply
  */
 static int
-nfs3_xdr_lookupres(struct rpc_rqst *req, u32 *p, struct nfs3_diropres *res)
+nfs3_xdr_lookupres(struct rpc_rqst *req, __be32 *p, struct nfs3_diropres *res)
 {
 	int	status;
 
@@ -757,7 +757,7 @@ nfs3_xdr_lookupres(struct rpc_rqst *req,
  * Decode ACCESS reply
  */
 static int
-nfs3_xdr_accessres(struct rpc_rqst *req, u32 *p, struct nfs3_accessres *res)
+nfs3_xdr_accessres(struct rpc_rqst *req, __be32 *p, struct nfs3_accessres *res)
 {
 	int	status = ntohl(*p++);
 
@@ -769,7 +769,7 @@ nfs3_xdr_accessres(struct rpc_rqst *req,
 }
 
 static int
-nfs3_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs3_readlinkargs *args)
+nfs3_xdr_readlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -787,7 +787,7 @@ nfs3_xdr_readlinkargs(struct rpc_rqst *r
  * Decode READLINK reply
  */
 static int
-nfs3_xdr_readlinkres(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_readlinkres(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -835,7 +835,7 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
  * Decode READ reply
  */
 static int
-nfs3_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
+nfs3_xdr_readres(struct rpc_rqst *req, __be32 *p, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
 	int	status, count, ocount, recvd, hdrlen;
@@ -886,7 +886,7 @@ nfs3_xdr_readres(struct rpc_rqst *req, u
  * Decode WRITE response
  */
 static int
-nfs3_xdr_writeres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs3_xdr_writeres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	int	status;
 
@@ -908,7 +908,7 @@ nfs3_xdr_writeres(struct rpc_rqst *req, 
  * Decode a CREATE response
  */
 static int
-nfs3_xdr_createres(struct rpc_rqst *req, u32 *p, struct nfs3_diropres *res)
+nfs3_xdr_createres(struct rpc_rqst *req, __be32 *p, struct nfs3_diropres *res)
 {
 	int	status;
 
@@ -935,7 +935,7 @@ nfs3_xdr_createres(struct rpc_rqst *req,
  * Decode RENAME reply
  */
 static int
-nfs3_xdr_renameres(struct rpc_rqst *req, u32 *p, struct nfs3_renameres *res)
+nfs3_xdr_renameres(struct rpc_rqst *req, __be32 *p, struct nfs3_renameres *res)
 {
 	int	status;
 
@@ -950,7 +950,7 @@ nfs3_xdr_renameres(struct rpc_rqst *req,
  * Decode LINK reply
  */
 static int
-nfs3_xdr_linkres(struct rpc_rqst *req, u32 *p, struct nfs3_linkres *res)
+nfs3_xdr_linkres(struct rpc_rqst *req, __be32 *p, struct nfs3_linkres *res)
 {
 	int	status;
 
@@ -965,7 +965,7 @@ nfs3_xdr_linkres(struct rpc_rqst *req, u
  * Decode FSSTAT reply
  */
 static int
-nfs3_xdr_fsstatres(struct rpc_rqst *req, u32 *p, struct nfs_fsstat *res)
+nfs3_xdr_fsstatres(struct rpc_rqst *req, __be32 *p, struct nfs_fsstat *res)
 {
 	int		status;
 
@@ -990,7 +990,7 @@ nfs3_xdr_fsstatres(struct rpc_rqst *req,
  * Decode FSINFO reply
  */
 static int
-nfs3_xdr_fsinfores(struct rpc_rqst *req, u32 *p, struct nfs_fsinfo *res)
+nfs3_xdr_fsinfores(struct rpc_rqst *req, __be32 *p, struct nfs_fsinfo *res)
 {
 	int		status;
 
@@ -1018,7 +1018,7 @@ nfs3_xdr_fsinfores(struct rpc_rqst *req,
  * Decode PATHCONF reply
  */
 static int
-nfs3_xdr_pathconfres(struct rpc_rqst *req, u32 *p, struct nfs_pathconf *res)
+nfs3_xdr_pathconfres(struct rpc_rqst *req, __be32 *p, struct nfs_pathconf *res)
 {
 	int		status;
 
@@ -1038,7 +1038,7 @@ nfs3_xdr_pathconfres(struct rpc_rqst *re
  * Decode COMMIT reply
  */
 static int
-nfs3_xdr_commitres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs3_xdr_commitres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	int		status;
 
@@ -1057,7 +1057,7 @@ nfs3_xdr_commitres(struct rpc_rqst *req,
  * Decode GETACL reply
  */
 static int
-nfs3_xdr_getaclres(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_getaclres(struct rpc_rqst *req, __be32 *p,
 		   struct nfs3_getaclres *res)
 {
 	struct xdr_buf *buf = &req->rq_rcv_buf;
@@ -1089,7 +1089,7 @@ nfs3_xdr_getaclres(struct rpc_rqst *req,
  * Decode setacl reply.
  */
 static int
-nfs3_xdr_setaclres(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_setaclres(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int status = ntohl(*p++);
 
Index: linux-sparse/fs/nfs/nfs4_fs.h
===================================================================
--- linux-sparse.orig/fs/nfs/nfs4_fs.h	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs4_fs.h	2005-08-06 18:10:06.000000000 +0400
@@ -233,7 +233,7 @@ extern void nfs4_copy_stateid(nfs4_state
 extern const nfs4_stateid zero_stateid;
 
 /* nfs4xdr.c */
-extern uint32_t *nfs4_decode_dirent(uint32_t *p, struct nfs_entry *entry, int plus);
+extern __be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus);
 extern struct rpc_procinfo nfs4_procedures[];
 
 struct nfs4_mount_data;
Index: linux-sparse/fs/nfs/nfs4proc.c
===================================================================
--- linux-sparse.orig/fs/nfs/nfs4proc.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs4proc.c	2005-08-06 18:08:53.000000000 +0400
@@ -60,7 +60,7 @@ static int nfs4_do_fsinfo(struct nfs_ser
 static int nfs4_async_handle_error(struct rpc_task *, struct nfs_server *);
 static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry);
 static int nfs4_handle_exception(struct nfs_server *server, int errorcode, struct nfs4_exception *exception);
-extern u32 *nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus);
+extern __be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus);
 extern struct rpc_procinfo nfs4_procedures[];
 
 /* Prevent leaks of NFSv4 errors into userland */
@@ -119,7 +119,7 @@ const u32 nfs4_fsinfo_bitmap[2] = { FATT
 static void nfs4_setup_readdir(u64 cookie, u32 *verifier, struct dentry *dentry,
 		struct nfs4_readdir_arg *readdir)
 {
-	u32 *start, *p;
+	__be32 *start, *p;
 
 	BUG_ON(readdir->count < 80);
 	if (cookie > 2) {
@@ -140,7 +140,7 @@ static void nfs4_setup_readdir(u64 cooki
 	 * when talking to the server, we always send cookie 0
 	 * instead of 1 or 2.
 	 */
-	start = p = (u32 *)kmap_atomic(*readdir->pages, KM_USER0);
+	start = p = kmap_atomic(*readdir->pages, KM_USER0);
 	
 	if (cookie == 0) {
 		*p++ = xdr_one;                                  /* next */
@@ -2471,11 +2471,11 @@ int nfs4_proc_setclientid(struct nfs4_cl
 		.rpc_resp = clp,
 		.rpc_cred = clp->cl_cred,
 	};
-	u32 *p;
+	__be32 *p;
 	int loop = 0;
 	int status;
 
-	p = (u32*)sc_verifier.data;
+	p = (__be32*)sc_verifier.data;
 	*p++ = htonl((u32)clp->cl_boot_time.tv_sec);
 	*p = htonl((u32)clp->cl_boot_time.tv_nsec);
 
Index: linux-sparse/fs/nfs/nfs4xdr.c
===================================================================
--- linux-sparse.orig/fs/nfs/nfs4xdr.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/nfs4xdr.c	2005-08-06 18:40:41.000000000 +0400
@@ -430,7 +430,7 @@ struct compound_hdr {
 
 static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4 + len);
 	BUG_ON(p == NULL);
@@ -439,7 +439,7 @@ static void encode_string(struct xdr_str
 
 static int encode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	dprintk("encode_compound: tag=%.*s\n", (int)hdr->taglen, hdr->tag);
 	BUG_ON(hdr->taglen > NFS4_MAXTAGLEN);
@@ -453,7 +453,7 @@ static int encode_compound_hdr(struct xd
 
 static void encode_nfs4_verifier(struct xdr_stream *xdr, const nfs4_verifier *verf)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
 	BUG_ON(p == NULL);
@@ -466,8 +466,8 @@ static int encode_attrs(struct xdr_strea
 	char owner_group[IDMAP_NAMESZ];
 	int owner_namelen = 0;
 	int owner_grouplen = 0;
-	uint32_t *p;
-	uint32_t *q;
+	__be32 *p;
+	__be32 *q;
 	int len;
 	uint32_t bmval0 = 0;
 	uint32_t bmval1 = 0;
@@ -589,7 +589,7 @@ static int encode_attrs(struct xdr_strea
 
 static int encode_access(struct xdr_stream *xdr, u32 access)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8);
 	WRITE32(OP_ACCESS);
@@ -600,7 +600,7 @@ static int encode_access(struct xdr_stre
 
 static int encode_close(struct xdr_stream *xdr, const struct nfs_closeargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid.data));
 	WRITE32(OP_CLOSE);
@@ -612,7 +612,7 @@ static int encode_close(struct xdr_strea
 
 static int encode_commit(struct xdr_stream *xdr, const struct nfs_writeargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
         
         RESERVE_SPACE(16);
         WRITE32(OP_COMMIT);
@@ -624,7 +624,7 @@ static int encode_commit(struct xdr_stre
 
 static int encode_create(struct xdr_stream *xdr, const struct nfs4_create_arg *create)
 {
-	uint32_t *p;
+	__be32 *p;
 	
 	RESERVE_SPACE(8);
 	WRITE32(OP_CREATE);
@@ -656,7 +656,7 @@ static int encode_create(struct xdr_stre
 
 static int encode_getattr_one(struct xdr_stream *xdr, uint32_t bitmap)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(12);
         WRITE32(OP_GETATTR);
@@ -667,7 +667,7 @@ static int encode_getattr_one(struct xdr
 
 static int encode_getattr_two(struct xdr_stream *xdr, uint32_t bm0, uint32_t bm1)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(16);
         WRITE32(OP_GETATTR);
@@ -692,7 +692,7 @@ static int encode_fsinfo(struct xdr_stre
 
 static int encode_getfh(struct xdr_stream *xdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_GETFH);
@@ -702,7 +702,7 @@ static int encode_getfh(struct xdr_strea
 
 static int encode_link(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + name->len);
 	WRITE32(OP_LINK);
@@ -718,7 +718,7 @@ static int encode_link(struct xdr_stream
  */
 static int encode_lock(struct xdr_stream *xdr, const struct nfs_lockargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 	struct nfs_lock_opargs *opargs = arg->u.lock;
 
 	RESERVE_SPACE(32);
@@ -752,7 +752,7 @@ static int encode_lock(struct xdr_stream
 
 static int encode_lockt(struct xdr_stream *xdr, const struct nfs_lockargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 	struct nfs_lowner *opargs = arg->u.lockt;
 
 	RESERVE_SPACE(40);
@@ -769,7 +769,7 @@ static int encode_lockt(struct xdr_strea
 
 static int encode_locku(struct xdr_stream *xdr, const struct nfs_lockargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 	struct nfs_locku_opargs *opargs = arg->u.locku;
 
 	RESERVE_SPACE(44);
@@ -786,7 +786,7 @@ static int encode_locku(struct xdr_strea
 static int encode_lookup(struct xdr_stream *xdr, const struct qstr *name)
 {
 	int len = name->len;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + len);
 	WRITE32(OP_LOOKUP);
@@ -798,7 +798,7 @@ static int encode_lookup(struct xdr_stre
 
 static void encode_share_access(struct xdr_stream *xdr, int open_flags)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8);
 	switch (open_flags & (FMODE_READ|FMODE_WRITE)) {
@@ -819,7 +819,7 @@ static void encode_share_access(struct x
 
 static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
  /*
  * opcode 4, seqid 4, share_access 4, share_deny 4, clientid 8, ownerlen 4,
  * owner 4 = 32
@@ -836,7 +836,7 @@ static inline void encode_openhdr(struct
 
 static inline void encode_createmode(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch(arg->open_flags & O_EXCL) {
@@ -852,7 +852,7 @@ static inline void encode_createmode(str
 
 static void encode_opentype(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch (arg->open_flags & O_CREAT) {
@@ -868,7 +868,7 @@ static void encode_opentype(struct xdr_s
 
 static inline void encode_delegation_type(struct xdr_stream *xdr, int delegation_type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch (delegation_type) {
@@ -888,7 +888,7 @@ static inline void encode_delegation_typ
 
 static inline void encode_claim_null(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(NFS4_OPEN_CLAIM_NULL);
@@ -897,7 +897,7 @@ static inline void encode_claim_null(str
 
 static inline void encode_claim_previous(struct xdr_stream *xdr, int type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(NFS4_OPEN_CLAIM_PREVIOUS);
@@ -906,7 +906,7 @@ static inline void encode_claim_previous
 
 static inline void encode_claim_delegate_cur(struct xdr_stream *xdr, const struct qstr *name, const nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4+sizeof(stateid->data));
 	WRITE32(NFS4_OPEN_CLAIM_DELEGATE_CUR);
@@ -936,7 +936,7 @@ static int encode_open(struct xdr_stream
 
 static int encode_open_confirm(struct xdr_stream *xdr, const struct nfs_open_confirmargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid.data));
 	WRITE32(OP_OPEN_CONFIRM);
@@ -948,7 +948,7 @@ static int encode_open_confirm(struct xd
 
 static int encode_open_downgrade(struct xdr_stream *xdr, const struct nfs_closeargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid.data));
 	WRITE32(OP_OPEN_DOWNGRADE);
@@ -962,7 +962,7 @@ static int
 encode_putfh(struct xdr_stream *xdr, const struct nfs_fh *fh)
 {
 	int len = fh->size;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + len);
 	WRITE32(OP_PUTFH);
@@ -974,7 +974,7 @@ encode_putfh(struct xdr_stream *xdr, con
 
 static int encode_putrootfh(struct xdr_stream *xdr)
 {
-        uint32_t *p;
+        __be32 *p;
         
         RESERVE_SPACE(4);
         WRITE32(OP_PUTROOTFH);
@@ -985,7 +985,7 @@ static int encode_putrootfh(struct xdr_s
 static void encode_stateid(struct xdr_stream *xdr, const struct nfs_open_context *ctx)
 {
 	nfs4_stateid stateid;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(16);
 	if (ctx->state != NULL) {
@@ -997,7 +997,7 @@ static void encode_stateid(struct xdr_st
 
 static int encode_read(struct xdr_stream *xdr, const struct nfs_readargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_READ);
@@ -1019,7 +1019,7 @@ static int encode_readdir(struct xdr_str
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
 	int replen;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(32+sizeof(nfs4_verifier));
 	WRITE32(OP_READDIR);
@@ -1061,7 +1061,7 @@ static int encode_readlink(struct xdr_st
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_READLINK);
@@ -1079,7 +1079,7 @@ static int encode_readlink(struct xdr_st
 
 static int encode_remove(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + name->len);
 	WRITE32(OP_REMOVE);
@@ -1091,7 +1091,7 @@ static int encode_remove(struct xdr_stre
 
 static int encode_rename(struct xdr_stream *xdr, const struct qstr *oldname, const struct qstr *newname)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + oldname->len);
 	WRITE32(OP_RENAME);
@@ -1107,7 +1107,7 @@ static int encode_rename(struct xdr_stre
 
 static int encode_renew(struct xdr_stream *xdr, const struct nfs4_client *client_stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(12);
 	WRITE32(OP_RENEW);
@@ -1119,7 +1119,7 @@ static int encode_renew(struct xdr_strea
 static int
 encode_setacl(struct xdr_stream *xdr, struct nfs_setaclargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4+sizeof(zero_stateid.data));
 	WRITE32(OP_SETATTR);
@@ -1138,7 +1138,7 @@ encode_setacl(struct xdr_stream *xdr, st
 static int
 encode_savefh(struct xdr_stream *xdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_SAVEFH);
@@ -1149,7 +1149,7 @@ encode_savefh(struct xdr_stream *xdr)
 static int encode_setattr(struct xdr_stream *xdr, const struct nfs_setattrargs *arg, const struct nfs_server *server)
 {
 	int status;
-	uint32_t *p;
+	__be32 *p;
 	
         RESERVE_SPACE(4+sizeof(arg->stateid.data));
         WRITE32(OP_SETATTR);
@@ -1163,7 +1163,7 @@ static int encode_setattr(struct xdr_str
 
 static int encode_setclientid(struct xdr_stream *xdr, const struct nfs4_setclientid *setclientid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4 + sizeof(setclientid->sc_verifier->data));
 	WRITE32(OP_SETCLIENTID);
@@ -1182,7 +1182,7 @@ static int encode_setclientid(struct xdr
 
 static int encode_setclientid_confirm(struct xdr_stream *xdr, const struct nfs4_client *client_state)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(12 + sizeof(client_state->cl_confirm.data));
         WRITE32(OP_SETCLIENTID_CONFIRM);
@@ -1194,7 +1194,7 @@ static int encode_setclientid_confirm(st
 
 static int encode_write(struct xdr_stream *xdr, const struct nfs_writeargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_WRITE);
@@ -1213,7 +1213,7 @@ static int encode_write(struct xdr_strea
 
 static int encode_delegreturn(struct xdr_stream *xdr, const nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(20);
 
@@ -1936,7 +1936,7 @@ static int nfs4_xdr_enc_delegreturn(stru
 
 static int decode_opaque_inline(struct xdr_stream *xdr, uint32_t *len, char **string)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(*len);
@@ -1947,7 +1947,7 @@ static int decode_opaque_inline(struct x
 
 static int decode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(8);
 	READ32(hdr->status);
@@ -1962,7 +1962,7 @@ static int decode_compound_hdr(struct xd
 
 static int decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t opnum;
 	int32_t nfserr;
 
@@ -1984,7 +1984,7 @@ static int decode_op_hdr(struct xdr_stre
 /* Dummy routine */
 static int decode_ace(struct xdr_stream *xdr, void *ace, struct nfs4_client *clp)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t strlen;
 	char *str;
 
@@ -1994,7 +1994,8 @@ static int decode_ace(struct xdr_stream 
 
 static int decode_attr_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 {
-	uint32_t bmlen, *p;
+	uint32_t bmlen;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(bmlen);
@@ -2011,7 +2012,7 @@ static int decode_attr_bitmap(struct xdr
 
 static inline int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen, uint32_t **savep)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(*attrlen);
@@ -2032,7 +2033,7 @@ static int decode_attr_supported(struct 
 
 static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*type = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_TYPE - 1U)))
@@ -2052,7 +2053,7 @@ static int decode_attr_type(struct xdr_s
 
 static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *change)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*change = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_CHANGE - 1U)))
@@ -2069,7 +2070,7 @@ static int decode_attr_change(struct xdr
 
 static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *size)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*size = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_SIZE - 1U)))
@@ -2085,7 +2086,7 @@ static int decode_attr_size(struct xdr_s
 
 static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_LINK_SUPPORT - 1U)))
@@ -2101,7 +2102,7 @@ static int decode_attr_link_support(stru
 
 static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_SYMLINK_SUPPORT - 1U)))
@@ -2117,7 +2118,7 @@ static int decode_attr_symlink_support(s
 
 static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_fsid *fsid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	fsid->major = 0;
 	fsid->minor = 0;
@@ -2137,7 +2138,7 @@ static int decode_attr_fsid(struct xdr_s
 
 static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 60;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_LEASE_TIME - 1U)))
@@ -2153,7 +2154,7 @@ static int decode_attr_lease_time(struct
 
 static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = ACL4_SUPPORT_ALLOW_ACL|ACL4_SUPPORT_DENY_ACL;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_ACLSUPPORT - 1U)))
@@ -2169,7 +2170,7 @@ static int decode_attr_aclsupport(struct
 
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*fileid = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_FILEID - 1U)))
@@ -2185,7 +2186,7 @@ static int decode_attr_fileid(struct xdr
 
 static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2202,7 +2203,7 @@ static int decode_attr_files_avail(struc
 
 static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2219,7 +2220,7 @@ static int decode_attr_files_free(struct
 
 static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2236,7 +2237,7 @@ static int decode_attr_files_total(struc
 
 static int decode_attr_maxfilesize(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2253,7 +2254,7 @@ static int decode_attr_maxfilesize(struc
 
 static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxlink)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*maxlink = 1;
@@ -2270,7 +2271,7 @@ static int decode_attr_maxlink(struct xd
 
 static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxname)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*maxname = 1024;
@@ -2287,7 +2288,7 @@ static int decode_attr_maxname(struct xd
 
 static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 1024;
@@ -2308,7 +2309,7 @@ static int decode_attr_maxread(struct xd
 
 static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 1024;
@@ -2329,7 +2330,7 @@ static int decode_attr_maxwrite(struct x
 
 static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *mode)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*mode = 0;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_MODE - 1U)))
@@ -2346,7 +2347,7 @@ static int decode_attr_mode(struct xdr_s
 
 static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *nlink)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*nlink = 1;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_NUMLINKS - 1U)))
@@ -2362,7 +2363,8 @@ static int decode_attr_nlink(struct xdr_
 
 static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_client *clp, int32_t *uid)
 {
-	uint32_t len, *p;
+	uint32_t len;
+	__be32 *p;
 
 	*uid = -2;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_OWNER - 1U)))
@@ -2386,7 +2388,8 @@ static int decode_attr_owner(struct xdr_
 
 static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_client *clp, int32_t *gid)
 {
-	uint32_t len, *p;
+	uint32_t len;
+	__be32 *p;
 
 	*gid = -2;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_OWNER_GROUP - 1U)))
@@ -2410,7 +2413,8 @@ static int decode_attr_group(struct xdr_
 
 static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rdev)
 {
-	uint32_t major = 0, minor = 0, *p;
+	uint32_t major = 0, minor = 0;
+	__be32 *p;
 
 	*rdev = MKDEV(0,0);
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_RAWDEV - 1U)))
@@ -2432,7 +2436,7 @@ static int decode_attr_rdev(struct xdr_s
 
 static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2449,7 +2453,7 @@ static int decode_attr_space_avail(struc
 
 static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2466,7 +2470,7 @@ static int decode_attr_space_free(struct
 
 static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2483,7 +2487,7 @@ static int decode_attr_space_total(struc
 
 static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *used)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*used = 0;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_SPACE_USED - 1U)))
@@ -2500,7 +2504,7 @@ static int decode_attr_space_used(struct
 
 static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint64_t sec;
 	uint32_t nsec;
 
@@ -2578,7 +2582,7 @@ static int verify_attr_len(struct xdr_st
 
 static int decode_change_info(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(20);
 	READ32(cinfo->atomic);
@@ -2589,7 +2593,7 @@ static int decode_change_info(struct xdr
 
 static int decode_access(struct xdr_stream *xdr, struct nfs4_accessres *access)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t supp, acc;
 	int status;
 
@@ -2606,7 +2610,7 @@ static int decode_access(struct xdr_stre
 
 static int decode_close(struct xdr_stream *xdr, struct nfs_closeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_CLOSE);
@@ -2619,7 +2623,7 @@ static int decode_close(struct xdr_strea
 
 static int decode_commit(struct xdr_stream *xdr, struct nfs_writeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_COMMIT);
@@ -2632,7 +2636,7 @@ static int decode_commit(struct xdr_stre
 
 static int decode_create(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t bmlen;
 	int status;
 
@@ -2833,7 +2837,7 @@ xdr_error:
 
 static int decode_getfh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t len;
 	int status;
 
@@ -2868,7 +2872,7 @@ static int decode_link(struct xdr_stream
  */
 static int decode_lock_denied (struct xdr_stream *xdr, struct nfs_lock_denied *denied)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t namelen;
 
 	READ_BUF(32);
@@ -2885,7 +2889,7 @@ static int decode_lock_denied (struct xd
 
 static int decode_lock(struct xdr_stream *xdr, struct nfs_lockres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_LOCK);
@@ -2908,7 +2912,7 @@ static int decode_lockt(struct xdr_strea
 
 static int decode_locku(struct xdr_stream *xdr, struct nfs_lockres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_LOCKU);
@@ -2927,7 +2931,7 @@ static int decode_lookup(struct xdr_stre
 /* This is too sick! */
 static int decode_space_limit(struct xdr_stream *xdr, u64 *maxsize)
 {
-        uint32_t *p;
+        __be32 *p;
 	uint32_t limit_type, nblocks, blocksize;
 
 	READ_BUF(12);
@@ -2946,7 +2950,7 @@ static int decode_space_limit(struct xdr
 
 static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 {
-        uint32_t *p;
+        __be32 *p;
         uint32_t delegation_type;
 
 	READ_BUF(4);
@@ -2972,7 +2976,7 @@ static int decode_delegation(struct xdr_
 
 static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 {
-        uint32_t *p;
+        __be32 *p;
         uint32_t bmlen;
         int status;
 
@@ -3000,7 +3004,7 @@ xdr_error:
 
 static int decode_open_confirm(struct xdr_stream *xdr, struct nfs_open_confirmres *res)
 {
-        uint32_t *p;
+        __be32 *p;
 	int status;
 
         status = decode_op_hdr(xdr, OP_OPEN_CONFIRM);
@@ -3013,7 +3017,7 @@ static int decode_open_confirm(struct xd
 
 static int decode_open_downgrade(struct xdr_stream *xdr, struct nfs_closeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_OPEN_DOWNGRADE);
@@ -3037,7 +3041,7 @@ static int decode_putrootfh(struct xdr_s
 static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
-	uint32_t *p;
+	__be32 *p;
 	uint32_t count, eof, recvd, hdrlen;
 	int status;
 
@@ -3067,7 +3071,7 @@ static int decode_readdir(struct xdr_str
 	struct page	*page = *rcvbuf->pages;
 	struct kvec	*iov = rcvbuf->head;
 	unsigned int	nr, pglen = rcvbuf->page_len;
-	uint32_t	*end, *entry, *p, *kaddr;
+	__be32		*end, *entry, *p, *kaddr;
 	uint32_t	len, attrlen;
 	int 		hdrlen, recvd, status;
 
@@ -3089,8 +3093,8 @@ static int decode_readdir(struct xdr_str
 	xdr_read_pages(xdr, pglen);
 
 	BUG_ON(pglen + readdir->pgbase > PAGE_CACHE_SIZE);
-	kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
-	end = (uint32_t *) ((char *)p + pglen + readdir->pgbase);
+	kaddr = p = kmap_atomic(page, KM_USER0);
+	end = (__be32 *) ((char *)p + pglen + readdir->pgbase);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
 		if (p + 3 > end)
@@ -3140,7 +3144,7 @@ static int decode_readlink(struct xdr_st
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
 	int hdrlen, len, recvd;
-	uint32_t *p;
+	__be32 *p;
 	char *kaddr;
 	int status;
 
@@ -3257,7 +3261,7 @@ decode_savefh(struct xdr_stream *xdr)
 
 static int decode_setattr(struct xdr_stream *xdr, struct nfs_setattrres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t bmlen;
 	int status;
 
@@ -3273,7 +3277,7 @@ static int decode_setattr(struct xdr_str
 
 static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_client *clp)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t opnum;
 	int32_t nfserr;
 
@@ -3316,7 +3320,7 @@ static int decode_setclientid_confirm(st
 
 static int decode_write(struct xdr_stream *xdr, struct nfs_writeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_WRITE);
@@ -4047,7 +4051,7 @@ static int nfs4_xdr_dec_delegreturn(stru
 	return status;
 }
 
-uint32_t *nfs4_decode_dirent(uint32_t *p, struct nfs_entry *entry, int plus)
+__be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	uint32_t bitmap[2] = {0};
 	uint32_t len;
Index: linux-sparse/fs/nfs/proc.c
===================================================================
--- linux-sparse.orig/fs/nfs/proc.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/proc.c	2005-08-06 17:41:30.000000000 +0400
@@ -532,7 +532,7 @@ nfs_proc_pathconf(struct nfs_server *ser
 	return 0;
 }
 
-extern u32 * nfs_decode_dirent(u32 *, struct nfs_entry *, int);
+extern __be32 * nfs_decode_dirent(__be32 *, struct nfs_entry *, int);
 
 static void
 nfs_read_done(struct rpc_task *task)
Index: linux-sparse/include/linux/nfs_xdr.h
===================================================================
--- linux-sparse.orig/include/linux/nfs_xdr.h	2005-08-06 12:37:56.000000000 +0400
+++ linux-sparse/include/linux/nfs_xdr.h	2005-08-06 17:42:16.000000000 +0400
@@ -745,7 +745,7 @@ struct nfs_rpc_ops {
 			    struct nfs_fsinfo *);
 	int	(*pathconf) (struct nfs_server *, struct nfs_fh *,
 			     struct nfs_pathconf *);
-	u32 *	(*decode_dirent)(u32 *, struct nfs_entry *, int plus);
+	__be32 *(*decode_dirent)(__be32 *, struct nfs_entry *, int plus);
 	void	(*read_setup)   (struct nfs_read_data *);
 	void	(*write_setup)  (struct nfs_write_data *, int how);
 	void	(*commit_setup) (struct nfs_write_data *, int how);
Index: linux-sparse/fs/nfs/callback_xdr.c
===================================================================
--- linux-sparse.orig/fs/nfs/callback_xdr.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/callback_xdr.c	2005-08-06 20:51:25.000000000 +0400
@@ -52,9 +52,9 @@ static int nfs4_encode_void(struct svc_r
 	return xdr_ressize_check(rqstp, p);
 }
 
-static uint32_t *read_buf(struct xdr_stream *xdr, int nbytes)
+static __be32 *read_buf(struct xdr_stream *xdr, int nbytes)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_inline_decode(xdr, nbytes);
 	if (unlikely(p == NULL))
@@ -62,9 +62,9 @@ static uint32_t *read_buf(struct xdr_str
 	return p;
 }
 
-static unsigned decode_string(struct xdr_stream *xdr, unsigned int *len, const char **str)
+static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len, const char **str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
@@ -82,9 +82,9 @@ static unsigned decode_string(struct xdr
 	return 0;
 }
 
-static unsigned decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
+static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
@@ -100,9 +100,9 @@ static unsigned decode_fh(struct xdr_str
 	return 0;
 }
 
-static unsigned decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
+static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 {
-	uint32_t *p;
+	__be32 *p;
 	unsigned int attrlen;
 
 	p = read_buf(xdr, 4);
@@ -119,9 +119,9 @@ static unsigned decode_bitmap(struct xdr
 	return 0;
 }
 
-static unsigned decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
+static __be32 decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 16);
 	if (unlikely(p == NULL))
@@ -130,11 +130,11 @@ static unsigned decode_stateid(struct xd
 	return 0;
 }
 
-static unsigned decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound_hdr_arg *hdr)
+static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound_hdr_arg *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 	unsigned int minor_version;
-	unsigned status;
+	__be32 status;
 
 	status = decode_string(xdr, &hdr->taglen, &hdr->tag);
 	if (unlikely(status != 0))
@@ -160,9 +160,9 @@ static unsigned decode_compound_hdr_arg(
 	return 0;
 }
 
-static unsigned decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
+static __be32 decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
 {
-	uint32_t *p;
+	__be32 *p;
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
@@ -170,9 +170,9 @@ static unsigned decode_op_hdr(struct xdr
 	return 0;
 }
 
-static unsigned decode_getattr_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_getattrargs *args)
+static __be32 decode_getattr_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_getattrargs *args)
 {
-	unsigned status;
+	__be32 status;
 
 	status = decode_fh(xdr, &args->fh);
 	if (unlikely(status != 0))
@@ -186,8 +186,8 @@ out:
 
 static unsigned decode_recall_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_recallargs *args)
 {
-	uint32_t *p;
-	unsigned status;
+	__be32 *p;
+	__be32 status;
 
 	args->addr = &rqstp->rq_addr;
 	status = decode_stateid(xdr, &args->stateid);
@@ -205,9 +205,9 @@ out:
 	return 0;
 }
 
-static unsigned encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
+static __be32 encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4 + len);
 	if (unlikely(p == NULL))
@@ -218,10 +218,10 @@ static unsigned encode_string(struct xdr
 
 #define CB_SUPPORTED_ATTR0 (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE)
 #define CB_SUPPORTED_ATTR1 (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY)
-static unsigned encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, uint32_t **savep)
+static __be32 encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, __be32 **savep)
 {
-	uint32_t bm[2];
-	uint32_t *p;
+	__be32 bm[2];
+	__be32 *p;
 
 	bm[0] = htonl(bitmap[0] & CB_SUPPORTED_ATTR0);
 	bm[1] = htonl(bitmap[1] & CB_SUPPORTED_ATTR1);
@@ -248,9 +248,9 @@ static unsigned encode_attr_bitmap(struc
 	return 0;
 }
 
-static unsigned encode_attr_change(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t change)
+static __be32 encode_attr_change(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t change)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	if (!(bitmap[0] & FATTR4_WORD0_CHANGE))
 		return 0;
@@ -261,9 +261,9 @@ static unsigned encode_attr_change(struc
 	return 0;
 }
 
-static unsigned encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t size)
+static __be32 encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t size)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	if (!(bitmap[0] & FATTR4_WORD0_SIZE))
 		return 0;
@@ -274,9 +274,9 @@ static unsigned encode_attr_size(struct 
 	return 0;
 }
 
-static unsigned encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
+static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 12);
 	if (unlikely(p == 0))
@@ -286,23 +286,23 @@ static unsigned encode_attr_time(struct 
 	return 0;
 }
 
-static unsigned encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
+static __be32 encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_METADATA))
 		return 0;
 	return encode_attr_time(xdr,time);
 }
 
-static unsigned encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
+static __be32 encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_MODIFY))
 		return 0;
 	return encode_attr_time(xdr,time);
 }
 
-static unsigned encode_compound_hdr_res(struct xdr_stream *xdr, struct cb_compound_hdr_res *hdr)
+static __be32 encode_compound_hdr_res(struct xdr_stream *xdr, struct cb_compound_hdr_res *hdr)
 {
-	unsigned status;
+	__be32 status;
 
 	hdr->status = xdr_reserve_space(xdr, 4);
 	if (unlikely(hdr->status == NULL))
@@ -316,9 +316,9 @@ static unsigned encode_compound_hdr_res(
 	return 0;
 }
 
-static unsigned encode_op_hdr(struct xdr_stream *xdr, uint32_t op, uint32_t res)
+static __be32 encode_op_hdr(struct xdr_stream *xdr, uint32_t op, __be32 res)
 {
-	uint32_t *p;
+	__be32 *p;
 	
 	p = xdr_reserve_space(xdr, 8);
 	if (unlikely(p == NULL))
@@ -328,10 +328,10 @@ static unsigned encode_op_hdr(struct xdr
 	return 0;
 }
 
-static unsigned encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr, const struct cb_getattrres *res)
+static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr, const struct cb_getattrres *res)
 {
-	uint32_t *savep;
-	unsigned status = res->status;
+	__be32 *savep;
+	__be32 status = res->status;
 	
 	if (unlikely(status != 0))
 		goto out;
@@ -354,15 +354,15 @@ out:
 	return status;
 }
 
-static unsigned process_op(struct svc_rqst *rqstp,
+static __be32 process_op(struct svc_rqst *rqstp,
 		struct xdr_stream *xdr_in, void *argp,
 		struct xdr_stream *xdr_out, void *resp)
 {
 	struct callback_op *op;
 	unsigned int op_nr;
-	unsigned int status = 0;
+	__be32 status = 0;
 	long maxlen;
-	unsigned res;
+	__be32 res;
 
 	dprintk("%s: start\n", __FUNCTION__);
 	status = decode_op_hdr(xdr_in, &op_nr);
@@ -403,7 +403,7 @@ static int nfs4_callback_compound(struct
 	struct cb_compound_hdr_res hdr_res;
 	struct xdr_stream xdr_in, xdr_out;
 	uint32_t *p;
-	unsigned int status;
+	__be32 status;
 	unsigned int nops = 1;
 
 	dprintk("%s: start\n", __FUNCTION__);
Index: linux-sparse/fs/nfs/callback.h
===================================================================
--- linux-sparse.orig/fs/nfs/callback.h	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/callback.h	2005-08-06 18:59:59.000000000 +0400
@@ -60,7 +60,7 @@ struct cb_recallargs {
 };
 
 extern unsigned nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res);
-extern unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
+extern __be32 nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
 
 extern int nfs_callback_up(void);
 extern int nfs_callback_down(void);
Index: linux-sparse/fs/nfs/callback_proc.c
===================================================================
--- linux-sparse.orig/fs/nfs/callback_proc.c	2005-08-06 12:37:48.000000000 +0400
+++ linux-sparse/fs/nfs/callback_proc.c	2005-08-06 18:59:45.000000000 +0400
@@ -53,11 +53,11 @@ out:
 	return res->status;
 }
 
-unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy)
+__be32 nfs4_callback_recall(struct cb_recallargs *args, void *dummy)
 {
 	struct nfs4_client *clp;
 	struct inode *inode;
-	unsigned res;
+	__be32 res;
 	
 	res = htonl(NFS4ERR_BADHANDLE);
 	clp = nfs4_find_client(&args->addr->sin_addr);


