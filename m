Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSG1PXY>; Sun, 28 Jul 2002 11:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSG1PXX>; Sun, 28 Jul 2002 11:23:23 -0400
Received: from mons.uio.no ([129.240.130.14]:56466 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316887AbSG1PWm>;
	Sun, 28 Jul 2002 11:22:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3332.536049.763879@charged.uio.no>
Date: Sun, 28 Jul 2002 17:25:56 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [3/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cache the information about whether or not the server supports
READDIRPLUS.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-rdplus2/fs/nfs/dir.c linux-2.5.29-rdplus3/fs/nfs/dir.c
--- linux-2.5.29-rdplus2/fs/nfs/dir.c	Sat Jul 27 18:20:26 2002
+++ linux-2.5.29-rdplus3/fs/nfs/dir.c	Sat Jul 27 18:58:30 2002
@@ -107,14 +107,16 @@
  again:
 	error = NFS_PROTO(inode)->readdir(inode, cred, desc->entry->cookie, page,
 					  NFS_SERVER(inode)->dtsize, desc->plus);
-	/* We requested READDIRPLUS, but the server doesn't grok it */
-	if (desc->plus && error == -ENOTSUPP) {
-		NFS_FLAGS(inode) &= ~NFS_INO_ADVISE_RDPLUS;
-		desc->plus = 0;
-		goto again;
-	}
-	if (error < 0)
+	if (error < 0) {
+		/* We requested READDIRPLUS, but the server doesn't grok it */
+		if (error == -ENOTSUPP && desc->plus) {
+			NFS_SERVER(inode)->caps &= ~NFS_CAP_READDIRPLUS;
+			NFS_FLAGS(inode) &= ~NFS_INO_ADVISE_RDPLUS;
+			desc->plus = 0;
+			goto again;
+		}
 		goto error;
+	}
 	SetPageUptodate(page);
 	/* Ensure consistent page alignment of the data.
 	 * Note: assumes we have exclusive access to this mapping either
@@ -194,7 +196,6 @@
 
 	dfprintk(VFS, "NFS: find_dirent_page() searching directory page %ld\n", desc->page_index);
 
-	desc->plus = NFS_USE_READDIRPLUS(inode);
 	page = read_cache_page(&inode->i_data, desc->page_index,
 			       (filler_t *)nfs_readdir_filler, desc);
 	if (IS_ERR(page)) {
@@ -376,6 +377,7 @@
 	desc->file = filp;
 	desc->target = filp->f_pos;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
+	desc->plus = NFS_USE_READDIRPLUS(inode);
 
 	my_entry.cookie = my_entry.prev_cookie = 0;
 	my_entry.eof = 0;
diff -u --recursive --new-file linux-2.5.29-rdplus2/fs/nfs/inode.c linux-2.5.29-rdplus3/fs/nfs/inode.c
--- linux-2.5.29-rdplus2/fs/nfs/inode.c	Sat Jul 27 18:20:58 2002
+++ linux-2.5.29-rdplus3/fs/nfs/inode.c	Sat Jul 27 18:53:18 2002
@@ -283,12 +283,14 @@
 	INIT_LIST_HEAD(&server->lru_busy);
 
  nfsv3_try_again:
+	server->caps = 0;
 	/* Check NFS protocol revision and initialize RPC op vector
 	 * and file handle pool. */
 	if (data->flags & NFS_MOUNT_VER3) {
 #ifdef CONFIG_NFS_V3
 		server->rpc_ops = &nfs_v3_clientops;
 		version = 3;
+		server->caps |= NFS_CAP_READDIRPLUS;
 		if (data->version < 4) {
 			printk(KERN_NOTICE "NFS: NFSv3 not supported by mount program.\n");
 			goto out_unlock;
diff -u --recursive --new-file linux-2.5.29-rdplus2/include/linux/nfs_fs.h linux-2.5.29-rdplus3/include/linux/nfs_fs.h
--- linux-2.5.29-rdplus2/include/linux/nfs_fs.h	Fri Jul 26 23:05:37 2002
+++ linux-2.5.29-rdplus3/include/linux/nfs_fs.h	Sat Jul 27 18:59:41 2002
@@ -225,8 +225,15 @@
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 
-/* Inode Flags */
-#define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
+static inline int nfs_server_capable(struct inode *inode, int cap)
+{
+	return NFS_SERVER(inode)->caps & cap;
+}
+
+static inline int NFS_USE_READDIRPLUS(struct inode *inode)
+{
+	return NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS;
+}
 
 static inline
 loff_t page_offset(struct page *page)
diff -u --recursive --new-file linux-2.5.29-rdplus2/include/linux/nfs_fs_sb.h linux-2.5.29-rdplus3/include/linux/nfs_fs_sb.h
--- linux-2.5.29-rdplus2/include/linux/nfs_fs_sb.h	Tue Mar 12 21:23:35 2002
+++ linux-2.5.29-rdplus3/include/linux/nfs_fs_sb.h	Sat Jul 27 18:56:14 2002
@@ -10,6 +10,7 @@
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
 	int			flags;		/* various flags */
+	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
@@ -31,4 +32,7 @@
 	struct sockaddr_in	addr;
 };
 
+/* Server capabilities */
+#define NFS_CAP_READDIRPLUS	(1)
+
 #endif
