Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270159AbTGUPgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270160AbTGUPgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:36:20 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:521 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270159AbTGUPfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:35:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more VFAT_IOCTL_READDIR_BOTH/_SHORT ioctl fix (1/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:50:27 +0900
Message-ID: <87oeznx4jg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes

    - check the ioctl cmd first
    - check the directory whether it's an already dead

Please apply.


 fs/fat/dir.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff -puN fs/fat/dir.c~fat_more-ioctl-fix fs/fat/dir.c
--- linux-2.6.0-test1/fs/fat/dir.c~fat_more-ioctl-fix	2003-07-21 02:48:09.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/dir.c	2003-07-21 02:48:09.000000000 +0900
@@ -647,9 +647,23 @@ int fat_dir_ioctl(struct inode * inode, 
 		  unsigned int cmd, unsigned long arg)
 {
 	struct fat_ioctl_filldir_callback buf;
-	struct dirent __user *d1 = (struct dirent *)arg;
+	struct dirent __user *d1;
 	int ret, shortname, both;
 
+	switch (cmd) {
+	case VFAT_IOCTL_READDIR_SHORT:
+		shortname = 1;
+		both = 1;
+		break;
+	case VFAT_IOCTL_READDIR_BOTH:
+		shortname = 0;
+		both = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	d1 = (struct dirent *)arg;
 	if (!access_ok(VERIFY_WRITE, d1, sizeof(struct dirent[2])))
 		return -EFAULT;
 	/*
@@ -662,20 +676,13 @@ int fat_dir_ioctl(struct inode * inode, 
 
 	buf.dirent = d1;
 	buf.result = 0;
-	switch (cmd) {
-	case VFAT_IOCTL_READDIR_SHORT:
-		shortname = 1;
-		both = 1;
-		break;
-	case VFAT_IOCTL_READDIR_BOTH:
-		shortname = 0;
-		both = 1;
-		break;
-	default:
-		return -EINVAL;
+	down(&inode->i_sem);
+	ret = -ENOENT;
+	if (!IS_DEADDIR(inode)) {
+		ret = fat_readdirx(inode, filp, &buf, fat_ioctl_filldir,
+				   shortname, both);
 	}
-	ret = fat_readdirx(inode, filp, &buf, fat_ioctl_filldir,
-			   shortname, both);
+	up(&inode->i_sem);
 	if (ret >= 0)
 		ret = buf.result;
 	return ret;

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
