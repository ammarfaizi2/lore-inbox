Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUEWTyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUEWTyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUEWTyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:54:17 -0400
Received: from ghoul.undead.cc ([216.126.84.18]:5248 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263551AbUEWTup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:50:45 -0400
Message-ID: <40B10093.6030703@undead.cc>
Date: Sun, 23 May 2004 15:50:43 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] sysfs rename dir problem
Content-Type: multipart/mixed;
 boundary="------------000802070000040400040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000802070000040400040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the sysfs_rename_dir function if something goes wrong then the 
directory name would no longer match the internal kobj name.  Here's a 
patch I made to fix that but I'm not sure if it's 100% correct.

John




--------------000802070000040400040204
Content-Type: text/plain;
 name="sysfs_rename_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_rename_fix"

diff -urNX dontdiff linux-2.6.6/fs/sysfs/dir.c linux/fs/sysfs/dir.c
--- linux-2.6.6/fs/sysfs/dir.c	2004-05-09 22:32:28.000000000 -0400
+++ linux/fs/sysfs/dir.c	2004-05-23 15:16:40.000000000 -0400
@@ -169,8 +169,14 @@
 	down(&parent->d_inode->i_sem);
 
 	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
+	if (!IS_ERR(new_dentry)) {
+		if (kobject_set_name(kobj,new_name))
+			d_move(kobj->dentry, new_dentry);
+		else {
+			d_delete(new_dentry);
+			dput(new_dentry);
+		}
+	}
 	up(&parent->d_inode->i_sem);	
 }
 

--------------000802070000040400040204--

