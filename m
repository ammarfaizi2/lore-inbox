Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVAHH1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVAHH1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVAHH0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:26:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:63365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261897AbVAHFsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:33 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163260958@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632602286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.11, 2004/12/17 15:12:52-08:00, chrisw@osdl.org

[PATCH] sysfs: Allocate sysfs_dirent structures from their own slab.

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c   |    2 +-
 fs/sysfs/mount.c |   17 +++++++++++++++--
 fs/sysfs/sysfs.h |    3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2005-01-07 15:45:26 -08:00
+++ b/fs/sysfs/dir.c	2005-01-07 15:45:26 -08:00
@@ -36,7 +36,7 @@
 {
 	struct sysfs_dirent * sd;
 
-	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
 	if (!sd)
 		return NULL;
 
diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	2005-01-07 15:45:26 -08:00
+++ b/fs/sysfs/mount.c	2005-01-07 15:45:26 -08:00
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
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2005-01-07 15:45:26 -08:00
+++ b/fs/sysfs/sysfs.h	2005-01-07 15:45:26 -08:00
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

