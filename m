Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTAMAKW>; Sun, 12 Jan 2003 19:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTAMAJw>; Sun, 12 Jan 2003 19:09:52 -0500
Received: from pat.uio.no ([129.240.130.16]:39373 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267668AbTAMAGV>;
	Sun, 12 Jan 2003 19:06:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1287.965237.784713@charged.uio.no>
Date: Mon, 13 Jan 2003 01:15:03 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [5/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patches the RPCSEC_GSS client to make use of the upcall mechanism
that was provided by patch [3/6].

If an RPC task presents a non-uptodate credential to call_refresh(),
a user daemon is contacted by means of a dedicated rpc_pipefs pipe.
The daemon is then fed the uid for which it must establish a new RPCSEC
security context.

While the daemon goes about its business, the RPC task is put to sleep
on a wait queue in order to allow the 'rpciod' process to service other
requests. If another task wants to use the same credential, it too will
be put to sleep once it reaches call_refresh(). A timeout mechanism
ensures that requests are retried (or that 'soft' mounts fail) if the
daemon crashes / is killed.

Once the daemon has established the RPCSEC context, it writes the result
back to the pipe, causing the credential to be updated. Those RPC tasks
that were sleeping on the context are automatically woken up, and
their execution can proceed.

diff -u --recursive --new-file linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth_gss.h linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/auth_gss.h
--- linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth_gss.h	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/auth_gss.h	2003-01-12 22:40:31.000000000 +0100
@@ -71,6 +71,7 @@
  * the wire when communicating with a server. */
 
 struct gss_cl_ctx {
+	atomic_t		count;
 	u32			gc_proc;
 	u32			gc_seq;
 	spinlock_t		gc_seq_lock;
diff -u --recursive --new-file linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth.h linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/auth.h
--- linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth.h	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/auth.h	2003-01-12 22:40:31.000000000 +0100
@@ -115,6 +115,7 @@
 int			rpcauth_unregister(struct rpc_authops *);
 struct rpc_auth *	rpcauth_create(rpc_authflavor_t, struct rpc_clnt *);
 void			rpcauth_destroy(struct rpc_auth *);
+struct rpc_cred *	rpcauth_lookup_credcache(struct rpc_auth *, struct auth_cred *, int);
 struct rpc_cred *	rpcauth_lookupcred(struct rpc_auth *, int);
 struct rpc_cred *	rpcauth_bindcred(struct rpc_task *);
 void			rpcauth_holdcred(struct rpc_task *);
diff -u --recursive --new-file linux-2.5.56-05-rpc_gss/net/sunrpc/auth.c linux-2.5.56-06-auth_upcall2/net/sunrpc/auth.c
--- linux-2.5.56-05-rpc_gss/net/sunrpc/auth.c	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-06-auth_upcall2/net/sunrpc/auth.c	2003-01-12 22:40:31.000000000 +0100
@@ -181,7 +181,7 @@
 /*
  * Look up a process' credentials in the authentication cache
  */
-static struct rpc_cred *
+struct rpc_cred *
 rpcauth_lookup_credcache(struct rpc_auth *auth, struct auth_cred * acred,
 		int taskflags)
 {
@@ -360,10 +360,7 @@
 int
 rpcauth_uptodatecred(struct rpc_task *task)
 {
-	int retval;
-	spin_lock(&rpc_credcache_lock);
-	retval = !(task->tk_msg.rpc_cred) ||
+	return !(task->tk_msg.rpc_cred) ||
 		(task->tk_msg.rpc_cred->cr_flags & RPCAUTH_CRED_UPTODATE);
-	spin_unlock(&rpc_credcache_lock);
-	return retval;
 }
+
diff -u --recursive --new-file linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/auth_gss.c linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/auth_gss.c
--- linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/auth_gss.c	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/auth_gss.c	2003-01-12 22:40:31.000000000 +0100
@@ -50,6 +50,8 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
+#include <linux/sunrpc/rpc_pipe_fs.h>
+#include <asm/uaccess.h>
 
 static struct rpc_authops authgss_ops;
 
@@ -74,6 +76,20 @@
 /* dump the buffer in `emacs-hexl' style */
 #define isprint(c)      ((c > 0x1f) && (c < 0x7f))
 
+static rwlock_t gss_ctx_lock = RW_LOCK_UNLOCKED;
+
+struct gss_auth {
+	struct rpc_auth rpc_auth;
+	struct gss_api_mech *mech;
+	struct list_head upcalls;
+	struct dentry *dentry;
+	char path[48];
+	spinlock_t lock;
+};
+
+static void gss_destroy_ctx(struct gss_cl_ctx *);
+static struct rpc_pipe_ops gss_upcall_ops;
+
 void
 print_hexl(u32 *p, u_int length, u_int offset)
 {
@@ -112,6 +128,304 @@
 	}
 }
 
+static inline struct gss_cl_ctx *
+gss_get_ctx(struct gss_cl_ctx *ctx)
+{
+	atomic_inc(&ctx->count);
+	return ctx;
+}
+
+static inline void
+gss_put_ctx(struct gss_cl_ctx *ctx)
+{
+	if (atomic_dec_and_test(&ctx->count))
+		gss_destroy_ctx(ctx);
+}
+
+static void
+gss_cred_set_ctx(struct rpc_cred *cred, struct gss_cl_ctx *ctx)
+{
+	struct gss_cred *gss_cred = container_of(cred, struct gss_cred, gc_base);
+	struct gss_cl_ctx *old;
+	write_lock(&gss_ctx_lock);
+	old = gss_cred->gc_ctx;
+	gss_cred->gc_ctx = ctx;
+	cred->cr_flags |= RPCAUTH_CRED_UPTODATE;
+	write_unlock(&gss_ctx_lock);
+	if (old)
+		gss_put_ctx(old);
+}
+
+static struct gss_cl_ctx *
+gss_cred_get_ctx(struct rpc_cred *cred)
+{
+	struct gss_cred *gss_cred = container_of(cred, struct gss_cred, gc_base);
+	struct gss_cl_ctx *ctx = NULL;
+
+	read_lock(&gss_ctx_lock);
+	if ((cred->cr_flags & RPCAUTH_CRED_UPTODATE) && gss_cred->gc_ctx)
+		ctx = gss_get_ctx(gss_cred->gc_ctx);
+	read_unlock(&gss_ctx_lock);
+	return ctx;
+}
+
+static inline int
+simple_get_bytes(char **ptr, const char *end, void *res, int len)
+{
+	char *p, *q;
+	p = *ptr;
+	q = p + len;
+	if (q > end || q < p)
+		return -1;
+	memcpy(res, p, len);
+	*ptr = q;
+	return 0;
+}
+
+static inline int
+simple_get_netobj(char **ptr, const char *end, struct xdr_netobj *res)
+{
+	char *p, *q;
+	p = *ptr;
+	if (simple_get_bytes(&p, end, &res->len, sizeof(res->len)))
+		return -1;
+	q = p + res->len;
+	if (q > end || q < p)
+		return -1;
+	res->data = p;
+	*ptr = q;
+	return 0;
+}
+
+static int
+dup_netobj(struct xdr_netobj *source, struct xdr_netobj *dest)
+{
+	dest->len = source->len;
+	if (!(dest->data = kmalloc(dest->len, GFP_KERNEL)))
+		return -1;
+	memcpy(dest->data, source->data, dest->len);
+	return 0;
+}
+
+static int
+gss_parse_init_downcall(struct gss_api_mech *gm, struct xdr_netobj *buf,
+		struct gss_cl_ctx **gc, uid_t *uid)
+{
+	char *end = buf->data + buf->len;
+	char *p = buf->data;
+	struct gss_cl_ctx *ctx;
+	struct xdr_netobj tmp_buf;
+	unsigned int timeout;
+	int err = -EIO;
+
+	if (!(ctx = kmalloc(sizeof(*ctx), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto err;
+	}
+	ctx->gc_proc = RPC_GSS_PROC_DATA;
+	ctx->gc_seq = 0;
+	spin_lock_init(&ctx->gc_seq_lock);
+	atomic_set(&ctx->count,1);
+
+	if (simple_get_bytes(&p, end, uid, sizeof(uid)))
+		goto err_free_ctx;
+	/* FIXME: discarded timeout for now */
+	if (simple_get_bytes(&p, end, &timeout, sizeof(timeout)))
+		goto err_free_ctx;
+	if (simple_get_bytes(&p, end, &ctx->gc_win, sizeof(ctx->gc_win)))
+		goto err_free_ctx;
+	if (simple_get_netobj(&p, end, &tmp_buf))
+		goto err_free_ctx;
+	if (dup_netobj(&tmp_buf, &ctx->gc_wire_ctx)) {
+		err = -ENOMEM;
+		goto err_free_ctx;
+	}
+	if (simple_get_netobj(&p, end, &tmp_buf))
+		goto err_free_wire_ctx;
+	if (p != end)
+		goto err_free_wire_ctx;
+	if (gss_import_sec_context(&tmp_buf, gm, &ctx->gc_gss_ctx))
+		goto err_free_wire_ctx;
+	*gc = ctx;
+	return 0;
+err_free_wire_ctx:
+	kfree(ctx->gc_wire_ctx.data);
+err_free_ctx:
+	kfree(ctx);
+err:
+	*gc = NULL;
+	dprintk("RPC: gss_parse_init_downcall returning %d\n", err);
+	return err;
+}
+
+
+struct gss_upcall_msg {
+	struct rpc_pipe_msg msg;
+	struct list_head list;
+	struct rpc_wait_queue waitq;
+	uid_t	uid;
+	atomic_t count;
+};
+
+static void
+gss_release_msg(struct gss_upcall_msg *gss_msg)
+{
+	if (atomic_dec_and_test(&gss_msg->count))
+		kfree(gss_msg);
+}
+
+static struct gss_upcall_msg *
+gss_find_upcall(struct gss_auth *gss_auth, uid_t uid)
+{
+	struct gss_upcall_msg *pos;
+	list_for_each_entry(pos, &gss_auth->upcalls, list) {
+		if (pos->uid == uid)
+			return pos;
+	}
+	return NULL;
+}
+
+static void
+gss_release_callback(struct rpc_task *task)
+{
+	struct rpc_clnt *clnt = task->tk_client;
+	struct gss_auth *gss_auth = container_of(clnt->cl_auth,
+			struct gss_auth, rpc_auth);
+	struct gss_upcall_msg *gss_msg;
+
+	spin_lock(&gss_auth->lock);
+	gss_msg = gss_find_upcall(gss_auth, task->tk_msg.rpc_cred->cr_uid);
+	if (gss_msg) {
+		rpc_wake_up(&gss_msg->waitq);
+		list_del(&gss_msg->list);
+		gss_release_msg(gss_msg);
+	}
+	spin_unlock(&gss_auth->lock);
+}
+
+static int
+gss_upcall(struct rpc_clnt *clnt, struct rpc_task *task, uid_t uid)
+{
+	struct gss_auth *gss_auth = container_of(clnt->cl_auth,
+			struct gss_auth, rpc_auth);
+	struct gss_upcall_msg *gss_msg, *gss_new = NULL;
+	struct rpc_pipe_msg *msg;
+	struct dentry *dentry = gss_auth->dentry;
+	int res;
+
+retry:
+	gss_msg = gss_find_upcall(gss_auth, uid);
+	if (gss_msg == NULL && gss_new == NULL) {
+		spin_unlock(&gss_auth->lock);
+		gss_new = kmalloc(sizeof(*gss_new), GFP_KERNEL);
+		spin_lock(&gss_auth->lock);
+		if (gss_new)
+			goto retry;
+		return -ENOMEM;
+	}
+	if (gss_msg)
+		goto out_sleep;
+	gss_msg = gss_new;
+	memset(gss_new, 0, sizeof(*gss_new));
+	INIT_LIST_HEAD(&gss_new->list);
+	INIT_RPC_WAITQ(&gss_new->waitq, "RPCSEC_GSS upcall waitq");
+	atomic_set(&gss_new->count, 2);
+	msg = &gss_new->msg;
+	msg->data = &gss_new->uid;
+	msg->len = sizeof(gss_new->uid);
+	gss_new->uid = uid;
+	list_add(&gss_new->list, &gss_auth->upcalls);
+	gss_new = NULL;
+	rpc_sleep_on(&gss_msg->waitq, task, gss_release_callback, NULL);
+	spin_unlock(&gss_auth->lock);
+	res = rpc_queue_upcall(dentry->d_inode, msg);
+	spin_lock(&gss_auth->lock);
+	if (res)
+		gss_release_msg(gss_msg);
+	return res;
+out_sleep:
+	rpc_sleep_on(&gss_msg->waitq, task, NULL, NULL);
+	if (gss_new)
+		kfree(gss_new);
+	return 0;
+}
+
+static ssize_t
+gss_pipe_upcall(struct file *filp, struct rpc_pipe_msg *msg,
+		char *dst, size_t buflen)
+{
+	char *data = (char *)msg->data + msg->copied;
+	ssize_t mlen = msg->len - msg->copied;
+	ssize_t left;
+
+	if (mlen > buflen)
+		mlen = buflen;
+	left = copy_to_user(dst, data, mlen);
+	msg->copied += mlen - left;
+	return mlen - left;
+}
+
+static ssize_t
+gss_pipe_downcall(struct file *filp, const char *src, size_t mlen)
+{
+	char buf[1024];
+	struct xdr_netobj obj = {
+		.len	= mlen,
+		.data	= buf,
+	};
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rpc_inode *rpci = RPC_I(inode);
+	struct rpc_clnt *clnt;
+	struct rpc_auth *auth;
+	struct gss_auth *gss_auth;
+	struct gss_api_mech *mech;
+	struct auth_cred acred = { 0 };
+	struct rpc_cred *cred;
+	struct gss_upcall_msg *gss_msg;
+	struct gss_cl_ctx *ctx;
+	ssize_t left;
+	int err;
+
+	if (mlen > sizeof(buf))
+		return -ENOSPC;
+	left = copy_from_user(buf, src, mlen);
+	if (left)
+		return -EFAULT;
+	clnt = rpci->private;
+	atomic_inc(&clnt->cl_users);
+	auth = clnt->cl_auth;
+	gss_auth = container_of(auth, struct gss_auth, rpc_auth);
+	mech = gss_auth->mech;
+	err = gss_parse_init_downcall(mech, &obj, &ctx, &acred.uid);
+	if (err)
+		goto err;
+	cred = rpcauth_lookup_credcache(auth, &acred, 0);
+	if (!cred)
+		goto err_release_ctx;
+	gss_cred_set_ctx(cred, ctx);
+	spin_lock(&gss_auth->lock);
+	gss_msg = gss_find_upcall(gss_auth, acred.uid);
+	if (gss_msg)
+		rpc_wake_up(&gss_msg->waitq);
+	spin_unlock(&gss_auth->lock);
+	rpc_release_client(clnt);
+	return mlen;
+err_release_ctx:
+	gss_destroy_ctx(ctx);
+err:
+	rpc_release_client(clnt);
+	dprintk("RPC: gss_pipe_downcall returning %d\n", err);
+	return err;
+}
+
+void
+gss_pipe_destroy_msg(struct rpc_pipe_msg *msg)
+{
+	struct gss_upcall_msg *gss_msg = container_of(msg, struct gss_upcall_msg, msg);
+
+	rpc_wake_up(&gss_msg->waitq);
+	gss_release_msg(gss_msg);
+}
 
 /* 
  * NOTE: we have the opportunity to use different 
@@ -120,13 +434,23 @@
 static struct rpc_auth *
 gss_create(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
 {
+	struct gss_auth *gss_auth;
 	struct rpc_auth * auth;
 
 	dprintk("RPC: creating GSS authenticator for client %p\n",clnt);
 	if (!try_module_get(THIS_MODULE))
 		return NULL;
-	if (!(auth = kmalloc(sizeof(*auth), GFP_KERNEL)))
+	if (!(gss_auth = kmalloc(sizeof(*gss_auth), GFP_KERNEL)))
 		goto out_dec;
+	gss_auth->mech = gss_pseudoflavor_to_mech(flavor);
+	if (!gss_auth->mech) {
+		printk(KERN_WARNING "%s: Pseudoflavor %d not found!",
+				__FUNCTION__, flavor);
+		goto err_free;
+	}
+	INIT_LIST_HEAD(&gss_auth->upcalls);
+	spin_lock_init(&gss_auth->lock);
+	auth = &gss_auth->rpc_auth;
 	auth->au_cslack = GSS_CRED_SLACK >> 2;
 	auth->au_rslack = GSS_VERF_SLACK >> 2;
 	auth->au_expire = GSS_CRED_EXPIRE;
@@ -135,7 +459,16 @@
 
 	rpcauth_init_credcache(auth);
 
+	snprintf(gss_auth->path, sizeof(gss_auth->path), "%s/%s",
+			clnt->cl_pathname,
+			gss_auth->mech->gm_ops->name);
+	gss_auth->dentry = rpc_mkpipe(gss_auth->path, clnt, &gss_upcall_ops);
+	if (IS_ERR(gss_auth->dentry))
+		goto err_free;
+
 	return auth;
+err_free:
+	kfree(gss_auth);
 out_dec:
 	module_put(THIS_MODULE);
 	return NULL;
@@ -144,9 +477,13 @@
 static void
 gss_destroy(struct rpc_auth *auth)
 {
+	struct gss_auth *gss_auth;
 	dprintk("RPC: destroying GSS authenticator %p flavor %d\n",
 		auth, auth->au_flavor);
 
+	gss_auth = container_of(auth, struct gss_auth, rpc_auth);
+	rpc_unlink(gss_auth->path);
+
 	rpcauth_free_credcache(auth);
 
 	kfree(auth);
@@ -156,7 +493,7 @@
 /* gss_destroy_cred (and gss_destroy_ctx) are used to clean up after failure
  * to create a new cred or context, so they check that things have been
  * allocated before freeing them. */
-void
+static void
 gss_destroy_ctx(struct gss_cl_ctx *ctx)
 {
 
@@ -182,7 +519,7 @@
 	dprintk("RPC: gss_destroy_cred \n");
 
 	if (cred->gc_ctx)
-		gss_destroy_ctx(cred->gc_ctx);
+		gss_put_ctx(cred->gc_ctx);
 	kfree(cred);
 }
 
@@ -229,8 +566,10 @@
 static u32 *
 gss_marshal(struct rpc_task *task, u32 *p, int ruid)
 {
-	struct gss_cred	*cred = (struct gss_cred *) task->tk_msg.rpc_cred;
-	struct gss_cl_ctx	*ctx = cred->gc_ctx;
+	struct rpc_cred *cred = task->tk_msg.rpc_cred;
+	struct gss_cred	*gss_cred = container_of(cred, struct gss_cred,
+						 gc_base);
+	struct gss_cl_ctx	*ctx = gss_cred_get_ctx(cred);
 	u32		*cred_len;
 	struct rpc_rqst *req = task->tk_rqstp;
 	struct rpc_clnt *clnt = task->tk_client;
@@ -251,11 +590,11 @@
 	*p++ = htonl(RPC_AUTH_GSS);
 	cred_len = p++;
 
-	service = gss_pseudoflavor_to_service(cred->gc_flavor);
+	service = gss_pseudoflavor_to_service(gss_cred->gc_flavor);
 	if (service == 0) {
 		dprintk("Bad pseudoflavor %d in gss_marshal\n",
-			cred->gc_flavor);
-		return NULL;
+			gss_cred->gc_flavor);
+		goto out_put_ctx;
 	}
 	spin_lock(&ctx->gc_seq_lock);
 	task->tk_gss_seqno = ctx->gc_seq++;
@@ -281,10 +620,13 @@
 	if(maj_stat != 0){
 		printk("gss_marshal: gss_get_mic FAILED (%d)\n",
 		       maj_stat);
-		return(NULL);
+		goto out_put_ctx;
 	}
 	p = xdr_encode_netobj(p, &bufout);
 	return p;
+out_put_ctx:
+	gss_put_ctx(ctx);
+	return NULL;
 }
 
 /*
@@ -293,9 +635,21 @@
 static int
 gss_refresh(struct rpc_task *task)
 {
-	/* Insert upcall here ! */
-	task->tk_msg.rpc_cred->cr_flags |= RPCAUTH_CRED_UPTODATE;
-	return task->tk_status = -EACCES;
+	struct rpc_clnt *clnt = task->tk_client;
+	struct gss_auth *gss_auth = container_of(clnt->cl_auth,
+			struct gss_auth, rpc_auth);
+	struct rpc_xprt *xprt = task->tk_xprt;
+	struct rpc_cred *cred = task->tk_msg.rpc_cred;
+	int err = 0;
+
+	task->tk_timeout = xprt->timeout.to_current;
+	spin_lock(&gss_auth->lock);
+	if (gss_cred_get_ctx(cred))
+		goto out;
+	err = gss_upcall(clnt, task, cred->cr_uid);
+out:
+	spin_unlock(&gss_auth->lock);
+	return err;
 }
 
 static u32 *
@@ -354,7 +708,11 @@
 	.crvalidate	= gss_validate,
 };
 
-extern void gss_svc_ctx_init(void);
+static struct rpc_pipe_ops gss_upcall_ops = {
+	.upcall		= gss_pipe_upcall,
+	.downcall	= gss_pipe_downcall,
+	.destroy_msg	= gss_pipe_destroy_msg,
+};
 
 /*
  * Initialize RPCSEC_GSS module
diff -u --recursive --new-file linux-2.5.56-05-rpc_gss/net/sunrpc/sunrpc_syms.c linux-2.5.56-06-auth_upcall2/net/sunrpc/sunrpc_syms.c
--- linux-2.5.56-05-rpc_gss/net/sunrpc/sunrpc_syms.c	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-06-auth_upcall2/net/sunrpc/sunrpc_syms.c	2003-01-12 22:40:31.000000000 +0100
@@ -68,6 +68,7 @@
 EXPORT_SYMBOL(rpcauth_register);
 EXPORT_SYMBOL(rpcauth_unregister);
 EXPORT_SYMBOL(rpcauth_lookupcred);
+EXPORT_SYMBOL(rpcauth_lookup_credcache);
 EXPORT_SYMBOL(rpcauth_free_credcache);
 EXPORT_SYMBOL(rpcauth_init_credcache);
 EXPORT_SYMBOL(put_rpccred);
