Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUDZKsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUDZKsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUDZK3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:29:53 -0400
Received: from ns.suse.de ([195.135.220.2]:61397 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264492AbUDZK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:51 -0400
Subject: [PATCH 7/11] nfs-access-acl
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975198.3295.77.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS mount parameter noacl

Add the [no]acl mount parameter for the nfs filesystem, as discussed
with Trond Myklebust <trond.myklebust@fys.uio.no> and Olaf Kirch
<okir@suse.de>. This parameter disables the ACCESS procedure call which
is otherwise used to determine whether or not a user is granted access
to a file system object.

  Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.6-rc2/fs/nfs/dir.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/nfs/dir.c
+++ linux-2.6.6-rc2/fs/nfs/dir.c
@@ -1501,6 +1501,7 @@ out:
 int
 nfs_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_access_cache *cache = &NFS_I(inode)->cache_access;
 	struct rpc_cred *cred;
 	int mode = inode->i_mode;
@@ -1538,7 +1539,7 @@ nfs_permission(struct inode *inode, int 
 
 	lock_kernel();
 
-	if (!NFS_PROTO(inode)->access)
+	if ((server->flags & NFS_MOUNT_NOACL) || !NFS_PROTO(inode)->access)
 		goto out_notsup;
 
 	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
Index: linux-2.6.6-rc2/fs/nfs/inode.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/nfs/inode.c
+++ linux-2.6.6-rc2/fs/nfs/inode.c
@@ -559,6 +559,7 @@ static int nfs_show_options(struct seq_f
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
 		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
+		{ NFS_MOUNT_NOACL, ",noacl", "" },
 		{ 0, NULL, NULL }
 	};
 	struct proc_nfs_info *nfs_infop;
Index: linux-2.6.6-rc2/include/linux/nfs_mount.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/nfs_mount.h
+++ linux-2.6.6-rc2/include/linux/nfs_mount.h
@@ -58,6 +58,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_KERBEROS	0x0100	/* 3 */
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
+#define NFS_MOUNT_NOACL		0x0800  /* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF

