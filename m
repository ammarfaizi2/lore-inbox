Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265638AbTGDB4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTGDBzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:55:19 -0400
Received: from granite.he.net ([216.218.226.66]:24078 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265651AbTGDByv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:51 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845543452@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845542237@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1374, 2003/07/03 17:43:18-07:00, greg@kroah.com

[PATCH] sysfs: add sysfs_rename_dir()
Based on a patch written by Dan Aloni <da-x@gmx.net>


 fs/sysfs/dir.c        |   22 ++++++++++++++++++++++
 include/linux/sysfs.h |    3 +++
 2 files changed, 25 insertions(+)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Thu Jul  3 18:15:51 2003
+++ b/fs/sysfs/dir.c	Thu Jul  3 18:15:51 2003
@@ -121,7 +121,29 @@
 	dput(parent);
 }
 
+void sysfs_rename_dir(struct kobject * kobj, char *new_name)
+{
+	struct dentry * new_dentry, * parent;
+
+	if (!strcmp(kobj->name, new_name))
+		return;
+
+	if (!kobj->parent)
+		return;
+
+	parent = kobj->parent->dentry;
+
+	down(&parent->d_inode->i_sem);
+
+	new_dentry = sysfs_get_dentry(parent, new_name);
+	d_move(kobj->dentry, new_dentry);
+
+	strlcpy(kobj->name, new_name, KOBJ_NAME_LEN);
+
+	up(&parent->d_inode->i_sem);	
+}
 
 EXPORT_SYMBOL(sysfs_create_dir);
 EXPORT_SYMBOL(sysfs_remove_dir);
+EXPORT_SYMBOL(sysfs_rename_dir);
 
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Thu Jul  3 18:15:51 2003
+++ b/include/linux/sysfs.h	Thu Jul  3 18:15:51 2003
@@ -39,6 +39,9 @@
 extern void
 sysfs_remove_dir(struct kobject *);
 
+extern void
+sysfs_rename_dir(struct kobject *, char *new_name);
+
 extern int
 sysfs_create_file(struct kobject *, struct attribute *);
 

