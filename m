Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAKUnW>; Thu, 11 Jan 2001 15:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRAKUnC>; Thu, 11 Jan 2001 15:43:02 -0500
Received: from mons.uio.no ([129.240.130.14]:4487 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129511AbRAKUmx>;
	Thu, 11 Jan 2001 15:42:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.6629.182749.985042@charged.uio.no>
Date: Thu, 11 Jan 2001 21:39:01 +0100 (CET)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Russell King <rmk@arm.linux.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <20010111194354.F3560@athlon.random>
In-Reply-To: <20010110013755.D13955@suse.de>
	<200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
	<20010110163158.F19503@athlon.random>
	<shszogy2jmr.fsf@charged.uio.no>
	<3A5DDD09.C8C70D36@colorfullife.com>
	<14941.61668.697523.866481@charged.uio.no>
	<shsae8y2blg.fsf@charged.uio.no>
	<20010111192758.E3560@athlon.random>
	<14941.64473.902580.756312@charged.uio.no>
	<20010111194354.F3560@athlon.random>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > On Thu, Jan 11, 2001 at 07:30:49PM +0100, Trond Myklebust
     > wrote:
    >> OK. In that case my patch, would just be amended to eliminate
    >> the redundant comparison as is the case below.

     > This patch looks fine w.r.t. alignment but given the below
     > seems called at runtime (not just at mount time) for
     > performance and to save a dozen of bytes of kernel stack it
     > would probably better to use the nfs_fh structure in 2.2.19pre7
     > for the in-kernel representation and to define a new structure
     > for userspace message passing (defined as the nfs_fh in
     > 2.2.19pre6). But at least now we see _why_ it broke ;)

I'm not at all convinced that saving us a copy of 66 bytes in NLM is
really worth the effort. It certainly isn't worth the ugliness of
living with arrays of (void *) in order to match the alignment of a
fake pointer. I'd rather we make them integers.
If we really are to change struct nfs_fh, I therefore propose that we
also make struct nfs_fhbase reflect the fact that fb_dentry is a
32-bit cookie. That means that both nfs_fh and knfs_fh would be
integer-aligned.

The following is untested, but should be correct.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.2.18/fs/lockd/svcsubs.c linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c
--- linux-2.2.18/fs/lockd/svcsubs.c	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/fs/lockd/svcsubs.c	Thu Jan 11 20:37:37 2001
@@ -44,6 +44,10 @@
  * Note that we open the file O_RDONLY even when creating write locks.
  * This is not quite right, but for now, we assume the client performs
  * the proper R/W checking.
+ *
+ * BEWARE:
+ * The cast to struct knfs_fh in this routine, imposes an alignment
+ * requirement on (struct nfs_fh)->data for some platforms.
  */
 u32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
@@ -63,8 +67,7 @@
 	down(&nlm_file_sema);
 
 	for (file = nlm_files[hash]; file; file = file->f_next) {
-		if (file->f_handle.fh_dcookie == fh->fh_dcookie &&
-		    !memcmp(&file->f_handle, fh, sizeof(*fh)))
+		if (!memcmp(&file->f_handle, fh, sizeof(*fh)))
 			goto found;
 	}
 
diff -u --recursive --new-file linux-2.2.18/fs/nfs/inode.c linux-2.2.18-fix_ppc/fs/nfs/inode.c
--- linux-2.2.18/fs/nfs/inode.c	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/fs/nfs/inode.c	Thu Jan 11 21:13:04 2001
@@ -273,9 +273,8 @@
 	struct nfs_server	*server;
 	struct rpc_xprt		*xprt = 0;
 	struct rpc_clnt		*clnt = 0;
-	struct nfs_fh		*root_fh = NULL,
-				*root = &data->root,
-				fh;
+	struct nfs_fh		fh,
+				*root_fh = NULL;
 	struct inode		*root_inode = NULL;
 	unsigned int		authflavor;
 	struct sockaddr_in	srvaddr;
@@ -290,7 +289,6 @@
 		goto failure;
 	}
 
-	memset(&fh, 0, sizeof(fh));
 	if (data->version != NFS_MOUNT_VERSION) {
 		printk(KERN_WARNING "nfs warning: mount version %s than kernel\n",
 			data->version < NFS_MOUNT_VERSION ? "older" : "newer");
@@ -298,12 +296,21 @@
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
+			goto failure;
 		}
+		memcpy(fh.data, data->root.data, fh.size);
 	}
 
 	/* We now require that the mount process passes the remote address */
@@ -351,19 +358,15 @@
 	if (data->flags & NFS_MOUNT_VER3) {
 #ifdef CONFIG_NFS_V3
 		server->rpc_ops = &nfs_v3_clientops;
-		NFS_SB_FHSIZE(sb) = sizeof(unsigned short) + NFS3_FHSIZE;
+		NFS_SB_FHSIZE(sb) = NFS3_FHSIZE;
 		version = 3;
-		if (data->version < 4) {
-			printk(KERN_NOTICE "NFS: NFSv3 not supported by mount program.\n");
-			goto failure_unlock;
-		}
 #else
 		printk(KERN_NOTICE "NFS: NFSv3 not supported.\n");
 		goto failure_unlock;
 #endif
 	} else {
 		server->rpc_ops = &nfs_v2_clientops;
-		NFS_SB_FHSIZE(sb) = sizeof(unsigned short) + NFS2_FHSIZE;
+		NFS_SB_FHSIZE(sb) = NFS2_FHSIZE;
 		version = 2;
 	}
 
@@ -422,13 +425,14 @@
 	root_fh = nfs_fh_alloc();
 	if (!root_fh)
 		goto out_no_fh;
-	memcpy((u8*)root_fh, (u8*)root, sizeof(*root_fh));
+	memcpy((u8*)root_fh, (u8*)&fh, sizeof(*root_fh));
 
 	/* Did getting the root inode fail? */
-	if ((root->size > NFS_SB_FHSIZE(sb)
-	     || ! (root_inode = nfs_get_root(sb, root)))
+	if ((fh.size > NFS_SB_FHSIZE(sb)
+	     || ! (root_inode = nfs_get_root(sb, &fh)))
 	    && (data->flags & NFS_MOUNT_VER3)) {
 		data->flags &= ~NFS_MOUNT_VER3;
+		fh.size = NFS2_FHSIZE;
 		nfs_fh_free(root_fh);
 		rpciod_down();
 		rpc_shutdown_client(server->client);
@@ -445,7 +449,7 @@
 	sb->u.nfs_sb.s_root = root_fh;
 
 	/* Get some general file system info */
-	if (server->rpc_ops->statfs(server, root, &fsinfo) >= 0) {
+	if (server->rpc_ops->statfs(server, &fh, &fsinfo) >= 0) {
 		if (server->namelen == 0)
 			server->namelen = fsinfo.namelen;
 	} else {
diff -u --recursive --new-file linux-2.2.18/fs/nfsd/nfsfh.c linux-2.2.18-fix_ppc/fs/nfsd/nfsfh.c
--- linux-2.2.18/fs/nfsd/nfsfh.c	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/fs/nfsd/nfsfh.c	Thu Jan 11 20:10:09 2001
@@ -690,7 +690,7 @@
 	fhp->fh_handle.fh_dev    = kdev_t_to_u32(parent->d_inode->i_dev);
 	fhp->fh_handle.fh_xdev   = kdev_t_to_u32(exp->ex_dev);
 	fhp->fh_handle.fh_xino   = ino_t_to_u32(exp->ex_ino);
-	fhp->fh_handle.fh_dcookie = (struct dentry *)0xfeebbaca;
+	fhp->fh_handle.fh_dcookie = 0xfeebbaca;
 	if (inode) {
 		fhp->fh_handle.fh_ino = ino_t_to_u32(inode->i_ino);
 		fhp->fh_handle.fh_generation = inode->i_generation;
diff -u --recursive --new-file linux-2.2.18/include/linux/nfs.h linux-2.2.18-fix_ppc/include/linux/nfs.h
--- linux-2.2.18/include/linux/nfs.h	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/include/linux/nfs.h	Thu Jan 11 20:55:26 2001
@@ -94,8 +94,8 @@
  */
 #define NFS_MAXFHSIZE		64
 struct nfs_fh {
-	unsigned short		size;
-	unsigned char		data[NFS_MAXFHSIZE];
+	unsigned int		size;
+	unsigned int		data[NFS_MAXFHSIZE / sizeof(unsigned int)];
 };
 
 enum nfs3_stable_how {
diff -u --recursive --new-file linux-2.2.18/include/linux/nfs3.h linux-2.2.18-fix_ppc/include/linux/nfs3.h
--- linux-2.2.18/include/linux/nfs3.h	Mon Dec 11 01:49:44 2000
+++ linux-2.2.18-fix_ppc/include/linux/nfs3.h	Thu Jan 11 20:06:50 2001
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
diff -u --recursive --new-file linux-2.2.18/include/linux/nfs_mount.h linux-2.2.18-fix_ppc/include/linux/nfs_mount.h
--- linux-2.2.18/include/linux/nfs_mount.h	Thu Dec 14 12:30:13 2000
+++ linux-2.2.18-fix_ppc/include/linux/nfs_mount.h	Thu Jan 11 21:21:09 2001
@@ -8,9 +8,9 @@
  *
  *  structure passed from user-space to kernel-space during an nfs mount
  */
-#include <linux/nfs.h>
+#include <linux/in.h>
 #include <linux/nfs2.h>
-#include <linux/nfs_fs.h>
+#include <linux/nfs3.h>
 
 /*
  * WARNING!  Do not delete or change the order of these fields.  If
@@ -42,7 +42,7 @@
 	char		hostname[256];		/* 1 */
 	int		namlen;			/* 2 */
 	unsigned int	bsize;			/* 3 */
-	struct nfs_fh	root;			/* 4 */
+	struct nfs3_fh	root;			/* 4 */
 };
 
 /* bits in the flags field */
diff -u --recursive --new-file linux-2.2.18/include/linux/nfsd/nfsfh.h linux-2.2.18-fix_ppc/include/linux/nfsd/nfsfh.h
--- linux-2.2.18/include/linux/nfsd/nfsfh.h	Thu Dec 14 12:30:28 2000
+++ linux-2.2.18-fix_ppc/include/linux/nfsd/nfsfh.h	Thu Jan 11 20:09:31 2001
@@ -30,7 +30,7 @@
  * ino/dev of the exported inode.
  */
 struct nfs_fhbase {
-	struct dentry *	fb_dentry;	/* dentry cookie */
+	__u32		fb_dcookie;	/* dentry cookie */
 	__u32		fb_ino;		/* our inode number */
 	__u32		fb_dirino;	/* dir inode number */
 	__u32		fb_dev;		/* our device */
@@ -45,7 +45,7 @@
 	__u8			fh_cookie[NFS_FH_PADDING];
 };
 
-#define fh_dcookie		fh_base.fb_dentry
+#define fh_dcookie		fh_base.fb_dcookie
 #define fh_ino			fh_base.fb_ino
 #define fh_dirino		fh_base.fb_dirino
 #define fh_dev			fh_base.fb_dev
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
