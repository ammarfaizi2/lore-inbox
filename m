Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbTFMAGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTFMAGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:06:05 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:34809 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265076AbTFMAFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:05:42 -0400
Date: Thu, 12 Jun 2003 17:19:06 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linus Torvalds <torvalds@transmeta.com>, marcelo@conectiva.com.br
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       viro@parcelfarce.linux.theplanet.co.uk,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS sillyrename fixes take 3
Message-ID: <20030612171906.A9488@google.com>
References: <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no> <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk> <20030610194333.B18623@google.com> <20030611030041.GE6754@parcelfarce.linux.theplanet.co.uk> <20030611002226.A19078@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611002226.A19078@google.com>; from fcusack@fcusack.com on Wed, Jun 11, 2003 at 12:22:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2003 at 12:22:26AM -0700, Frank Cusack wrote:
> so anyway, please find attached a 2.4.21-rc7 and 2.5.70 patch which
> prevents removal or rename of unlinked-but-open files.

Minor adjustment.  It's functionally the same but prevents a spurious
printk (fs/nfs/dir.c:1199 in 2.5.70).

Works for me.

/fc

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.21-rc7-silly-1.patch"

--- linux-2.4.21-rc7/fs/namei.c	Sun Jun  8 23:57:33 2003
+++ linux-2.4.21-rc7-silly/fs/namei.c	Tue Jun 10 23:49:08 2003
@@ -1482,13 +1482,14 @@ int vfs_unlink(struct inode *dir, struct
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
 				unlock_kernel();
-				if (!error)
+				if (!error &&
+				    !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 					d_delete(dentry);
 			}
 		}
 	}
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 		inode_dir_notify(dir, DN_DELETE);
 	return error;
 }
@@ -1830,6 +1831,11 @@ int vfs_rename(struct inode *old_dir, st
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
 	int error;
+
+	if (old_dentry->d_flags & DCACHE_NFSFS_RENAMED ||
+	    new_dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
+
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
 		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
 	else

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.70-silly-1.patch"

--- linux-2.5.70/fs/namei.c	Sun Jun  1 23:30:30 2003
+++ linux-2.5.70-silly/fs/namei.c	Tue Jun 10 23:44:14 2003
@@ -1631,7 +1631,9 @@ int vfs_unlink(struct inode *dir, struct
 			error = dir->i_op->unlink(dir, dentry);
 	}
 	up(&dentry->d_inode->i_sem);
-	if (!error) {
+
+	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
 		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
 	}
@@ -1949,6 +1951,11 @@ int vfs_rename(struct inode *old_dir, st
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
+
+	/* Don't allow sillyrenamed files to move; messes up async_unlink */
+	if (old_dentry->d_flags & DCACHE_NFSFS_RENAMED ||
+	    new_dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
  
 	error = may_delete(old_dir, old_dentry, is_dir);
 	if (error)

--PNTmBPCT7hxwcZjr--
