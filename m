Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTH2RLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTH2RLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:11:54 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:55743 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261524AbTH2RJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:09:45 -0400
Date: Fri, 29 Aug 2003 19:09:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, mochel@osdl.org
Subject: [PATCH] s390 (3/8): sysfs memory leak.
Message-ID: <20030829170908.GD1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dcache reference counting in sysfs.

diffstat:
 fs/sysfs/bin.c     |    1 +
 fs/sysfs/dir.c     |    6 +++---
 fs/sysfs/file.c    |    5 +----
 fs/sysfs/inode.c   |    2 +-
 fs/sysfs/symlink.c |    1 +
 5 files changed, 7 insertions(+), 8 deletions(-)

diff -urN linux-2.6/fs/sysfs/bin.c linux-2.6-s390/fs/sysfs/bin.c
--- linux-2.6/fs/sysfs/bin.c	Sat Aug 23 01:56:12 2003
+++ linux-2.6-s390/fs/sysfs/bin.c	Fri Aug 29 18:55:08 2003
@@ -168,6 +168,7 @@
 			dentry->d_inode->i_size = attr->size;
 			dentry->d_inode->i_fop = &bin_fops;
 		}
+		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
 	up(&parent->d_inode->i_sem);
diff -urN linux-2.6/fs/sysfs/dir.c linux-2.6-s390/fs/sysfs/dir.c
--- linux-2.6/fs/sysfs/dir.c	Sat Aug 23 01:54:57 2003
+++ linux-2.6-s390/fs/sysfs/dir.c	Fri Aug 29 18:55:08 2003
@@ -35,10 +35,8 @@
 		if (!error) {
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
-		} else {
-			dput(dentry);
-			dentry = ERR_PTR(error);
 		}
+		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
 	return dentry;
@@ -136,6 +134,7 @@
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
+			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			spin_lock(&dcache_lock);
@@ -143,6 +142,7 @@
 		pr_debug(" done\n");
 		node = dentry->d_subdirs.next;
 	}
+	list_del_init(&dentry->d_child);
 	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 
diff -urN linux-2.6/fs/sysfs/file.c linux-2.6-s390/fs/sysfs/file.c
--- linux-2.6/fs/sysfs/file.c	Sat Aug 23 01:51:32 2003
+++ linux-2.6-s390/fs/sysfs/file.c	Fri Aug 29 18:55:08 2003
@@ -356,10 +356,7 @@
 		error = sysfs_create(dentry,(attr->mode & S_IALLUGO) | S_IFREG,init_file);
 		if (!error)
 			dentry->d_fsdata = (void *)attr;
-		else {
-			dput(dentry);
-			dentry = ERR_PTR(error);
-		}
+		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
 	up(&dir->d_inode->i_sem);
diff -urN linux-2.6/fs/sysfs/inode.c linux-2.6-s390/fs/sysfs/inode.c
--- linux-2.6/fs/sysfs/inode.c	Sat Aug 23 01:58:54 2003
+++ linux-2.6-s390/fs/sysfs/inode.c	Fri Aug 29 18:55:08 2003
@@ -97,8 +97,8 @@
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			simple_unlink(dir->d_inode,victim);
 			d_delete(victim);
+			simple_unlink(dir->d_inode,victim);
 		}
 		/*
 		 * Drop reference from sysfs_get_dentry() above.
diff -urN linux-2.6/fs/sysfs/symlink.c linux-2.6-s390/fs/sysfs/symlink.c
--- linux-2.6/fs/sysfs/symlink.c	Sat Aug 23 01:55:32 2003
+++ linux-2.6-s390/fs/sysfs/symlink.c	Fri Aug 29 18:55:08 2003
@@ -102,6 +102,7 @@
 		error = sysfs_symlink(dentry->d_inode,d,path);
 	else
 		error = PTR_ERR(d);
+	dput(d);
 	up(&dentry->d_inode->i_sem);
 	kfree(path);
 	return error;
