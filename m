Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTBFEEa>; Wed, 5 Feb 2003 23:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTBFEEL>; Wed, 5 Feb 2003 23:04:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48912 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265373AbTBFECz>;
	Wed, 5 Feb 2003 23:02:55 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044862346@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044863071@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.6, 2003/02/05 17:18:17+11:00, greg@kroah.com

[PATCH] sysfs: add sysfs_update_file() function.


diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Thu Feb  6 14:52:02 2003
+++ b/fs/sysfs/inode.c	Thu Feb  6 14:52:02 2003
@@ -37,6 +37,7 @@
 #include <linux/backing-dev.h>
 #include <linux/kobject.h>
 #include <linux/mount.h>
+#include <linux/dnotify.h>
 #include <asm/uaccess.h>
 
 /* Random magic number */
@@ -714,6 +715,46 @@
 		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
+}
+
+/**
+ * sysfs_update_file - update the modified timestamp on an object attribute.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ *
+ * Also call dnotify for the dentry, which lots of userspace programs
+ * use.
+ */
+int sysfs_update_file(struct kobject * kobj, struct attribute * attr)
+{
+	struct dentry * dir = kobj->dentry;
+	struct dentry * victim;
+	int res = -ENOENT;
+
+	down(&dir->d_inode->i_sem);
+	victim = get_dentry(dir, attr->name);
+	if (!IS_ERR(victim)) {
+		/* make sure dentry is really there */
+		if (victim->d_inode && 
+		    (victim->d_parent->d_inode == dir->d_inode)) {
+			victim->d_inode->i_mtime = CURRENT_TIME;
+			dnotify_parent(victim, DN_MODIFY);
+
+			/**
+			 * Drop reference from initial get_dentry().
+			 */
+			dput(victim);
+			res = 0;
+		}
+		
+		/**
+		 * Drop the reference acquired from get_dentry() above.
+		 */
+		dput(victim);
+	}
+	up(&dir->d_inode->i_sem);
+
+	return res;
 }
 
 
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Thu Feb  6 14:52:02 2003
+++ b/include/linux/sysfs.h	Thu Feb  6 14:52:02 2003
@@ -30,6 +30,9 @@
 extern int
 sysfs_create_file(struct kobject *, struct attribute *);
 
+extern int
+sysfs_update_file(struct kobject *, struct attribute *);
+
 extern void
 sysfs_remove_file(struct kobject *, struct attribute *);
 

