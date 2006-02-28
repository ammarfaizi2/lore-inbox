Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWB1GED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWB1GED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWB1GED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:04:03 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:4055 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751858AbWB1GEC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:04:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fWUfO0w9YPJKCvp8JfwcuB6DLJ29aSgMTWdaANWAWua2mUrrsPc1fVaKmysDFc85q4djuKXAj3YEq5i+vuntDlaQHMQhnwW+ZbdSl6HeU5A409j6G3wbl2ifp4VLLDVxEFbrHh97XFRemZNceTwevT3Pyrm0So+fcP2IOqfCuVE=
Message-ID: <bda6d13a0602272204l494e8fe7q67c2509d4e7aa0f7@mail.gmail.com>
Date: Mon, 27 Feb 2006 22:04:01 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/27] allow hard links to directories, opt-in for any filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch seems to work, might want more testing.
It probably should not be applied without a discussion, especially
as no filesystem in kernel tree wants this. I am working on a fs that does.

---
--- include/linux/fs.orig.h     2006-02-27 21:45:26.000000000 -0800
+++ include/linux/fs.h  2006-02-27 21:48:17.000000000 -0800
@@ -83,6 +83,8 @@
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1
 #define FS_BINARY_MOUNTDATA 2
+#define FS_ALLOW_HLINK_DIR 4     /* FS will accept hard links to directories */
+#define FS_ALLOW_USER_HLINK_DIR 8 /* And it makes sense for regular users */
 #define FS_REVAL_DOT   16384   /* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME  32768   /* Temporary stuff; will go away as soon
                                  * as nfs_rename() will be cleaned up
--- fs/namei.c.orig     2006-02-27 21:55:26.000000000 -0800
+++ fs/namei.c  2006-02-27 22:08:27.000000000 -0800
@@ -2107,7 +2107,14 @@
        if (!dir->i_op || !dir->i_op->link)
                return -EPERM;
        if (S_ISDIR(old_dentry->d_inode->i_mode))
-               return -EPERM;
+       {
+               if (!(old_dentry->d_sb->s_type->fs_flags & FS_ALLOW_HLINK_DIR))
+                       return -EPERM;
+               if (!(old_dentry->d_sb->s_type->fs_flags
+                               & FS_ALLOW_USER_HLINK_DIR)
+                               && !capable(CAP_SYS_ADMIN))
+                       return -EPERM;
+       }

        error = security_inode_link(old_dentry, dir, new_dentry);
        if (error)
