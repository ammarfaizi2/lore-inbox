Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314275AbSEMQkU>; Mon, 13 May 2002 12:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSEMQkT>; Mon, 13 May 2002 12:40:19 -0400
Received: from [195.223.140.120] ([195.223.140.120]:55329 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314281AbSEMQj5>; Mon, 13 May 2002 12:39:57 -0400
Date: Mon, 13 May 2002 18:40:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Mario Vanoni <vanonim@dial.eunet.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NFS problem after 2.4.19-pre3, not solved
Message-ID: <20020513184050.D22902@dualathlon.random>
In-Reply-To: <3CDC4962.4B9393D7@dial.eunet.ch> <15582.65383.578660.222454@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:48:55AM +0200, Trond Myklebust wrote:
> >>>>> " " == Mario Vanoni <vanonim@dial.eunet.ch> writes:
> 
>      > Hi Trond, hi Andrea, hi All In production environment, since >6
>      > months, ethernet 10Mbits/s, on backup_machine mount -t nfs
>      > production_machine /mnt.
> 
>      > find `listing from production_machine` | \ cpio -pdm
>      > backup_machine
> 
>      > Volume ~320MB, nearly constant.
> 
>      > Medium times:
> 
>      > 2.4.17-rc1aa1: 1m58s, _the_ champion !!!
> 
>      > all later's, e.g.:
> 
>      > 2.4.19-pre8aa2; 4m35s 2.4.19-pre8-ac1: 4m00s
>      > 2.4.19-pre7-rmap13a: 4m02s 2.4.19-pre7: 4m35s 2.4.19-pre4:
>      > 4m20s
> 
>      > the last usable was:
> 
>      > 2.4.19-pre3: 2m35s, _not_ a champion
> 
>      > All benchmarks don't reflect some production needs, <2 minutes
>      > or >4 minutes is a great difference !!!
> 
>      > Mario, not in lkml, but active reader (and tester).
> 
> Mario,
> 
> Your case where you transfer 320MB in 1'58" is either a measurement
> error, or it involves some pretty heavy caching, since otherwise you
> would be reading at ~3MB/sec == ~24Mbit/s over a 10Mbit line.
> 
> 4 minutes is in fact wire speed for 320MB of data over a 10Mbit
> connection. To imply that is 'unusable' would be a tad exaggerating...
> 
> 
> It may indeed be that the CTO patch is having an effect on the cache
> but it should only do so if the file's mtimes or inode number or NFS
> filehandle are changing with time.
> If not, then the only thing that could be causing cache invalidation
> is memory pressure and the standard Linux memory reclamation scheme.

the thing that makes the difference is the backout-cto patch according
those numbers and I doubt it is influencing the page replacement in any
way (is kernel-side memory pressure going to increase significantly with
cto?).

2.4.19-pre3 vanilla
first time after boot 5m15s, then 1m56s 1m57s 1m56s 1m56s 1m57s

2.4.19-pre4 vanilla
5m20s, then 4m00s 4m01s 4m00s 4m01s 4m01a

2.4.19-pre4-nfs-backout-cto, from pr8aa2, 2 Hunks
5m13a, then 1m57s 1m58s 1m57s 1m58s 1m59s

nfs-backout-cto is appended. Now if the previous kernel was buggy and it
was not invalidating "invalid" cache then cto is right, otherwise it
sounds like the cto patch is invalidating more cache than necessary.

diff -urN 2.4.19pre6aa1/fs/nfs/dir.c nfs/fs/nfs/dir.c
--- 2.4.19pre6aa1/fs/nfs/dir.c	Fri Apr  5 20:19:43 2002
+++ nfs/fs/nfs/dir.c	Fri Apr  5 20:22:01 2002
@@ -423,21 +423,6 @@
 }
 
 /*
- * A check for whether or not the parent directory has changed.
- * In the case it has, we assume that the dentries are untrustworthy
- * and may need to be looked up again.
- */
-static inline
-int nfs_check_verifier(struct inode *dir, struct dentry *dentry)
-{
-	if (IS_ROOT(dentry))
-		return 1;
-	if (nfs_revalidate_inode(NFS_SERVER(dir), dir))
-		return 0;
-	return time_after(dentry->d_time, NFS_MTIME_UPDATE(dir));
-}
-
-/*
  * Whenever an NFS operation succeeds, we know that the dentry
  * is valid, so we update the revalidation timestamp.
  */
@@ -446,31 +431,48 @@
 	dentry->d_time = jiffies;
 }
 
-static inline
-int nfs_lookup_verify_inode(struct inode *inode, int flags)
+static inline int nfs_dentry_force_reval(struct dentry *dentry, int flags)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
+	struct inode *inode = dentry->d_inode;
+	unsigned long timeout = NFS_ATTRTIMEO(inode);
+
 	/*
-	 * If we're interested in close-to-open cache consistency,
-	 * then we revalidate the inode upon lookup.
+	 * If it's the last lookup in a series, we use a stricter
+	 * cache consistency check by looking at the parent mtime.
+	 *
+	 * If it's been modified in the last hour, be really strict.
+	 * (This still means that we can avoid doing unnecessary
+	 * work on directories like /usr/share/bin etc which basically
+	 * never change).
 	 */
-	if (!(server->flags & NFS_MOUNT_NOCTO) && !(flags & LOOKUP_CONTINUE))
-		NFS_CACHEINV(inode);
-	return nfs_revalidate_inode(server, inode);
+	if (!(flags & LOOKUP_CONTINUE)) {
+		long diff = CURRENT_TIME - dentry->d_parent->d_inode->i_mtime;
+
+		if (diff < 15*60)
+			timeout = 0;
+	}
+	
+	return time_after(jiffies,dentry->d_time + timeout);
 }
 
 /*
  * We judge how long we want to trust negative
  * dentries by looking at the parent inode mtime.
  *
- * If parent mtime has changed, we revalidate, else we wait for a
- * period corresponding to the parent's attribute cache timeout value.
+ * If mtime is close to present time, we revalidate
+ * more often.
  */
-static inline int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry)
+#define NFS_REVALIDATE_NEGATIVE (1 * HZ)
+static inline int nfs_neg_need_reval(struct dentry *dentry)
 {
-	if (!nfs_check_verifier(dir, dentry))
-		return 1;
-	return time_after(jiffies, dentry->d_time + NFS_ATTRTIMEO(dir));
+	struct inode *dir = dentry->d_parent->d_inode;
+	unsigned long timeout = NFS_ATTRTIMEO(dir);
+	long diff = CURRENT_TIME - dir->i_mtime;
+
+	if (diff < 5*60 && timeout > NFS_REVALIDATE_NEGATIVE)
+		timeout = NFS_REVALIDATE_NEGATIVE;
+
+	return time_after(jiffies, dentry->d_time + timeout);
 }
 
 /*
@@ -481,8 +483,9 @@
  * NOTE! The hit can be a negative hit too, don't assume
  * we have an inode!
  *
- * If the parent directory is seen to have changed, we throw out the
- * cached dentry and do a new lookup.
+ * If the dentry is older than the revalidation interval, 
+ * we do a new lookup and verify that the dentry is still
+ * correct.
  */
 static int nfs_lookup_revalidate(struct dentry * dentry, int flags)
 {
@@ -495,9 +498,13 @@
 	lock_kernel();
 	dir = dentry->d_parent->d_inode;
 	inode = dentry->d_inode;
-
+	/*
+	 * If we don't have an inode, let's look at the parent
+	 * directory mtime to get a hint about how often we
+	 * should validate things..
+	 */
 	if (!inode) {
-		if (nfs_neg_need_reval(dir, dentry))
+		if (nfs_neg_need_reval(dentry))
 			goto out_bad;
 		goto out_valid;
 	}
@@ -508,39 +515,48 @@
 		goto out_bad;
 	}
 
-	/* Force a full look up iff the parent directory has changed */
-	if (nfs_check_verifier(dir, dentry)) {
-		if (nfs_lookup_verify_inode(inode, flags))
-			goto out_bad;
+	if (!nfs_dentry_force_reval(dentry, flags))
 		goto out_valid;
-	}
 
-	if (NFS_STALE(inode))
-		goto out_bad;
+	if (IS_ROOT(dentry)) {
+		__nfs_revalidate_inode(NFS_SERVER(inode), inode);
+		goto out_valid_renew;
+	}
 
+	/*
+	 * Do a new lookup and check the dentry attributes.
+	 */
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error)
 		goto out_bad;
-	if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
+
+	/* Inode number matches? */
+	if (!(fattr.valid & NFS_ATTR_FATTR) ||
+	    NFS_FSID(inode) != fattr.fsid ||
+	    NFS_FILEID(inode) != fattr.fileid)
 		goto out_bad;
-	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
+
+	/* Ok, remember that we successfully checked it.. */
+	nfs_refresh_inode(inode, &fattr);
+
+	if (nfs_inode_is_stale(inode, &fhandle, &fattr))
 		goto out_bad;
 
+ out_valid_renew:
 	nfs_renew_times(dentry);
- out_valid:
+out_valid:
 	unlock_kernel();
 	return 1;
- out_bad:
-	NFS_CACHEINV(dir);
-	if (inode && S_ISDIR(inode->i_mode)) {
-		/* Purge readdir caches. */
-		nfs_zap_caches(inode);
-		/* If we have submounts, don't unhash ! */
-		if (have_submounts(dentry))
-			goto out_valid;
-		shrink_dcache_parent(dentry);
-	}
+out_bad:
+	shrink_dcache_parent(dentry);
+	/* If we have submounts, don't unhash ! */
+	if (have_submounts(dentry))
+		goto out_valid;
 	d_drop(dentry);
+	/* Purge readdir caches. */
+	nfs_zap_caches(dir);
+	if (inode && S_ISDIR(inode->i_mode))
+		nfs_zap_caches(inode);
 	unlock_kernel();
 	return 0;
 }
@@ -573,8 +589,6 @@
 		nfs_complete_unlink(dentry);
 		unlock_kernel();
 	}
-	if (is_bad_inode(inode))
-		force_delete(inode);
 	iput(inode);
 }
 
@@ -611,9 +625,9 @@
 		if (inode) {
 	    no_entry:
 			d_add(dentry, inode);
+			nfs_renew_times(dentry);
 			error = 0;
 		}
-		nfs_renew_times(dentry);
 	}
 out:
 	return ERR_PTR(error);
diff -urN 2.4.19pre6aa1/fs/nfs/inode.c nfs/fs/nfs/inode.c
--- 2.4.19pre6aa1/fs/nfs/inode.c	Fri Apr  5 20:19:43 2002
+++ nfs/fs/nfs/inode.c	Fri Apr  5 20:22:01 2002
@@ -660,6 +660,7 @@
 	 */
 	if (inode->i_mode == 0) {
 		NFS_FILEID(inode) = fattr->fileid;
+		NFS_FSID(inode) = fattr->fsid;
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
@@ -698,18 +699,39 @@
 	struct nfs_fh		*fh = desc->fh;
 	struct nfs_fattr	*fattr = desc->fattr;
 
+	if (NFS_FSID(inode) != fattr->fsid)
+		return 0;
 	if (NFS_FILEID(inode) != fattr->fileid)
 		return 0;
 	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0)
 		return 0;
-	if (is_bad_inode(inode))
-		return 0;
 	/* Force an attribute cache update if inode->i_count == 0 */
 	if (!atomic_read(&inode->i_count))
 		NFS_CACHEINV(inode);
 	return 1;
 }
 
+int
+nfs_inode_is_stale(struct inode *inode, struct nfs_fh *fh, struct nfs_fattr *fattr)
+{
+	/* Empty inodes are not stale */
+	if (!inode->i_mode)
+		return 0;
+
+	if ((fattr->mode & S_IFMT) != (inode->i_mode & S_IFMT))
+		return 1;
+
+	if (is_bad_inode(inode) || NFS_STALE(inode))
+		return 1;
+
+	/* Has the filehandle changed? If so is the old one stale? */
+	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0 &&
+	    __nfs_revalidate_inode(NFS_SERVER(inode),inode) == -ESTALE)
+		return 1;
+
+	return 0;
+}
+
 /*
  * This is our own version of iget that looks up inodes by file handle
  * instead of inode number.  We use this technique instead of using
@@ -775,7 +797,7 @@
 	/*
 	 * Make sure the inode is up-to-date.
 	 */
-	error = nfs_revalidate_inode(NFS_SERVER(inode),inode);
+	error = nfs_revalidate(dentry);
 	if (error) {
 #ifdef NFS_PARANOIA
 printk("nfs_notify_change: revalidate failed, error=%d\n", error);
@@ -1021,11 +1043,12 @@
 			inode->i_dev, inode->i_ino,
 			atomic_read(&inode->i_count), fattr->valid);
 
-	if (NFS_FILEID(inode) != fattr->fileid) {
+	if (NFS_FSID(inode) != fattr->fsid ||
+	    NFS_FILEID(inode) != fattr->fileid) {
 		printk(KERN_ERR "nfs_refresh_inode: inode number mismatch\n"
-		       "expected (0x%x/0x%Lx), got (0x%x/0x%Lx)\n",
-		       inode->i_dev, (long long)NFS_FILEID(inode),
-		       inode->i_dev, (long long)fattr->fileid);
+		       "expected (0x%Lx/0x%Lx), got (0x%Lx/0x%Lx)\n",
+		       (long long)NFS_FSID(inode), (long long)NFS_FILEID(inode),
+		       (long long)fattr->fsid, (long long)fattr->fileid);
 		goto out_err;
 	}
 
@@ -1096,11 +1119,8 @@
 
 	inode->i_atime = new_atime;
 
-	if (NFS_CACHE_MTIME(inode) != new_mtime) {
-		NFS_MTIME_UPDATE(inode) = jiffies;
-		NFS_CACHE_MTIME(inode) = new_mtime;
-		inode->i_mtime = nfs_time_to_secs(new_mtime);
-	}
+	NFS_CACHE_MTIME(inode) = new_mtime;
+	inode->i_mtime = nfs_time_to_secs(new_mtime);
 
 	NFS_CACHE_ISIZE(inode) = new_size;
 	inode->i_size = new_isize;
diff -urN 2.4.19pre6aa1/fs/nfs/nfs3proc.c nfs/fs/nfs/nfs3proc.c
--- 2.4.19pre6aa1/fs/nfs/nfs3proc.c	Fri Apr  5 20:19:43 2002
+++ nfs/fs/nfs/nfs3proc.c	Fri Apr  5 20:22:01 2002
@@ -111,8 +111,7 @@
 		status = rpc_call(NFS_CLIENT(dir), NFS3PROC_GETATTR,
 			 fhandle, fattr, 0);
 	dprintk("NFS reply lookup: %d\n", status);
-	if (status >= 0)
-		status = nfs_refresh_inode(dir, &dir_attr);
+	nfs_refresh_inode(dir, &dir_attr);
 	return status;
 }
 
diff -urN 2.4.19pre6aa1/include/linux/nfs_fs.h nfs/include/linux/nfs_fs.h
--- 2.4.19pre6aa1/include/linux/nfs_fs.h	Fri Apr  5 20:19:44 2002
+++ nfs/include/linux/nfs_fs.h	Fri Apr  5 20:22:01 2002
@@ -78,7 +78,6 @@
 #define NFS_CONGESTED(inode)		(RPC_CONGESTED(NFS_CLIENT(inode)))
 #define NFS_COOKIEVERF(inode)		((inode)->u.nfs_i.cookieverf)
 #define NFS_READTIME(inode)		((inode)->u.nfs_i.read_cache_jiffies)
-#define NFS_MTIME_UPDATE(inode)		((inode)->u.nfs_i.cache_mtime_jiffies)
 #define NFS_CACHE_CTIME(inode)		((inode)->u.nfs_i.read_cache_ctime)
 #define NFS_CACHE_MTIME(inode)		((inode)->u.nfs_i.read_cache_mtime)
 #define NFS_CACHE_ISIZE(inode)		((inode)->u.nfs_i.read_cache_isize)
@@ -98,6 +97,7 @@
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
 
 #define NFS_FILEID(inode)		((inode)->u.nfs_i.fileid)
+#define NFS_FSID(inode)			((inode)->u.nfs_i.fsid)
 
 /* Inode Flags */
 #define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
@@ -152,7 +152,6 @@
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_release(struct inode *, struct file *);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
-extern int nfs_check_stale(struct inode *);
 extern int nfs_notify_change(struct dentry *, struct iattr *);
 
 /*
diff -urN 2.4.19pre6aa1/include/linux/nfs_fs_i.h nfs/include/linux/nfs_fs_i.h
--- 2.4.19pre6aa1/include/linux/nfs_fs_i.h	Fri Apr  5 20:00:43 2002
+++ nfs/include/linux/nfs_fs_i.h	Fri Apr  5 20:22:01 2002
@@ -12,6 +12,7 @@
 	/*
 	 * The 64bit 'inode number'
 	 */
+	__u64 fsid;
 	__u64 fileid;
 
 	/*
@@ -49,12 +50,6 @@
 	unsigned long		attrtimeo_timestamp;
 
 	/*
-	 * Timestamp that dates the change made to read_cache_mtime.
-	 * This is of use for dentry revalidation
-	 */
-	unsigned long		cache_mtime_jiffies;
-
-	/*
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
 	 */
@@ -72,6 +67,11 @@
 				ndirty,
 				ncommit,
 				npages;
+
+	/* Flush daemon info */
+	struct inode		*hash_next,
+				*hash_prev;
+	unsigned long		nextscan;
 
 	/* Credentials for shared mmap */
 	struct rpc_cred		*mm_cred;

Andrea
