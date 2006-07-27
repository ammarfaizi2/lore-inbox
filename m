Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWG0UxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWG0UxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWG0UxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40407 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750809AbWG0Uw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:52:57 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/30] NFS: Return an error when starting the idmapping pipe [try #11]
Date: Thu, 27 Jul 2006 21:52:42 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205242.8443.12357.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error when starting the idmapping pipe so that we can detect it
failing.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/idmap.c            |   12 ++++++++----
 fs/nfs/super.c            |    3 ++-
 include/linux/nfs_idmap.h |    2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/idmap.c b/fs/nfs/idmap.c
index b151053..cd80d89 100644
--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -108,15 +108,17 @@ static struct rpc_pipe_ops idmap_upcall_
         .destroy_msg    = idmap_pipe_destroy_msg,
 };
 
-void
+int
 nfs_idmap_new(struct nfs_client *clp)
 {
 	struct idmap *idmap;
+	int error;
 
 	if (clp->cl_idmap != NULL)
-		return;
+		return 0;
+
         if ((idmap = kzalloc(sizeof(*idmap), GFP_KERNEL)) == NULL)
-                return;
+                return -ENOMEM;
 
 	snprintf(idmap->idmap_path, sizeof(idmap->idmap_path),
 	    "%s/idmap", clp->cl_rpcclient->cl_pathname);
@@ -124,8 +126,9 @@ nfs_idmap_new(struct nfs_client *clp)
         idmap->idmap_dentry = rpc_mkpipe(idmap->idmap_path,
 	    idmap, &idmap_upcall_ops, 0);
         if (IS_ERR(idmap->idmap_dentry)) {
+		error = PTR_ERR(idmap->idmap_dentry);
 		kfree(idmap);
-		return;
+		return error;
 	}
 
         mutex_init(&idmap->idmap_lock);
@@ -135,6 +138,7 @@ nfs_idmap_new(struct nfs_client *clp)
 	idmap->idmap_group_hash.h_type = IDMAP_TYPE_GROUP;
 
 	clp->cl_idmap = idmap;
+	return 0;
 }
 
 void
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 509fa99..0fbb75e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1131,7 +1131,8 @@ static struct rpc_clnt *nfs4_create_clie
 		clnt->cl_softrtry = 1;
 		clp->cl_rpcclient = clnt;
 		memcpy(clp->cl_ipaddr, server->ip_addr, sizeof(clp->cl_ipaddr));
-		nfs_idmap_new(clp);
+		if (nfs_idmap_new(clp) < 0)
+			goto out_fail;
 	}
 	list_add_tail(&server->nfs4_siblings, &clp->cl_superblocks);
 	clnt = rpc_clone_client(clp->cl_rpcclient);
diff --git a/include/linux/nfs_idmap.h b/include/linux/nfs_idmap.h
index 678fe68..15a9f3b 100644
--- a/include/linux/nfs_idmap.h
+++ b/include/linux/nfs_idmap.h
@@ -64,7 +64,7 @@ #ifdef __KERNEL__
 /* Forward declaration to make this header independent of others */
 struct nfs_client;
 
-void nfs_idmap_new(struct nfs_client *);
+int nfs_idmap_new(struct nfs_client *);
 void nfs_idmap_delete(struct nfs_client *);
 
 int nfs_map_name_to_uid(struct nfs_client *, const char *, size_t, __u32 *);
