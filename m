Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTFKHJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 03:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTFKHJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 03:09:09 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:27225 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264181AbTFKHJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 03:09:04 -0400
Date: Wed, 11 Jun 2003 00:22:26 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS sillyrename fixes (was: [PATCH] nfs_unlink() race)
Message-ID: <20030611002226.A19078@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no> <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk> <20030610194333.B18623@google.com> <20030611030041.GE6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611030041.GE6754@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Jun 11, 2003 at 04:00:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2003 at 04:00:41AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> FWIW, we could probably simply do the following: have nfs_lookup()
> return ERR_PTR(-EINVAL) if it notices that it's about to give us
> such alias.  IOW, no access to such guys at all - if it's going
> to die, we refuse to do anything with it.  I'll try to do that
> variant when I get some sleep - I'd rather not mess with anything
> in that area until I'm completely awake...

Sounds ok to me, except that Linus says

On Tue, Jun 10, 2003 at 10:30:10PM -0700, Linus Torvalds wrote:
> 
> On Wed, 11 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Two different dentries for the same file is obviously not a problem...
> 
> It _is_ a problem. It does the wrong thing on any subsequent directory
> operation (move or unlink). 
> 
> Multiple aliased dentries have never been ok, unless the filesystem 
> explicitly handles them and invalidates them (ie ntfs/fat kind of things).

so anyway, please find attached a 2.4.21-rc7 and 2.5.70 patch which
prevents removal or rename of unlinked-but-open files.  You can see
the rename bug by doing something like

mkdir d1 d2
hold a file open in d1 and rm it; it gets sillyrenamed
move sillyrenamed file to d2
rmdir d1
close file => "inode number mismatch" (data->dir isn't "live", ie it
doesn't follow the rename, and d1 is gone)

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
@@ -1830,6 +1831,10 @@ int vfs_rename(struct inode *old_dir, st
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
 	int error;
+
+	if (old_dentry->d_flags & DCACHE_NFSFS_RENAMED)
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
@@ -1949,6 +1951,10 @@ int vfs_rename(struct inode *old_dir, st
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
+
+	/* Don't allow sillyrenamed files to move; messes up async_unlink */
+	if (old_dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
  
 	error = may_delete(old_dir, old_dentry, is_dir);
 	if (error)

--PNTmBPCT7hxwcZjr--
