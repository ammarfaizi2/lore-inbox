Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVDANrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVDANrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVDANrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:47:40 -0500
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]:32615 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262742AbVDANrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:47:11 -0500
Message-ID: <424D50D7.1000503@gentoo.org>
Date: Fri, 01 Apr 2005 14:47:03 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: Fix hardlink counts
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000205070100040703070006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000205070100040703070006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The pid directories in /proc/ currently return the wrong hardlink count - 3, 
when there are actually 4 : ".", "..", "fd", and "task".

This is easy to notice using find(1):
	cd /proc/<pid>
	find

In the output, you'll see a message similar to:
find: WARNING: Hard link count is wrong for .: this may be a bug in your 
filesystem driver.  Automatically turning on find's -noleaf option.  Earlier 
results may have failed to include directories that should have been searched.

http://bugs.gentoo.org/show_bug.cgi?id=86031

I also noticed that CONFIG_SECURITY can add a 5th: attr, and performed a 
similar fix on the task directories too.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------000205070100040703070006
Content-Type: text/x-patch;
 name="procfs-hardlinks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procfs-hardlinks.patch"

--- linux-2.6.11-gentoo-r5/fs/proc/base.c.orig	2005-04-01 14:06:43.000000000 +0100
+++ linux-2.6.11-gentoo-r5/fs/proc/base.c	2005-04-01 14:35:39.000000000 +0100
@@ -1702,8 +1702,12 @@ struct dentry *proc_pid_lookup(struct in
 	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
-	inode->i_nlink = 3;
 	inode->i_flags|=S_IMMUTABLE;
+#ifdef CONFIG_SECURITY
+	inode->i_nlink = 5;
+#else
+	inode->i_nlink = 4;
+#endif
 
 	dentry->d_op = &pid_base_dentry_operations;
 
@@ -1757,8 +1761,12 @@ static struct dentry *proc_task_lookup(s
 	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
-	inode->i_nlink = 3;
 	inode->i_flags|=S_IMMUTABLE;
+#ifdef CONFIG_SECURITY
+	inode->i_nlink = 4;
+#else
+	inode->i_nlink = 3;
+#endif
 
 	dentry->d_op = &pid_base_dentry_operations;
 

--------------000205070100040703070006--
