Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSFJEvE>; Mon, 10 Jun 2002 00:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSFJEvD>; Mon, 10 Jun 2002 00:51:03 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:8968 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S316635AbSFJEvA>; Mon, 10 Jun 2002 00:51:00 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu, linux-fsdevel@vger.kernel.org
Cc: trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu, braam@clusterfs.com,
        urban@teststation.com, linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: [PATCH] Push BKL into ->permission() calls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jun 2002 21:50:39 -0700
Message-Id: <E17HH8a-0006Y9-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below (against 2.5.21) removes the BKL from around the call 
to i_op->permission() in fs/namei.c, and pushes the BKL into those 
filesystems that have permission() methods that require it:

fs/nfs/dir.c:nfs_permission():  Take BKL if we need to do RPC

fs/coda/dir.c:coda_permission(): Take BKL if mask != 0

fs/coda/pioctl.c:coda_ioctl_permission(): BKL not needed

net/wanrouter/wanproc.c:router_proc_perms(): BKL not needed 

fs/intermezzo/dir.c:presto_permission(): Always take BKL (and avoid
abuse of inode method table)

fs/proc/base.c:proc_permission(): BKL not needed

fs/smbfs/file.c:smb_file_permission(): BKL not needed

kernel/sysctl.c:proc_sys_permission(): BKL not needed

Out-of-tree filesystems that have their own permission() method will 
need updating if they're relying on the BKL.

Al, please forward this patch to Linus if you're happy with it.

Paul

diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.21/Documentation/filesystems/Locking linux-2.5.21-permission/Documentation/filesystems/Locking
--- linux-2.5.21/Documentation/filesystems/Locking	Sat Jun  8 22:28:48 2002
+++ linux-2.5.21-permission/Documentation/filesystems/Locking	Sun Jun  9 20:54:51 2002
@@ -50,27 +50,27 @@
 	int (*removexattr) (struct dentry *, const char *);
 
 locking rules:
-	all may block
-		BKL	i_sem(inode)
-lookup:		no	yes
-create:		no	yes
-link:		no	yes (both)
-mknod:		no	yes
-symlink:	no	yes
-mkdir:		no	yes
-unlink:		no	yes (both)
-rmdir:		no	yes (both)	(see below)
-rename:		no	yes (all)	(see below)
-readlink:	no	no
-follow_link:	no	no
-truncate:	no	yes		(see below)
-setattr:	no	yes
-permission:	yes	no
-getattr:	no	no
-setxattr:	no	yes
-getxattr:	no	yes
-listxattr:	no	yes
-removexattr:	no	yes
+	all may block, none have BKL
+		i_sem(inode)
+lookup:		yes
+create:		yes
+link:		yes (both)
+mknod:		yes
+symlink:	yes
+mkdir:		yes
+unlink:		yes (both)
+rmdir:		yes (both)	(see below)
+rename:		yes (all)	(see below)
+readlink:	no
+follow_link:	no
+truncate:	yes		(see below)
+setattr:	yes
+permission:	no
+getattr:	no
+setxattr:	yes
+getxattr:	yes
+listxattr:	yes
+removexattr:	yes
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_sem on
 victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.21/fs/coda/dir.c linux-2.5.21-permission/fs/coda/dir.c
--- linux-2.5.21/fs/coda/dir.c	Sat Jun  8 22:27:26 2002
+++ linux-2.5.21-permission/fs/coda/dir.c	Sun Jun  9 20:31:24 2002
@@ -147,21 +147,26 @@
 
 int coda_permission(struct inode *inode, int mask)
 {
-        int error;
+        int error = 0;
  
 	if (!mask)
 		return 0; 
 
+	lock_kernel();
+
 	coda_vfs_stat.permission++;
 
 	if (coda_cache_check(inode, mask))
-		return 0; 
+		goto out; 
 
         error = venus_access(inode->i_sb, coda_i2f(inode), mask);
     
 	if (!error)
 		coda_cache_enter(inode, mask);
 
+ out:
+	unlock_kernel();
+
         return error; 
 }
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.21/fs/intermezzo/dir.c linux-2.5.21-permission/fs/intermezzo/dir.c
--- linux-2.5.21/fs/intermezzo/dir.c	Sat Jun  8 22:28:16 2002
+++ linux-2.5.21-permission/fs/intermezzo/dir.c	Sun Jun  9 20:57:38 2002
@@ -785,13 +785,15 @@
 {
         unsigned short mode = inode->i_mode;
         struct presto_cache *cache;
-        int rc;
+        int rc = 0;
 
+	lock_kernel();
         ENTRY;
+
         if ( presto_can_ilookup() && !(mask & S_IWOTH)) {
                 CDEBUG(D_CACHE, "ilookup on %ld OK\n", inode->i_ino);
-                EXIT;
-                return 0;
+		EXIT;
+		goto out;
         }
 
         cache = presto_get_cache(inode);
@@ -803,25 +805,22 @@
 
                 if ( S_ISREG(mode) && fiops && fiops->permission ) {
                         EXIT;
-                        return fiops->permission(inode, mask);
+                        rc = fiops->permission(inode, mask);
+			goto out;
                 }
                 if ( S_ISDIR(mode) && diops && diops->permission ) {
                         EXIT;
-                        return diops->permission(inode, mask);
+                        rc = diops->permission(inode, mask);
+			goto out;
                 }
         }
 
-        /* The cache filesystem doesn't have its own permission function,
-         * but we don't want to duplicate the VFS code here.  In order
-         * to avoid looping from permission calling this function again,
-         * we temporarily override the permission operation while we call
-         * the VFS permission function.
-         */
-        inode->i_op->permission = NULL;
-        rc = permission(inode, mask);
-        inode->i_op->permission = &presto_permission;
+        rc = vfs_permission(inode, mask);
 
         EXIT;
+
+ out:
+	unlock_kernel();
         return rc;
 }
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.21/fs/namei.c linux-2.5.21-permission/fs/namei.c
--- linux-2.5.21/fs/namei.c	Sat Jun  8 22:28:50 2002
+++ linux-2.5.21-permission/fs/namei.c	Sun Jun  9 20:25:31 2002
@@ -204,13 +204,8 @@
 
 int permission(struct inode * inode,int mask)
 {
-	if (inode->i_op && inode->i_op->permission) {
-		int retval;
-		lock_kernel();
-		retval = inode->i_op->permission(inode, mask);
-		unlock_kernel();
-		return retval;
-	}
+	if (inode->i_op && inode->i_op->permission)
+		return inode->i_op->permission(inode, mask);
 	return vfs_permission(inode, mask);
 }
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.21/fs/nfs/dir.c linux-2.5.21-permission/fs/nfs/dir.c
--- linux-2.5.21/fs/nfs/dir.c	Sat Jun  8 22:29:55 2002
+++ linux-2.5.21-permission/fs/nfs/dir.c	Sun Jun  9 20:30:36 2002
@@ -1123,6 +1123,8 @@
 	    && error != -EACCES)
 		goto out;
 
+	lock_kernel();
+
 	error = NFS_PROTO(inode)->access(inode, mask, 0);
 
 	if (error == -EACCES && NFS_CLIENT(inode)->cl_droppriv &&
@@ -1130,6 +1132,8 @@
 	    (current->fsuid != current->uid || current->fsgid != current->gid))
 		error = NFS_PROTO(inode)->access(inode, mask, 1);
 
+	unlock_kernel();
+
  out:
 	return error;
 }


