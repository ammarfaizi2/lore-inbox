Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTARFAB>; Sat, 18 Jan 2003 00:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTARFAB>; Sat, 18 Jan 2003 00:00:01 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:61407 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262420AbTARFAA>; Sat, 18 Jan 2003 00:00:00 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Jan 2003 21:08:49 -0800
Message-Id: <200301180508.VAA07511@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.59/fs/devfs shrink
Cc: akpm@digeo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Many thanks to Andrew Morton for a patch to my devfs shrink
that fixes premature unlocking of an inode, eliminates a redundant "if
(err)", and removes an incorrect comment.  I'm running with Andrew's
changes now, and I've put up a new diff against 2.5.59 so that
everyone can be up to date, at the following URL.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.59-v9.patch

	Just for completeness, here is the URL for devfs_helper (no change):

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz

	Also for completeness, I've appended a copy of Andrew's diff.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."



 devfs/base.c |   11 ++++-------
 devfs/fs.c   |    0 
 2 files changed, 4 insertions(+), 7 deletions(-)

diff -puN fs/devfs/base.c~a fs/devfs/base.c
--- 25/fs/devfs/base.c~a	2003-01-17 19:20:17.000000000 -0800
+++ 25-akpm/fs/devfs/base.c	2003-01-17 19:26:29.000000000 -0800
@@ -48,7 +48,6 @@ extern int __init init_devfs_fs(void);
    different interface from lookup_create. */
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
-/* Called and returns with dcache_lock held.  */
 static int walk_parents_mkdir(const char **path, struct nameidata *nd,
 			      int is_dir)
 {
@@ -78,10 +77,8 @@ static int walk_parents_mkdir(const char
 		
 		up(&nd->dentry->d_parent->d_inode->i_sem);
 
-		if (err) {
-			if (err)
-				return err;
-		}
+		if (err)
+			return err;
 
 		*path += len + 1;
 	}
@@ -156,7 +153,6 @@ devfs_handle_t devfs_register (devfs_han
 		goto err_free_devnum;
 
 	err = vfs_mknod(parent_inode, dentry, mode, devnum);
-	up(&parent_inode->i_sem);
 	if (!err) {
 		/* FIXME? Is DEVFS_FL_CURRENT_OWNER useful?  Don't we
 		   already set uid and gid to current->fs{uid,gid}?  */
@@ -164,8 +160,10 @@ devfs_handle_t devfs_register (devfs_han
 			dentry->d_inode->i_uid = current->uid;
 			dentry->d_inode->i_gid = current->gid;
 		}
+		up(&parent_inode->i_sem);
 		return dentry;
 	}
+	up(&parent_inode->i_sem);
 
 	dput(dentry);
 
@@ -259,7 +257,6 @@ void devfs_remove(const char *fmt, ...)
 		devfs_put(nd.dentry);
 	}
 }
-
 EXPORT_SYMBOL(devfs_remove);
 
 int devfs_only(void)
diff -puN fs/devfs/fs.c~a fs/devfs/fs.c

_
