Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUGCUWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUGCUWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUGCUWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:22:45 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:12223 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265238AbUGCUWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:22:42 -0400
Date: Sat, 3 Jul 2004 22:22:42 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: procfs permissions on 2.6.x
Message-ID: <20040703202242.GA31656@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew!

stumbled over the following detail ...

usually when somebody tries to modify an inode,
notify_change() calls inode_change_ok() to verify
the user's permissions ... now it seems that
somewhere around 2.5.41, a patch similar to this
one was included into the mainline, and remained
almost unmodified ...

http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.1/1002.html

this probably unintentionally circumvents the 
inode_change_ok() check, so that now any user
can modify inodes of the procfs. 

example:

  $ chmod a-rwx /proc/cmdline

the following patch hopefully fixes this, so
please consider for inclusion ...

TIA,
Herbert


diff -NurpP --minimal linux-2.6.7/fs/proc/generic.c linux-2.6.7-fix/fs/proc/generic.c
--- linux-2.6.7/fs/proc/generic.c	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.7-fix/fs/proc/generic.c	2004-07-03 21:50:30.000000000 +0200
@@ -241,8 +241,20 @@ static int proc_notify_change(struct den
 	return error;
 }
 
+static int proc_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+        struct inode *inode = dentry->d_inode;
+        int error;
+
+        error = inode_change_ok(inode, iattr);
+        if (error)
+                return error;
+	error = proc_notify_change(dentry, iattr);
+	return error;
+}
+
 static struct inode_operations proc_file_inode_operations = {
-	.setattr	= proc_notify_change,
+	.setattr	= proc_setattr,
 };
 
 /*
@@ -472,7 +484,7 @@ static struct file_operations proc_dir_o
  */
 static struct inode_operations proc_dir_inode_operations = {
 	.lookup		= proc_lookup,
-	.setattr	= proc_notify_change,
+	.setattr	= proc_setattr,
 };
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
