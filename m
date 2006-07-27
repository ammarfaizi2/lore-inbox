Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWG0VEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWG0VEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWG0VC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751212AbWG0VCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:11 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/30] NFS: Make better use of inode* dereferencing macros [try #11]
Date: Thu, 27 Jul 2006 21:52:58 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205258.8443.63100.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make better use of inode* dereferencing macros to hide dereferencing chains
(including NFS_PROTO and NFS_CLIENT).

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/file.c     |    2 +-
 fs/nfs/nfs4proc.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cc2b874..52f161d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -111,7 +111,7 @@ nfs_file_open(struct inode *inode, struc
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 	lock_kernel();
-	res = NFS_SERVER(inode)->rpc_ops->file_open(inode, filp);
+	res = NFS_PROTO(inode)->file_open(inode, filp);
 	unlock_kernel();
 	return res;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a3adfb1..74b9163 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1268,7 +1268,7 @@ nfs4_atomic_open(struct inode *dir, stru
 		BUG_ON(nd->intent.open.flags & O_CREAT);
 	}
 
-	cred = rpcauth_lookupcred(NFS_SERVER(dir)->client->cl_auth, 0);
+	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
 	if (IS_ERR(cred))
 		return (struct dentry *)cred;
 	state = nfs4_do_open(dir, dentry, nd->intent.open.flags, &attr, cred);
@@ -1291,7 +1291,7 @@ nfs4_open_revalidate(struct inode *dir, 
 	struct rpc_cred *cred;
 	struct nfs4_state *state;
 
-	cred = rpcauth_lookupcred(NFS_SERVER(dir)->client->cl_auth, 0);
+	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
 	if (IS_ERR(cred))
 		return PTR_ERR(cred);
 	state = nfs4_open_delegated(dentry->d_inode, openflags, cred);
@@ -1565,7 +1565,7 @@ nfs4_proc_setattr(struct dentry *dentry,
 
 	nfs_fattr_init(fattr);
 	
-	cred = rpcauth_lookupcred(NFS_SERVER(inode)->client->cl_auth, 0);
+	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
 	if (IS_ERR(cred))
 		return PTR_ERR(cred);
 
@@ -1927,7 +1927,7 @@ nfs4_proc_create(struct inode *dir, stru
 	struct rpc_cred *cred;
 	int status = 0;
 
-	cred = rpcauth_lookupcred(NFS_SERVER(dir)->client->cl_auth, 0);
+	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
 	if (IS_ERR(cred)) {
 		status = PTR_ERR(cred);
 		goto out;
@@ -2803,7 +2803,7 @@ static int nfs4_proc_set_acl(struct inod
 		return -EOPNOTSUPP;
 	nfs_inode_return_delegation(inode);
 	buf_to_pages(buf, buflen, arg.acl_pages, &arg.acl_pgbase);
-	ret = rpc_call_sync(NFS_SERVER(inode)->client, &msg, 0);
+	ret = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
 	if (ret == 0)
 		nfs4_write_cached_acl(inode, buf, buflen);
 	return ret;
