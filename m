Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTH2A27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTH2A27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 20:28:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:50149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264345AbTH2A24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 20:28:56 -0400
Date: Thu, 28 Aug 2003 17:26:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Thomas Spatzier <TSPAT@de.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory leak in sysfs
In-Reply-To: <OF846221A1.E004CC84-ONC1256D8F.00491EF9-C1256D8F.004A7867@de.ibm.com>
Message-ID: <Pine.LNX.4.33.0308281725430.3181-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> please verify the following patch. We found a memory leak in sysfs. Entries
> in the dentry_cache allocated for objects in sysfs are not freed when the
> objects in sysfs are deleted. This effect is due to inconsistent reference
> counting in sysfs. Furthermore, when calling sysfs_remove_dir the deleted
> directory was not removed from its parent's list of children. The attached
> patch should fix the problems.

It turns out some of the code had changed, to deal with another small bug
when dentry creation failed. The patch below is updated to -test4.  Could
you please test it and let me know if it still works?

Thanks,


	Pat

===== fs/sysfs/bin.c 1.11 vs edited =====
--- 1.11/fs/sysfs/bin.c	Thu Aug 14 18:17:20 2003
+++ edited/fs/sysfs/bin.c	Thu Aug 28 17:21:05 2003
@@ -168,6 +168,7 @@
 			dentry->d_inode->i_size = attr->size;
 			dentry->d_inode->i_fop = &bin_fops;
 		}
+		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
 	up(&parent->d_inode->i_sem);
===== fs/sysfs/dir.c 1.9 vs edited =====
--- 1.9/fs/sysfs/dir.c	Wed Aug 13 15:21:11 2003
+++ edited/fs/sysfs/dir.c	Thu Aug 28 17:19:26 2003
@@ -35,10 +35,9 @@
 		if (!error) {
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
-		} else {
-			dput(dentry);
+		} else
 			dentry = ERR_PTR(error);
-		}
+		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
 	return dentry;
@@ -136,6 +135,7 @@
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
+			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			spin_lock(&dcache_lock);
@@ -143,6 +143,7 @@
 		pr_debug(" done\n");
 		node = dentry->d_subdirs.next;
 	}
+	list_del_init(&dentry->d_child);
 	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 
===== fs/sysfs/file.c 1.10 vs edited =====
--- 1.10/fs/sysfs/file.c	Wed Aug 13 15:21:11 2003
+++ edited/fs/sysfs/file.c	Thu Aug 28 17:17:07 2003
@@ -356,10 +356,9 @@
 		error = sysfs_create(dentry,(attr->mode & S_IALLUGO) | S_IFREG,init_file);
 		if (!error)
 			dentry->d_fsdata = (void *)attr;
-		else {
-			dput(dentry);
+		else
 			dentry = ERR_PTR(error);
-		}
+		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
 	up(&dir->d_inode->i_sem);
===== fs/sysfs/inode.c 1.86 vs edited =====
--- 1.86/fs/sysfs/inode.c	Thu May 22 16:35:57 2003
+++ edited/fs/sysfs/inode.c	Thu Aug 28 17:17:58 2003
@@ -97,8 +97,8 @@
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			simple_unlink(dir->d_inode,victim);
 			d_delete(victim);
+			simple_unlink(dir->d_inode,victim);
 		}
 		/*
 		 * Drop reference from sysfs_get_dentry() above.
===== fs/sysfs/symlink.c 1.4 vs edited =====
--- 1.4/fs/sysfs/symlink.c	Tue May 20 00:23:06 2003
+++ edited/fs/sysfs/symlink.c	Thu Aug 28 17:17:46 2003
@@ -102,6 +102,7 @@
 		error = sysfs_symlink(dentry->d_inode,d,path);
 	else
 		error = PTR_ERR(d);
+	dput(d);
 	up(&dentry->d_inode->i_sem);
 	kfree(path);
 	return error;

