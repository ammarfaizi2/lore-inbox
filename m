Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268116AbSIRQxq>; Wed, 18 Sep 2002 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbSIRQw5>; Wed, 18 Sep 2002 12:52:57 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:2176 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267890AbSIRQvn>; Wed, 18 Sep 2002 12:51:43 -0400
Date: Wed, 18 Sep 2002 12:56:44 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] stricter type checking for rpc auth flavors
Message-ID: <Pine.LNX.4.44.0209181254580.1495-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch, against 2.5.36, implements stricter type checking for rpc auth 
flavors.  it is a prerequisite for RPC GSSAPI and its authentication 
pseudoflavors.  please apply it.

btw, i've split out the svc_get/put rename changes, which follow.

diff -drN -U2 03-connect2/fs/nfs/inode.c 04-authflav/fs/nfs/inode.c
--- 03-connect2/fs/nfs/inode.c	Tue Sep 17 20:59:08 2002
+++ 04-authflav/fs/nfs/inode.c	Wed Sep 18 10:05:34 2002
@@ -246,5 +246,5 @@
 	struct rpc_clnt		*clnt = NULL;
 	struct inode		*root_inode = NULL;
-	unsigned int		authflavor;
+	rpc_authflavor_t	authflavor;
 	struct rpc_timeout	timeparms;
 	struct nfs_fsinfo	fsinfo;
diff -drN -U2 03-connect2/include/linux/lockd/lockd.h 04-authflav/include/linux/lockd/lockd.h
--- 03-connect2/include/linux/lockd/lockd.h	Tue Sep 17 20:58:47 2002
+++ 04-authflav/include/linux/lockd/lockd.h	Wed Sep 18 10:05:34 2002
@@ -43,6 +43,6 @@
 	char			h_name[20];	/* remote hostname */
 	u32			h_version;	/* interface version */
+	rpc_authflavor_t	h_authflavor;	/* RPC authentication type */
 	unsigned short		h_proto;	/* transport proto */
-	unsigned short		h_authflavor;	/* RPC authentication type */
 	unsigned short		h_reclaiming : 1,
 				h_server     : 1, /* server side, not client side */
diff -drN -U2 03-connect2/include/linux/sunrpc/auth.h 04-authflav/include/linux/sunrpc/auth.h
--- 03-connect2/include/linux/sunrpc/auth.h	Tue Sep 17 20:58:59 2002
+++ 04-authflav/include/linux/sunrpc/auth.h	Wed Sep 18 10:05:34 2002
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
diff -drN -U2 03-connect2/include/linux/sunrpc/clnt.h 04-authflav/include/linux/sunrpc/clnt.h
--- 03-connect2/include/linux/sunrpc/clnt.h	Tue Sep 17 20:58:59 2002
+++ 04-authflav/include/linux/sunrpc/clnt.h	Wed Sep 18 10:05:34 2002
@@ -112,5 +112,5 @@
 struct rpc_clnt *rpc_create_client(struct rpc_xprt *xprt, char *servname,
 				struct rpc_program *info,
-				u32 version, int authflavor);
+				u32 version, rpc_authflavor_t authflavor);
 int		rpc_shutdown_client(struct rpc_clnt *);
 int		rpc_destroy_client(struct rpc_clnt *);
diff -drN -U2 03-connect2/include/linux/sunrpc/msg_prot.h 04-authflav/include/linux/sunrpc/msg_prot.h
--- 03-connect2/include/linux/sunrpc/msg_prot.h	Tue Sep 17 20:59:07 2002
+++ 04-authflav/include/linux/sunrpc/msg_prot.h	Wed Sep 18 10:05:34 2002
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
 
diff -drN -U2 03-connect2/include/linux/sunrpc/svcauth.h 04-authflav/include/linux/sunrpc/svcauth.h
--- 03-connect2/include/linux/sunrpc/svcauth.h	Tue Sep 17 20:58:52 2002
+++ 04-authflav/include/linux/sunrpc/svcauth.h	Wed Sep 18 10:05:34 2002
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
 
diff -drN -U2 03-connect2/net/sunrpc/auth.c 04-authflav/net/sunrpc/auth.c
--- 03-connect2/net/sunrpc/auth.c	Tue Sep 17 20:58:40 2002
+++ 04-authflav/net/sunrpc/auth.c	Wed Sep 18 10:05:34 2002
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
diff -drN -U2 03-connect2/net/sunrpc/auth_null.c 04-authflav/net/sunrpc/auth_null.c
--- 03-connect2/net/sunrpc/auth_null.c	Tue Sep 17 20:59:23 2002
+++ 04-authflav/net/sunrpc/auth_null.c	Wed Sep 18 10:05:34 2002
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
diff -drN -U2 03-connect2/net/sunrpc/auth_unix.c 04-authflav/net/sunrpc/auth_unix.c
--- 03-connect2/net/sunrpc/auth_unix.c	Tue Sep 17 20:58:43 2002
+++ 04-authflav/net/sunrpc/auth_unix.c	Wed Sep 18 10:05:34 2002
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
diff -drN -U2 03-connect2/net/sunrpc/clnt.c 04-authflav/net/sunrpc/clnt.c
--- 03-connect2/net/sunrpc/clnt.c	Wed Sep 18 10:03:45 2002
+++ 04-authflav/net/sunrpc/clnt.c	Wed Sep 18 10:05:34 2002
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
diff -drN -U2 03-connect2/net/sunrpc/svcauth.c 04-authflav/net/sunrpc/svcauth.c
--- 03-connect2/net/sunrpc/svcauth.c	Tue Sep 17 20:58:48 2002
+++ 04-authflav/net/sunrpc/svcauth.c	Wed Sep 18 11:57:39 2002
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
@@ -48,6 +43,6 @@
 svc_authenticate(struct svc_rqst *rqstp, u32 *statp, u32 *authp)
 {
-	u32		flavor;
-	auth_fn_t	func;
+	rpc_authflavor_t	flavor;
+	auth_fn_t		func;
 
 	*statp = rpc_success;
@@ -58,5 +53,5 @@
 
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

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>



