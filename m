Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWG0UxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWG0UxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWG0UxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbWG0Uw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:52:57 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/30] NFS: Add a lookupfh NFS RPC op [try #11]
Date: Thu, 27 Jul 2006 21:52:44 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205244.8443.66251.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a lookup filehandle NFS RPC op so that a file handle can be looked up
without requiring dentries and inodes and other VFS stuff when doing an NFS4
pathwalk during mounting.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4proc.c       |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h |    3 +++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index eff6043..7fa2938 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1583,6 +1583,52 @@ nfs4_proc_setattr(struct dentry *dentry,
 	return status;
 }
 
+static int _nfs4_proc_lookupfh(struct nfs_server *server, struct nfs_fh *dirfh,
+		struct qstr *name, struct nfs_fh *fhandle,
+		struct nfs_fattr *fattr)
+{
+	int		       status;
+	struct nfs4_lookup_arg args = {
+		.bitmask = server->attr_bitmask,
+		.dir_fh = dirfh,
+		.name = name,
+	};
+	struct nfs4_lookup_res res = {
+		.server = server,
+		.fattr = fattr,
+		.fh = fhandle,
+	};
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LOOKUP],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+
+	nfs_fattr_init(fattr);
+
+	dprintk("NFS call  lookupfh %s\n", name->name);
+	status = rpc_call_sync(server->client, &msg, 0);
+	dprintk("NFS reply lookupfh: %d\n", status);
+	if (status == -NFS4ERR_MOVED)
+		status = -EREMOTE;
+	return status;
+}
+
+static int nfs4_proc_lookupfh(struct nfs_server *server, struct nfs_fh *dirfh,
+			      struct qstr *name, struct nfs_fh *fhandle,
+			      struct nfs_fattr *fattr)
+{
+	struct nfs4_exception exception = { };
+	int err;
+	do {
+		err = nfs4_handle_exception(server,
+				_nfs4_proc_lookupfh(server, dirfh, name,
+						    fhandle, fattr),
+				&exception);
+	} while (exception.retry);
+	return err;
+}
+
 static int _nfs4_proc_lookup(struct inode *dir, struct qstr *name,
 		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
@@ -3698,6 +3744,7 @@ struct nfs_rpc_ops	nfs_v4_clientops = {
 	.getroot	= nfs4_proc_get_root,
 	.getattr	= nfs4_proc_getattr,
 	.setattr	= nfs4_proc_setattr,
+	.lookupfh	= nfs4_proc_lookupfh,
 	.lookup		= nfs4_proc_lookup,
 	.access		= nfs4_proc_access,
 	.readlink	= nfs4_proc_readlink,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2d3fb64..be80310 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -770,6 +770,9 @@ struct nfs_rpc_ops {
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
+	int	(*lookupfh)(struct nfs_server *, struct nfs_fh *,
+			    struct qstr *, struct nfs_fh *,
+			    struct nfs_fattr *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *);
 	int	(*setattr) (struct dentry *, struct nfs_fattr *,
