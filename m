Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262957AbRE1E0Z>; Mon, 28 May 2001 00:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262958AbRE1E0P>; Mon, 28 May 2001 00:26:15 -0400
Received: from mail.turbolinux.co.jp ([210.171.55.67]:521 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S262957AbRE1E0F>; Mon, 28 May 2001 00:26:05 -0400
Message-ID: <3B11D36C.2967AFDC@turbolinux.co.jp>
Date: Mon, 28 May 2001 13:26:20 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
X-Mailer: Mozilla 4.75 [ja] (X11; U; Linux 2.2.18-10 i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH]initrd unmount problem
Content-Type: multipart/mixed;
 boundary="------------84577076693BE99D2FC32024"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------84577076693BE99D2FC32024
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

Hi,

It seems that ioctl_by_bdev() in fs/block_dev.c has a problem.
When initrd is unmounted it can cause OOPS. 
This problem occurs in recent ac patches.
May be vanilla too.

change_root() in fs/super.c calls ioctl_by_bdev() in
fs/block_dev.c which does not set inode_fake.i_bdev.

But ioctl of ramdisk (rd_ioctl() in rd.c) accesses to
i_bdev->bd_openers of the inode and which causes OOPS.

I attach the patch.

- GO!
--------------84577076693BE99D2FC32024
Content-Type: text/plain; charset=iso-2022-jp;
 name="block_dev.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block_dev.c.patch"

--- linux/fs/block_dev.c.orig	Mon May 28 12:40:12 2001
+++ linux/fs/block_dev.c	Mon May 28 12:40:12 2001
@@ -602,6 +602,7 @@
 	if (!bdev->bd_op->ioctl)
 		return -EINVAL;
 	inode_fake.i_rdev=rdev;
+	inode_fake.i_bdev=bdev;
 	init_waitqueue_head(&inode_fake.i_wait);
 	set_fs(KERNEL_DS);
 	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

--------------84577076693BE99D2FC32024--

