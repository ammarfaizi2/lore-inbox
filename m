Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSGZUKU>; Fri, 26 Jul 2002 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318553AbSGZUKT>; Fri, 26 Jul 2002 16:10:19 -0400
Received: from mons.uio.no ([129.240.130.14]:63881 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318546AbSGZUKD>;
	Fri, 26 Jul 2002 16:10:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15681.44377.815113.724217@charged.uio.no>
Date: Fri, 26 Jul 2002 22:13:13 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] add proper NFSv3 permissions checking.
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add full support for the NFSv3 permissions checking. Ensures that we
work properly with NFSv3 servers that do uid/gid mapping and/or have
support for ACLs.
Permissions are cached in the struct nfs_inode in order to reduce the
number of RPC calls. The cache timeout period is given by the ordinary
attribute timeout.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.28-cto2/fs/nfs/dir.c linux-2.5.28-access/fs/nfs/dir.c
--- linux-2.5.28-cto2/fs/nfs/dir.c	Fri Jul 26 21:15:30 2002
+++ linux-2.5.28-access/fs/nfs/dir.c	Fri Jul 26 21:15:42 2002
@@ -1080,38 +1080,70 @@
 int
 nfs_permission(struct inode *inode, int mask)
 {
-	int			error = vfs_permission(inode, mask);
-
-	if (!NFS_PROTO(inode)->access)
-		goto out;
-
-	if (error == -EROFS)
-		goto out;
-
-	/*
-	 * Trust UNIX mode bits except:
-	 *
-	 * 1) When override capabilities may have been invoked
-	 * 2) When root squashing may be involved
-	 * 3) When ACLs may overturn a negative answer */
-	if (!capable(CAP_DAC_OVERRIDE) && !capable(CAP_DAC_READ_SEARCH)
-	    && (current->fsuid != 0) && (current->fsgid != 0)
-	    && error != -EACCES)
-		goto out;
+	struct nfs_access_cache *cache = &NFS_I(inode)->cache_access;
+	struct rpc_cred *cred;
+	int mode = inode->i_mode;
+	int res;
+
+	if (mask & MAY_WRITE) {
+		/*
+		 *
+		 * Nobody gets write access to a read-only fs.
+		 *
+		 */
+		if (IS_RDONLY(inode) &&
+		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+			return -EROFS;
+
+		/*
+		 *
+		 * Nobody gets write access to an immutable file.
+		 *
+		 */
+		if (IS_IMMUTABLE(inode))
+			return -EACCES;
+	}
 
 	lock_kernel();
 
-	error = NFS_PROTO(inode)->access(inode, mask, 0);
-
-	if (error == -EACCES && NFS_CLIENT(inode)->cl_droppriv &&
-	    current->uid != 0 && current->gid != 0 &&
-	    (current->fsuid != current->uid || current->fsgid != current->gid))
-		error = NFS_PROTO(inode)->access(inode, mask, 1);
+	if (!NFS_PROTO(inode)->access)
+		goto out_notsup;
 
+	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
+	if (cache->cred == cred
+	    && time_before(jiffies, cache->jiffies + NFS_ATTRTIMEO(inode))) {
+		if (!(res = cache->err)) {
+			/* Is the mask a subset of an accepted mask? */
+			if ((cache->mask & mask) == mask)
+				goto out;
+		} else {
+			/* ...or is it a superset of a rejected mask? */
+			if ((cache->mask & mask) == cache->mask)
+				goto out;
+		}
+	}
+
+	res = NFS_PROTO(inode)->access(inode, cred, mask);
+	if (!res || res == -EACCES)
+		goto add_cache;
+out:
+	put_rpccred(cred);
 	unlock_kernel();
-
- out:
-	return error;
+	return res;
+out_notsup:
+	nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	res = vfs_permission(inode, mask);
+	unlock_kernel();
+	return res;
+add_cache:
+	cache->jiffies = jiffies;
+	if (cache->cred)
+		put_rpccred(cache->cred);
+	cache->cred = cred;
+	cache->mask = mask;
+	cache->err = res;
+	unlock_kernel();
+	return res;
 }
 
 /*
diff -u --recursive --new-file linux-2.5.28-cto2/fs/nfs/inode.c linux-2.5.28-access/fs/nfs/inode.c
--- linux-2.5.28-cto2/fs/nfs/inode.c	Fri Jul 26 21:04:48 2002
+++ linux-2.5.28-access/fs/nfs/inode.c	Fri Jul 26 21:09:24 2002
@@ -125,10 +125,14 @@
 static void
 nfs_clear_inode(struct inode *inode)
 {
-	struct rpc_cred *cred = NFS_I(inode)->mm_cred;
+	struct nfs_inode *nfsi = NFS_I(inode);
+	struct rpc_cred *cred = nfsi->mm_cred;
 
 	if (cred)
 		put_rpccred(cred);
+	cred = nfsi->cache_access.cred;
+	if (cred)
+		put_rpccred(cred);
 }
 
 void
@@ -722,6 +726,7 @@
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
+		NFS_I(inode)->cache_access.cred = NULL;
 
 		unlock_new_inode(inode);
 	} else
@@ -1085,6 +1090,16 @@
 	NFS_CACHE_ISIZE(inode) = new_size;
 	inode->i_size = new_isize;
 
+	if (inode->i_mode != fattr->mode ||
+	    inode->i_uid != fattr->uid ||
+	    inode->i_gid != fattr->gid) {
+		struct rpc_cred **cred = &NFS_I(inode)->cache_access.cred;
+		if (*cred) {
+			put_rpccred(*cred);
+			*cred = NULL;
+		}
+	}
+
 	inode->i_mode = fattr->mode;
 	inode->i_nlink = fattr->nlink;
 	inode->i_uid = fattr->uid;
diff -u --recursive --new-file linux-2.5.28-cto2/fs/nfs/nfs3proc.c linux-2.5.28-access/fs/nfs/nfs3proc.c
--- linux-2.5.28-cto2/fs/nfs/nfs3proc.c	Thu May 23 17:09:24 2002
+++ linux-2.5.28-access/fs/nfs/nfs3proc.c	Fri Jul 26 21:53:34 2002
@@ -133,16 +133,22 @@
 }
 
 static int
-nfs3_proc_access(struct inode *inode, int mode, int ruid)
+nfs3_proc_access(struct inode *inode, struct rpc_cred *cred, int mode)
 {
 	struct nfs_fattr	fattr;
 	struct nfs3_accessargs	arg = {
-		fh:		NFS_FH(inode),
+		.fh		= NFS_FH(inode),
 	};
 	struct nfs3_accessres	res = {
-		fattr:		&fattr,
+		.fattr		= &fattr,
 	};
-	int	status, flags;
+	struct rpc_message msg = {
+		.rpc_proc	= NFS3PROC_ACCESS,
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+		.rpc_cred	= cred
+	};
+	int	status;
 
 	dprintk("NFS call  access\n");
 	fattr.valid = 0;
@@ -160,8 +166,7 @@
 		if (mode & MAY_EXEC)
 			arg.access |= NFS3_ACCESS_EXECUTE;
 	}
-	flags = (ruid) ? RPC_CALL_REALUID : 0;
-	status = rpc_call(NFS_CLIENT(inode), NFS3PROC_ACCESS, &arg, &res, flags);
+	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
 	nfs_refresh_inode(inode, &fattr);
 	dprintk("NFS reply access\n");
 
diff -u --recursive --new-file linux-2.5.28-cto2/include/linux/nfs_fs.h linux-2.5.28-access/include/linux/nfs_fs.h
--- linux-2.5.28-cto2/include/linux/nfs_fs.h	Sat Jun  1 03:18:09 2002
+++ linux-2.5.28-access/include/linux/nfs_fs.h	Fri Jul 26 21:05:37 2002
@@ -90,6 +90,16 @@
 #ifdef __KERNEL__
 
 /*
+ * NFSv3 Access mode cache
+ */
+struct nfs_access_cache {
+	unsigned long		jiffies;
+	struct rpc_cred *	cred;
+	int			mask;
+	int			err;
+};
+
+/*
  * nfs fs inode data in memory
  */
 struct nfs_inode {
@@ -138,6 +148,8 @@
 	 */
 	unsigned long		cache_mtime_jiffies;
 
+	struct nfs_access_cache	cache_access;
+
 	/*
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
diff -u --recursive --new-file linux-2.5.28-cto2/include/linux/nfs_xdr.h linux-2.5.28-access/include/linux/nfs_xdr.h
--- linux-2.5.28-cto2/include/linux/nfs_xdr.h	Mon Jul 15 19:03:21 2002
+++ linux-2.5.28-access/include/linux/nfs_xdr.h	Fri Jul 26 14:35:23 2002
@@ -300,7 +300,7 @@
 			    struct iattr *);
 	int	(*lookup)  (struct inode *, struct qstr *,
 			    struct nfs_fh *, struct nfs_fattr *);
-	int	(*access)  (struct inode *, int , int);
+	int	(*access)  (struct inode *, struct rpc_cred *, int);
 	int	(*readlink)(struct inode *, struct page *);
 	int	(*read)    (struct inode *, struct rpc_cred *,
 			    struct nfs_fattr *,
