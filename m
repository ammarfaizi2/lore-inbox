Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALMiv>; Fri, 12 Jan 2001 07:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRALMil>; Fri, 12 Jan 2001 07:38:41 -0500
Received: from pat.uio.no ([129.240.130.16]:58550 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129183AbRALMie>;
	Fri, 12 Jan 2001 07:38:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.64195.856547.131247@charged.uio.no>
Date: Fri, 12 Jan 2001 13:38:27 +0100 (CET)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS devel <nfs-devel@linux.kernel.org>
Subject: Alignment of NFS filehandles in 2.4.0
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

  The following patch separates the representation of NFS filehandles
in the nfs mount structure from the internal kernel representation.

  The motivation for doing this is Russell's complaint about alignment
issues on PPC architectures when casting from the generic filehandle
to knfsd filehandles.

  This patch ensures that both the internal generic NFS filehandle and
the knfsd filehandles have integer alignment, thus rendering the cast
portable across architectures. It makes sure that we preserve the
current alignment within the nfs mount structure, hence we don't break
the userland mount programs.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.1-pre2/fs/nfs/inode.c linux-2.4.1-fix_ppc/fs/nfs/inode.c
--- linux-2.4.1-pre2/fs/nfs/inode.c	Tue Dec 12 02:46:04 2000
+++ linux-2.4.1-fix_ppc/fs/nfs/inode.c	Fri Jan 12 01:07:38 2001
@@ -239,7 +239,7 @@
 	struct nfs_server	*server;
 	struct rpc_xprt		*xprt = NULL;
 	struct rpc_clnt		*clnt = NULL;
-	struct nfs_fh		*root = &data->root, fh;
+	struct nfs_fh		fh;
 	struct inode		*root_inode = NULL;
 	unsigned int		authflavor;
 	struct sockaddr_in	srvaddr;
@@ -251,7 +251,6 @@
 	if (!data)
 		goto out_miss_args;
 
-	memset(&fh, 0, sizeof(fh));
 	if (data->version != NFS_MOUNT_VERSION) {
 		printk("nfs warning: mount version %s than kernel\n",
 			data->version < NFS_MOUNT_VERSION ? "older" : "newer");
@@ -259,12 +258,21 @@
 			data->namlen = 0;
 		if (data->version < 3)
 			data->bsize  = 0;
-		if (data->version < 4) {
+		if (data->version < 4)
 			data->flags &= ~NFS_MOUNT_VER3;
-			root = &fh;
-			root->size = NFS2_FHSIZE;
-			memcpy(root->data, data->old_root.data, NFS2_FHSIZE);
+	}
+
+	memset(&fh, 0, sizeof(fh));
+	if (data->version < 4) {
+		fh.size = NFS2_FHSIZE;
+		memcpy(fh.data, data->old_root.data, NFS2_FHSIZE);
+	} else {
+		fh.size = (data->flags & NFS_MOUNT_VER3) ? data->root.size : NFS2_FHSIZE;
+		if (fh.size > sizeof(fh.data)) {
+			printk(KERN_WARNING "NFS: mount program passes invalid filehandle!\n");
+			goto out_no_remote;
 		}
+		memcpy(fh.data, data->root.data, fh.size);
 	}
 
 	/* We now require that the mount process passes the remote address */
@@ -363,9 +371,10 @@
 	 * the root fh attributes.
 	 */
 	/* Did getting the root inode fail? */
-	if (!(root_inode = nfs_get_root(sb, root))
+	if (!(root_inode = nfs_get_root(sb, &fh))
 	    && (data->flags & NFS_MOUNT_VER3)) {
 		data->flags &= ~NFS_MOUNT_VER3;
+		fh.size = NFS2_FHSIZE;
 		rpciod_down();
 		rpc_shutdown_client(server->client);
 		goto nfsv3_try_again;
@@ -380,7 +389,7 @@
 	sb->s_root->d_op = &nfs_dentry_operations;
 
 	/* Get some general file system info */
-        if (server->rpc_ops->statfs(server, root, &fsinfo) >= 0) {
+        if (server->rpc_ops->statfs(server, &fh, &fsinfo) >= 0) {
 		if (server->namelen == 0)
 			server->namelen = fsinfo.namelen;
 	} else {
diff -u --recursive --new-file linux-2.4.1-pre2/include/linux/nfs.h linux-2.4.1-fix_ppc/include/linux/nfs.h
--- linux-2.4.1-pre2/include/linux/nfs.h	Sat Apr  1 18:04:27 2000
+++ linux-2.4.1-fix_ppc/include/linux/nfs.h	Fri Jan 12 01:09:59 2001
@@ -93,8 +93,8 @@
  */
 #define NFS_MAXFHSIZE		64
 struct nfs_fh {
-	unsigned short		size;
-	unsigned char		data[NFS_MAXFHSIZE];
+	unsigned int		size;
+	unsigned int		data[NFS_MAXFHSIZE / sizeof(int)];
 };
 
 /*
diff -u --recursive --new-file linux-2.4.1-pre2/include/linux/nfs3.h linux-2.4.1-fix_ppc/include/linux/nfs3.h
--- linux-2.4.1-pre2/include/linux/nfs3.h	Sat Apr  1 18:04:27 2000
+++ linux-2.4.1-fix_ppc/include/linux/nfs3.h	Fri Jan 12 01:09:35 2001
@@ -58,6 +58,11 @@
 	NF3BAD  = 8
 };
 
+struct nfs3_fh {
+	unsigned short		size;
+	unsigned char		data[NFS3_FHSIZE];
+};
+
 #define NFS3_VERSION		3
 #define NFS3PROC_NULL		0
 #define NFS3PROC_GETATTR	1
diff -u --recursive --new-file linux-2.4.1-pre2/include/linux/nfs_mount.h linux-2.4.1-fix_ppc/include/linux/nfs_mount.h
--- linux-2.4.1-pre2/include/linux/nfs_mount.h	Fri Jan  5 21:55:12 2001
+++ linux-2.4.1-fix_ppc/include/linux/nfs_mount.h	Fri Jan 12 01:34:12 2001
@@ -9,7 +9,8 @@
  *  structure passed from user-space to kernel-space during an nfs mount
  */
 #include <linux/in.h>
-#include <linux/nfs.h>
+#include <linux/nfs2.h>
+#include <linux/nfs3.h>
 
 /*
  * WARNING!  Do not delete or change the order of these fields.  If
@@ -37,7 +38,7 @@
 	char		hostname[256];		/* 1 */
 	int		namlen;			/* 2 */
 	unsigned int	bsize;			/* 3 */
-	struct nfs_fh	root;			/* 4 */
+	struct nfs3_fh	root;			/* 4 */
 };
 
 /* bits in the flags field */
diff -u --recursive --new-file linux-2.4.1-pre2/include/linux/nfsd/nfsfh.h linux-2.4.1-fix_ppc/include/linux/nfsd/nfsfh.h
--- linux-2.4.1-pre2/include/linux/nfsd/nfsfh.h	Fri Jan  5 22:32:31 2001
+++ linux-2.4.1-fix_ppc/include/linux/nfsd/nfsfh.h	Fri Jan 12 02:16:14 2001
@@ -31,7 +31,7 @@
  * ino/dev of the exported inode.
  */
 struct nfs_fhbase_old {
-	struct dentry *	fb_dentry;	/* dentry cookie - always 0xfeebbaca */
+	__u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
 	__u32		fb_ino;		/* our inode number */
 	__u32		fb_dirino;	/* dir inode number, 0 for directories */
 	__u32		fb_dev;		/* our device */
@@ -101,7 +101,7 @@
 	} fh_base;
 };
 
-#define ofh_dcookie		fh_base.fh_old.fb_dentry
+#define ofh_dcookie		fh_base.fh_old.fb_dcookie
 #define ofh_ino			fh_base.fh_old.fb_ino
 #define ofh_dirino		fh_base.fh_old.fb_dirino
 #define ofh_dev			fh_base.fh_old.fb_dev

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
