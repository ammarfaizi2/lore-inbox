Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUEWTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUEWTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEWTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:47:25 -0400
Received: from ns2.undead.cc ([216.126.84.18]:4992 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263529AbUEWTrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:47:23 -0400
Message-ID: <40B0FFC9.1060601@undead.cc>
Date: Sun, 23 May 2004 15:47:21 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] sysfs null dentry pointer checking
Content-Type: multipart/mixed;
 boundary="------------030106010402050201080305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030106010402050201080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've just discovered that some of the sysfs directory functions do not 
check if the dentry pointer is valid.  Some of the subsystems in the 
kernel don't check the return value of  subsystem_register since not 
being able to create a directory in sysfs is not fatal and shouldn't 
prevent booting the machine.  Any kobject that tries to create a 
directory under that subsystem would cause a null pointer dereference.

Here's a patch where the dentry pointers should be checked.  The sysfs 
directory structure wouldn't get updated if there were any directory 
creation errors in a parent but the internal kset/kobject hierarchy 
would still function properly.

John



--------------030106010402050201080305
Content-Type: text/plain;
 name="sysfs_dir_null_check"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_dir_null_check"

diff -urNX dontdiff linux-2.6.6/fs/sysfs/dir.c linux/fs/sysfs/dir.c
--- linux-2.6.6/fs/sysfs/dir.c	2004-05-09 22:32:28.000000000 -0400
+++ linux/fs/sysfs/dir.c	2004-05-23 15:15:08.000000000 -0400
@@ -26,6 +26,9 @@
 {
 	int error;
 
+	if (!p)
+		return -EFAULT;
+
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
@@ -95,7 +98,8 @@
 
 void sysfs_remove_subdir(struct dentry * d)
 {
-	remove_dir(d);
+	if (d)
+		remove_dir(d);
 }
 
 
@@ -164,6 +168,11 @@
 	if (!kobj->parent)
 		return;
 
+	if (!kobj->dentry) {
+		kobject_set_name(kobj,new_name);
+		return;
+	}
+
 	parent = kobj->parent->dentry;
 
 	down(&parent->d_inode->i_sem);

--------------030106010402050201080305--

