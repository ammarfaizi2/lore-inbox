Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319332AbSIKUIL>; Wed, 11 Sep 2002 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319334AbSIKUIL>; Wed, 11 Sep 2002 16:08:11 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:896 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S319332AbSIKUIE>; Wed, 11 Sep 2002 16:08:04 -0400
Date: Wed, 11 Sep 2002 16:12:43 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] stricter type checking for rpc auth flavors
Message-ID: <Pine.LNX.4.44.0209111558560.1554-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus-

this patch, against 2.5.34, implements stricter type checking for rpc auth 
flavors.  it is a prerequisite for RPC GSSAPI and its authentication 
pseudoflavors.  please apply it.

notes:  there are some innocuous corrections included with this patch.
there are some block comment corrections, and also, i renamed
svc_get/putlong to svc_get/putu32 to reflect better what these macros do.
on a platform where BITS_PER_LONG != BITS_PER_INT this might be somewhat
confusing.

btw, there is an undocumented dependency here on the type of the
buffer pointers in the svc_buf struct, which is u32 *.  if that type is 
changed, these macros would probably continue to compile, but would behave 
differently.  i can submit a patch making them static inline functions if 
you wish.


diff -drN -U2 02-connect2/fs/nfs/inode.c 03-authflav/fs/nfs/inode.c
--- 02-connect2/fs/nfs/inode.c	Mon Sep  9 13:35:15 2002
+++ 03-authflav/fs/nfs/inode.c	Wed Sep 11 14:02:54 2002
@@ -246,5 +246,5 @@
 	struct rpc_clnt		*clnt = NULL;
 	struct inode		*root_inode = NULL;
-	unsigned int		authflavor;
+	rpc_authflavor_t	authflavor;
 	struct rpc_timeout	timeparms;
 	struct nfs_fsinfo	fsinfo;
diff -drN -U2 02-connect2/fs/nfsd/nfscache.c 03-authflav/fs/nfsd/nfscache.c
--- 02-connect2/fs/nfsd/nfscache.c	Mon Sep  9 13:35:30 2002
+++ 03-authflav/fs/nfsd/nfscache.c	Wed Sep 11 12:16:57 2002
@@ -273,5 +273,5 @@
 		break;
 	case RC_REPLSTAT:
-		svc_putlong(&rqstp->rq_resbuf, rp->c_replstat);
+		svc_putu32(&rqstp->rq_resbuf, rp->c_replstat);
 		rtn = RC_REPLY;
 		break;
diff -drN -U2 02-connect2/fs/nfsd/nfssvc.c 03-authflav/fs/nfsd/nfssvc.c
--- 02-connect2/fs/nfsd/nfssvc.c	Mon Sep  9 13:35:00 2002
+++ 03-authflav/fs/nfsd/nfssvc.c	Wed Sep 11 12:17:07 2002
@@ -303,5 +303,5 @@
 		
 	if (rqstp->rq_proc != 0)
-		svc_putlong(&rqstp->rq_resbuf, nfserr);
+		svc_putu32(&rqstp->rq_resbuf, nfserr);
 
 	/* Encode result.
diff -drN -U2 02-connect2/include/linux/lockd/lockd.h 03-authflav/include/linux/lockd/lockd.h
--- 02-connect2/include/linux/lockd/lockd.h	Mon Sep  9 13:35:04 2002
+++ 03-authflav/include/linux/lockd/lockd.h	Wed Sep 11 14:01:45 2002
@@ -44,6 +44,6 @@
 	char			h_name[20];	/* remote hostname */
 	u32			h_version;	/* interface version */
+	rpc_authflavor_t	h_authflavor;	/* RPC authentication type */
 	unsigned short		h_proto;	/* transport proto */
-	unsigned short		h_authflavor;	/* RPC authentication type */
 	unsigned short		h_reclaiming : 1,
 				h_inuse      : 1,
diff -drN -U2 02-connect2/include/linux/sunrpc/auth.h 03-authflav/include/linux/sunrpc/auth.h
--- 02-connect2/include/linux/sunrpc/auth.h	Mon Sep  9 13:35:12 2002
+++ 03-authflav/include/linux/sunrpc/auth.h	Wed Sep 11 14:02:07 2002
@@ -1,6 +1,6 @@
 /*
- * linux/include/linux/auth.h
+ * linux/include/linux/sunrpc/auth.h
  *
- * Declarations for the RPC authentication machinery.
+ * Declarations for the RPC client authentication machinery.
  *
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
@@ -68,5 +68,5 @@
  */
 struct rpc_authops {
-	unsigned int		au_flavor;	/* flavor (RPC_AUTH_*) */
+	rpc_authflavor_t	au_flavor;	/* flavor (RPC_AUTH_*) */
 #ifdef RPC_DEBUG
 	char *			au_name;
@@ -95,5 +95,5 @@
 int			rpcauth_register(struct rpc_authops *);
 int			rpcauth_unregister(struct rpc_authops *);
-struct rpc_auth *	rpcauth_create(unsigned int, struct rpc_clnt *);
+struct rpc_auth *	rpcauth_create(rpc_authflavor_t, struct rpc_clnt *);
 void			rpcauth_destroy(struct rpc_auth *);
 struct rpc_cred *	rpcauth_lookupcred(struct rpc_auth *, int);
diff -drN -U2 02-connect2/include/linux/sunrpc/clnt.h 03-authflav/include/linux/sunrpc/clnt.h
--- 02-connect2/include/linux/sunrpc/clnt.h	Mon Sep  9 13:35:13 2002
+++ 03-authflav/include/linux/sunrpc/clnt.h	Wed Sep 11 14:02:13 2002
@@ -112,5 +112,5 @@
 struct rpc_clnt *rpc_create_client(struct rpc_xprt *xprt, char *servname,
 				struct rpc_program *info,
-				u32 version, int authflavor);
+				u32 version, rpc_authflavor_t authflavor);
 int		rpc_shutdown_client(struct rpc_clnt *);
 int		rpc_destroy_client(struct rpc_clnt *);
diff -drN -U2 02-connect2/include/linux/sunrpc/msg_prot.h 03-authflav/include/linux/sunrpc/msg_prot.h
--- 02-connect2/include/linux/sunrpc/msg_prot.h	Mon Sep  9 13:35:14 2002
+++ 03-authflav/include/linux/sunrpc/msg_prot.h	Wed Sep 11 14:02:22 2002
@@ -12,5 +12,8 @@
 #define RPC_VERSION 2
 
-enum rpc_auth_flavor {
+/* spec defines authentication flavor as an unsigned 32 bit integer */
+typedef u32	rpc_authflavor_t;
+
+enum rpc_auth_flavors {
 	RPC_AUTH_NULL  = 0,
 	RPC_AUTH_UNIX  = 1,
@@ -18,4 +21,5 @@
 	RPC_AUTH_DES   = 3,
 	RPC_AUTH_KRB   = 4,
+	RPC_AUTH_MAXFLAVOR = 8,
 };
 
diff -drN -U2 02-connect2/include/linux/sunrpc/svc.h 03-authflav/include/linux/sunrpc/svc.h
--- 02-connect2/include/linux/sunrpc/svc.h	Mon Sep  9 13:35:12 2002
+++ 03-authflav/include/linux/sunrpc/svc.h	Wed Sep 11 12:16:47 2002
@@ -83,6 +83,6 @@
 	int			nriov;
 };
-#define svc_getlong(argp, val)	{ (val) = *(argp)->buf++; (argp)->len--; }
-#define svc_putlong(resp, val)	{ *(resp)->buf++ = (val); (resp)->len++; }
+#define svc_getu32(argp, val)	{ (val) = *(argp)->buf++; (argp)->len--; }
+#define svc_putu32(resp, val)	{ *(resp)->buf++ = (val); (resp)->len++; }
 
 /*
diff -drN -U2 02-connect2/include/linux/sunrpc/svcauth.h 03-authflav/include/linux/sunrpc/svcauth.h
--- 02-connect2/include/linux/sunrpc/svcauth.h	Mon Sep  9 13:35:08 2002
+++ 03-authflav/include/linux/sunrpc/svcauth.h	Wed Sep 11 14:02:46 2002
@@ -15,5 +15,5 @@
 
 struct svc_cred {
-	u32			cr_flavor;
+	rpc_authflavor_t	cr_flavor;
 	uid_t			cr_uid;
 	gid_t			cr_gid;
@@ -24,6 +24,7 @@
 
 void	svc_authenticate(struct svc_rqst *rqstp, u32 *statp, u32 *authp);
-int	svc_auth_register(u32 flavor, void (*)(struct svc_rqst *,u32 *,u32 *));
-void	svc_auth_unregister(u32 flavor);
+int	svc_auth_register(rpc_authflavor_t flavor,
+				void (*)(struct svc_rqst *,u32 *,u32 *));
+void	svc_auth_unregister(rpc_authflavor_t flavor);
 
 #if 0
@@ -40,5 +41,5 @@
 };
 
-struct svc_authops *	auth_getops(u32 flavor);
+struct svc_authops *	auth_getops(rpc_authflavor_t flavor);
 #endif
 
diff -drN -U2 02-connect2/net/sunrpc/auth.c 03-authflav/net/sunrpc/auth.c
--- 02-connect2/net/sunrpc/auth.c	Mon Sep  9 13:34:59 2002
+++ 03-authflav/net/sunrpc/auth.c	Wed Sep 11 14:03:35 2002
@@ -1,6 +1,6 @@
 /*
- * linux/fs/nfs/rpcauth.c
+ * linux/net/sunrpc/auth.c
  *
- * Generic RPC authentication API.
+ * Generic RPC client authentication API.
  *
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
@@ -19,7 +19,5 @@
 #endif
 
-#define RPC_MAXFLAVOR	8
-
-static struct rpc_authops *	auth_flavors[RPC_MAXFLAVOR] = {
+static struct rpc_authops *	auth_flavors[RPC_AUTH_MAXFLAVOR] = {
 	&authnull_ops,		/* AUTH_NULL */
 	&authunix_ops,		/* AUTH_UNIX */
@@ -30,7 +28,7 @@
 rpcauth_register(struct rpc_authops *ops)
 {
-	unsigned int	flavor;
+	rpc_authflavor_t flavor;
 
-	if ((flavor = ops->au_flavor) >= RPC_MAXFLAVOR)
+	if ((flavor = ops->au_flavor) >= RPC_AUTH_MAXFLAVOR)
 		return -EINVAL;
 	if (auth_flavors[flavor] != NULL)
@@ -43,7 +41,7 @@
 rpcauth_unregister(struct rpc_authops *ops)
 {
-	unsigned int	flavor;
+	rpc_authflavor_t flavor;
 
-	if ((flavor = ops->au_flavor) >= RPC_MAXFLAVOR)
+	if ((flavor = ops->au_flavor) >= RPC_AUTH_MAXFLAVOR)
 		return -EINVAL;
 	if (auth_flavors[flavor] != ops)
@@ -54,9 +52,9 @@
 
 struct rpc_auth *
-rpcauth_create(unsigned int flavor, struct rpc_clnt *clnt)
+rpcauth_create(rpc_authflavor_t flavor, struct rpc_clnt *clnt)
 {
 	struct rpc_authops	*ops;
 
-	if (flavor >= RPC_MAXFLAVOR || !(ops = auth_flavors[flavor]))
+	if (flavor >= RPC_AUTH_MAXFLAVOR || !(ops = auth_flavors[flavor]))
 		return NULL;
 	clnt->cl_auth = ops->create(clnt);
diff -drN -U2 02-connect2/net/sunrpc/auth_null.c 03-authflav/net/sunrpc/auth_null.c
--- 02-connect2/net/sunrpc/auth_null.c	Mon Sep  9 13:35:12 2002
+++ 03-authflav/net/sunrpc/auth_null.c	Wed Sep 11 14:03:46 2002
@@ -1,4 +1,4 @@
 /*
- * linux/net/sunrpc/rpcauth_null.c
+ * linux/net/sunrpc/auth_null.c
  *
  * AUTH_NULL authentication. Really :-)
@@ -107,12 +107,16 @@
 nul_validate(struct rpc_task *task, u32 *p)
 {
-	u32		n = ntohl(*p++);
+	rpc_authflavor_t	flavor;
+	u32			size;
 
-	if (n != RPC_AUTH_NULL) {
-		printk("RPC: bad verf flavor: %ld\n", (unsigned long) n);
+	flavor = ntohl(*p++);
+	if (flavor != RPC_AUTH_NULL) {
+		printk("RPC: bad verf flavor: %u\n", flavor);
 		return NULL;
 	}
-	if ((n = ntohl(*p++)) != 0) {
-		printk("RPC: bad verf size: %ld\n", (unsigned long) n);
+
+	size = ntohl(*p++);
+	if (size != 0) {
+		printk("RPC: bad verf size: %u\n", size);
 		return NULL;
 	}
diff -drN -U2 02-connect2/net/sunrpc/auth_unix.c 03-authflav/net/sunrpc/auth_unix.c
--- 02-connect2/net/sunrpc/auth_unix.c	Mon Sep  9 13:35:01 2002
+++ 03-authflav/net/sunrpc/auth_unix.c	Wed Sep 11 14:03:55 2002
@@ -1,4 +1,4 @@
 /*
- * linux/net/sunrpc/rpcauth_unix.c
+ * linux/net/sunrpc/auth_unix.c
  *
  * UNIX-style authentication; no AUTH_SHORT support
@@ -217,16 +217,22 @@
 unx_validate(struct rpc_task *task, u32 *p)
 {
-	u32		n = ntohl(*p++);
+	rpc_authflavor_t	flavor;
+	u32			size;
 
-	if (n != RPC_AUTH_NULL && n != RPC_AUTH_UNIX && n != RPC_AUTH_SHORT) {
-		printk("RPC: bad verf flavor: %ld\n", (unsigned long) n);
+	flavor = ntohl(*p++);
+	if (flavor != RPC_AUTH_NULL &&
+	    flavor != RPC_AUTH_UNIX &&
+	    flavor != RPC_AUTH_SHORT) {
+		printk("RPC: bad verf flavor: %u\n", flavor);
 		return NULL;
 	}
-	if ((n = ntohl(*p++)) > 400) {
-		printk("RPC: giant verf size: %ld\n", (unsigned long) n);
+
+	size = ntohl(*p++);
+	if (size > 400) {
+		printk("RPC: giant verf size: %u\n", size);
 		return NULL;
 	}
-	task->tk_auth->au_rslack = (n >> 2) + 2;
-	p += (n >> 2);
+	task->tk_auth->au_rslack = (size >> 2) + 2;
+	p += (size >> 2);
 
 	return p;
diff -drN -U2 02-connect2/net/sunrpc/clnt.c 03-authflav/net/sunrpc/clnt.c
--- 02-connect2/net/sunrpc/clnt.c	Tue Sep 10 15:29:07 2002
+++ 03-authflav/net/sunrpc/clnt.c	Wed Sep 11 14:04:12 2002
@@ -72,5 +72,6 @@
 struct rpc_clnt *
 rpc_create_client(struct rpc_xprt *xprt, char *servname,
-		  struct rpc_program *program, u32 vers, int flavor)
+		  struct rpc_program *program, u32 vers,
+		  rpc_authflavor_t flavor)
 {
 	struct rpc_version	*version;
@@ -123,5 +124,5 @@
 	goto out;
 out_no_auth:
-	printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %d)\n",
+	printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %u)\n",
 		flavor);
 	rpc_free(clnt);
diff -drN -U2 02-connect2/net/sunrpc/svc.c 03-authflav/net/sunrpc/svc.c
--- 02-connect2/net/sunrpc/svc.c	Mon Sep  9 13:35:16 2002
+++ 03-authflav/net/sunrpc/svc.c	Wed Sep 11 12:18:08 2002
@@ -248,6 +248,6 @@
 
 	/* First words of reply: */
-	svc_putlong(resp, xdr_one);		/* REPLY */
-	svc_putlong(resp, xdr_zero);		/* ACCEPT */
+	svc_putu32(resp, xdr_one);		/* REPLY */
+	svc_putu32(resp, xdr_zero);		/* ACCEPT */
 
 	if (dir != 0)		/* direction != CALL */
@@ -301,5 +301,5 @@
 	/* Build the reply header. */
 	statp = resp->buf;
-	svc_putlong(resp, rpc_success);		/* RPC_SUCCESS */
+	svc_putu32(resp, rpc_success);		/* RPC_SUCCESS */
 
 	/* Bump per-procedure stats counter */
@@ -372,7 +372,7 @@
 	serv->sv_stats->rpcbadfmt++;
 	resp->buf[-1] = xdr_one;	/* REJECT */
-	svc_putlong(resp, xdr_zero);	/* RPC_MISMATCH */
-	svc_putlong(resp, xdr_two);	/* Only RPCv2 supported */
-	svc_putlong(resp, xdr_two);
+	svc_putu32(resp, xdr_zero);	/* RPC_MISMATCH */
+	svc_putu32(resp, xdr_two);	/* Only RPCv2 supported */
+	svc_putu32(resp, xdr_two);
 	goto sendit;
 
@@ -381,6 +381,6 @@
 	serv->sv_stats->rpcbadauth++;
 	resp->buf[-1] = xdr_one;	/* REJECT */
-	svc_putlong(resp, xdr_one);	/* AUTH_ERROR */
-	svc_putlong(resp, auth_stat);	/* status */
+	svc_putu32(resp, xdr_one);	/* AUTH_ERROR */
+	svc_putu32(resp, auth_stat);	/* status */
 	goto sendit;
 
@@ -392,5 +392,5 @@
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putlong(resp, rpc_prog_unavail);
+	svc_putu32(resp, rpc_prog_unavail);
 	goto sendit;
 
@@ -400,7 +400,7 @@
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putlong(resp, rpc_prog_mismatch);
-	svc_putlong(resp, htonl(progp->pg_lovers));
-	svc_putlong(resp, htonl(progp->pg_hivers));
+	svc_putu32(resp, rpc_prog_mismatch);
+	svc_putu32(resp, htonl(progp->pg_lovers));
+	svc_putu32(resp, htonl(progp->pg_hivers));
 	goto sendit;
 
@@ -410,5 +410,5 @@
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putlong(resp, rpc_proc_unavail);
+	svc_putu32(resp, rpc_proc_unavail);
 	goto sendit;
 
@@ -418,5 +418,5 @@
 #endif
 	serv->sv_stats->rpcbadfmt++;
-	svc_putlong(resp, rpc_garbage_args);
+	svc_putu32(resp, rpc_garbage_args);
 	goto sendit;
 }
diff -drN -U2 02-connect2/net/sunrpc/svcauth.c 03-authflav/net/sunrpc/svcauth.c
--- 02-connect2/net/sunrpc/svcauth.c	Mon Sep  9 13:35:05 2002
+++ 03-authflav/net/sunrpc/svcauth.c	Wed Sep 11 14:04:29 2002
@@ -32,12 +32,7 @@
 
 /*
- * Max number of authentication flavors we support
- */
-#define RPC_SVCAUTH_MAX	8
-
-/*
  * Table of authenticators
  */
-static auth_fn_t	authtab[RPC_SVCAUTH_MAX] = {
+static auth_fn_t	authtab[RPC_AUTH_MAXFLAVOR] = {
 	svcauth_null,
 	svcauth_unix,
@@ -48,15 +43,15 @@
 svc_authenticate(struct svc_rqst *rqstp, u32 *statp, u32 *authp)
 {
-	u32		flavor;
-	auth_fn_t	func;
+	rpc_authflavor_t	flavor;
+	auth_fn_t		func;
 
 	*statp = rpc_success;
 	*authp = rpc_auth_ok;
 
-	svc_getlong(&rqstp->rq_argbuf, flavor);
+	svc_getu32(&rqstp->rq_argbuf, flavor);
 	flavor = ntohl(flavor);
 
 	dprintk("svc: svc_authenticate (%d)\n", flavor);
-	if (flavor >= RPC_SVCAUTH_MAX || !(func = authtab[flavor])) {
+	if (flavor >= RPC_AUTH_MAXFLAVOR || !(func = authtab[flavor])) {
 		*authp = rpc_autherr_badcred;
 		return;
@@ -68,7 +63,7 @@
 
 int
-svc_auth_register(u32 flavor, auth_fn_t func)
+svc_auth_register(rpc_authflavor_t flavor, auth_fn_t func)
 {
-	if (flavor >= RPC_SVCAUTH_MAX || authtab[flavor])
+	if (flavor >= RPC_AUTH_MAXFLAVOR || authtab[flavor])
 		return -EINVAL;
 	authtab[flavor] = func;
@@ -77,7 +72,7 @@
 
 void
-svc_auth_unregister(u32 flavor)
+svc_auth_unregister(rpc_authflavor_t flavor)
 {
-	if (flavor < RPC_SVCAUTH_MAX)
+	if (flavor < RPC_AUTH_MAXFLAVOR)
 		authtab[flavor] = NULL;
 }
@@ -111,6 +106,6 @@
 	/* Put NULL verifier */
 	rqstp->rq_verfed = 1;
-	svc_putlong(resp, RPC_AUTH_NULL);
-	svc_putlong(resp, 0);
+	svc_putu32(resp, RPC_AUTH_NULL);
+	svc_putu32(resp, 0);
 }
 
@@ -158,6 +153,6 @@
 	/* Put NULL verifier */
 	rqstp->rq_verfed = 1;
-	svc_putlong(resp, RPC_AUTH_NULL);
-	svc_putlong(resp, 0);
+	svc_putu32(resp, RPC_AUTH_NULL);
+	svc_putu32(resp, 0);
 
 	return;
diff -drN -U2 02-connect2/net/sunrpc/svcsock.c 03-authflav/net/sunrpc/svcsock.c
--- 02-connect2/net/sunrpc/svcsock.c	Mon Sep  9 13:35:02 2002
+++ 03-authflav/net/sunrpc/svcsock.c	Wed Sep 11 12:18:45 2002
@@ -1092,6 +1092,6 @@
 	rqstp->rq_verfed  = 0;
 
-	svc_getlong(&rqstp->rq_argbuf, rqstp->rq_xid);
-	svc_putlong(&rqstp->rq_resbuf, rqstp->rq_xid);
+	svc_getu32(&rqstp->rq_argbuf, rqstp->rq_xid);
+	svc_putu32(&rqstp->rq_resbuf, rqstp->rq_xid);
 
 	/* Assume that the reply consists of a single buffer. */

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

