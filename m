Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbRE1JDR>; Mon, 28 May 2001 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbRE1JDH>; Mon, 28 May 2001 05:03:07 -0400
Received: from noc242.toshiba-eng.co.jp ([210.254.22.242]:43403 "EHLO
	noc4.toshiba-eng.co.jp") by vger.kernel.org with ESMTP
	id <S263002AbRE1JDE>; Mon, 28 May 2001 05:03:04 -0400
Date: Mon, 28 May 2001 18:02:54 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd oops; still happens with 2.4.5ac2
Message-Id: <20010528180254.380908d8.masaruk@gol.com>
In-Reply-To: <20010528102551.N11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk>
	<20010527192650.H11981@niksula.cs.hut.fi>
	<20010528001220.M11981@niksula.cs.hut.fi>
	<20010528102551.N11981@niksula.cs.hut.fi>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001 10:25:51 +0300
Ville Herva <vherva@mail.niksula.cs.hut.fi> wrote:
> The oops call trace seems to be the same as in 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2
> 
> Any ideas?

Did you try the patch posted by Go Taniguchi <go@turbolinux.co.jp>?
Following is the copy of his message and the patch itself.

--
Masaru Kawashima

=====================================================================
From: Go Taniguchi <go@turbolinux.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH]initrd unmount problem
Date: 	Mon, 28 May 2001 13:26:20 +0900
Sender: linux-kernel-owner@vger.kernel.org
Organization: Turbolinx Inc.
X-Mailer: Mozilla 4.75 [ja] (X11; U; Linux 2.2.18-10 i686)

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


