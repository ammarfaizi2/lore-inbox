Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTAMAFQ>; Sun, 12 Jan 2003 19:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbTAMAFP>; Sun, 12 Jan 2003 19:05:15 -0500
Received: from mons.uio.no ([129.240.130.14]:26506 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267662AbTAMAEg>;
	Sun, 12 Jan 2003 19:04:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1182.706813.345539@charged.uio.no>
Date: Mon, 13 Jan 2003 01:13:18 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [1/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clean up RPC client credcache lookups.

    - Remove the limitation whereby the RPC client may only look up
      credentials for the current task.

The ability to lookup arbitrary credentials is needed in order to allow
a user daemon to set the RPCSEC_GSS private information once it
has finished negotiating the RPCSEC user context with the server.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.56-01-fix_oops/include/linux/sunrpc/auth.h linux-2.5.56-02-auth2/include/linux/sunrpc/auth.h
--- linux-2.5.56-01-fix_oops/include/linux/sunrpc/auth.h	2003-01-08 14:29:07.000000000 +0100
+++ linux-2.5.56-02-auth2/include/linux/sunrpc/auth.h	2003-01-12 22:39:26.000000000 +0100
@@ -19,6 +19,14 @@
 /* size of the nodename buffer */
 #define UNX_MAXNODENAME	32
 
+/* Work around the lack of a VFS credential */
+struct auth_cred {
+	uid_t	uid;
+	gid_t	gid;
+	int	ngroups;
+	gid_t	*groups;
+};
+
 /*
  * Client user credentials
  */
@@ -74,13 +82,13 @@
 	struct rpc_auth *	(*create)(struct rpc_clnt *);
 	void			(*destroy)(struct rpc_auth *);
 
-	struct rpc_cred *	(*crcreate)(int);
+	struct rpc_cred *	(*crcreate)(struct auth_cred *, int);
 };
 
 struct rpc_credops {
 	void			(*crdestroy)(struct rpc_cred *);
 
-	int			(*crmatch)(struct rpc_cred *, int);
+	int			(*crmatch)(struct auth_cred *, struct rpc_cred *, int);
 	u32 *			(*crmarshal)(struct rpc_task *, u32 *, int);
 	int			(*crrefresh)(struct rpc_task *);
 	u32 *			(*crvalidate)(struct rpc_task *, u32 *);
diff -u --recursive --new-file linux-2.5.56-01-fix_oops/net/sunrpc/auth.c linux-2.5.56-02-auth2/net/sunrpc/auth.c
--- linux-2.5.56-01-fix_oops/net/sunrpc/auth.c	2003-01-08 14:29:07.000000000 +0100
+++ linux-2.5.56-02-auth2/net/sunrpc/auth.c	2003-01-12 22:39:26.000000000 +0100
@@ -174,7 +174,8 @@
  * Look up a process' credentials in the authentication cache
  */
 static struct rpc_cred *
-rpcauth_lookup_credcache(struct rpc_auth *auth, int taskflags)
+rpcauth_lookup_credcache(struct rpc_auth *auth, struct auth_cred * acred,
+		int taskflags)
 {
 	LIST_HEAD(free);
 	struct list_head *pos, *next;
@@ -183,7 +184,7 @@
 	int		nr = 0;
 
 	if (!(taskflags & RPC_TASK_ROOTCREDS))
-		nr = current->uid & RPC_CREDCACHE_MASK;
+		nr = acred->uid & RPC_CREDCACHE_MASK;
 retry:
 	spin_lock(&rpc_credcache_lock);
 	if (time_before(auth->au_nextgc, jiffies))
@@ -195,7 +196,7 @@
 			continue;
 		if (rpcauth_prune_expired(entry, &free))
 			continue;
-		if (entry->cr_ops->crmatch(entry, taskflags)) {
+		if (entry->cr_ops->crmatch(acred, entry, taskflags)) {
 			list_del(&entry->cr_hash);
 			cred = entry;
 			break;
@@ -217,7 +218,7 @@
 	rpcauth_destroy_credlist(&free);
 
 	if (!cred) {
-		new = auth->au_ops->crcreate(taskflags);
+		new = auth->au_ops->crcreate(acred, taskflags);
 		if (new) {
 #ifdef RPC_DEBUG
 			new->cr_magic = RPCAUTH_CRED_MAGIC;
@@ -232,19 +233,31 @@
 struct rpc_cred *
 rpcauth_lookupcred(struct rpc_auth *auth, int taskflags)
 {
+	struct auth_cred acred = {
+		.uid = current->fsuid,
+		.gid = current->fsgid,
+		.ngroups = current->ngroups,
+		.groups = current->groups,
+	};
 	dprintk("RPC:     looking up %s cred\n",
 		auth->au_ops->au_name);
-	return rpcauth_lookup_credcache(auth, taskflags);
+	return rpcauth_lookup_credcache(auth, &acred, taskflags);
 }
 
 struct rpc_cred *
 rpcauth_bindcred(struct rpc_task *task)
 {
 	struct rpc_auth *auth = task->tk_auth;
+	struct auth_cred acred = {
+		.uid = current->fsuid,
+		.gid = current->fsgid,
+		.ngroups = current->ngroups,
+		.groups = current->groups,
+	};
 
 	dprintk("RPC: %4d looking up %s cred\n",
 		task->tk_pid, task->tk_auth->au_ops->au_name);
-	task->tk_msg.rpc_cred = rpcauth_lookup_credcache(auth, task->tk_flags);
+	task->tk_msg.rpc_cred = rpcauth_lookup_credcache(auth, &acred, task->tk_flags);
 	if (task->tk_msg.rpc_cred == 0)
 		task->tk_status = -ENOMEM;
 	return task->tk_msg.rpc_cred;
diff -u --recursive --new-file linux-2.5.56-01-fix_oops/net/sunrpc/auth_null.c linux-2.5.56-02-auth2/net/sunrpc/auth_null.c
--- linux-2.5.56-01-fix_oops/net/sunrpc/auth_null.c	2002-11-09 00:29:45.000000000 +0100
+++ linux-2.5.56-02-auth2/net/sunrpc/auth_null.c	2003-01-12 22:39:26.000000000 +0100
@@ -48,7 +48,7 @@
  * Create NULL creds for current process
  */
 static struct rpc_cred *
-nul_create_cred(int flags)
+nul_create_cred(struct auth_cred *acred, int flags)
 {
 	struct rpc_cred	*cred;
 
@@ -56,7 +56,7 @@
 		return NULL;
 	atomic_set(&cred->cr_count, 0);
 	cred->cr_flags = RPCAUTH_CRED_UPTODATE;
-	cred->cr_uid = current->uid;
+	cred->cr_uid = acred->uid;
 	cred->cr_ops = &null_credops;
 
 	return cred;
@@ -75,7 +75,7 @@
  * Match cred handle against current process
  */
 static int
-nul_match(struct rpc_cred *cred, int taskflags)
+nul_match(struct auth_cred *acred, struct rpc_cred *cred, int taskflags)
 {
 	return 1;
 }
diff -u --recursive --new-file linux-2.5.56-01-fix_oops/net/sunrpc/auth_unix.c linux-2.5.56-02-auth2/net/sunrpc/auth_unix.c
--- linux-2.5.56-01-fix_oops/net/sunrpc/auth_unix.c	2002-11-09 00:55:56.000000000 +0100
+++ linux-2.5.56-02-auth2/net/sunrpc/auth_unix.c	2003-01-12 22:39:26.000000000 +0100
@@ -14,10 +14,12 @@
 #include <linux/sunrpc/auth.h>
 
 #define NFS_NGROUPS	16
+
 struct unx_cred {
 	struct rpc_cred		uc_base;
-	uid_t			uc_fsuid;
-	gid_t			uc_gid, uc_fsgid;
+	gid_t			uc_gid;
+	uid_t			uc_puid;		/* process uid */
+	gid_t			uc_pgid;		/* process gid */
 	gid_t			uc_gids[NFS_NGROUPS];
 };
 #define uc_uid			uc_base.cr_uid
@@ -62,13 +64,13 @@
 }
 
 static struct rpc_cred *
-unx_create_cred(int flags)
+unx_create_cred(struct auth_cred *acred, int flags)
 {
 	struct unx_cred	*cred;
 	int		i;
 
 	dprintk("RPC:      allocating UNIX cred for uid %d gid %d\n",
-				current->uid, current->gid);
+				acred->uid, acred->gid);
 
 	if (!(cred = (struct unx_cred *) kmalloc(sizeof(*cred), GFP_KERNEL)))
 		return NULL;
@@ -76,20 +78,20 @@
 	atomic_set(&cred->uc_count, 0);
 	cred->uc_flags = RPCAUTH_CRED_UPTODATE;
 	if (flags & RPC_TASK_ROOTCREDS) {
-		cred->uc_uid = cred->uc_fsuid = 0;
-		cred->uc_gid = cred->uc_fsgid = 0;
+		cred->uc_uid = cred->uc_puid = 0;
+		cred->uc_gid = cred->uc_pgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = current->ngroups;
+		int groups = acred->ngroups;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 
-		cred->uc_uid = current->uid;
-		cred->uc_gid = current->gid;
-		cred->uc_fsuid = current->fsuid;
-		cred->uc_fsgid = current->fsgid;
+		cred->uc_uid = acred->uid;
+		cred->uc_gid = acred->gid;
+		cred->uc_puid = current->uid;
+		cred->uc_pgid = current->gid;
 		for (i = 0; i < groups; i++)
-			cred->uc_gids[i] = (gid_t) current->groups[i];
+			cred->uc_gids[i] = (gid_t) acred->groups[i];
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
@@ -110,7 +112,7 @@
  * request root creds (e.g. for NFS swapping).
  */
 static int
-unx_match(struct rpc_cred *rcred, int taskflags)
+unx_match(struct auth_cred *acred, struct rpc_cred *rcred, int taskflags)
 {
 	struct unx_cred	*cred = (struct unx_cred *) rcred;
 	int		i;
@@ -118,22 +120,22 @@
 	if (!(taskflags & RPC_TASK_ROOTCREDS)) {
 		int groups;
 
-		if (cred->uc_uid != current->uid
-		 || cred->uc_gid != current->gid
-		 || cred->uc_fsuid != current->fsuid
-		 || cred->uc_fsgid != current->fsgid)
+		if (cred->uc_uid != acred->uid
+		 || cred->uc_gid != acred->gid
+		 || cred->uc_puid != current->uid
+		 || cred->uc_pgid != current->gid)
 			return 0;
 
-		groups = current->ngroups;
+		groups = acred->ngroups;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 		for (i = 0; i < groups ; i++)
-			if (cred->uc_gids[i] != (gid_t) current->groups[i])
+			if (cred->uc_gids[i] != (gid_t) acred->groups[i])
 				return 0;
 		return 1;
 	}
-	return (cred->uc_uid == 0 && cred->uc_fsuid == 0
-	     && cred->uc_gid == 0 && cred->uc_fsgid == 0
+	return (cred->uc_uid == 0 && cred->uc_puid == 0
+	     && cred->uc_gid == 0 && cred->uc_pgid == 0
 	     && cred->uc_gids[0] == (gid_t) NOGROUP);
 }
 
@@ -162,12 +164,12 @@
 	p += (n + 3) >> 2;
 
 	/* Note: we don't use real uid if it involves raising priviledge */
-	if (ruid && cred->uc_uid != 0 && cred->uc_gid != 0) {
+	if (ruid && cred->uc_puid != 0 && cred->uc_pgid != 0) {
+		*p++ = htonl((u32) cred->uc_puid);
+		*p++ = htonl((u32) cred->uc_pgid);
+	} else {
 		*p++ = htonl((u32) cred->uc_uid);
 		*p++ = htonl((u32) cred->uc_gid);
-	} else {
-		*p++ = htonl((u32) cred->uc_fsuid);
-		*p++ = htonl((u32) cred->uc_fsgid);
 	}
 	hold = p++;
 	for (i = 0; i < 16 && cred->uc_gids[i] != (gid_t) NOGROUP; i++)
