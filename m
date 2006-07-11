Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWGKGCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWGKGCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWGKGCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:02:42 -0400
Received: from xenotime.net ([66.160.160.81]:56235 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932482AbWGKGCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:02:41 -0400
Date: Mon, 10 Jul 2006 23:05:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, gregkh <greg@kroah.com>
Subject: [PATCH -mm] sysfs_remove_bin_file: no return value, dump_stack on
 error
Message-Id: <20060710230525.860d0caa.rdunlap@xenotime.net>
In-Reply-To: <20060710173636.35008ada.rdunlap@xenotime.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<20060710122910.08c01f46.rdunlap@xenotime.net>
	<20060710144342.2efc174c.akpm@osdl.org>
	<20060710173636.35008ada.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

> So I think a better policy would be to emit a warning from within
> sysfs_remove_bin_file(), then return void.  The warning should include the
> stack trace and the filename (if possible).

Make sysfs_remove_bin_file() void.  If it detects an error,
printk the file name and call dump_stack().

sysfs_hash_and_remove() now returns an error code indicating
its success or failure so that sysfs_remove_bin_file() can
know success/failure.

Convert the only driver that checked the return value of
sysfs_remove_bin_file().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    4 +---
 fs/sysfs/bin.c                    |   13 ++++++++-----
 fs/sysfs/inode.c                  |   11 ++++++++---
 fs/sysfs/sysfs.h                  |    2 +-
 include/linux/sysfs.h             |    2 +-
 5 files changed, 19 insertions(+), 13 deletions(-)

--- linux-2618-rc1mm1.orig/fs/sysfs/bin.c
+++ linux-2618-rc1mm1/fs/sysfs/bin.c
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -176,7 +177,6 @@ const struct file_operations bin_fops = 
  *	sysfs_create_bin_file - create binary file for object.
  *	@kobj:	object.
  *	@attr:	attribute descriptor.
- *
  */
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
@@ -191,13 +191,16 @@ int sysfs_create_bin_file(struct kobject
  *	sysfs_remove_bin_file - remove binary file for object.
  *	@kobj:	object.
  *	@attr:	attribute descriptor.
- *
  */
 
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
+void sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->attr.name);
-	return 0;
+	if (sysfs_hash_and_remove(kobj->dentry, attr->attr.name) < 0) {
+		printk(KERN_ERR "%s: "
+			"bad dentry or inode or no such file: \"%s\"\n",
+			__FUNCTION__, attr->attr.name);
+		dump_stack();
+	}
 }
 
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
--- linux-2618-rc1mm1.orig/fs/sysfs/inode.c
+++ linux-2618-rc1mm1/fs/sysfs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
 #include <linux/capability.h>
+#include <linux/errno.h>
 #include "sysfs.h"
 
 extern struct super_block * sysfs_sb;
@@ -221,17 +222,18 @@ void sysfs_drop_dentry(struct sysfs_dire
 	}
 }
 
-void sysfs_hash_and_remove(struct dentry * dir, const char * name)
+int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
 	struct sysfs_dirent * parent_sd;
+	int found = 0;
 
 	if (!dir)
-		return;
+		return -ENOENT;
 
 	if (dir->d_inode == NULL)
 		/* no inode means this hasn't been made visible yet */
-		return;
+		return -ENOENT;
 
 	parent_sd = dir->d_fsdata;
 	mutex_lock(&dir->d_inode->i_mutex);
@@ -242,8 +244,11 @@ void sysfs_hash_and_remove(struct dentry
 			list_del_init(&sd->s_sibling);
 			sysfs_drop_dentry(sd, dir);
 			sysfs_put(sd);
+			found = 1;
 			break;
 		}
 	}
 	mutex_unlock(&dir->d_inode->i_mutex);
+
+	return found ? 0 : -ENOENT;
 }
--- linux-2618-rc1mm1.orig/fs/sysfs/sysfs.h
+++ linux-2618-rc1mm1/fs/sysfs/sysfs.h
@@ -10,7 +10,7 @@ extern int sysfs_make_dirent(struct sysf
 				umode_t, int);
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
-extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern int sysfs_hash_and_remove(struct dentry * dir, const char * name);
 extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
--- linux-2618-rc1mm1.orig/include/linux/sysfs.h
+++ linux-2618-rc1mm1/include/linux/sysfs.h
@@ -116,7 +116,7 @@ sysfs_remove_link(struct kobject *, cons
 
 int __must_check sysfs_create_bin_file(struct kobject * kobj,
 					struct bin_attribute * attr);
-int __must_check sysfs_remove_bin_file(struct kobject * kobj,
+void sysfs_remove_bin_file(struct kobject * kobj,
 					struct bin_attribute * attr);
 
 int __must_check sysfs_create_group(struct kobject *,
--- linux-2618-rc1mm1.orig/drivers/pci/hotplug/acpiphp_ibm.c
+++ linux-2618-rc1mm1/drivers/pci/hotplug/acpiphp_ibm.c
@@ -487,9 +487,7 @@ static void __exit ibm_acpiphp_exit(void
 	if (ACPI_FAILURE(status))
 		err("%s: Notification handler removal failed\n", __FUNCTION__);
 	/* remove the /sys entries */
-	if (sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr))
-		err("%s: removal of sysfs file apci_table failed\n",
-				__FUNCTION__);
+	sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr);
 }
 
 module_init(ibm_acpiphp_init);
