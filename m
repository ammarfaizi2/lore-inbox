Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264518AbSIQTCX>; Tue, 17 Sep 2002 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264528AbSIQTCX>; Tue, 17 Sep 2002 15:02:23 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:2176 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S264518AbSIQTBX>; Tue, 17 Sep 2002 15:01:23 -0400
Date: Tue, 17 Sep 2002 15:06:22 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] stricter type checking for rpc auth flavors
Message-ID: <Pine.LNX.4.44.0209171505010.1591-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus-

this patch, against 2.5.35, implements stricter type checking for rpc auth 
flavors.  it is a prerequisite for RPC GSSAPI and its authentication 
pseudoflavors.  please apply it.

notes:  there are some innocuous corrections included with this patch.
there are some block comment corrections, and also, i renamed
svc_get/putlong to svc_get/putu32 to reflect better what these macros do.
on a platform where BITS_PER_LONG != BITS_PER_INT this might be somewhat
confusing.

diff -drN -U2 03-connect2/fs/nfs/inode.c 04-authflav/fs/nfs/inode.c
--- 03-connect2/fs/nfs/inode.c	Sun Sep 15 22:18:48 2002
+++ 04-authflav/fs/nfs/inode.c	Tue Sep 17 14:14:07 2002
@@ -246,5 +246,5 @@
 	struct rpc_clnt		*clnt = NULL;
 	struct inode		*root_inode = NULL;
-	unsigned int		authflavor;
+	rpc_authflavor_t	authflavor;
 	struct rpc_timeout	timeparms;
 	struct nfs_fsinfo	fsinfo;
diff -drN -U2 03-connect2/fs/nfsd/nfscache.c 04-authflav/fs/nfsd/nfscache.c
--- 03-connect2/fs/nfsd/nfscache.c	Sun Sep 15 22:19:03 2002
+++ 04-authflav/fs/nfsd/nfscache.c	Tue Sep 17 14:14:07 2002
@@ -273,5 +273,5 @@
 		break;
 	case RC_REPLSTAT:
-		svc_putlong(&rqstp->rq_resbuf, rp->c_replstat);
+		svc_putu32(&rqstp->rq_resbuf, rp->c_replstat);
 		rtn = RC_REPLY;
 		break;
diff -drN -U2 03-connect2/fs/nfsd/nfssvc.c 04-authflav/fs/nfsd/nfssvc.c
--- 03-connect2/fs/nfsd/nfssvc.c	Sun Sep 15 22:18:17 2002
+++ 04-authflav/fs/nfsd/nfssvc.c	Tue Sep 17 14:14:07 2002
@@ -303,5 +303,5 @@
 		
 	if (rqstp->rq_proc != 0)
-		svc_putlong(&rqstp->rq_resbuf, nfserr);
+		svc_putu32(&rqstp->rq_resbuf, nfserr);
 
 	/* Encode result.
diff -drN -U2 03-connect2/include/linux/lockd/lockd.h 04-authflav/include/linux/lockd/lockd.h
--- 03-connect2/include/linux/lockd/lockd.h	Sun Sep 15 22:18:22 2002
+++ 04-authflav/include/linux/lockd/lockd.h	Tue Sep 17 14:14:07 2002
@@ -43,6 +43,6 @@
 	char			h_name[20];	/* remote hostname */
 	u32			h_version;	/* interface version */
+	rpc_authflavor_t	h_authflavor;	/* RPC authentication type */
 	unsigned short		h_proto;	/* transport proto */
-	unsigned short		h_authflavor;	/* RPC authentication type */
 	unsigned short		h_reclaiming : 1,
 				h_server     : 1, /* server side, not client side */
diff -drN -U2 03-connect2/include/linux/lockd/lockd.h.orig 04-authflav/include/linux/lockd/lockd.h.orig
--- 03-connect2/include/linux/lockd/lockd.h.orig	Wed Dec 31 19:00:00 1969
+++ 04-authflav/include/linux/lockd/lockd.h.orig	Sun Sep 15 22:18:22 2002
@@ -0,0 +1,209 @@
+/*
+ * linux/include/linux/lockd/lockd.h
+ *
+ * General-purpose lockd include file.
+ *
+ * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
+ */
+
+#ifndef LINUX_LOCKD_LOCKD_H
+#define LINUX_LOCKD_LOCKD_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/in.h>
+#include <linux/fs.h>
+#include <linux/utsname.h>
+#include <linux/nfsd/nfsfh.h>
+#include <linux/lockd/bind.h>
+#include <linux/lockd/xdr.h>
+#ifdef CONFIG_LOCKD_V4
+#include <linux/lockd/xdr4.h>
+#endif
+#include <linux/lockd/debug.h>
+
+/*
+ * Version string
+ */
+#define LOCKD_VERSION		"0.4"
+
+/*
+ * Default timeout for RPC calls (seconds)
+ */
+#define LOCKD_DFLT_TIMEO	10
+
+/*
+ * Lockd host handle (used both by the client and server personality).
+ */
+struct nlm_host {
+	struct nlm_host *	h_next;		/* linked list (hash table) */
+	struct sockaddr_in	h_addr;		/* peer address */
+	struct rpc_clnt	*	h_rpcclnt;	/* RPC client to talk to peer */
+	char			h_name[20];	/* remote hostname */
+	u32			h_version;	/* interface version */
+	unsigned short		h_proto;	/* transport proto */
+	unsigned short		h_authflavor;	/* RPC authentication type */
+	unsigned short		h_reclaiming : 1,
+				h_server     : 1, /* server side, not client side */
+				h_inuse      : 1,
+				h_killed     : 1,
+				h_monitored  : 1;
+	wait_queue_head_t	h_gracewait;	/* wait while reclaiming */
+	u32			h_state;	/* pseudo-state counter */
+	u32			h_nsmstate;	/* true remote NSM state */
+	unsigned int		h_count;	/* reference count */
+	struct semaphore	h_sema;		/* mutex for pmap binding */
+	unsigned long		h_nextrebind;	/* next portmap call */
+	unsigned long		h_expires;	/* eligible for GC */
+};
+
+/*
+ * Memory chunk for NLM client RPC request.
+ */
+#define NLMCLNT_OHSIZE		(sizeof(system_utsname.nodename)+10)
+struct nlm_rqst {
+	unsigned int		a_flags;	/* initial RPC task flags */
+	struct nlm_host *	a_host;		/* host handle */
+	struct nlm_args		a_args;		/* arguments */
+	struct nlm_res		a_res;		/* result */
+	char			a_owner[NLMCLNT_OHSIZE];
+};
+
+/*
+ * This struct describes a file held open by lockd on behalf of
+ * an NFS client.
+ */
+struct nlm_file {
+	struct nlm_file *	f_next;		/* linked list */
+	struct nfs_fh		f_handle;	/* NFS file handle */
+	struct file		f_file;		/* VFS file pointer */
+	struct nlm_share *	f_shares;	/* DOS shares */
+	struct nlm_block *	f_blocks;	/* blocked locks */
+	unsigned int		f_locks;	/* guesstimate # of locks */
+	unsigned int		f_count;	/* reference count */
+	struct semaphore	f_sema;		/* avoid concurrent access */
+	int		       	f_hash;		/* hash of f_handle */
+};
+
+/*
+ * This is a server block (i.e. a lock requested by some client which
+ * couldn't be granted because of a conflicting lock).
+ */
+#define NLM_NEVER		(~(unsigned long) 0)
+struct nlm_block {
+	struct nlm_block *	b_next;		/* linked list (all blocks) */
+	struct nlm_block *	b_fnext;	/* linked list (per file) */
+	struct nlm_rqst		b_call;		/* RPC args & callback info */
+	struct svc_serv *	b_daemon;	/* NLM service */
+	struct nlm_host *	b_host;		/* host handle for RPC clnt */
+	unsigned long		b_when;		/* next re-xmit */
+	unsigned int		b_id;		/* block id */
+	unsigned char		b_queued;	/* re-queued */
+	unsigned char		b_granted;	/* VFS granted lock */
+	unsigned char		b_incall;	/* doing callback */
+	unsigned char		b_done;		/* callback complete */
+	struct nlm_file *	b_file;		/* file in question */
+};
+
+/*
+ * Valid actions for nlmsvc_traverse_files
+ */
+#define NLM_ACT_CHECK		0		/* check for locks */
+#define NLM_ACT_MARK		1		/* mark & sweep */
+#define NLM_ACT_UNLOCK		2		/* release all locks */
+
+/*
+ * Global variables
+ */
+extern struct rpc_program	nlm_program;
+extern struct svc_procedure	nlmsvc_procedures[];
+#ifdef CONFIG_LOCKD_V4
+extern struct svc_procedure	nlmsvc_procedures4[];
+#endif
+extern int			nlmsvc_grace_period;
+extern unsigned long		nlmsvc_timeout;
+
+/*
+ * Lockd client functions
+ */
+struct nlm_rqst * nlmclnt_alloc_call(void);
+int		  nlmclnt_call(struct nlm_rqst *, u32);
+int		  nlmclnt_async_call(struct nlm_rqst *, u32, rpc_action);
+int		  nlmclnt_block(struct nlm_host *, struct file_lock *, u32 *);
+int		  nlmclnt_cancel(struct nlm_host *, struct file_lock *);
+u32		  nlmclnt_grant(struct nlm_lock *);
+void		  nlmclnt_recovery(struct nlm_host *, u32);
+int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
+int		  nlmclnt_setgrantargs(struct nlm_rqst *, struct nlm_lock *);
+void		  nlmclnt_freegrantargs(struct nlm_rqst *);
+
+/*
+ * Host cache
+ */
+struct nlm_host * nlmclnt_lookup_host(struct sockaddr_in *, int, int);
+struct nlm_host * nlmsvc_lookup_host(struct svc_rqst *);
+struct nlm_host * nlm_lookup_host(int server, struct sockaddr_in *, int, int);
+struct rpc_clnt * nlm_bind_host(struct nlm_host *);
+void		  nlm_rebind_host(struct nlm_host *);
+struct nlm_host * nlm_get_host(struct nlm_host *);
+void		  nlm_release_host(struct nlm_host *);
+void		  nlm_shutdown_hosts(void);
+extern struct nlm_host *nlm_find_client(void);
+
+
+/*
+ * Server-side lock handling
+ */
+int		  nlmsvc_async_call(struct nlm_rqst *, u32, rpc_action);
+u32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
+					struct nlm_lock *, int, struct nlm_cookie *);
+u32		  nlmsvc_unlock(struct nlm_file *, struct nlm_lock *);
+u32		  nlmsvc_testlock(struct nlm_file *, struct nlm_lock *,
+					struct nlm_lock *);
+u32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
+unsigned long	  nlmsvc_retry_blocked(void);
+int		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
+					int action);
+
+/*
+ * File handling for the server personality
+ */
+u32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
+					struct nfs_fh *);
+void		  nlm_release_file(struct nlm_file *);
+void		  nlmsvc_mark_resources(void);
+void		  nlmsvc_free_host_resources(struct nlm_host *);
+void		  nlmsvc_invalidate_all(void);
+
+static __inline__ struct inode *
+nlmsvc_file_inode(struct nlm_file *file)
+{
+	return file->f_file.f_dentry->d_inode;
+}
+
+/*
+ * Compare two host addresses (needs modifying for ipv6)
+ */
+static __inline__ int
+nlm_cmp_addr(struct sockaddr_in *sin1, struct sockaddr_in *sin2)
+{
+	return sin1->sin_addr.s_addr == sin2->sin_addr.s_addr;
+}
+
+/*
+ * Compare two NLM locks.
+ * When the second lock is of type F_UNLCK, this acts like a wildcard.
+ */
+static __inline__ int
+nlm_compare_locks(struct file_lock *fl1, struct file_lock *fl2)
+{
+	return	fl1->fl_pid   == fl2->fl_pid
+	     && fl1->fl_start == fl2->fl_start
+	     && fl1->fl_end   == fl2->fl_end
+	     &&(fl1->fl_type  == fl2->fl_type || fl2->fl_type == F_UNLCK);
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* LINUX_LOCKD_LOCKD_H */
diff -drN -U2 03-connect2/include/linux/sunrpc/auth.h 04-authflav/include/linux/sunrpc/auth.h
--- 03-connect2/include/linux/sunrpc/auth.h	Sun Sep 15 22:18:30 2002
+++ 04-authflav/include/linux/sunrpc/auth.h	Tue Sep 17 14:14:07 2002
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
--- 03-connect2/include/linux/sunrpc/clnt.h	Sun Sep 15 22:18:31 2002
+++ 04-authflav/include/linux/sunrpc/clnt.h	Tue Sep 17 14:14:07 2002
@@ -112,5 +112,5 @@
 struct rpc_clnt *rpc_create_client(struct rpc_xprt *xprt, char *servname,
 				struct rpc_program *info,
-				u32 version, int authflavor);
+				u32 version, rpc_authflavor_t authflavor);
 int		rpc_shutdown_client(struct rpc_clnt *);
 int		rpc_destroy_client(struct rpc_clnt *);
diff -drN -U2 03-connect2/include/linux/sunrpc/msg_prot.h 04-authflav/include/linux/sunrpc/msg_prot.h
--- 03-connect2/include/linux/sunrpc/msg_prot.h	Sun Sep 15 22:18:46 2002
+++ 04-authflav/include/linux/sunrpc/msg_prot.h	Tue Sep 17 14:14:07 2002
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
 
diff -drN -U2 03-connect2/include/linux/sunrpc/svc.h 04-authflav/include/linux/sunrpc/svc.h
--- 03-connect2/include/linux/sunrpc/svc.h	Sun Sep 15 22:18:30 2002
+++ 04-authflav/include/linux/sunrpc/svc.h	Tue Sep 17 14:14:07 2002
@@ -83,6 +83,6 @@
 	int			nriov;
 };
-#define svc_getlong(argp, val)	{ (val) = *(argp)->buf++; (argp)->len--; }
-#define svc_putlong(resp, val)	{ *(resp)->buf++ = (val); (resp)->len++; }
+#define svc_getu32(argp, val)	{ (val) = *(argp)->buf++; (argp)->len--; }
+#define svc_putu32(resp, val)	{ *(resp)->buf++ = (val); (resp)->len++; }
 
 /*
diff -drN -U2 03-connect2/include/linux/sunrpc/svcauth.h 04-authflav/include/linux/sunrpc/svcauth.h
--- 03-connect2/include/linux/sunrpc/svcauth.h	Sun Sep 15 22:18:27 2002
+++ 04-authflav/include/linux/sunrpc/svcauth.h	Tue Sep 17 14:14:07 2002
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
--- 03-connect2/net/sunrpc/auth.c	Sun Sep 15 22:18:15 2002
+++ 04-authflav/net/sunrpc/auth.c	Tue Sep 17 14:14:07 2002
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
--- 03-connect2/net/sunrpc/auth_null.c	Sun Sep 15 22:18:29 2002
+++ 04-authflav/net/sunrpc/auth_null.c	Tue Sep 17 14:14:07 2002
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
--- 03-connect2/net/sunrpc/auth_unix.c	Sun Sep 15 22:18:18 2002
+++ 04-authflav/net/sunrpc/auth_unix.c	Tue Sep 17 14:14:07 2002
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
--- 03-connect2/net/sunrpc/clnt.c	Tue Sep 17 14:06:27 2002
+++ 04-authflav/net/sunrpc/clnt.c	Tue Sep 17 14:14:07 2002
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
diff -drN -U2 03-connect2/net/sunrpc/svc.c 04-authflav/net/sunrpc/svc.c
--- 03-connect2/net/sunrpc/svc.c	Sun Sep 15 22:18:54 2002
+++ 04-authflav/net/sunrpc/svc.c	Tue Sep 17 14:14:07 2002
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
diff -drN -U2 03-connect2/net/sunrpc/svcauth.c 04-authflav/net/sunrpc/svcauth.c
--- 03-connect2/net/sunrpc/svcauth.c	Sun Sep 15 22:18:23 2002
+++ 04-authflav/net/sunrpc/svcauth.c	Tue Sep 17 14:14:07 2002
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
diff -drN -U2 03-connect2/net/sunrpc/svcsock.c 04-authflav/net/sunrpc/svcsock.c
--- 03-connect2/net/sunrpc/svcsock.c	Sun Sep 15 22:18:19 2002
+++ 04-authflav/net/sunrpc/svcsock.c	Tue Sep 17 14:14:07 2002
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


