Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSGZUJO>; Fri, 26 Jul 2002 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318543AbSGZUJO>; Fri, 26 Jul 2002 16:09:14 -0400
Received: from mons.uio.no ([129.240.130.14]:59529 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318542AbSGZUJM>;
	Fri, 26 Jul 2002 16:09:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15681.44325.923919.616466@charged.uio.no>
Date: Fri, 26 Jul 2002 22:12:21 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Reduce the number of getattr/lookup calls in nfs_lookup_revalidate()
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce the number of getattr/lookup calls in nfs_lookup_revalidate()
by making the latter rely on the ordinary attribute cache, and moving
the close-to-open data consistency checking into nfs_open().

This does mean that we can end up calling GETATTR twice: once in
nfs_lookup_revalidate() then immediately after in nfs_open(), however
it also means that sys_stat() and friends now use cached attributes.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.28-rpc_buf/fs/nfs/dir.c linux-2.5.28-cto2/fs/nfs/dir.c
--- linux-2.5.28-rpc_buf/fs/nfs/dir.c	Mon Jul 22 23:33:48 2002
+++ linux-2.5.28-cto2/fs/nfs/dir.c	Fri Jul 26 21:15:30 2002
@@ -430,16 +430,9 @@
 }
 
 static inline
-int nfs_lookup_verify_inode(struct inode *inode, int flags)
+int nfs_lookup_verify_inode(struct inode *inode)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
-	/*
-	 * If we're interested in close-to-open cache consistency,
-	 * then we revalidate the inode upon lookup.
-	 */
-	if (!(server->flags & NFS_MOUNT_NOCTO) && !(flags & LOOKUP_CONTINUE))
-		NFS_CACHEINV(inode);
-	return nfs_revalidate_inode(server, inode);
+	return nfs_revalidate_inode(NFS_SERVER(inode), inode);
 }
 
 /*
@@ -497,7 +490,7 @@
 
 	/* Force a full look up iff the parent directory has changed */
 	if (nfs_check_verifier(dir, dentry)) {
-		if (nfs_lookup_verify_inode(inode, flags))
+		if (nfs_lookup_verify_inode(inode))
 			goto out_bad;
 		goto out_valid;
 	}
diff -u --recursive --new-file linux-2.5.28-rpc_buf/fs/nfs/inode.c linux-2.5.28-cto2/fs/nfs/inode.c
--- linux-2.5.28-rpc_buf/fs/nfs/inode.c	Fri Jul 26 00:05:29 2002
+++ linux-2.5.28-cto2/fs/nfs/inode.c	Fri Jul 26 21:04:48 2002
@@ -855,15 +855,23 @@
 {
 	struct rpc_auth *auth;
 	struct rpc_cred *cred;
+	int err = 0;
 
 	lock_kernel();
+	/* Ensure that we revalidate the data cache */
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO) {
+		err = __nfs_revalidate_inode(NFS_SERVER(inode),inode);
+		if (err)
+			goto out;
+	}
 	auth = NFS_CLIENT(inode)->cl_auth;
 	cred = rpcauth_lookupcred(auth, 0);
 	filp->private_data = cred;
 	if (filp->f_mode & FMODE_WRITE)
 		nfs_set_mmcred(inode, cred);
+out:
 	unlock_kernel();
-	return 0;
+	return err;
 }
 
 int nfs_release(struct inode *inode, struct file *filp)
