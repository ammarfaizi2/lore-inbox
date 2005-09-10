Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVIJQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVIJQay (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVIJQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:30:54 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:57540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750999AbVIJQax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:30:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Thzde2znp2GCdLvwFFL9uvoBT+MFFOdwNHJbosNExu5WQNRcDMjWEetlx+r5mPSLquqVxR1vr8R9+KY5yJAXUGt71pxzB+bEVhhWeMYGpX+IcwBJOJsTb52Qi/2dz7R1KLARKLk4myZ7vLY4o8hdFZuI43g7mPE8eOo/2GAS5fM=
Date: Sat, 10 Sep 2005 20:40:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sunrpc: add endian annotations
Message-ID: <20050910164051.GA23850@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal patch to remove junk endianness warnings from net/sunrpc/*.

* usual s/u32/__be32/.
* add svc_getnl():
	Take network-endian value from buffer, convert to host-endian
	and return it.
* add svc_putnl():
	Take host-endian value, convert to network-endian and put it
	into a buffer.
* convert to svc_getnl(), svc_putnl().

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sunrpc/auth.h         |   16 +++++-----
 include/linux/sunrpc/svc.h          |   23 +++++++++++++--
 include/linux/sunrpc/svcauth.h      |    4 +-
 include/linux/sunrpc/xdr.h          |   20 ++++++-------
 include/linux/sunrpc/xprt.h         |    8 ++---
 net/sunrpc/auth.c                   |   12 ++++----
 net/sunrpc/auth_gss/auth_gss.c      |   26 +++++++++--------
 net/sunrpc/auth_gss/gss_krb5_seal.c |    4 +-
 net/sunrpc/auth_gss/svcauth_gss.c   |   54 ++++++++++++++++++------------------
 net/sunrpc/auth_null.c              |    8 ++---
 net/sunrpc/auth_unix.c              |   10 +++---
 net/sunrpc/clnt.c                   |   23 ++++++++-------
 net/sunrpc/pmap_clnt.c              |    6 ++--
 net/sunrpc/svc.c                    |   50 ++++++++++++++++-----------------
 net/sunrpc/svcauth.c                |    4 +-
 net/sunrpc/svcauth_unix.c           |   16 +++++-----
 net/sunrpc/svcsock.c                |    2 -
 net/sunrpc/xdr.c                    |   28 +++++++++---------
 net/sunrpc/xprt.c                   |    9 +++---
 19 files changed, 172 insertions(+), 151 deletions(-)

diff -uprN linux-vanilla/include/linux/sunrpc/auth.h linux-001/include/linux/sunrpc/auth.h
--- linux-vanilla/include/linux/sunrpc/auth.h	2005-09-10 10:52:29.000000000 +0400
+++ linux-001/include/linux/sunrpc/auth.h	2005-09-10 11:24:40.000000000 +0400
@@ -103,13 +103,13 @@ struct rpc_credops {
 	void			(*crdestroy)(struct rpc_cred *);
 
 	int			(*crmatch)(struct auth_cred *, struct rpc_cred *, int);
-	u32 *			(*crmarshal)(struct rpc_task *, u32 *);
+	__be32 *		(*crmarshal)(struct rpc_task *, __be32 *);
 	int			(*crrefresh)(struct rpc_task *);
-	u32 *			(*crvalidate)(struct rpc_task *, u32 *);
+	__be32 *		(*crvalidate)(struct rpc_task *, __be32 *);
 	int			(*crwrap_req)(struct rpc_task *, kxdrproc_t,
-						void *, u32 *, void *);
+						void *, __be32 *, void *);
 	int			(*crunwrap_resp)(struct rpc_task *, kxdrproc_t,
-						void *, u32 *, void *);
+						void *, __be32 *, void *);
 };
 
 extern struct rpc_authops	authunix_ops;
@@ -128,10 +128,10 @@ struct rpc_cred *	rpcauth_bindcred(struc
 void			rpcauth_holdcred(struct rpc_task *);
 void			put_rpccred(struct rpc_cred *);
 void			rpcauth_unbindcred(struct rpc_task *);
-u32 *			rpcauth_marshcred(struct rpc_task *, u32 *);
-u32 *			rpcauth_checkverf(struct rpc_task *, u32 *);
-int			rpcauth_wrap_req(struct rpc_task *task, kxdrproc_t encode, void *rqstp, u32 *data, void *obj);
-int			rpcauth_unwrap_resp(struct rpc_task *task, kxdrproc_t decode, void *rqstp, u32 *data, void *obj);
+__be32 *		rpcauth_marshcred(struct rpc_task *, __be32 *);
+__be32 *		rpcauth_checkverf(struct rpc_task *, __be32 *);
+int			rpcauth_wrap_req(struct rpc_task *task, kxdrproc_t encode, void *rqstp, __be32 *data, void *obj);
+int			rpcauth_unwrap_resp(struct rpc_task *task, kxdrproc_t decode, void *rqstp, __be32 *data, void *obj);
 int			rpcauth_refreshcred(struct rpc_task *);
 void			rpcauth_invalcred(struct rpc_task *);
 int			rpcauth_uptodatecred(struct rpc_task *);
diff -uprN linux-vanilla/include/linux/sunrpc/svc.h linux-001/include/linux/sunrpc/svc.h
--- linux-vanilla/include/linux/sunrpc/svc.h	2005-09-10 10:52:29.000000000 +0400
+++ linux-001/include/linux/sunrpc/svc.h	2005-09-10 12:10:29.000000000 +0400
@@ -78,6 +78,23 @@ struct svc_serv {
  */
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 2)
 
+static inline u32 svc_getnl(struct kvec *iov)
+{
+	__be32 val, *vp;
+	vp = iov->iov_base;
+	val = *vp++;
+	iov->iov_base = (void*)vp;
+	iov->iov_len -= sizeof(__be32);
+	return ntohl(val);
+}
+
+static inline void svc_putnl(struct kvec *iov, u32 val)
+{
+	__be32 *vp = iov->iov_base + iov->iov_len;
+	*vp = htonl(val);
+	iov->iov_len += sizeof(__be32);
+}
+
 static inline u32 svc_getu32(struct kvec *iov)
 {
 	u32 val, *vp;
@@ -175,7 +192,7 @@ xdr_argsize_check(struct svc_rqst *rqstp
 }
 
 static inline int
-xdr_ressize_check(struct svc_rqst *rqstp, u32 *p)
+xdr_ressize_check(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct kvec *vec = &rqstp->rq_res.head[0];
 	char *cp = (char*)p;
@@ -279,13 +296,13 @@ struct svc_version {
 	 * A return value of 0 means drop the request. 
 	 * vs_dispatch == NULL means use default dispatcher.
 	 */
-	int			(*vs_dispatch)(struct svc_rqst *, u32 *);
+	int			(*vs_dispatch)(struct svc_rqst *, __be32 *);
 };
 
 /*
  * RPC procedure info
  */
-typedef int	(*svc_procfunc)(struct svc_rqst *, void *argp, void *resp);
+typedef __be32	(*svc_procfunc)(struct svc_rqst *, void *argp, void *resp);
 struct svc_procedure {
 	svc_procfunc		pc_func;	/* process the request */
 	kxdrproc_t		pc_decode;	/* XDR decode args */
diff -uprN linux-vanilla/include/linux/sunrpc/svcauth.h linux-001/include/linux/sunrpc/svcauth.h
--- linux-vanilla/include/linux/sunrpc/svcauth.h	2005-09-10 10:52:29.000000000 +0400
+++ linux-001/include/linux/sunrpc/svcauth.h	2005-09-10 11:50:02.000000000 +0400
@@ -91,7 +91,7 @@ struct auth_ops {
 	char *	name;
 	struct module *owner;
 	int	flavour;
-	int	(*accept)(struct svc_rqst *rq, u32 *authp);
+	int	(*accept)(struct svc_rqst *rq, __be32 *authp);
 	int	(*release)(struct svc_rqst *rq);
 	void	(*domain_release)(struct auth_domain *);
 	int	(*set_client)(struct svc_rqst *rq);
@@ -108,7 +108,7 @@ struct auth_ops {
 #define	SVC_COMPLETE	9
 
 
-extern int	svc_authenticate(struct svc_rqst *rqstp, u32 *authp);
+extern int	svc_authenticate(struct svc_rqst *rqstp, __be32 *authp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern int	svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
diff -uprN linux-vanilla/include/linux/sunrpc/xdr.h linux-001/include/linux/sunrpc/xdr.h
--- linux-vanilla/include/linux/sunrpc/xdr.h	2005-09-10 10:52:29.000000000 +0400
+++ linux-001/include/linux/sunrpc/xdr.h	2005-09-10 11:59:48.000000000 +0400
@@ -32,7 +32,7 @@ struct xdr_netobj {
  * side) or svc_rqst pointer (server side).
  * Encode functions always assume there's enough room in the buffer.
  */
-typedef int	(*kxdrproc_t)(void *rqstp, u32 *data, void *obj);
+typedef int	(*kxdrproc_t)(void *rqstp, __be32 *data, void *obj);
 
 /*
  * Basic structure for transmission/reception of a client XDR message.
@@ -88,20 +88,20 @@ struct xdr_buf {
 /*
  * Miscellaneous XDR helper functions
  */
-u32 *	xdr_encode_opaque_fixed(u32 *p, const void *ptr, unsigned int len);
-u32 *	xdr_encode_opaque(u32 *p, const void *ptr, unsigned int len);
-u32 *	xdr_encode_string(u32 *p, const char *s);
-u32 *	xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen);
-u32 *	xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen);
-u32 *	xdr_encode_netobj(u32 *p, const struct xdr_netobj *);
-u32 *	xdr_decode_netobj(u32 *p, struct xdr_netobj *);
+__be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigned int len);
+__be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int len);
+__be32 *xdr_encode_string(__be32 *p, const char *s);
+__be32 *xdr_decode_string(__be32 *p, char **sp, int *lenp, int maxlen);
+__be32 *xdr_decode_string_inplace(__be32 *p, char **sp, int *lenp, int maxlen);
+__be32 *xdr_encode_netobj(__be32 *p, const struct xdr_netobj *);
+__be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
 
 void	xdr_encode_pages(struct xdr_buf *, struct page **, unsigned int,
 			 unsigned int);
 void	xdr_inline_pages(struct xdr_buf *, unsigned int,
 			 struct page **, unsigned int, unsigned int);
 
-static inline u32 *xdr_encode_array(u32 *p, const void *s, unsigned int len)
+static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int len)
 {
 	return xdr_encode_opaque(p, s, len);
 }
@@ -129,7 +129,7 @@ xdr_decode_hyper(u32 *p, __u64 *valp)
  * Adjust kvec to reflect end of xdr'ed data (RPC client XDR)
  */
 static inline int
-xdr_adjust_iovec(struct kvec *iov, u32 *p)
+xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 {
 	return iov->iov_len = ((u8 *) p - (u8 *) iov->iov_base);
 }
diff -uprN linux-vanilla/include/linux/sunrpc/xprt.h linux-001/include/linux/sunrpc/xprt.h
--- linux-vanilla/include/linux/sunrpc/xprt.h	2005-09-10 10:52:29.000000000 +0400
+++ linux-001/include/linux/sunrpc/xprt.h	2005-09-10 11:19:38.000000000 +0400
@@ -91,7 +91,7 @@ struct rpc_rqst {
 	 * This is the private part
 	 */
 	struct rpc_task *	rq_task;	/* RPC task data */
-	__u32			rq_xid;		/* request XID */
+	__be32			rq_xid;		/* request XID */
 	int			rq_cong;	/* has incremented xprt->cong */
 	int			rq_received;	/* receive completed */
 	u32			rq_seqno;	/* gss seq no. used on req. */
@@ -164,9 +164,9 @@ struct rpc_xprt {
 	/*
 	 * State of TCP reply receive stuff
 	 */
-	u32			tcp_recm,	/* Fragment header */
-				tcp_xid,	/* Current XID */
-				tcp_reclen,	/* fragment length */
+	__be32			tcp_recm,	/* Fragment header */
+				tcp_xid;	/* Current XID */
+	u32			tcp_reclen,	/* fragment length */
 				tcp_offset;	/* fragment offset */
 	unsigned long		tcp_copied,	/* copied to request */
 				tcp_flags;
diff -uprN linux-vanilla/net/sunrpc/auth.c linux-001/net/sunrpc/auth.c
--- linux-vanilla/net/sunrpc/auth.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth.c	2005-09-10 11:23:33.000000000 +0400
@@ -310,8 +310,8 @@ rpcauth_unbindcred(struct rpc_task *task
 	task->tk_msg.rpc_cred = NULL;
 }
 
-u32 *
-rpcauth_marshcred(struct rpc_task *task, u32 *p)
+__be32 *
+rpcauth_marshcred(struct rpc_task *task, __be32 *p)
 {
 	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
@@ -321,8 +321,8 @@ rpcauth_marshcred(struct rpc_task *task,
 	return cred->cr_ops->crmarshal(task, p);
 }
 
-u32 *
-rpcauth_checkverf(struct rpc_task *task, u32 *p)
+__be32 *
+rpcauth_checkverf(struct rpc_task *task, __be32 *p)
 {
 	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
@@ -334,7 +334,7 @@ rpcauth_checkverf(struct rpc_task *task,
 
 int
 rpcauth_wrap_req(struct rpc_task *task, kxdrproc_t encode, void *rqstp,
-		u32 *data, void *obj)
+		__be32 *data, void *obj)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 
@@ -348,7 +348,7 @@ rpcauth_wrap_req(struct rpc_task *task, 
 
 int
 rpcauth_unwrap_resp(struct rpc_task *task, kxdrproc_t decode, void *rqstp,
-		u32 *data, void *obj)
+		__be32 *data, void *obj)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 
diff -uprN linux-vanilla/net/sunrpc/auth_gss/auth_gss.c linux-001/net/sunrpc/auth_gss/auth_gss.c
--- linux-vanilla/net/sunrpc/auth_gss/auth_gss.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth_gss/auth_gss.c	2005-09-10 12:08:09.000000000 +0400
@@ -814,14 +814,14 @@ gss_match(struct auth_cred *acred, struc
 * Marshal credentials.
 * Maybe we should keep a cached credential for performance reasons.
 */
-static u32 *
-gss_marshal(struct rpc_task *task, u32 *p)
+static __be32 *
+gss_marshal(struct rpc_task *task, __be32 *p)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 	struct gss_cred	*gss_cred = container_of(cred, struct gss_cred,
 						 gc_base);
 	struct gss_cl_ctx	*ctx = gss_cred_get_ctx(cred);
-	u32		*cred_len;
+	__be32		*cred_len;
 	struct rpc_rqst *req = task->tk_rqstp;
 	u32             maj_stat = 0;
 	struct xdr_netobj mic;
@@ -886,14 +886,15 @@ gss_refresh(struct rpc_task *task)
 	return 0;
 }
 
-static u32 *
-gss_validate(struct rpc_task *task, u32 *p)
+static __be32 *
+gss_validate(struct rpc_task *task, __be32 *p)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 	struct gss_cred	*gss_cred = container_of(cred, struct gss_cred,
 						gc_base);
 	struct gss_cl_ctx *ctx = gss_cred_get_ctx(cred);
-	u32		seq, qop_state;
+	__be32		seq;
+	u32		qop_state;
 	struct kvec	iov;
 	struct xdr_buf	verf_buf;
 	struct xdr_netobj mic;
@@ -943,13 +944,14 @@ out_bad:
 
 static inline int
 gss_wrap_req_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
-		kxdrproc_t encode, struct rpc_rqst *rqstp, u32 *p, void *obj)
+		kxdrproc_t encode, struct rpc_rqst *rqstp, __be32 *p, void *obj)
 {
 	struct xdr_buf	*snd_buf = &rqstp->rq_snd_buf;
 	struct xdr_buf	integ_buf;
-	u32             *integ_len = NULL;
+	__be32          *integ_len = NULL;
 	struct xdr_netobj mic;
-	u32		offset, *q;
+	u32		offset;
+	__be32		*q;
 	struct kvec	*iov;
 	u32             maj_stat = 0;
 	int		status = -EIO;
@@ -992,7 +994,7 @@ gss_wrap_req_integ(struct rpc_cred *cred
 
 static int
 gss_wrap_req(struct rpc_task *task,
-	     kxdrproc_t encode, void *rqstp, u32 *p, void *obj)
+	     kxdrproc_t encode, void *rqstp, __be32 *p, void *obj)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 	struct gss_cred	*gss_cred = container_of(cred, struct gss_cred,
@@ -1027,7 +1029,7 @@ out:
 
 static inline int
 gss_unwrap_resp_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
-		struct rpc_rqst *rqstp, u32 **p)
+		struct rpc_rqst *rqstp, __be32 **p)
 {
 	struct xdr_buf	*rcv_buf = &rqstp->rq_rcv_buf;
 	struct xdr_buf integ_buf;
@@ -1065,7 +1067,7 @@ gss_unwrap_resp_integ(struct rpc_cred *c
 
 static int
 gss_unwrap_resp(struct rpc_task *task,
-		kxdrproc_t decode, void *rqstp, u32 *p, void *obj)
+		kxdrproc_t decode, void *rqstp, __be32 *p, void *obj)
 {
 	struct rpc_cred *cred = task->tk_msg.rpc_cred;
 	struct gss_cred *gss_cred = container_of(cred, struct gss_cred,
diff -uprN linux-vanilla/net/sunrpc/auth_gss/gss_krb5_seal.c linux-001/net/sunrpc/auth_gss/gss_krb5_seal.c
--- linux-vanilla/net/sunrpc/auth_gss/gss_krb5_seal.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth_gss/gss_krb5_seal.c	2005-09-10 12:17:04.000000000 +0400
@@ -131,10 +131,10 @@ krb5_make_token(struct krb5_ctx *ctx, in
 	krb5_hdr = ptr - 2;
 	msg_start = krb5_hdr + 24;
 
-	*(u16 *)(krb5_hdr + 2) = htons(ctx->signalg);
+	*(__be16 *)(krb5_hdr + 2) = htons(ctx->signalg);
 	memset(krb5_hdr + 4, 0xff, 4);
 	if (toktype == KG_TOK_WRAP_MSG)
-		*(u16 *)(krb5_hdr + 4) = htons(ctx->sealalg);
+		*(__be16 *)(krb5_hdr + 4) = htons(ctx->sealalg);
 
 	if (toktype == KG_TOK_WRAP_MSG) {
 		/* XXX removing support for now */
diff -uprN linux-vanilla/net/sunrpc/auth_gss/svcauth_gss.c linux-001/net/sunrpc/auth_gss/svcauth_gss.c
--- linux-vanilla/net/sunrpc/auth_gss/svcauth_gss.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth_gss/svcauth_gss.c	2005-09-10 12:16:42.000000000 +0400
@@ -508,7 +508,7 @@ svc_safe_getnetobj(struct kvec *argv, st
 
 	if (argv->iov_len < 4)
 		return -1;
-	o->len = ntohl(svc_getu32(argv));
+	o->len = svc_getnl(argv);
 	l = round_up_to_quad(o->len);
 	if (argv->iov_len < l)
 		return -1;
@@ -525,7 +525,7 @@ svc_safe_putnetobj(struct kvec *resv, st
 
 	if (resv->iov_len + 4 > PAGE_SIZE)
 		return -1;
-	svc_putu32(resv, htonl(o->len));
+	svc_putnl(resv, o->len);
 	p = resv->iov_base + resv->iov_len;
 	resv->iov_len += round_up_to_quad(o->len);
 	if (resv->iov_len > PAGE_SIZE)
@@ -541,7 +541,7 @@ svc_safe_putnetobj(struct kvec *resv, st
  */
 static int
 gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
-		  u32 *rpcstart, struct rpc_gss_wire_cred *gc, u32 *authp)
+		  u32 *rpcstart, struct rpc_gss_wire_cred *gc, __be32 *authp)
 {
 	struct gss_ctx		*ctx_id = rsci->mechctx;
 	struct xdr_buf		rpchdr;
@@ -558,7 +558,7 @@ gss_verify_header(struct svc_rqst *rqstp
 	*authp = rpc_autherr_badverf;
 	if (argv->iov_len < 4)
 		return SVC_DENIED;
-	flavor = ntohl(svc_getu32(argv));
+	flavor = svc_getnl(argv);
 	if (flavor != RPC_AUTH_GSS)
 		return SVC_DENIED;
 	if (svc_safe_getnetobj(argv, &checksum))
@@ -589,14 +589,14 @@ gss_verify_header(struct svc_rqst *rqstp
 static int
 gss_write_verf(struct svc_rqst *rqstp, struct gss_ctx *ctx_id, u32 seq)
 {
-	u32			xdr_seq;
+	__be32			xdr_seq;
 	u32			maj_stat;
 	struct xdr_buf		verf_data;
 	struct xdr_netobj	mic;
-	u32			*p;
+	__be32			*p;
 	struct kvec		iov;
 
-	svc_putu32(rqstp->rq_res.head, htonl(RPC_AUTH_GSS));
+	svc_putnl(rqstp->rq_res.head, RPC_AUTH_GSS);
 	xdr_seq = htonl(seq);
 
 	iov.iov_base = &xdr_seq;
@@ -670,7 +670,7 @@ EXPORT_SYMBOL(svcauth_gss_register_pseud
 static inline int
 read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 {
-	u32     raw;
+	__be32  raw;
 	int     status;
 
 	status = read_bytes_from_xdr_buf(buf, base, &raw, sizeof(*obj));
@@ -693,7 +693,7 @@ unwrap_integ_data(struct xdr_buf *buf, u
 	struct xdr_netobj mic;
 	struct xdr_buf integ_buf;
 
-	integ_len = ntohl(svc_getu32(&buf->head[0]));
+	integ_len = svc_getnl(&buf->head[0]);
 	if (integ_len & 3)
 		goto out;
 	if (integ_len > buf->len)
@@ -713,7 +713,7 @@ unwrap_integ_data(struct xdr_buf *buf, u
 	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic, NULL);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto out;
-	if (ntohl(svc_getu32(&buf->head[0])) != seq)
+	if (svc_getnl(&buf->head[0]) != seq)
 		goto out;
 	stat = 0;
 out:
@@ -725,7 +725,7 @@ struct gss_svc_data {
 	struct rpc_gss_wire_cred	clcred;
 	/* pointer to the beginning of the procedure-specific results,
 	 * which may be encrypted/checksummed in svcauth_gss_release: */
-	u32				*body_start;
+	__be32				*body_start;
 	struct rsc			*rsci;
 };
 
@@ -751,7 +751,7 @@ svcauth_gss_set_client(struct svc_rqst *
  * response here and return SVC_COMPLETE.
  */
 static int
-svcauth_gss_accept(struct svc_rqst *rqstp, u32 *authp)
+svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -762,7 +762,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 	struct rsc	*rsci = NULL;
 	struct rsi	*rsip, rsikey;
 	u32		*rpcstart;
-	u32		*reject_stat = resv->iov_base + resv->iov_len;
+	__be32		*reject_stat = resv->iov_base + resv->iov_len;
 	int		ret;
 
 	dprintk("RPC:      svcauth_gss: argv->iov_len = %zd\n",argv->iov_len);
@@ -790,12 +790,12 @@ svcauth_gss_accept(struct svc_rqst *rqst
 
 	if (argv->iov_len < 5 * 4)
 		goto auth_err;
-	crlen = ntohl(svc_getu32(argv));
-	if (ntohl(svc_getu32(argv)) != RPC_GSS_VERSION)
+	crlen = svc_getnl(argv);
+	if (svc_getnl(argv) != RPC_GSS_VERSION)
 		goto auth_err;
-	gc->gc_proc = ntohl(svc_getu32(argv));
-	gc->gc_seq = ntohl(svc_getu32(argv));
-	gc->gc_svc = ntohl(svc_getu32(argv));
+	gc->gc_proc = svc_getnl(argv);
+	gc->gc_seq = svc_getnl(argv);
+	gc->gc_svc = svc_getnl(argv);
 	if (svc_safe_getnetobj(argv, &gc->gc_ctx))
 		goto auth_err;
 	if (crlen != round_up_to_quad(gc->gc_ctx.len) + 5 * 4)
@@ -821,9 +821,9 @@ svcauth_gss_accept(struct svc_rqst *rqst
 	case RPC_GSS_PROC_CONTINUE_INIT:
 		if (argv->iov_len < 2 * 4)
 			goto auth_err;
-		if (ntohl(svc_getu32(argv)) != RPC_AUTH_NULL)
+		if (svc_getnl(argv) != RPC_AUTH_NULL)
 			goto auth_err;
-		if (ntohl(svc_getu32(argv)) != 0)
+		if (svc_getnl(argv) != 0)
 			goto auth_err;
 		break;
 	case RPC_GSS_PROC_DATA:
@@ -885,14 +885,14 @@ svcauth_gss_accept(struct svc_rqst *rqst
 				goto drop;
 			if (resv->iov_len + 4 > PAGE_SIZE)
 				goto drop;
-			svc_putu32(resv, rpc_success);
+			svc_putnl(resv, RPC_SUCCESS);
 			if (svc_safe_putnetobj(resv, &rsip->out_handle))
 				goto drop;
 			if (resv->iov_len + 3 * 4 > PAGE_SIZE)
 				goto drop;
-			svc_putu32(resv, htonl(rsip->major_status));
-			svc_putu32(resv, htonl(rsip->minor_status));
-			svc_putu32(resv, htonl(GSS_SEQ_WIN));
+			svc_putnl(resv, rsip->major_status);
+			svc_putnl(resv, rsip->minor_status);
+			svc_putnl(resv, GSS_SEQ_WIN);
 			if (svc_safe_putnetobj(resv, &rsip->out_token))
 				goto drop;
 			rqstp->rq_client = NULL;
@@ -902,7 +902,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 		set_bit(CACHE_NEGATIVE, &rsci->h.flags);
 		if (resv->iov_len + 4 > PAGE_SIZE)
 			goto drop;
-		svc_putu32(resv, rpc_success);
+		svc_putnl(resv, RPC_SUCCESS);
 		goto complete;
 	case RPC_GSS_PROC_DATA:
 		*authp = rpcsec_gsserr_ctxproblem;
@@ -958,7 +958,7 @@ svcauth_gss_release(struct svc_rqst *rqs
 	struct xdr_buf integ_buf;
 	struct xdr_netobj mic;
 	struct kvec *resv;
-	u32 *p;
+	__be32 *p;
 	int integ_offset, integ_len;
 	int stat = -EINVAL;
 
@@ -1014,7 +1014,7 @@ svcauth_gss_release(struct svc_rqst *rqs
 		mic.data = (u8 *)resv->iov_base + resv->iov_len + 4;
 		if (gss_get_mic(gsd->rsci->mechctx, 0, &integ_buf, &mic))
 			goto out_err;
-		svc_putu32(resv, htonl(mic.len));
+		svc_putnl(resv, mic.len);
 		memset(mic.data + mic.len, 0,
 				round_up_to_quad(mic.len) - mic.len);
 		resv->iov_len += XDR_QUADLEN(mic.len) << 2;
diff -uprN linux-vanilla/net/sunrpc/auth_null.c linux-001/net/sunrpc/auth_null.c
--- linux-vanilla/net/sunrpc/auth_null.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth_null.c	2005-09-10 11:25:36.000000000 +0400
@@ -62,8 +62,8 @@ nul_match(struct auth_cred *acred, struc
 /*
  * Marshal credential.
  */
-static u32 *
-nul_marshal(struct rpc_task *task, u32 *p)
+static __be32 *
+nul_marshal(struct rpc_task *task, __be32 *p)
 {
 	*p++ = htonl(RPC_AUTH_NULL);
 	*p++ = 0;
@@ -83,8 +83,8 @@ nul_refresh(struct rpc_task *task)
 	return 0;
 }
 
-static u32 *
-nul_validate(struct rpc_task *task, u32 *p)
+static __be32 *
+nul_validate(struct rpc_task *task, __be32 *p)
 {
 	rpc_authflavor_t	flavor;
 	u32			size;
diff -uprN linux-vanilla/net/sunrpc/auth_unix.c linux-001/net/sunrpc/auth_unix.c
--- linux-vanilla/net/sunrpc/auth_unix.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/auth_unix.c	2005-09-10 11:28:54.000000000 +0400
@@ -139,12 +139,12 @@ unx_match(struct auth_cred *acred, struc
  * Marshal credentials.
  * Maybe we should keep a cached credential for performance reasons.
  */
-static u32 *
-unx_marshal(struct rpc_task *task, u32 *p)
+static __be32 *
+unx_marshal(struct rpc_task *task, __be32 *p)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 	struct unx_cred	*cred = (struct unx_cred *) task->tk_msg.rpc_cred;
-	u32		*base, *hold;
+	__be32		*base, *hold;
 	int		i;
 
 	*p++ = htonl(RPC_AUTH_UNIX);
@@ -180,8 +180,8 @@ unx_refresh(struct rpc_task *task)
 	return 0;
 }
 
-static u32 *
-unx_validate(struct rpc_task *task, u32 *p)
+static __be32 *
+unx_validate(struct rpc_task *task, __be32 *p)
 {
 	rpc_authflavor_t	flavor;
 	u32			size;
diff -uprN linux-vanilla/net/sunrpc/clnt.c linux-001/net/sunrpc/clnt.c
--- linux-vanilla/net/sunrpc/clnt.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/clnt.c	2005-09-10 11:24:17.000000000 +0400
@@ -60,8 +60,8 @@ static void	call_refreshresult(struct rp
 static void	call_timeout(struct rpc_task *task);
 static void	call_connect(struct rpc_task *task);
 static void	call_connect_status(struct rpc_task *task);
-static u32 *	call_header(struct rpc_task *task);
-static u32 *	call_verify(struct rpc_task *task);
+static __be32 *	call_header(struct rpc_task *task);
+static __be32 *	call_verify(struct rpc_task *task);
 
 
 static int
@@ -692,7 +692,7 @@ call_encode(struct rpc_task *task)
 	unsigned int	bufsiz;
 	kxdrproc_t	encode;
 	int		status;
-	u32		*p;
+	__be32		*p;
 
 	dprintk("RPC: %4d call_encode (status %d)\n", 
 				task->tk_pid, task->tk_status);
@@ -925,7 +925,7 @@ call_decode(struct rpc_task *task)
 	struct rpc_clnt	*clnt = task->tk_client;
 	struct rpc_rqst	*req = task->tk_rqstp;
 	kxdrproc_t	decode = task->tk_msg.rpc_proc->p_decode;
-	u32		*p;
+	__be32		*p;
 
 	dprintk("RPC: %4d call_decode (status %d)\n", 
 				task->tk_pid, task->tk_status);
@@ -1016,13 +1016,13 @@ call_refreshresult(struct rpc_task *task
 /*
  * Call header serialization
  */
-static u32 *
+static __be32 *
 call_header(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
 	struct rpc_xprt *xprt = clnt->cl_xprt;
 	struct rpc_rqst	*req = task->tk_rqstp;
-	u32		*p = req->rq_svec[0].iov_base;
+	__be32		*p = req->rq_svec[0].iov_base;
 
 	/* FIXME: check buffer size? */
 	if (xprt->stream)
@@ -1041,12 +1041,13 @@ call_header(struct rpc_task *task)
 /*
  * Reply header verification
  */
-static u32 *
+static __be32 *
 call_verify(struct rpc_task *task)
 {
 	struct kvec *iov = &task->tk_rqstp->rq_rcv_buf.head[0];
 	int len = task->tk_rqstp->rq_rcv_buf.len >> 2;
-	u32	*p = iov->iov_base, n;
+	__be32	*p = iov->iov_base;
+	u32 n;
 	int error = -EACCES;
 
 	if ((len -= 3) < 0)
@@ -1112,7 +1113,7 @@ call_verify(struct rpc_task *task)
 		printk(KERN_WARNING "call_verify: auth check failed\n");
 		goto out_retry;		/* bad verifier, retry */
 	}
-	len = p - (u32 *)iov->iov_base - 1;
+	len = p - (__be32 *)iov->iov_base - 1;
 	if (len < 0)
 		goto out_overflow;
 	switch ((n = ntohl(*p++))) {
@@ -1166,12 +1167,12 @@ out_overflow:
 	goto out_retry;
 }
 
-static int rpcproc_encode_null(void *rqstp, u32 *data, void *obj)
+static int rpcproc_encode_null(void *rqstp, __be32 *data, void *obj)
 {
 	return 0;
 }
 
-static int rpcproc_decode_null(void *rqstp, u32 *data, void *obj)
+static int rpcproc_decode_null(void *rqstp, __be32 *data, void *obj)
 {
 	return 0;
 }
diff -uprN linux-vanilla/net/sunrpc/pmap_clnt.c linux-001/net/sunrpc/pmap_clnt.c
--- linux-vanilla/net/sunrpc/pmap_clnt.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/pmap_clnt.c	2005-09-10 11:54:54.000000000 +0400
@@ -225,7 +225,7 @@ pmap_create(char *hostname, struct socka
  * XDR encode/decode functions for PMAP
  */
 static int
-xdr_encode_mapping(struct rpc_rqst *req, u32 *p, struct rpc_portmap *map)
+xdr_encode_mapping(struct rpc_rqst *req, __be32 *p, struct rpc_portmap *map)
 {
 	dprintk("RPC: xdr_encode_mapping(%d, %d, %d, %d)\n",
 		map->pm_prog, map->pm_vers, map->pm_prot, map->pm_port);
@@ -239,14 +239,14 @@ xdr_encode_mapping(struct rpc_rqst *req,
 }
 
 static int
-xdr_decode_port(struct rpc_rqst *req, u32 *p, unsigned short *portp)
+xdr_decode_port(struct rpc_rqst *req, __be32 *p, unsigned short *portp)
 {
 	*portp = (unsigned short) ntohl(*p++);
 	return 0;
 }
 
 static int
-xdr_decode_bool(struct rpc_rqst *req, u32 *p, unsigned int *boolp)
+xdr_decode_bool(struct rpc_rqst *req, __be32 *p, unsigned int *boolp)
 {
 	*boolp = (unsigned int) ntohl(*p++);
 	return 0;
diff -uprN linux-vanilla/net/sunrpc/svc.c linux-001/net/sunrpc/svc.c
--- linux-vanilla/net/sunrpc/svc.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/svc.c	2005-09-10 12:10:54.000000000 +0400
@@ -262,11 +262,11 @@ svc_process(struct svc_serv *serv, struc
 	struct kvec *		argv = &rqstp->rq_arg.head[0];
 	struct kvec *		resv = &rqstp->rq_res.head[0];
 	kxdrproc_t		xdr;
-	u32			*statp;
-	u32			dir, prog, vers, proc,
-				auth_stat, rpc_stat;
+	__be32			*statp;
+	u32			dir, prog, vers, proc;
+	__be32			auth_stat, rpc_stat;
 	int			auth_res;
-	u32			*accept_statp;
+	__be32			*accept_statp;
 
 	rpc_stat = rpc_success;
 
@@ -292,11 +292,11 @@ svc_process(struct svc_serv *serv, struc
 	rqstp->rq_xid = svc_getu32(argv);
 	svc_putu32(resv, rqstp->rq_xid);
 
-	dir  = ntohl(svc_getu32(argv));
-	vers = ntohl(svc_getu32(argv));
+	dir  = svc_getnl(argv);
+	vers = svc_getnl(argv);
 
 	/* First words of reply: */
-	svc_putu32(resv, xdr_one);		/* REPLY */
+	svc_putnl(resv, 1);		/* REPLY */
 
 	if (dir != 0)		/* direction != CALL */
 		goto err_bad_dir;
@@ -306,11 +306,11 @@ svc_process(struct svc_serv *serv, struc
 	/* Save position in case we later decide to reject: */
 	accept_statp = resv->iov_base + resv->iov_len;
 
-	svc_putu32(resv, xdr_zero);		/* ACCEPT */
+	svc_putnl(resv, 0);		/* ACCEPT */
 
-	rqstp->rq_prog = prog = ntohl(svc_getu32(argv));	/* program number */
-	rqstp->rq_vers = vers = ntohl(svc_getu32(argv));	/* version number */
-	rqstp->rq_proc = proc = ntohl(svc_getu32(argv));	/* procedure number */
+	rqstp->rq_prog = prog = svc_getnl(argv);	/* program number */
+	rqstp->rq_vers = vers = svc_getnl(argv);	/* version number */
+	rqstp->rq_proc = proc = svc_getnl(argv);	/* procedure number */
 
 	progp = serv->sv_program;
 	/*
@@ -362,7 +362,7 @@ svc_process(struct svc_serv *serv, struc
 
 	/* Build the reply header. */
 	statp = resv->iov_base +resv->iov_len;
-	svc_putu32(resv, rpc_success);		/* RPC_SUCCESS */
+	svc_putnl(resv, RPC_SUCCESS);
 
 	/* Bump per-procedure stats counter */
 	procp->pc_count++;
@@ -440,10 +440,10 @@ err_bad_dir:
 
 err_bad_rpc:
 	serv->sv_stats->rpcbadfmt++;
-	svc_putu32(resv, xdr_one);	/* REJECT */
-	svc_putu32(resv, xdr_zero);	/* RPC_MISMATCH */
-	svc_putu32(resv, xdr_two);	/* Only RPCv2 supported */
-	svc_putu32(resv, xdr_two);
+	svc_putnl(resv, 1);	/* REJECT */
+	svc_putnl(resv, 0);	/* RPC_MISMATCH */
+	svc_putnl(resv, 2);	/* Only RPCv2 supported */
+	svc_putnl(resv, 2);
 	goto sendit;
 
 err_bad_auth:
@@ -451,15 +451,15 @@ err_bad_auth:
 	serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, accept_statp);
-	svc_putu32(resv, xdr_one);	/* REJECT */
-	svc_putu32(resv, xdr_one);	/* AUTH_ERROR */
-	svc_putu32(resv, auth_stat);	/* status */
+	svc_putnl(resv, 1);	/* REJECT */
+	svc_putnl(resv, 1);	/* AUTH_ERROR */
+	svc_putnl(resv, ntohl(auth_stat));	/* status */
 	goto sendit;
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", prog);
 	serv->sv_stats->rpcbadfmt++;
-	svc_putu32(resv, rpc_prog_unavail);
+	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;
 
 err_bad_vers:
@@ -467,9 +467,9 @@ err_bad_vers:
 	printk("svc: unknown version (%d)\n", vers);
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putu32(resv, rpc_prog_mismatch);
-	svc_putu32(resv, htonl(progp->pg_lovers));
-	svc_putu32(resv, htonl(progp->pg_hivers));
+	svc_putnl(resv, RPC_PROG_MISMATCH);
+	svc_putnl(resv, progp->pg_lovers);
+	svc_putnl(resv, progp->pg_hivers);
 	goto sendit;
 
 err_bad_proc:
@@ -477,7 +477,7 @@ err_bad_proc:
 	printk("svc: unknown procedure (%d)\n", proc);
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putu32(resv, rpc_proc_unavail);
+	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;
 
 err_garbage:
@@ -487,6 +487,6 @@ err_garbage:
 	rpc_stat = rpc_garbage_args;
 err_bad:
 	serv->sv_stats->rpcbadfmt++;
-	svc_putu32(resv, rpc_stat);
+	svc_putnl(resv, ntohl(rpc_stat));
 	goto sendit;
 }
diff -uprN linux-vanilla/net/sunrpc/svcauth.c linux-001/net/sunrpc/svcauth.c
--- linux-vanilla/net/sunrpc/svcauth.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/svcauth.c	2005-09-10 11:49:49.000000000 +0400
@@ -35,14 +35,14 @@ static struct auth_ops	*authtab[RPC_AUTH
 };
 
 int
-svc_authenticate(struct svc_rqst *rqstp, u32 *authp)
+svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
 {
 	rpc_authflavor_t	flavor;
 	struct auth_ops		*aops;
 
 	*authp = rpc_auth_ok;
 
-	flavor = ntohl(svc_getu32(&rqstp->rq_arg.head[0]));
+	flavor = svc_getnl(&rqstp->rq_arg.head[0]);
 
 	dprintk("svc: svc_authenticate (%d)\n", flavor);
 
diff -uprN linux-vanilla/net/sunrpc/svcauth_unix.c linux-001/net/sunrpc/svcauth_unix.c
--- linux-vanilla/net/sunrpc/svcauth_unix.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/svcauth_unix.c	2005-09-10 11:53:34.000000000 +0400
@@ -129,7 +129,7 @@ static void ip_map_request(struct cache_
 {
 	char text_addr[20];
 	struct ip_map *im = container_of(h, struct ip_map, h);
-	__u32 addr = im->m_addr.s_addr;
+	__be32 addr = im->m_addr.s_addr;
 	
 	snprintf(text_addr, 20, "%u.%u.%u.%u",
 		 ntohl(addr) >> 24 & 0xff,
@@ -357,7 +357,7 @@ svcauth_unix_set_client(struct svc_rqst 
 }
 
 static int
-svcauth_null_accept(struct svc_rqst *rqstp, u32 *authp)
+svcauth_null_accept(struct svc_rqst *rqstp, __be32 *authp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -419,7 +419,7 @@ struct auth_ops svcauth_null = {
 
 
 static int
-svcauth_unix_accept(struct svc_rqst *rqstp, u32 *authp)
+svcauth_unix_accept(struct svc_rqst *rqstp, __be32 *authp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -435,22 +435,22 @@ svcauth_unix_accept(struct svc_rqst *rqs
 
 	svc_getu32(argv);			/* length */
 	svc_getu32(argv);			/* time stamp */
-	slen = XDR_QUADLEN(ntohl(svc_getu32(argv)));	/* machname length */
+	slen = XDR_QUADLEN(svc_getnl(argv));	/* machname length */
 	if (slen > 64 || (len -= (slen + 3)*4) < 0)
 		goto badcred;
 	argv->iov_base = (void*)((u32*)argv->iov_base + slen);	/* skip machname */
 	argv->iov_len -= slen*4;
 
-	cred->cr_uid = ntohl(svc_getu32(argv));		/* uid */
-	cred->cr_gid = ntohl(svc_getu32(argv));		/* gid */
-	slen = ntohl(svc_getu32(argv));			/* gids length */
+	cred->cr_uid = svc_getnl(argv);		/* uid */
+	cred->cr_gid = svc_getnl(argv);		/* gid */
+	slen = svc_getnl(argv);			/* gids length */
 	if (slen > 16 || (len -= (slen + 2)*4) < 0)
 		goto badcred;
 	cred->cr_group_info = groups_alloc(slen);
 	if (cred->cr_group_info == NULL)
 		return SVC_DROP;
 	for (i = 0; i < slen; i++)
-		GROUP_AT(cred->cr_group_info, i) = ntohl(svc_getu32(argv));
+		GROUP_AT(cred->cr_group_info, i) = svc_getnl(argv);
 
 	if (svc_getu32(argv) != RPC_AUTH_NULL || svc_getu32(argv) != 0) {
 		*authp = rpc_autherr_badverf;
diff -uprN linux-vanilla/net/sunrpc/svcsock.c linux-001/net/sunrpc/svcsock.c
--- linux-vanilla/net/sunrpc/svcsock.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/svcsock.c	2005-09-10 11:49:10.000000000 +0400
@@ -1051,7 +1051,7 @@ svc_tcp_sendto(struct svc_rqst *rqstp)
 {
 	struct xdr_buf	*xbufp = &rqstp->rq_res;
 	int sent;
-	u32 reclen;
+	__be32 reclen;
 
 	/* Set up the first element of the reply kvec.
 	 * Any other kvecs that may be in use have been taken
diff -uprN linux-vanilla/net/sunrpc/xdr.c linux-001/net/sunrpc/xdr.c
--- linux-vanilla/net/sunrpc/xdr.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/xdr.c	2005-09-10 12:02:47.000000000 +0400
@@ -21,8 +21,8 @@
 /*
  * XDR functions for basic NFS types
  */
-u32 *
-xdr_encode_netobj(u32 *p, const struct xdr_netobj *obj)
+__be32 *
+xdr_encode_netobj(__be32 *p, const struct xdr_netobj *obj)
 {
 	unsigned int	quadlen = XDR_QUADLEN(obj->len);
 
@@ -32,8 +32,8 @@ xdr_encode_netobj(u32 *p, const struct x
 	return p + XDR_QUADLEN(obj->len);
 }
 
-u32 *
-xdr_decode_netobj(u32 *p, struct xdr_netobj *obj)
+__be32 *
+xdr_decode_netobj(__be32 *p, struct xdr_netobj *obj)
 {
 	unsigned int	len;
 
@@ -58,7 +58,7 @@ xdr_decode_netobj(u32 *p, struct xdr_net
  * Returns the updated current XDR buffer position
  *
  */
-u32 *xdr_encode_opaque_fixed(u32 *p, const void *ptr, unsigned int nbytes)
+__be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigned int nbytes)
 {
 	if (likely(nbytes != 0)) {
 		unsigned int quadlen = XDR_QUADLEN(nbytes);
@@ -82,21 +82,21 @@ EXPORT_SYMBOL(xdr_encode_opaque_fixed);
  *
  * Returns the updated current XDR buffer position
  */
-u32 *xdr_encode_opaque(u32 *p, const void *ptr, unsigned int nbytes)
+__be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int nbytes)
 {
 	*p++ = htonl(nbytes);
 	return xdr_encode_opaque_fixed(p, ptr, nbytes);
 }
 EXPORT_SYMBOL(xdr_encode_opaque);
 
-u32 *
-xdr_encode_string(u32 *p, const char *string)
+__be32 *
+xdr_encode_string(__be32 *p, const char *string)
 {
 	return xdr_encode_array(p, string, strlen(string));
 }
 
-u32 *
-xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen)
+__be32 *
+xdr_decode_string(__be32 *p, char **sp, int *lenp, int maxlen)
 {
 	unsigned int	len;
 	char		*string;
@@ -116,8 +116,8 @@ xdr_decode_string(u32 *p, char **sp, int
 	return p + XDR_QUADLEN(len);
 }
 
-u32 *
-xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen)
+__be32 *
+xdr_decode_string_inplace(__be32 *p, char **sp, int *lenp, int maxlen)
 {
 	unsigned int	len;
 
@@ -916,7 +916,7 @@ out:
 int
 xdr_decode_word(struct xdr_buf *buf, int base, u32 *obj)
 {
-	u32	raw;
+	__be32	raw;
 	int	status;
 
 	status = read_bytes_from_xdr_buf(buf, base, &raw, sizeof(*obj));
@@ -929,7 +929,7 @@ xdr_decode_word(struct xdr_buf *buf, int
 int
 xdr_encode_word(struct xdr_buf *buf, int base, u32 obj)
 {
-	u32	raw = htonl(obj);
+	__be32	raw = htonl(obj);
 
 	return write_bytes_to_xdr_buf(buf, base, &raw, sizeof(obj));
 }
diff -uprN linux-vanilla/net/sunrpc/xprt.c linux-001/net/sunrpc/xprt.c
--- linux-vanilla/net/sunrpc/xprt.c	2005-09-10 10:52:34.000000000 +0400
+++ linux-001/net/sunrpc/xprt.c	2005-09-10 11:21:17.000000000 +0400
@@ -616,7 +616,7 @@ xprt_connect_status(struct rpc_task *tas
  * Look up the RPC request corresponding to a reply, and then lock it.
  */
 static inline struct rpc_rqst *
-xprt_lookup_rqst(struct rpc_xprt *xprt, u32 xid)
+xprt_lookup_rqst(struct rpc_xprt *xprt, __be32 xid)
 {
 	struct list_head *pos;
 	struct rpc_rqst	*req = NULL;
@@ -758,7 +758,8 @@ udp_data_ready(struct sock *sk, int len)
 	struct rpc_rqst *rovr;
 	struct sk_buff	*skb;
 	int err, repsize, copied;
-	u32 _xid, *xp;
+	u32 _xid;
+	__be32 *xp;
 
 	read_lock(&sk->sk_callback_lock);
 	dprintk("RPC:      udp_data_ready...\n");
@@ -1224,7 +1225,7 @@ xprt_transmit(struct rpc_task *task)
 	/* set up everything as needed. */
 	/* Write the record marker */
 	if (xprt->stream) {
-		u32	*marker = req->rq_svec[0].iov_base;
+		__be32	*marker = req->rq_svec[0].iov_base;
 
 		*marker = htonl(0x80000000|(req->rq_slen-sizeof(*marker)));
 	}
@@ -1378,7 +1379,7 @@ xprt_reserve(struct rpc_task *task)
 /*
  * Allocate a 'unique' XID
  */
-static inline u32 xprt_alloc_xid(struct rpc_xprt *xprt)
+static inline __be32 xprt_alloc_xid(struct rpc_xprt *xprt)
 {
 	return xprt->xid++;
 }

