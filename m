Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWJJDM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWJJDM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWJJDMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:12:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9133 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964824AbWJJDLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:51 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/25] fs/nfs/callback* passes error values big-endian
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX823-0004C6-2Y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/callback.h      |    6 ++---
 fs/nfs/callback_proc.c |    6 ++---
 fs/nfs/callback_xdr.c  |   60 ++++++++++++++++++++++++------------------------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 5676163..6921d82 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -44,7 +44,7 @@ struct cb_getattrargs {
 };
 
 struct cb_getattrres {
-	uint32_t status;
+	__be32 status;
 	uint32_t bitmap[2];
 	uint64_t size;
 	uint64_t change_attr;
@@ -59,8 +59,8 @@ struct cb_recallargs {
 	uint32_t truncate;
 };
 
-extern unsigned nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res);
-extern unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
+extern __be32 nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res);
+extern __be32 nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
 
 #ifdef CONFIG_NFS_V4
 extern int nfs_callback_up(void);
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 97cf8f7..72e55d8 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -14,7 +14,7 @@ #include "internal.h"
 
 #define NFSDBG_FACILITY NFSDBG_CALLBACK
  
-unsigned nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res)
+__be32 nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res)
 {
 	struct nfs_client *clp;
 	struct nfs_delegation *delegation;
@@ -55,11 +55,11 @@ out:
 	return res->status;
 }
 
-unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy)
+__be32 nfs4_callback_recall(struct cb_recallargs *args, void *dummy)
 {
 	struct nfs_client *clp;
 	struct inode *inode;
-	unsigned res;
+	__be32 res;
 	
 	res = htonl(NFS4ERR_BADHANDLE);
 	clp = nfs_find_client(args->addr, 4);
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 5998d0c..909a140 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -22,9 +22,9 @@ #define CB_OP_RECALL_RES_MAXSZ	(CB_OP_HD
 
 #define NFSDBG_FACILITY NFSDBG_CALLBACK
 
-typedef unsigned (*callback_process_op_t)(void *, void *);
-typedef unsigned (*callback_decode_arg_t)(struct svc_rqst *, struct xdr_stream *, void *);
-typedef unsigned (*callback_encode_res_t)(struct svc_rqst *, struct xdr_stream *, void *);
+typedef __be32 (*callback_process_op_t)(void *, void *);
+typedef __be32 (*callback_decode_arg_t)(struct svc_rqst *, struct xdr_stream *, void *);
+typedef __be32 (*callback_encode_res_t)(struct svc_rqst *, struct xdr_stream *, void *);
 
 
 struct callback_op {
@@ -61,7 +61,7 @@ static uint32_t *read_buf(struct xdr_str
 	return p;
 }
 
-static unsigned decode_string(struct xdr_stream *xdr, unsigned int *len, const char **str)
+static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len, const char **str)
 {
 	uint32_t *p;
 
@@ -81,7 +81,7 @@ static unsigned decode_string(struct xdr
 	return 0;
 }
 
-static unsigned decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
+static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
 	uint32_t *p;
 
@@ -99,7 +99,7 @@ static unsigned decode_fh(struct xdr_str
 	return 0;
 }
 
-static unsigned decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
+static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 {
 	uint32_t *p;
 	unsigned int attrlen;
@@ -118,7 +118,7 @@ static unsigned decode_bitmap(struct xdr
 	return 0;
 }
 
-static unsigned decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
+static __be32 decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	uint32_t *p;
 
@@ -129,11 +129,11 @@ static unsigned decode_stateid(struct xd
 	return 0;
 }
 
-static unsigned decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound_hdr_arg *hdr)
+static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound_hdr_arg *hdr)
 {
 	uint32_t *p;
 	unsigned int minor_version;
-	unsigned status;
+	__be32 status;
 
 	status = decode_string(xdr, &hdr->taglen, &hdr->tag);
 	if (unlikely(status != 0))
@@ -159,7 +159,7 @@ static unsigned decode_compound_hdr_arg(
 	return 0;
 }
 
-static unsigned decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
+static __be32 decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
 {
 	uint32_t *p;
 	p = read_buf(xdr, 4);
@@ -169,9 +169,9 @@ static unsigned decode_op_hdr(struct xdr
 	return 0;
 }
 
-static unsigned decode_getattr_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_getattrargs *args)
+static __be32 decode_getattr_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_getattrargs *args)
 {
-	unsigned status;
+	__be32 status;
 
 	status = decode_fh(xdr, &args->fh);
 	if (unlikely(status != 0))
@@ -183,10 +183,10 @@ out:
 	return status;
 }
 
-static unsigned decode_recall_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_recallargs *args)
+static __be32 decode_recall_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_recallargs *args)
 {
 	uint32_t *p;
-	unsigned status;
+	__be32 status;
 
 	args->addr = &rqstp->rq_addr;
 	status = decode_stateid(xdr, &args->stateid);
@@ -204,7 +204,7 @@ out:
 	return status;
 }
 
-static unsigned encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
+static __be32 encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
 	uint32_t *p;
 
@@ -217,7 +217,7 @@ static unsigned encode_string(struct xdr
 
 #define CB_SUPPORTED_ATTR0 (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE)
 #define CB_SUPPORTED_ATTR1 (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY)
-static unsigned encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, uint32_t **savep)
+static __be32 encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, uint32_t **savep)
 {
 	uint32_t bm[2];
 	uint32_t *p;
@@ -247,7 +247,7 @@ static unsigned encode_attr_bitmap(struc
 	return 0;
 }
 
-static unsigned encode_attr_change(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t change)
+static __be32 encode_attr_change(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t change)
 {
 	uint32_t *p;
 
@@ -260,7 +260,7 @@ static unsigned encode_attr_change(struc
 	return 0;
 }
 
-static unsigned encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t size)
+static __be32 encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t size)
 {
 	uint32_t *p;
 
@@ -273,7 +273,7 @@ static unsigned encode_attr_size(struct 
 	return 0;
 }
 
-static unsigned encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
+static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
 {
 	uint32_t *p;
 
@@ -285,23 +285,23 @@ static unsigned encode_attr_time(struct 
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
@@ -315,7 +315,7 @@ static unsigned encode_compound_hdr_res(
 	return 0;
 }
 
-static unsigned encode_op_hdr(struct xdr_stream *xdr, uint32_t op, uint32_t res)
+static __be32 encode_op_hdr(struct xdr_stream *xdr, uint32_t op, __be32 res)
 {
 	uint32_t *p;
 	
@@ -327,10 +327,10 @@ static unsigned encode_op_hdr(struct xdr
 	return 0;
 }
 
-static unsigned encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr, const struct cb_getattrres *res)
+static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr, const struct cb_getattrres *res)
 {
 	uint32_t *savep = NULL;
-	unsigned status = res->status;
+	__be32 status = res->status;
 	
 	if (unlikely(status != 0))
 		goto out;
@@ -353,15 +353,15 @@ out:
 	return status;
 }
 
-static unsigned process_op(struct svc_rqst *rqstp,
+static __be32 process_op(struct svc_rqst *rqstp,
 		struct xdr_stream *xdr_in, void *argp,
 		struct xdr_stream *xdr_out, void *resp)
 {
 	struct callback_op *op = &callback_ops[0];
 	unsigned int op_nr = OP_CB_ILLEGAL;
-	unsigned int status = 0;
+	__be32 status = 0;
 	long maxlen;
-	unsigned res;
+	__be32 res;
 
 	dprintk("%s: start\n", __FUNCTION__);
 	status = decode_op_hdr(xdr_in, &op_nr);
@@ -405,7 +405,7 @@ static __be32 nfs4_callback_compound(str
 	struct cb_compound_hdr_res hdr_res;
 	struct xdr_stream xdr_in, xdr_out;
 	uint32_t *p;
-	unsigned int status;
+	__be32 status;
 	unsigned int nops = 1;
 
 	dprintk("%s: start\n", __FUNCTION__);
-- 
1.4.2.GIT


