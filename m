Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSAQCim>; Wed, 16 Jan 2002 21:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288116AbSAQCiZ>; Wed, 16 Jan 2002 21:38:25 -0500
Received: from mons.uio.no ([129.240.130.14]:25758 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288114AbSAQCiK>;
	Wed, 16 Jan 2002 21:38:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.14576.445228.537714@charged.uio.no>
Date: Thu, 17 Jan 2002 03:37:36 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

 The following patch contains a rewrite of the NFS lookup()
code. Currently, as you know, we have a number of cases in which we do
not conform to the 'UNIX standard' close-to-open data and attribute
cache consistency checking. The following patch fixes the following
issues:

 - Use the directory mtime in order to give us a hint when we should
   check for namespace changes.

   Basically we timestamp the occurrence of a directory mtime change
   (c.f. the new define NFS_MTIME_UPDATE(inode)). By comparing this
   value to a dentry->d_time, we can determine whether or not we need
   to LOOKUP the filename again, or whether we can get away with using
   the far less expensive GETATTR (which only performs attribute cache
   revalidation on the inode).

   Note: This rule also affects negative dentries! We no longer need
   any arbitrary timeout values, but can rely on the parent mtime to
   tell us that it is safe to continue caching these dentries (which
   we do until the attribute cache times out - in case the server does
   not observe the RFCs w.r.t. mtime behaviour).

 - Close 'cto hole' when doing open("."). For the special case of
   opening the current directory for readdir, the function
   d_revalidate() never gets called. This means that
     a) The attribute cache never gets revalidated.
     b) Stale inode checking is never performed.
   For this reason, I introduce a new inode operation 'check_inode()'
   which can perform the above 2 tasks.

 - Add support for the 'nocto' flag, in order to turn off the strict
   attribute cache revalidation on file open(). Can improve
   performance on read-only partitions and those partitions for which
   one knows there is only a single NFS client.

 - Simplify inode lookup. Don't check the 'fsid' field (which appears
   to be buggy in too many servers in order to be reliable). Instead
   we only rely on the inode number (a.k.a. 'fileid') and the
   uniqueness of the filehandle.

Cheers,
   Trond

diff -u --recursive --new-file linux-2.5.3-pre1/fs/namei.c linux-2.5.3-cto/fs/namei.c
--- linux-2.5.3-pre1/fs/namei.c	Mon Jan 14 18:41:57 2002
+++ linux-2.5.3-cto/fs/namei.c	Thu Jan 17 02:48:25 2002
@@ -457,7 +457,7 @@
 	while (*name=='/')
 		name++;
 	if (!*name)
-		goto return_base;
+		goto return_reval;
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
@@ -576,7 +576,7 @@
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
-				goto return_base;
+				goto return_reval;
 		}
 		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
 			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
@@ -627,6 +627,17 @@
 			nd->last_type = LAST_DOT;
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
+return_reval:
+		/*
+		 * We bypassed the ordinary revalidation routines, so
+		 * NFS wants to check the cached inode for staleness.
+		 */
+		inode = nd->dentry->d_inode;
+		if (inode && inode->i_op && inode->i_op->check_stale) {
+			err = inode->i_op->check_stale(inode);
+			if (err)
+				break;
+		}
 return_base:
 		return 0;
 out_dput:
diff -u --recursive --new-file linux-2.5.3-pre1/fs/nfs/dir.c linux-2.5.3-cto/fs/nfs/dir.c
--- linux-2.5.3-pre1/fs/nfs/dir.c	Fri Jan  4 18:42:12 2002
+++ linux-2.5.3-cto/fs/nfs/dir.c	Thu Jan 17 03:21:46 2002
@@ -66,6 +66,7 @@
 	permission:	nfs_permission,
 	revalidate:	nfs_revalidate,
 	setattr:	nfs_notify_change,
+	check_stale:	nfs_check_stale,
 };
 
 typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
@@ -402,6 +403,21 @@
 }
 
 /*
+ * A check for whether or not the parent directory has changed.
+ * In the case it has, we assume that the dentries are untrustworthy
+ * and may need to be looked up again.
+ */
+static inline
+int nfs_check_verifier(struct inode *dir, struct dentry *dentry)
+{
+	if (IS_ROOT(dentry))
+		return 1;
+	if (nfs_revalidate_inode(NFS_SERVER(dir), dir))
+		return 0;
+	return time_after(dentry->d_time, NFS_MTIME_UPDATE(dir));
+}
+
+/*
  * Whenever an NFS operation succeeds, we know that the dentry
  * is valid, so we update the revalidation timestamp.
  */
@@ -410,48 +426,31 @@
 	dentry->d_time = jiffies;
 }
 
-static inline int nfs_dentry_force_reval(struct dentry *dentry, int flags)
+static inline
+int nfs_lookup_verify_inode(struct inode *inode, int flags)
 {
-	struct inode *inode = dentry->d_inode;
-	unsigned long timeout = NFS_ATTRTIMEO(inode);
-
+	struct nfs_server *server = NFS_SERVER(inode);
 	/*
-	 * If it's the last lookup in a series, we use a stricter
-	 * cache consistency check by looking at the parent mtime.
-	 *
-	 * If it's been modified in the last hour, be really strict.
-	 * (This still means that we can avoid doing unnecessary
-	 * work on directories like /usr/share/bin etc which basically
-	 * never change).
+	 * If we're interested in close-to-open cache consistency,
+	 * then we revalidate the inode upon lookup.
 	 */
-	if (!(flags & LOOKUP_CONTINUE)) {
-		long diff = CURRENT_TIME - dentry->d_parent->d_inode->i_mtime;
-
-		if (diff < 15*60)
-			timeout = 0;
-	}
-	
-	return time_after(jiffies,dentry->d_time + timeout);
+	if (!(server->flags & NFS_MOUNT_NOCTO) && !(flags & LOOKUP_CONTINUE))
+		NFS_CACHEINV(inode);
+	return nfs_revalidate_inode(server, inode);
 }
 
 /*
  * We judge how long we want to trust negative
  * dentries by looking at the parent inode mtime.
  *
- * If mtime is close to present time, we revalidate
- * more often.
+ * If parent mtime has changed, we revalidate, else we wait for a
+ * period corresponding to the parent's attribute cache timeout value.
  */
-#define NFS_REVALIDATE_NEGATIVE (1 * HZ)
-static inline int nfs_neg_need_reval(struct dentry *dentry)
+static inline int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *dir = dentry->d_parent->d_inode;
-	unsigned long timeout = NFS_ATTRTIMEO(dir);
-	long diff = CURRENT_TIME - dir->i_mtime;
-
-	if (diff < 5*60 && timeout > NFS_REVALIDATE_NEGATIVE)
-		timeout = NFS_REVALIDATE_NEGATIVE;
-
-	return time_after(jiffies, dentry->d_time + timeout);
+	if (!nfs_check_verifier(dir, dentry))
+		return 1;
+	return time_after(jiffies, dentry->d_time + NFS_ATTRTIMEO(dir));
 }
 
 /*
@@ -462,9 +461,8 @@
  * NOTE! The hit can be a negative hit too, don't assume
  * we have an inode!
  *
- * If the dentry is older than the revalidation interval, 
- * we do a new lookup and verify that the dentry is still
- * correct.
+ * If the parent directory is seen to have changed, we throw out the
+ * cached dentry and do a new lookup.
  */
 static int nfs_lookup_revalidate(struct dentry * dentry, int flags)
 {
@@ -477,13 +475,9 @@
 	lock_kernel();
 	dir = dentry->d_parent->d_inode;
 	inode = dentry->d_inode;
-	/*
-	 * If we don't have an inode, let's look at the parent
-	 * directory mtime to get a hint about how often we
-	 * should validate things..
-	 */
+
 	if (!inode) {
-		if (nfs_neg_need_reval(dentry))
+		if (nfs_neg_need_reval(dir, dentry))
 			goto out_bad;
 		goto out_valid;
 	}
@@ -494,48 +488,39 @@
 		goto out_bad;
 	}
 
-	if (!nfs_dentry_force_reval(dentry, flags))
+	/* Force a full look up iff the parent directory has changed */
+	if (nfs_check_verifier(dir, dentry)) {
+		if (nfs_lookup_verify_inode(inode, flags))
+			goto out_bad;
 		goto out_valid;
-
-	if (IS_ROOT(dentry)) {
-		__nfs_revalidate_inode(NFS_SERVER(inode), inode);
-		goto out_valid_renew;
 	}
 
-	/*
-	 * Do a new lookup and check the dentry attributes.
-	 */
+	if (NFS_STALE(inode))
+		goto out_bad;
+
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error)
 		goto out_bad;
-
-	/* Inode number matches? */
-	if (!(fattr.valid & NFS_ATTR_FATTR) ||
-	    NFS_FSID(inode) != fattr.fsid ||
-	    NFS_FILEID(inode) != fattr.fileid)
+	if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
 		goto out_bad;
-
-	/* Ok, remember that we successfully checked it.. */
-	nfs_refresh_inode(inode, &fattr);
-
-	if (nfs_inode_is_stale(inode, &fhandle, &fattr))
+	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
 		goto out_bad;
 
- out_valid_renew:
 	nfs_renew_times(dentry);
-out_valid:
+ out_valid:
 	unlock_kernel();
 	return 1;
-out_bad:
-	shrink_dcache_parent(dentry);
-	/* If we have submounts, don't unhash ! */
-	if (have_submounts(dentry))
-		goto out_valid;
-	d_drop(dentry);
-	/* Purge readdir caches. */
-	nfs_zap_caches(dir);
-	if (inode && S_ISDIR(inode->i_mode))
+ out_bad:
+	NFS_CACHEINV(dir);
+	if (inode && S_ISDIR(inode->i_mode)) {
+		/* Purge readdir caches. */
 		nfs_zap_caches(inode);
+		/* If we have submounts, don't unhash ! */
+		if (have_submounts(dentry))
+			goto out_valid;
+		shrink_dcache_parent(dentry);
+	}
+	d_drop(dentry);
 	unlock_kernel();
 	return 0;
 }
@@ -565,9 +550,12 @@
 {
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
 		lock_kernel();
+		inode->i_nlink--;
 		nfs_complete_unlink(dentry);
 		unlock_kernel();
 	}
+	if (is_bad_inode(inode))
+		force_delete(inode);
 	iput(inode);
 }
 
@@ -604,9 +592,9 @@
 		if (inode) {
 	    no_entry:
 			d_add(dentry, inode);
-			nfs_renew_times(dentry);
 			error = 0;
 		}
+		nfs_renew_times(dentry);
 	}
 out:
 	return ERR_PTR(error);
diff -u --recursive --new-file linux-2.5.3-pre1/fs/nfs/inode.c linux-2.5.3-cto/fs/nfs/inode.c
--- linux-2.5.3-pre1/fs/nfs/inode.c	Mon Jan  7 18:59:01 2002
+++ linux-2.5.3-cto/fs/nfs/inode.c	Thu Jan 17 02:48:25 2002
@@ -635,7 +635,6 @@
 	 */
 	if (inode->i_mode == 0) {
 		NFS_FILEID(inode) = fattr->fileid;
-		NFS_FSID(inode) = fattr->fsid;
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
@@ -674,39 +673,18 @@
 	struct nfs_fh		*fh = desc->fh;
 	struct nfs_fattr	*fattr = desc->fattr;
 
-	if (NFS_FSID(inode) != fattr->fsid)
-		return 0;
 	if (NFS_FILEID(inode) != fattr->fileid)
 		return 0;
 	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0)
 		return 0;
+	if (is_bad_inode(inode))
+		return 0;
 	/* Force an attribute cache update if inode->i_count == 0 */
 	if (!atomic_read(&inode->i_count))
 		NFS_CACHEINV(inode);
 	return 1;
 }
 
-int
-nfs_inode_is_stale(struct inode *inode, struct nfs_fh *fh, struct nfs_fattr *fattr)
-{
-	/* Empty inodes are not stale */
-	if (!inode->i_mode)
-		return 0;
-
-	if ((fattr->mode & S_IFMT) != (inode->i_mode & S_IFMT))
-		return 1;
-
-	if (is_bad_inode(inode) || NFS_STALE(inode))
-		return 1;
-
-	/* Has the filehandle changed? If so is the old one stale? */
-	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0 &&
-	    __nfs_revalidate_inode(NFS_SERVER(inode),inode) == -ESTALE)
-		return 1;
-
-	return 0;
-}
-
 /*
  * This is our own version of iget that looks up inodes by file handle
  * instead of inode number.  We use this technique instead of using
@@ -773,7 +751,7 @@
 	/*
 	 * Make sure the inode is up-to-date.
 	 */
-	error = nfs_revalidate(dentry);
+	error = nfs_revalidate_inode(NFS_SERVER(inode),inode);
 	if (error) {
 #ifdef NFS_PARANOIA
 printk("nfs_notify_change: revalidate failed, error=%d\n", error);
@@ -849,6 +827,21 @@
 }
 
 /*
+ * Another revalidation function: This one checks inodes for staleness
+ * when we've bypassed the ordinary dcache revalidation routines.
+ * e.g. open(".")
+ */
+int
+nfs_check_stale(struct inode *inode)
+{
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO))
+		NFS_CACHEINV(inode);
+	if (NFS_STALE(inode))
+		return -ESTALE;
+	return 0;
+}
+
+/*
  * Ensure that mmap has a recent RPC credential for use when writing out
  * shared pages
  */
@@ -1011,15 +1004,6 @@
 			inode->i_sb->s_id, inode->i_ino,
 			atomic_read(&inode->i_count), fattr->valid);
 
-	if (NFS_FSID(inode) != fattr->fsid ||
-	    NFS_FILEID(inode) != fattr->fileid) {
-		printk(KERN_ERR "nfs_refresh_inode: inode number mismatch\n"
-		       "expected (0x%Lx/0x%Lx), got (0x%Lx/0x%Lx)\n",
-		       (long long)NFS_FSID(inode), (long long)NFS_FILEID(inode),
-		       (long long)fattr->fsid, (long long)fattr->fileid);
-		goto out_err;
-	}
-
 	/*
 	 * Make sure the inode's type hasn't changed.
 	 */
@@ -1086,8 +1070,11 @@
 
 	inode->i_atime = new_atime;
 
-	NFS_CACHE_MTIME(inode) = new_mtime;
-	inode->i_mtime = nfs_time_to_secs(new_mtime);
+	if (NFS_CACHE_MTIME(inode) != new_mtime) {
+		NFS_MTIME_UPDATE(inode) = jiffies;
+		NFS_CACHE_MTIME(inode) = new_mtime;
+		inode->i_mtime = nfs_time_to_secs(new_mtime);
+	}
 
 	NFS_CACHE_ISIZE(inode) = new_size;
 	inode->i_size = new_isize;
@@ -1136,7 +1123,6 @@
 	 * (But we fall through to invalidate the caches.)
 	 */
 	nfs_invalidate_inode(inode);
- out_err:
 	return -EIO;
 }
 
diff -u --recursive --new-file linux-2.5.3-pre1/fs/nfs/nfs3proc.c linux-2.5.3-cto/fs/nfs/nfs3proc.c
--- linux-2.5.3-pre1/fs/nfs/nfs3proc.c	Mon Oct  1 22:45:37 2001
+++ linux-2.5.3-cto/fs/nfs/nfs3proc.c	Thu Jan 17 02:48:25 2002
@@ -80,7 +80,8 @@
 		status = rpc_call(NFS_CLIENT(dir), NFS3PROC_GETATTR,
 			 fhandle, fattr, 0);
 	dprintk("NFS reply lookup: %d\n", status);
-	nfs_refresh_inode(dir, &dir_attr);
+	if (status >= 0)
+		status = nfs_refresh_inode(dir, &dir_attr);
 	return status;
 }
 
diff -u --recursive --new-file linux-2.5.3-pre1/include/linux/fs.h linux-2.5.3-cto/include/linux/fs.h
--- linux-2.5.3-pre1/include/linux/fs.h	Thu Jan 17 01:52:03 2002
+++ linux-2.5.3-cto/include/linux/fs.h	Thu Jan 17 03:07:46 2002
@@ -850,6 +850,7 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+	int (*check_stale) (struct inode *);
 };
 
 struct seq_file;
diff -u --recursive --new-file linux-2.5.3-pre1/include/linux/nfs_fs.h linux-2.5.3-cto/include/linux/nfs_fs.h
--- linux-2.5.3-pre1/include/linux/nfs_fs.h	Thu Jan 17 01:52:06 2002
+++ linux-2.5.3-cto/include/linux/nfs_fs.h	Thu Jan 17 03:07:49 2002
@@ -77,6 +77,7 @@
 #define NFS_CONGESTED(inode)		(RPC_CONGESTED(NFS_CLIENT(inode)))
 #define NFS_COOKIEVERF(inode)		((inode)->u.nfs_i.cookieverf)
 #define NFS_READTIME(inode)		((inode)->u.nfs_i.read_cache_jiffies)
+#define NFS_MTIME_UPDATE(inode)		((inode)->u.nfs_i.cache_mtime_jiffies)
 #define NFS_CACHE_CTIME(inode)		((inode)->u.nfs_i.read_cache_ctime)
 #define NFS_CACHE_MTIME(inode)		((inode)->u.nfs_i.read_cache_mtime)
 #define NFS_CACHE_ISIZE(inode)		((inode)->u.nfs_i.read_cache_isize)
@@ -99,7 +100,6 @@
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
 
 #define NFS_FILEID(inode)		((inode)->u.nfs_i.fileid)
-#define NFS_FSID(inode)			((inode)->u.nfs_i.fsid)
 
 /* Inode Flags */
 #define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
@@ -152,6 +152,7 @@
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_release(struct inode *, struct file *);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
+extern int nfs_check_stale(struct inode *);
 extern int nfs_notify_change(struct dentry *, struct iattr *);
 
 /*
diff -u --recursive --new-file linux-2.5.3-pre1/include/linux/nfs_fs_i.h linux-2.5.3-cto/include/linux/nfs_fs_i.h
--- linux-2.5.3-pre1/include/linux/nfs_fs_i.h	Thu Jan 17 01:38:18 2002
+++ linux-2.5.3-cto/include/linux/nfs_fs_i.h	Thu Jan 17 03:07:45 2002
@@ -12,7 +12,6 @@
 	/*
 	 * The 64bit 'inode number'
 	 */
-	__u64 fsid;
 	__u64 fileid;
 
 	/*
@@ -50,6 +49,12 @@
 	unsigned long		attrtimeo_timestamp;
 
 	/*
+	 * Timestamp that dates the change made to read_cache_mtime.
+	 * This is of use for dentry revalidation
+	 */
+	unsigned long		cache_mtime_jiffies;
+
+	/*
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
 	 */
@@ -68,11 +73,6 @@
 				ncommit,
 				npages;
 
-	/* Flush daemon info */
-	struct inode		*hash_next,
-				*hash_prev;
-	unsigned long		nextscan;
-
 	/* Credentials for shared mmap */
 	struct rpc_cred		*mm_cred;
 };
