Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbULAX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbULAX6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbULAXzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:55:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:7321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbULAXwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:52:06 -0500
Date: Wed, 1 Dec 2004 15:51:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, maneesh@in.ibm.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Message-ID: <20041201155159.N14339@build.pdx.osdl.net>
References: <200412011856.iB1IuAc21682@adam.yggdrasil.com> <20041201130703.79a3f3b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041201130703.79a3f3b5.akpm@osdl.org>; from akpm@osdl.org on Wed, Dec 01, 2004 at 01:07:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> That's all well and good, but sysfs_new_dirent() should be using a
> standalone slab cache for allocating sysfs_dirent instances.  That way, we
> use 36 bytes for each one rather than 64.

Reasonable, here's a patch (lightly tested).  Without, size-64 looks
like so:

size-64             4064   4108     76   52    1 : tunables   32   16 8 : slabdata     79     79      0 : globalstat    4263   4079    79    0 0    0   84    0 : cpustat  15986    337  12286      3

And with:

size-64             1196   1196     76   52    1 : tunables   32   16 8 : slabdata     23     23      0 : globalstat    1297   1196    23    0 0    0   84    0 : cpustat  12418    108  11349      1
sysfs_dir_cache     2862   2916     48   81    1 : tunables   32   16 8 : slabdata     36     36      0 : globalstat    2931   2874    36    0 0    0  113    0 : cpustat   2756    216    110      0


Allocate sysfs_dirent structures from their own slab.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/sysfs/dir.c 1.31 vs edited =====
--- 1.31/fs/sysfs/dir.c	2004-11-17 16:00:00 -08:00
+++ edited/fs/sysfs/dir.c	2004-12-01 13:29:11 -08:00
@@ -36,7 +36,7 @@
 {
 	struct sysfs_dirent * sd;
 
-	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
 	if (!sd)
 		return NULL;
 
===== fs/sysfs/sysfs.h 1.14 vs edited =====
--- 1.14/fs/sysfs/sysfs.h	2004-10-30 06:15:11 -07:00
+++ edited/fs/sysfs/sysfs.h	2004-12-01 13:58:42 -08:00
@@ -1,5 +1,6 @@
 
 extern struct vfsmount * sysfs_mount;
+extern kmem_cache_t *sysfs_dir_cachep;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
@@ -74,7 +75,7 @@
 		kobject_put(sl->target_kobj);
 		kfree(sl);
 	}
-	kfree(sd);
+	kmem_cache_free(sysfs_dir_cachep, sd);
 }
 
 static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
===== fs/sysfs/mount.c 1.11 vs edited =====
--- 1.11/fs/sysfs/mount.c	2004-10-30 06:10:49 -07:00
+++ edited/fs/sysfs/mount.c	2004-12-01 14:43:44 -08:00
@@ -16,6 +16,7 @@
 
 struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
+kmem_cache_t *sysfs_dir_cachep;
 
 static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
@@ -76,7 +77,13 @@
 
 int __init sysfs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
+
+	sysfs_dir_cachep = kmem_cache_create("sysfs_dir_cache",
+					      sizeof(struct sysfs_dirent),
+					      0, 0, NULL, NULL);
+	if (!sysfs_dir_cachep)
+		goto out;
 
 	err = register_filesystem(&sysfs_fs_type);
 	if (!err) {
@@ -85,7 +92,13 @@
 			printk(KERN_ERR "sysfs: could not mount!\n");
 			err = PTR_ERR(sysfs_mount);
 			sysfs_mount = NULL;
+			goto out_err;
 		}
-	}
+	} else
+		goto out_err;
+out:
 	return err;
+out_err:
+	kmem_cache_destroy(sysfs_dir_cachep);
+	goto out;
 }
