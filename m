Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVAVUtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVAVUtS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAVUsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:48:21 -0500
Received: from ns.suse.de ([195.135.220.2]:49360 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262737AbVAVUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:31 -0500
Message-Id: <20050122203619.669767000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:08 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 8/13] Add noacl nfs mount option
Content-Disposition: inline; filename=patches.suse/nfs-access-acl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the noacl mount option, nfs clients stop using the ACCESS RPC
which they usually use to get an access decision from the server.
Instead, they make the decision based on the file ownership and
file mode permission bits.

Security-wise using this option can lead to illicit read access to data
cached locally on the client if the server uses POSIX ACLs.  Local
access decisions are correct as long as the server does not support
POSIX access control lists.

This approach was discussed with Trond Myklebust <trond.myklebust@fys.uio.no>
and Olaf Kirch <okir@suse.de>. Requires a patch to mount (util-linux).

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc2/fs/nfs/dir.c
@@ -1497,6 +1497,7 @@ out:
 
 int nfs_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct rpc_cred *cred;
 	int res;
 
@@ -1515,7 +1516,7 @@ int nfs_permission(struct inode *inode, 
 
 	lock_kernel();
 
-	if (!NFS_PROTO(inode)->access)
+	if ((server->flags & NFS_MOUNT_NOACL) || !NFS_PROTO(inode)->access)
 		goto out_notsup;
 
 	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
Index: linux-2.6.11-rc2/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc2/fs/nfs/inode.c
@@ -539,6 +539,7 @@ static int nfs_show_options(struct seq_f
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
 		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
+		{ NFS_MOUNT_NOACL, ",noacl", "" },
 		{ 0, NULL, NULL }
 	};
 	struct proc_nfs_info *nfs_infop;
Index: linux-2.6.11-rc2/include/linux/nfs_mount.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/nfs_mount.h
+++ linux-2.6.11-rc2/include/linux/nfs_mount.h
@@ -58,6 +58,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_KERBEROS	0x0100	/* 3 */
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
+#define NFS_MOUNT_NOACL		0x0800  /* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

