Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVCYVaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVCYVaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVCYVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:30:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:60083 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261810AbVCYV2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:28:50 -0500
Date: Fri, 25 Mar 2005 22:30:41 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] remove null pointer checks prior to calling kfree() - in
 fs/nfs/
Message-ID: <Pine.LNX.4.62.0503252227550.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC)


kfree() has no problem dealing with NULL pointers.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/nfs/delegation.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfs/delegation.c	2005-03-25 21:43:29.000000000 +0100
@@ -111,8 +111,7 @@ int nfs_inode_set_delegation(struct inod
 		}
 	}
 	spin_unlock(&clp->cl_lock);
-	if (delegation != NULL)
-		kfree(delegation);
+	kfree(delegation);
 	return status;
 }
 
--- linux-2.6.12-rc1-mm3-orig/fs/nfs/inode.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfs/inode.c	2005-03-25 21:44:28.000000000 +0100
@@ -1553,8 +1553,7 @@ static void nfs_kill_super(struct super_
 
 	rpciod_down();		/* release rpciod */
 
-	if (server->hostname != NULL)
-		kfree(server->hostname);
+	kfree(server->hostname);
 	kfree(server);
 }
 
@@ -1796,8 +1795,7 @@ nfs_copy_user_string(char *dst, struct n
 			return ERR_PTR(-ENOMEM);
 	}
 	if (copy_from_user(dst, src->data, maxlen)) {
-		if (p != NULL)
-			kfree(p);
+		kfree(p);
 		return ERR_PTR(-EFAULT);
 	}
 	dst[maxlen] = '\0';
@@ -1887,10 +1885,8 @@ static struct super_block *nfs4_get_sb(s
 out_err:
 	s = (struct super_block *)p;
 out_free:
-	if (server->mnt_path)
-		kfree(server->mnt_path);
-	if (server->hostname)
-		kfree(server->hostname);
+	kfree(server->mnt_path);
+	kfree(server->hostname);
 	kfree(server);
 	return s;
 }
@@ -1910,8 +1906,7 @@ static void nfs4_kill_super(struct super
 
 	destroy_nfsv4_state(server);
 
-	if (server->hostname != NULL)
-		kfree(server->hostname);
+	kfree(server->hostname);
 	kfree(server);
 }
 
--- linux-2.6.12-rc1-mm3-orig/fs/nfs/nfs4state.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfs/nfs4state.c	2005-03-25 21:45:47.000000000 +0100
@@ -69,10 +69,9 @@ init_nfsv4_state(struct nfs_server *serv
 void
 destroy_nfsv4_state(struct nfs_server *server)
 {
-	if (server->mnt_path) {
-		kfree(server->mnt_path);
-		server->mnt_path = NULL;
-	}
+	kfree(server->mnt_path);
+	server->mnt_path = NULL;
+
 	if (server->nfs4_state) {
 		nfs4_put_client(server->nfs4_state);
 		server->nfs4_state = NULL;
@@ -307,8 +306,7 @@ struct nfs4_state_owner *nfs4_get_state_
 		new = NULL;
 	}
 	spin_unlock(&clp->cl_lock);
-	if (new)
-		kfree(new);
+	kfree(new);
 	if (sp != NULL)
 		return sp;
 	put_rpccred(cred);
--- linux-2.6.12-rc1-mm3-orig/fs/nfs/proc.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfs/proc.c	2005-03-25 21:46:22.000000000 +0100
@@ -329,8 +329,7 @@ nfs_proc_unlink_done(struct dentry *dir,
 {
 	struct rpc_message *msg = &task->tk_msg;
 	
-	if (msg->rpc_argp)
-		kfree(msg->rpc_argp);
+	kfree(msg->rpc_argp);
 	return 0;
 }
 
--- linux-2.6.12-rc1-mm3-orig/fs/nfs/unlink.c	2005-03-21 23:12:41.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfs/unlink.c	2005-03-25 21:46:41.000000000 +0100
@@ -52,8 +52,7 @@ nfs_put_unlinkdata(struct nfs_unlinkdata
 {
 	if (--data->count == 0) {
 		nfs_detach_unlinkdata(data);
-		if (data->name.name != NULL)
-			kfree(data->name.name);
+		kfree(data->name.name);
 		kfree(data);
 	}
 }


