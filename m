Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291448AbSBSP5P>; Tue, 19 Feb 2002 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291449AbSBSP5I>; Tue, 19 Feb 2002 10:57:08 -0500
Received: from rj.SGI.COM ([204.94.215.100]:25270 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291447AbSBSP4x>;
	Tue, 19 Feb 2002 10:56:53 -0500
Subject: Re: BKL removal from VFS
From: Steve Lord <lord@sgi.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Nakayama Shintaro <nakayama@tritech.co.jp>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        shojima@tritech.co.jp, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0202190220290.8070-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202190220290.8070-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 09:54:31 -0600
Message-Id: <1014134071.3384.82.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-19 at 01:47, Alexander Viro wrote:
> 
> 
> On Tue, 19 Feb 2002, Nakayama Shintaro wrote:
> 
> > I've found great BKL contention when running multiple postmark
> > benchmarks. Here is the postmark results with lock contention
> > sampled by lockmeter.
> 
> Conflicts with (and massively duplicates) patches that already went
> into 2.5.  Absolutely useless wrt mount() locking changes (except for
> remount they can't race with filesystem code even in principle and
> definitely don't need system-wide exclusion among themselves).  Has
> a nice DoS potential (on OOM).  Too large and changes too many things
> to be acceptable at one chunk even if none of the above would apply.
> Consider it vetoed.
> 
> Seriously, just watching the changelogs would show that it has no chance
> to be applied.
> 
> I hadn't checked for races, but e.g. ext2_readdir() losing BKL without
> corresponding changes to lseek() looks very suspicious.  I'm more than
> sure that there's more - after doing that BKL-shifting in recent 2.5.
> E.g. I'm pretty sure that you are screwing ->i_nlink checks.
> 

Al, I am not proposing this to go in, but what is your opinion on a
change like this? XFS does not need the BKL at all, so for some aim7
experiments on large systems this  patch was used to bypass the BKL for
filesystems which state they can live without it:

This is against 2.4.17, so it is a bit dated, it is also not
comprehensive in terms of hitting all the BKL usage around
filesystem calls.

Steve

===========================================================================
Index: linux/fs/namei.c
===========================================================================

--- /usr/tmp/TmpDir.32271-0/linux/fs/namei.c_1.41	Sat Feb  2 14:34:21 2002
+++ linux/fs/namei.c	Sat Feb  2 14:11:23 2002
@@ -26,6 +26,12 @@
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
+#define lock_kernel_optional(ip)	\
+	if (!(ip->i_flags & S_NOBKL))	lock_kernel()
+
+#define unlock_kernel_optional(ip)	\
+	if (!(ip->i_flags & S_NOBKL))	unlock_kernel()
+
 #define ACC_MODE(x) ("\000\004\002\006"[(x)&O_ACCMODE])
 
 /* [Feb-1997 T. Schoebel-Theuer]
@@ -199,9 +205,9 @@
 {
 	if (inode->i_op && inode->i_op->permission) {
 		int retval;
-		lock_kernel();
+		lock_kernel_optional(inode);
 		retval = inode->i_op->permission(inode, mask);
-		unlock_kernel();
+		unlock_kernel_optional(inode);
 		return retval;
 	}
 	return vfs_permission(inode, mask);
@@ -298,9 +304,9 @@
 		struct dentry * dentry = d_alloc(parent, name);
 		result = ERR_PTR(-ENOMEM);
 		if (dentry) {
-			lock_kernel();
+			lock_kernel_optional(dir);
 			result = dir->i_op->lookup(dir, dentry);
-			unlock_kernel();
+			unlock_kernel_optional(dir);
 			if (result)
 				dput(dentry);
 			else
@@ -770,9 +776,9 @@
 		dentry = ERR_PTR(-ENOMEM);
 		if (!new)
 			goto out;
-		lock_kernel();
+		lock_kernel_optional(inode);
 		dentry = inode->i_op->lookup(inode, new);
-		unlock_kernel();
+		unlock_kernel_optional(inode);
 		if (!dentry)
 			dentry = new;
 		else
@@ -945,9 +951,9 @@
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
-	lock_kernel();
+	lock_kernel_optional(dir);
 	error = dir->i_op->create(dir, dentry, mode);
-	unlock_kernel();
+	unlock_kernel_optional(dir);
 exit_lock:
 	up(&dir->i_zombie);
 	if (!error)
@@ -1225,9 +1231,9 @@
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
-	lock_kernel();
+	lock_kernel_optional(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
-	unlock_kernel();
+	unlock_kernel_optional(dir);
 exit_lock:
 	up(&dir->i_zombie);
 	if (!error)
@@ -1296,9 +1302,9 @@
 
 	DQUOT_INIT(dir);
 	mode &= (S_IRWXUGO|S_ISVTX);
-	lock_kernel();
+	lock_kernel_optional(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
-	unlock_kernel();
+	unlock_kernel_optional(dir);
 
 exit_lock:
 	up(&dir->i_zombie);
@@ -1387,9 +1393,9 @@
 	else if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		lock_kernel();
+		lock_kernel_optional(dir);
 		error = dir->i_op->rmdir(dir, dentry);
-		unlock_kernel();
+		unlock_kernel_optional(dir);
 		if (!error)
 			dentry->d_inode->i_flags |= S_DEAD;
 	}
@@ -1458,9 +1464,9 @@
 			if (d_mountpoint(dentry))
 				error = -EBUSY;
 			else {
-				lock_kernel();
+				lock_kernel_optional(dir);
 				error = dir->i_op->unlink(dir, dentry);
-				unlock_kernel();
+				unlock_kernel_optional(dir);
 				if (!error)
 					d_delete(dentry);
 			}
@@ -1529,9 +1535,9 @@
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
-	lock_kernel();
+	lock_kernel_optional(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
-	unlock_kernel();
+	unlock_kernel_optional(dir);
 
 exit_lock:
 	up(&dir->i_zombie);
@@ -1603,9 +1609,9 @@
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
-	lock_kernel();
+	lock_kernel_optional(dir);
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
-	unlock_kernel();
+	unlock_kernel_optional(dir);
 
 exit_lock:
 	up(&dir->i_zombie);

===========================================================================
Index: linux/fs/xfs/xfs_iget.c
===========================================================================

--- /usr/tmp/TmpDir.32271-0/linux/fs/xfs/xfs_iget.c_1.149	Sat Feb  2 14:34:21 2002
+++ linux/fs/xfs/xfs_iget.c	Sat Feb  2 13:59:04 2002
@@ -478,6 +478,7 @@
 

 		vp = LINVFS_GET_VN_ADDRESS(inode);
+		inode->i_flags |= S_NOBKL;
 		if (inode->i_state & I_NEW) {
 			vn_initialize(XFS_MTOVFS(mp), inode, 0);
 			error = xfs_iget_core(vp, mp, tp, ino,

===========================================================================
Index: linux/include/linux/fs.h
===========================================================================

--- /usr/tmp/TmpDir.32271-0/linux/include/linux/fs.h_1.137	Sat Feb  2 14:34:21 2002
+++ linux/include/linux/fs.h	Sat Feb  2 13:57:20 2002
@@ -142,6 +142,7 @@
 #define S_IMMUTABLE	16	/* Immutable file */
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
+#define S_NOBKL	       128	/* No big kernel lock required */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
