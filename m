Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSJJQjr>; Thu, 10 Oct 2002 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbSJJQjr>; Thu, 10 Oct 2002 12:39:47 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:31895 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261757AbSJJQjp>; Thu, 10 Oct 2002 12:39:45 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: [PATCH] 2.5.40: fix chmod/chown on procfs
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 10 Oct 2002 18:45:03 +0200
Message-ID: <87zntm8cq8.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to change uid, gid and mode of files and directories
located in procfs.

Without this patch you can change uid, gid and mode as long as the
file is open. As soon as you close the file, it reverts back to its
default, which is root:root and readonly usually.

This patch is tested with 2.5.40, but applies to 2.5.41 as well.
Comments?

Regards, Olaf.

--- a/fs/proc/generic.c	Sat Oct  5 18:45:53 2002
+++ b/fs/proc/generic.c	Thu Oct 10 17:48:10 2002
@@ -165,6 +165,24 @@
     return -EINVAL;
 }
 
+static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error = inode_setattr(inode, iattr);
+	if (!error) {
+		struct proc_dir_entry *de = PDE(inode);
+		de->uid = inode->i_uid;
+		de->gid = inode->i_gid;
+		de->mode = inode->i_mode;
+	}
+
+	return error;
+}
+
+static struct inode_operations proc_file_inode_operations = {
+	.setattr	= proc_notify_change,
+};
+
 /*
  * This function parses a name such as "tty/driver/serial", and
  * returns the struct proc_dir_entry for "/proc/tty/driver", and
@@ -368,6 +386,7 @@
  */
 static struct inode_operations proc_dir_inode_operations = {
 	.lookup		= proc_lookup,
+	.setattr	= proc_notify_change,
 };
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
@@ -393,6 +412,8 @@
 	} else if (S_ISREG(dp->mode)) {
 		if (dp->proc_fops == NULL)
 			dp->proc_fops = &proc_file_operations;
+		if (dp->proc_iops == NULL)
+			dp->proc_iops = &proc_file_inode_operations;
 	}
 	return 0;
 }
