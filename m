Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWG0VDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWG0VDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWG0VDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50397 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751253AbWG0VDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:03:05 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/30] NFS: Generalise the nfs_client structure [try #11]
Date: Thu, 27 Jul 2006 21:52:48 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205248.8443.47254.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generalise the nfs_client structure by:

 (1) Moving nfs_client to a more general place (nfs_fs_sb.h).

 (2) Renaming its maintenance routines to be non-NFS4 specific.

 (3) Move those maintenance routines to a new non-NFS4 specific file (client.c)
     and move the declarations to internal.h.

 (4) Make nfs_find/get_client() take a full sockaddr_in to include the port
     number (will be required for NFS2/3).

 (5) Make nfs_find/get_client() take the NFS protocol version (again will be
     required to differentiate NFS2, 3 & 4 client records).

Also:

 (6) Make nfs_client construction proceed akin to inodes, marking them as under
     construction and providing a function to indicate completion.

 (7) Make nfs_get_client() wait interruptibly if it finds a client that it can
     share, but that client is currently being constructed.

 (8) Make nfs4_create_client() use (6) and (7) instead of locking cl_sem.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/Makefile           |    6 -
 fs/nfs/callback.c         |    9 +
 fs/nfs/callback_proc.c    |    9 +
 fs/nfs/client.c           |  312 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/delegation.c       |    9 +
 fs/nfs/internal.h         |    6 +
 fs/nfs/nfs4_fs.h          |   52 --------
 fs/nfs/nfs4proc.c         |    2 
 fs/nfs/nfs4state.c        |  128 +-----------------
 fs/nfs/super.c            |   53 +++-----
 include/linux/nfs_fs.h    |    1 
 include/linux/nfs_fs_sb.h |   60 +++++++++
 12 files changed, 425 insertions(+), 222 deletions(-)

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 0b572a0..3b993a6 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -4,9 +4,9 @@ #
 
 obj-$(CONFIG_NFS_FS) += nfs.o
 
-nfs-y 			:= dir.o file.o inode.o super.o nfs2xdr.o pagelist.o \
-			   proc.o read.o symlink.o unlink.o write.o \
-			   namespace.o
+nfs-y 			:= client.o dir.o file.o inode.o super.o nfs2xdr.o \
+			   pagelist.o proc.o read.o symlink.o unlink.o \
+			   write.o namespace.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
 nfs-$(CONFIG_NFS_V3_ACL)	+= nfs3acl.o
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 1b596b6..a3ee113 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -19,6 +19,7 @@ #include <net/inet_sock.h>
 
 #include "nfs4_fs.h"
 #include "callback.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY NFSDBG_CALLBACK
 
@@ -166,15 +167,15 @@ void nfs_callback_down(void)
 
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 {
-	struct in_addr *addr = &rqstp->rq_addr.sin_addr;
+	struct sockaddr_in *addr = &rqstp->rq_addr;
 	struct nfs_client *clp;
 
 	/* Don't talk to strangers */
-	clp = nfs4_find_client(addr);
+	clp = nfs_find_client(addr, 4);
 	if (clp == NULL)
 		return SVC_DROP;
-	dprintk("%s: %u.%u.%u.%u NFSv4 callback!\n", __FUNCTION__, NIPQUAD(addr));
-	nfs4_put_client(clp);
+	dprintk("%s: %u.%u.%u.%u NFSv4 callback!\n", __FUNCTION__, NIPQUAD(addr->sin_addr));
+	nfs_put_client(clp);
 	switch (rqstp->rq_authop->flavour) {
 		case RPC_AUTH_NULL:
 			if (rqstp->rq_proc != CB_NULL)
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 55d6e2e..97cf8f7 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -10,6 +10,7 @@ #include <linux/nfs_fs.h>
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY NFSDBG_CALLBACK
  
@@ -22,7 +23,7 @@ unsigned nfs4_callback_getattr(struct cb
 	
 	res->bitmap[0] = res->bitmap[1] = 0;
 	res->status = htonl(NFS4ERR_BADHANDLE);
-	clp = nfs4_find_client(&args->addr->sin_addr);
+	clp = nfs_find_client(args->addr, 4);
 	if (clp == NULL)
 		goto out;
 	inode = nfs_delegation_find_inode(clp, &args->fh);
@@ -48,7 +49,7 @@ out_iput:
 	up_read(&nfsi->rwsem);
 	iput(inode);
 out_putclient:
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 out:
 	dprintk("%s: exit with status = %d\n", __FUNCTION__, ntohl(res->status));
 	return res->status;
@@ -61,7 +62,7 @@ unsigned nfs4_callback_recall(struct cb_
 	unsigned res;
 	
 	res = htonl(NFS4ERR_BADHANDLE);
-	clp = nfs4_find_client(&args->addr->sin_addr);
+	clp = nfs_find_client(args->addr, 4);
 	if (clp == NULL)
 		goto out;
 	inode = nfs_delegation_find_inode(clp, &args->fh);
@@ -80,7 +81,7 @@ unsigned nfs4_callback_recall(struct cb_
 	}
 	iput(inode);
 out_putclient:
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 out:
 	dprintk("%s: exit with status = %d\n", __FUNCTION__, ntohl(res));
 	return res;
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
new file mode 100644
index 0000000..cb5e924
--- /dev/null
+++ b/fs/nfs/client.c
@@ -0,0 +1,312 @@
+/* client.c: NFS client sharing and management code
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/stats.h>
+#include <linux/sunrpc/metrics.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_mount.h>
+#include <linux/nfs4_mount.h>
+#include <linux/lockd/bind.h>
+#include <linux/smp_lock.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
+#include <linux/nfs_idmap.h>
+#include <linux/vfs.h>
+#include <linux/inet.h>
+#include <linux/nfs_xdr.h>
+
+#include <asm/system.h>
+
+#include "nfs4_fs.h"
+#include "callback.h"
+#include "delegation.h"
+#include "iostat.h"
+#include "internal.h"
+
+#define NFSDBG_FACILITY		NFSDBG_CLIENT
+
+static DEFINE_SPINLOCK(nfs_client_lock);
+static LIST_HEAD(nfs_client_list);
+static DECLARE_WAIT_QUEUE_HEAD(nfs_client_active_wq);
+
+/*
+ * Allocate a shared client record
+ *
+ * Since these are allocated/deallocated very rarely, we don't
+ * bother putting them in a slab cache...
+ */
+static struct nfs_client *nfs_alloc_client(const char *hostname,
+					   const struct sockaddr_in *addr,
+					   int nfsversion)
+{
+	struct nfs_client *clp;
+	int error;
+
+	if ((clp = kzalloc(sizeof(*clp), GFP_KERNEL)) == NULL)
+		goto error_0;
+
+	error = rpciod_up();
+	if (error < 0) {
+		dprintk("%s: couldn't start rpciod! Error = %d\n",
+				__FUNCTION__, error);
+		__set_bit(NFS_CS_RPCIOD, &clp->cl_res_state);
+		goto error_1;
+	}
+
+	if (nfsversion == 4) {
+		if (nfs_callback_up() < 0)
+			goto error_2;
+		__set_bit(NFS_CS_CALLBACK, &clp->cl_res_state);
+	}
+
+	atomic_set(&clp->cl_count, 1);
+	clp->cl_cons_state = NFS_CS_INITING;
+
+	clp->cl_nfsversion = nfsversion;
+	memcpy(&clp->cl_addr, addr, sizeof(clp->cl_addr));
+
+	if (hostname) {
+		clp->cl_hostname = kstrdup(hostname, GFP_KERNEL);
+		if (!clp->cl_hostname)
+			goto error_3;
+	}
+
+	INIT_LIST_HEAD(&clp->cl_superblocks);
+	clp->cl_rpcclient = ERR_PTR(-EINVAL);
+
+#ifdef CONFIG_NFS_V4
+	init_rwsem(&clp->cl_sem);
+	INIT_LIST_HEAD(&clp->cl_delegations);
+	INIT_LIST_HEAD(&clp->cl_state_owners);
+	INIT_LIST_HEAD(&clp->cl_unused);
+	spin_lock_init(&clp->cl_lock);
+	INIT_WORK(&clp->cl_renewd, nfs4_renew_state, clp);
+	rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS client");
+	clp->cl_boot_time = CURRENT_TIME;
+	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
+#endif
+
+	return clp;
+
+error_3:
+	nfs_callback_down();
+	__clear_bit(NFS_CS_CALLBACK, &clp->cl_res_state);
+error_2:
+	rpciod_down();
+	__clear_bit(NFS_CS_RPCIOD, &clp->cl_res_state);
+error_1:
+	kfree(clp);
+error_0:
+	return NULL;
+}
+
+/*
+ * Destroy a shared client record
+ */
+static void nfs_free_client(struct nfs_client *clp)
+{
+	dprintk("--> nfs_free_client(%d)\n", clp->cl_nfsversion);
+
+#ifdef CONFIG_NFS_V4
+	if (__test_and_clear_bit(NFS_CS_IDMAP, &clp->cl_res_state)) {
+		while (!list_empty(&clp->cl_unused)) {
+			struct nfs4_state_owner *sp;
+
+			sp = list_entry(clp->cl_unused.next,
+					struct nfs4_state_owner,
+					so_list);
+			list_del(&sp->so_list);
+			kfree(sp);
+		}
+		BUG_ON(!list_empty(&clp->cl_state_owners));
+		nfs_idmap_delete(clp);
+	}
+#endif
+
+	/* -EIO all pending I/O */
+	if (!IS_ERR(clp->cl_rpcclient))
+		rpc_shutdown_client(clp->cl_rpcclient);
+
+	if (__test_and_clear_bit(NFS_CS_CALLBACK, &clp->cl_res_state))
+		nfs_callback_down();
+
+	if (__test_and_clear_bit(NFS_CS_RPCIOD, &clp->cl_res_state))
+	rpciod_down();
+
+	kfree(clp->cl_hostname);
+	kfree(clp);
+
+	dprintk("<-- nfs_free_client()\n");
+}
+
+/*
+ * Release a reference to a shared client record
+ */
+void nfs_put_client(struct nfs_client *clp)
+{
+	dprintk("--> nfs_put_client({%d})\n", atomic_read(&clp->cl_count));
+
+	if (atomic_dec_and_lock(&clp->cl_count, &nfs_client_lock)) {
+		list_del(&clp->cl_share_link);
+		spin_unlock(&nfs_client_lock);
+
+		BUG_ON(!list_empty(&clp->cl_superblocks));
+
+		nfs_free_client(clp);
+	}
+}
+
+/*
+ * Find a client by address
+ * - caller must hold nfs_client_lock
+ */
+static struct nfs_client *__nfs_find_client(const struct sockaddr_in *addr, int nfsversion)
+{
+	struct nfs_client *clp;
+
+	list_for_each_entry(clp, &nfs_client_list, cl_share_link) {
+		/* Different NFS versions cannot share the same nfs_client */
+		if (clp->cl_nfsversion != nfsversion)
+			continue;
+
+		if (memcmp(&clp->cl_addr.sin_addr, &addr->sin_addr,
+			   sizeof(clp->cl_addr.sin_addr)) != 0)
+			continue;
+
+		if (clp->cl_addr.sin_port == addr->sin_port)
+			goto found;
+	}
+
+	return NULL;
+
+found:
+	atomic_inc(&clp->cl_count);
+	return clp;
+}
+
+/*
+ * Find a client by IP address and protocol version
+ * - returns NULL if no such client
+ */
+struct nfs_client *nfs_find_client(const struct sockaddr_in *addr, int nfsversion)
+{
+	struct nfs_client *clp;
+
+	spin_lock(&nfs_client_lock);
+	clp = __nfs_find_client(addr, nfsversion);
+	spin_unlock(&nfs_client_lock);
+
+	BUG_ON(clp->cl_cons_state == 0);
+
+	return clp;
+}
+
+/*
+ * Look up a client by IP address and protocol version
+ * - creates a new record if one doesn't yet exist
+ */
+struct nfs_client *nfs_get_client(const char *hostname,
+				  const struct sockaddr_in *addr,
+				  int nfsversion)
+{
+	struct nfs_client *clp, *new = NULL;
+	int error;
+
+	dprintk("--> nfs_get_client(%s,"NIPQUAD_FMT":%d,%d)\n",
+		hostname ?: "", NIPQUAD(addr->sin_addr),
+		addr->sin_port, nfsversion);
+
+	/* see if the client already exists */
+	do {
+		spin_lock(&nfs_client_lock);
+
+		clp = __nfs_find_client(addr, nfsversion);
+		if (clp)
+			goto found_client;
+		if (new)
+			goto install_client;
+
+		spin_unlock(&nfs_client_lock);
+
+		new = nfs_alloc_client(hostname, addr, nfsversion);
+	} while (new);
+
+	return ERR_PTR(-ENOMEM);
+
+	/* install a new client and return with it unready */
+install_client:
+	clp = new;
+	list_add(&clp->cl_share_link, &nfs_client_list);
+	spin_unlock(&nfs_client_lock);
+	dprintk("--> nfs_get_client() = %p [new]\n", clp);
+	return clp;
+
+	/* found an existing client
+	 * - make sure it's ready before returning
+	 */
+found_client:
+	spin_unlock(&nfs_client_lock);
+
+	if (new)
+		nfs_free_client(new);
+
+	if (clp->cl_cons_state == NFS_CS_INITING) {
+		DECLARE_WAITQUEUE(myself, current);
+
+		add_wait_queue(&nfs_client_active_wq, &myself);
+
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (signal_pending(current) ||
+			    clp->cl_cons_state > NFS_CS_READY)
+				break;
+			schedule();
+		}
+
+		remove_wait_queue(&nfs_client_active_wq, &myself);
+
+		if (signal_pending(current)) {
+			nfs_put_client(clp);
+			return ERR_PTR(-ERESTARTSYS);
+		}
+	}
+
+	if (clp->cl_cons_state < NFS_CS_READY) {
+		error = clp->cl_cons_state;
+		nfs_put_client(clp);
+		return ERR_PTR(error);
+	}
+
+	dprintk("--> nfs_get_client() = %p [share]\n", clp);
+	return clp;
+}
+
+/*
+ * Mark a server as ready or failed
+ */
+void nfs_mark_client_ready(struct nfs_client *clp, int state)
+{
+	clp->cl_cons_state = state;
+	wake_up_all(&nfs_client_active_wq);
+}
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cfe2397..5713367 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -18,6 +18,7 @@ #include <linux/nfs_xdr.h>
 
 #include "nfs4_fs.h"
 #include "delegation.h"
+#include "internal.h"
 
 static struct nfs_delegation *nfs_alloc_delegation(void)
 {
@@ -145,7 +146,7 @@ int nfs_inode_set_delegation(struct inod
 					sizeof(delegation->stateid)) != 0 ||
 				delegation->type != nfsi->delegation->type) {
 			printk("%s: server %u.%u.%u.%u, handed out a duplicate delegation!\n",
-					__FUNCTION__, NIPQUAD(clp->cl_addr));
+					__FUNCTION__, NIPQUAD(clp->cl_addr.sin_addr));
 			status = -EIO;
 		}
 	}
@@ -254,7 +255,7 @@ restart:
 	}
 out:
 	spin_unlock(&clp->cl_lock);
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 	module_put_and_exit(0);
 }
 
@@ -266,10 +267,10 @@ void nfs_expire_all_delegations(struct n
 	atomic_inc(&clp->cl_count);
 	task = kthread_run(nfs_do_expire_all_delegations, clp,
 			"%u.%u.%u.%u-delegreturn",
-			NIPQUAD(clp->cl_addr));
+			NIPQUAD(clp->cl_addr.sin_addr));
 	if (!IS_ERR(task))
 		return;
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 	module_put(THIS_MODULE);
 }
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 94a7870..5ae1306 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -15,6 +15,12 @@ struct nfs_clone_mount {
 	rpc_authflavor_t authflavor;
 };
 
+/* client.c */
+extern void nfs_put_client(struct nfs_client *);
+extern struct nfs_client *nfs_find_client(const struct sockaddr_in *, int);
+extern struct nfs_client *nfs_get_client(const char *, const struct sockaddr_in *, int);
+extern void nfs_mark_client_ready(struct nfs_client *, int);
+
 /* nfs4namespace.c */
 #ifdef CONFIG_NFS_V4
 extern struct vfsmount *nfs_do_refmount(const struct vfsmount *mnt_parent, struct dentry *dentry);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4e334cb..e787924 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -43,55 +43,6 @@ enum nfs4_client_state {
 };
 
 /*
- * The nfs_client identifies our client state to the server.
- */
-struct nfs_client {
-	struct list_head	cl_servers;	/* Global list of servers */
-	struct in_addr		cl_addr;	/* Server identifier */
-	u64			cl_clientid;	/* constant */
-	nfs4_verifier		cl_confirm;
-	unsigned long		cl_state;
-
-	u32			cl_lockowner_id;
-
-	/*
-	 * The following rwsem ensures exclusive access to the server
-	 * while we recover the state following a lease expiration.
-	 */
-	struct rw_semaphore	cl_sem;
-
-	struct list_head	cl_delegations;
-	struct list_head	cl_state_owners;
-	struct list_head	cl_unused;
-	int			cl_nunused;
-	spinlock_t		cl_lock;
-	atomic_t		cl_count;
-
-	struct rpc_clnt *	cl_rpcclient;
-
-	struct list_head	cl_superblocks;	/* List of nfs_server structs */
-
-	unsigned long		cl_lease_time;
-	unsigned long		cl_last_renewal;
-	struct work_struct	cl_renewd;
-	struct work_struct	cl_recoverd;
-
-	struct rpc_wait_queue	cl_rpcwaitq;
-
-	/* used for the setclientid verifier */
-	struct timespec		cl_boot_time;
-
-	/* idmapper */
-	struct idmap *		cl_idmap;
-
-	/* Our own IP address, as a null-terminated string.
-	 * This is used to generate the clientid, and the callback address.
-	 */
-	char			cl_ipaddr[16];
-	unsigned char		cl_id_uniquifier;
-};
-
-/*
  * struct rpc_sequence ensures that RPC calls are sent in the exact
  * order that they appear on the list.
  */
@@ -239,9 +190,6 @@ extern void nfs4_renew_state(void *);
 /* nfs4state.c */
 extern void init_nfsv4_state(struct nfs_server *);
 extern void destroy_nfsv4_state(struct nfs_server *);
-extern struct nfs_client *nfs4_get_client(struct in_addr *);
-extern void nfs4_put_client(struct nfs_client *clp);
-extern struct nfs_client *nfs4_find_client(struct in_addr *);
 struct rpc_cred *nfs4_get_renew_cred(struct nfs_client *clp);
 extern u32 nfs4_alloc_lockowner_id(struct nfs_client *);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b433810..2925d37 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2943,7 +2943,7 @@ int nfs4_proc_setclientid(struct nfs_cli
 	for(;;) {
 		setclientid.sc_name_len = scnprintf(setclientid.sc_name,
 				sizeof(setclientid.sc_name), "%s/%u.%u.%u.%u %s %u",
-				clp->cl_ipaddr, NIPQUAD(clp->cl_addr.s_addr),
+				clp->cl_ipaddr, NIPQUAD(clp->cl_addr.sin_addr),
 				cred->cr_ops->cr_name,
 				clp->cl_id_uniquifier);
 		setclientid.sc_netid_len = scnprintf(setclientid.sc_netid,
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index fa51a7d..058811e 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -50,12 +50,12 @@ #include <linux/bitops.h>
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
+#include "internal.h"
 
 #define OPENOWNER_POOL_SIZE	8
 
 const nfs4_stateid zero_stateid;
 
-static DEFINE_SPINLOCK(state_spinlock);
 static LIST_HEAD(nfs4_clientid_list);
 
 void
@@ -71,127 +71,11 @@ destroy_nfsv4_state(struct nfs_server *s
 	kfree(server->mnt_path);
 	server->mnt_path = NULL;
 	if (server->nfs_client) {
-		nfs4_put_client(server->nfs_client);
+		nfs_put_client(server->nfs_client);
 		server->nfs_client = NULL;
 	}
 }
 
-/*
- * nfs4_get_client(): returns an empty client structure
- * nfs4_put_client(): drops reference to client structure
- *
- * Since these are allocated/deallocated very rarely, we don't
- * bother putting them in a slab cache...
- */
-static struct nfs_client *
-nfs4_alloc_client(struct in_addr *addr)
-{
-	struct nfs_client *clp;
-
-	if (nfs_callback_up() < 0)
-		return NULL;
-	if ((clp = kzalloc(sizeof(*clp), GFP_KERNEL)) == NULL) {
-		nfs_callback_down();
-		return NULL;
-	}
-	memcpy(&clp->cl_addr, addr, sizeof(clp->cl_addr));
-	init_rwsem(&clp->cl_sem);
-	INIT_LIST_HEAD(&clp->cl_delegations);
-	INIT_LIST_HEAD(&clp->cl_state_owners);
-	INIT_LIST_HEAD(&clp->cl_unused);
-	spin_lock_init(&clp->cl_lock);
-	atomic_set(&clp->cl_count, 1);
-	INIT_WORK(&clp->cl_renewd, nfs4_renew_state, clp);
-	INIT_LIST_HEAD(&clp->cl_superblocks);
-	rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS4 client");
-	clp->cl_rpcclient = ERR_PTR(-EINVAL);
-	clp->cl_boot_time = CURRENT_TIME;
-	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
-	return clp;
-}
-
-static void
-nfs4_free_client(struct nfs_client *clp)
-{
-	struct nfs4_state_owner *sp;
-
-	while (!list_empty(&clp->cl_unused)) {
-		sp = list_entry(clp->cl_unused.next,
-				struct nfs4_state_owner,
-				so_list);
-		list_del(&sp->so_list);
-		kfree(sp);
-	}
-	BUG_ON(!list_empty(&clp->cl_state_owners));
-	nfs_idmap_delete(clp);
-	if (!IS_ERR(clp->cl_rpcclient))
-		rpc_shutdown_client(clp->cl_rpcclient);
-	kfree(clp);
-	nfs_callback_down();
-}
-
-static struct nfs_client *__nfs4_find_client(struct in_addr *addr)
-{
-	struct nfs_client *clp;
-	list_for_each_entry(clp, &nfs4_clientid_list, cl_servers) {
-		if (memcmp(&clp->cl_addr, addr, sizeof(clp->cl_addr)) == 0) {
-			atomic_inc(&clp->cl_count);
-			return clp;
-		}
-	}
-	return NULL;
-}
-
-struct nfs_client *nfs4_find_client(struct in_addr *addr)
-{
-	struct nfs_client *clp;
-	spin_lock(&state_spinlock);
-	clp = __nfs4_find_client(addr);
-	spin_unlock(&state_spinlock);
-	return clp;
-}
-
-struct nfs_client *
-nfs4_get_client(struct in_addr *addr)
-{
-	struct nfs_client *clp, *new = NULL;
-
-	spin_lock(&state_spinlock);
-	for (;;) {
-		clp = __nfs4_find_client(addr);
-		if (clp != NULL)
-			break;
-		clp = new;
-		if (clp != NULL) {
-			list_add(&clp->cl_servers, &nfs4_clientid_list);
-			new = NULL;
-			break;
-		}
-		spin_unlock(&state_spinlock);
-		new = nfs4_alloc_client(addr);
-		spin_lock(&state_spinlock);
-		if (new == NULL)
-			break;
-	}
-	spin_unlock(&state_spinlock);
-	if (new)
-		nfs4_free_client(new);
-	return clp;
-}
-
-void
-nfs4_put_client(struct nfs_client *clp)
-{
-	if (!atomic_dec_and_lock(&clp->cl_count, &state_spinlock))
-		return;
-	list_del(&clp->cl_servers);
-	spin_unlock(&state_spinlock);
-	BUG_ON(!list_empty(&clp->cl_superblocks));
-	rpc_wake_up(&clp->cl_rpcwaitq);
-	nfs4_kill_renewd(clp);
-	nfs4_free_client(clp);
-}
-
 static int nfs4_init_client(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	int status = nfs4_proc_setclientid(clp, NFS4_CALLBACK,
@@ -771,11 +655,11 @@ static void nfs4_recover_state(struct nf
 	__module_get(THIS_MODULE);
 	atomic_inc(&clp->cl_count);
 	task = kthread_run(reclaimer, clp, "%u.%u.%u.%u-reclaim",
-			NIPQUAD(clp->cl_addr));
+			NIPQUAD(clp->cl_addr.sin_addr));
 	if (!IS_ERR(task))
 		return;
 	nfs4_clear_recover_bit(clp);
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 	module_put(THIS_MODULE);
 }
 
@@ -970,12 +854,12 @@ out:
 	if (status == -NFS4ERR_CB_PATH_DOWN)
 		nfs_handle_cb_pathdown(clp);
 	nfs4_clear_recover_bit(clp);
-	nfs4_put_client(clp);
+	nfs_put_client(clp);
 	module_put_and_exit(0);
 	return 0;
 out_error:
 	printk(KERN_WARNING "Error: state recovery failed on NFSv4 server %u.%u.%u.%u with error %d\n",
-				NIPQUAD(clp->cl_addr.s_addr), -status);
+				NIPQUAD(clp->cl_addr.sin_addr), -status);
 	set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
 	goto out;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0fbb75e..ce24b52 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1099,47 +1099,46 @@ static struct rpc_clnt *nfs4_create_clie
 	struct rpc_clnt *clnt = NULL;
 	int err = -EIO;
 
-	clp = nfs4_get_client(&server->addr.sin_addr);
+	clp = nfs_get_client(server->hostname, &server->addr, 4);
 	if (!clp) {
 		dprintk("%s: failed to create NFS4 client.\n", __FUNCTION__);
 		return ERR_PTR(err);
 	}
 
 	/* Now create transport and client */
-	down_write(&clp->cl_sem);
-	if (IS_ERR(clp->cl_rpcclient)) {
+	if (clp->cl_cons_state == NFS_CS_INITING) {
 		xprt = xprt_create_proto(proto, &server->addr, timeparms);
 		if (IS_ERR(xprt)) {
-			up_write(&clp->cl_sem);
 			err = PTR_ERR(xprt);
 			dprintk("%s: cannot create RPC transport. Error = %d\n",
 					__FUNCTION__, err);
-			goto out_fail;
+			goto client_init_error;
 		}
 		/* Bind to a reserved port! */
 		xprt->resvport = 1;
 		clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
 				server->rpc_ops->version, flavor);
 		if (IS_ERR(clnt)) {
-			up_write(&clp->cl_sem);
 			err = PTR_ERR(clnt);
 			dprintk("%s: cannot create RPC client. Error = %d\n",
 					__FUNCTION__, err);
-			goto out_fail;
+			goto client_init_error;
 		}
 		clnt->cl_intr     = 1;
 		clnt->cl_softrtry = 1;
 		clp->cl_rpcclient = clnt;
 		memcpy(clp->cl_ipaddr, server->ip_addr, sizeof(clp->cl_ipaddr));
-		if (nfs_idmap_new(clp) < 0)
-			goto out_fail;
+		err = nfs_idmap_new(clp);
+		if (err < 0) {
+			dprintk("%s: failed to create idmapper.\n",
+				__FUNCTION__);
+			goto client_init_error;
+		}
+		__set_bit(NFS_CS_IDMAP, &clp->cl_res_state);
+		nfs_mark_client_ready(clp, 0);
 	}
-	list_add_tail(&server->nfs4_siblings, &clp->cl_superblocks);
+
 	clnt = rpc_clone_client(clp->cl_rpcclient);
-	if (!IS_ERR(clnt))
-		server->nfs_client = clp;
-	up_write(&clp->cl_sem);
-	clp = NULL;
 
 	if (IS_ERR(clnt)) {
 		dprintk("%s: cannot create RPC client. Error = %d\n",
@@ -1147,11 +1146,6 @@ static struct rpc_clnt *nfs4_create_clie
 		return clnt;
 	}
 
-	if (server->nfs_client->cl_idmap == NULL) {
-		dprintk("%s: failed to create idmapper.\n", __FUNCTION__);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (clnt->cl_auth->au_flavor != flavor) {
 		struct rpc_auth *auth;
 
@@ -1161,11 +1155,16 @@ static struct rpc_clnt *nfs4_create_clie
 			return (struct rpc_clnt *)auth;
 		}
 	}
+
+	server->nfs_client = clp;
+	down_write(&clp->cl_sem);
+	list_add_tail(&server->nfs4_siblings, &clp->cl_superblocks);
+	up_write(&clp->cl_sem);
 	return clnt;
 
- out_fail:
-	if (clp)
-		nfs4_put_client(clp);
+client_init_error:
+	nfs_mark_client_ready(clp, err);
+	nfs_put_client(clp);
 	return ERR_PTR(err);
 }
 
@@ -1324,14 +1323,6 @@ static int nfs4_get_sb(struct file_syste
 		goto out_free;
 	}
 
-	/* Fire up rpciod if not yet running */
-	error = rpciod_up();
-	if (error < 0) {
-		dprintk("%s: couldn't start rpciod! Error = %d\n",
-				__FUNCTION__, error);
-		goto out_free;
-	}
-
 	s = sget(fs_type, nfs4_compare_super, nfs_set_super, server);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
@@ -1378,8 +1369,6 @@ static void nfs4_kill_super(struct super
 
 	destroy_nfsv4_state(server);
 
-	rpciod_down();
-
 	nfs_free_iostats(server->io_stats);
 	kfree(server->hostname);
 	kfree(server);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 55ea853..9616419 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -581,6 +581,7 @@ #define NFSDBG_XDR		0x0020
 #define NFSDBG_FILE		0x0040
 #define NFSDBG_ROOT		0x0080
 #define NFSDBG_CALLBACK		0x0100
+#define NFSDBG_CLIENT		0x0200
 #define NFSDBG_ALL		0xFFFF
 
 #ifdef __KERNEL__
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fc20d6b..a727657 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -7,6 +7,66 @@ #include <linux/backing-dev.h>
 struct nfs_iostats;
 
 /*
+ * The nfs_client identifies our client state to the server.
+ */
+struct nfs_client {
+	atomic_t		cl_count;
+	int			cl_cons_state;	/* current construction state (-ve: init error) */
+#define NFS_CS_READY		0		/* ready to be used */
+#define NFS_CS_INITING		1		/* busy initialising */
+	int			cl_nfsversion;	/* NFS protocol version */
+	unsigned long		cl_res_state;	/* NFS resources state */
+#define NFS_CS_RPCIOD		0		/* - rpciod started */
+#define NFS_CS_CALLBACK		1		/* - callback started */
+#define NFS_CS_IDMAP		2		/* - idmap started */
+	struct sockaddr_in	cl_addr;	/* server identifier */
+	char *			cl_hostname;	/* hostname of server */
+	struct list_head	cl_share_link;	/* link in global client list */
+	struct list_head	cl_superblocks;	/* List of nfs_server structs */
+
+	struct rpc_clnt *	cl_rpcclient;
+
+#ifdef CONFIG_NFS_V4
+	u64			cl_clientid;	/* constant */
+	nfs4_verifier		cl_confirm;
+	unsigned long		cl_state;
+
+	u32			cl_lockowner_id;
+
+	/*
+	 * The following rwsem ensures exclusive access to the server
+	 * while we recover the state following a lease expiration.
+	 */
+	struct rw_semaphore	cl_sem;
+
+	struct list_head	cl_delegations;
+	struct list_head	cl_state_owners;
+	struct list_head	cl_unused;
+	int			cl_nunused;
+	spinlock_t		cl_lock;
+
+	unsigned long		cl_lease_time;
+	unsigned long		cl_last_renewal;
+	struct work_struct	cl_renewd;
+	struct work_struct	cl_recoverd;
+
+	struct rpc_wait_queue	cl_rpcwaitq;
+
+	/* used for the setclientid verifier */
+	struct timespec		cl_boot_time;
+
+	/* idmapper */
+	struct idmap *		cl_idmap;
+
+	/* Our own IP address, as a null-terminated string.
+	 * This is used to generate the clientid, and the callback address.
+	 */
+	char			cl_ipaddr[16];
+	unsigned char		cl_id_uniquifier;
+#endif
+};
+
+/*
  * NFS client parameters stored in the superblock.
  */
 struct nfs_server {
