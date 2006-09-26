Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWIZFj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWIZFj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWIZFj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50389 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWIZFjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:52 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 34/47] sysfs_remove_bin_file: no return value, dump_stack on error
Date: Mon, 25 Sep 2006 22:37:54 -0700
Message-Id: <11592491924093-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491901464-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy.Dunlap <rdunlap@xenotime.net>

Make sysfs_remove_bin_file() void.  If it detects an error,
printk the file name and call dump_stack().

sysfs_hash_and_remove() now returns an error code indicating
its success or failure so that sysfs_remove_bin_file() can
know success/failure.

Convert the only driver that checked the return value of
sysfs_remove_bin_file().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    4 +---
 fs/sysfs/bin.c                    |   13 ++++++++-----
 fs/sysfs/inode.c                  |   11 ++++++++---
 fs/sysfs/sysfs.h                  |    2 +-
 include/linux/sysfs.h             |    2 +-
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 317457d..d0a07d9 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
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
diff --git a/fs/sysfs/bin.c b/fs/sysfs/bin.c
index c16a93c..98022e4 100644
--- a/fs/sysfs/bin.c
+++ b/fs/sysfs/bin.c
@@ -10,6 +10,7 @@ #undef DEBUG
 
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
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 9889e54..fd7cd5f 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -12,6 +12,7 @@ #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
 #include <linux/capability.h>
+#include <linux/errno.h>
 #include "sysfs.h"
 
 extern struct super_block * sysfs_sb;
@@ -234,17 +235,18 @@ void sysfs_drop_dentry(struct sysfs_dire
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
@@ -255,8 +257,11 @@ void sysfs_hash_and_remove(struct dentry
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
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 3651ffb..6f3d6bd 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -10,7 +10,7 @@ extern int sysfs_make_dirent(struct sysf
 				umode_t, int);
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
-extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern int sysfs_hash_and_remove(struct dentry * dir, const char * name);
 extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 1ea5d3c..95f6db5 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -114,7 +114,7 @@ extern void
 sysfs_remove_link(struct kobject *, const char * name);
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+void sysfs_remove_bin_file(struct kobject *kobj, struct bin_attribute *attr);
 
 int sysfs_create_group(struct kobject *, const struct attribute_group *);
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
-- 
1.4.2.1

