Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbULCTzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbULCTzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbULCTyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:54:07 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:27802 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262482AbULCTvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:51:14 -0500
Date: Fri, 3 Dec 2004 20:51:03 +0100 (CET)
From: franz_pletz@t-online.de (Franz Pletz)
X-X-Sender: thorus@sgx.home
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Ludwig Schmidt <ludoschmidt@web.de>
Subject: [PATCH] loopback device can't act as its backing store
Message-ID: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-ID: XVWSncZdYer0JjfKTsNYD3TBqJygIlDK9JuIz9NSNRpvsnTfNKdUUr
X-TOI-MSGID: ffad04f0-5ca3-472f-aa9a-38e146dd35ed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug in loop which apparently causes the kernel to call
the initialization routine of a loopback device recursively while trying to set
the backing store to the loopback device it's being mapped to.

Ludwig Schmidt <ludoschmidt@web.de> found this misbehaviour by accident. After
having been informed by him, I analyzed the problem and wrote this patch.

You can verify this bug for instance by issuing the following command
     # mount -o loop /dev/loop0 /mnt
with /dev/loop0 being the first free loop device. You should sync before. ;-)

However, if you try setting the backing file of the loopback device using the
losetup utility, you won't experience any crash. For example:
     # losetup /dev/loop0 /dev/loop0

But as a matter of fact, the device will be busy until the next reboot. Forced
unloading of loop will succeed. But after reloading, the kernel will lock up on
any attempt accessing a loop device.
Consequently this bug needs to be resolved in any case, although it seems that
there may also be a bug in the mount utility. By looking at the source code of
mount, which ironically shares the same codebase as losetup within the
util-linux package, I couldn't find anything suspicious.

This bug is fully reproduceable on at least all recent 2.6 series kernels.
The patch below applies cleanly on 2.6.10-rc2.

Comments would be graciously appreciated as this being my first serious kernel
patch. ;-)


Signed-off-by: Franz Pletz <franz_pletz@t-online.de>

  linux/drivers/block/loop.c |    7 +++++++
   1 files changed, 7 insertions(+)

--- linux-2.6.10-rc2/drivers/block/loop.c	2004-11-25 19:56:32.000000000 +0100
+++ linux/drivers/block/loop.c	2004-12-02 23:39:43.516913144 +0100
@@ -596,6 +596,9 @@
  	old_file = lo->lo_backing_file;

  	error = -EINVAL;
+	/* new backing store mustn't be the loop device it's being mapped to */
+	if(inode->i_rdev == bdev->bd_dev)
+		goto out_putf;

  	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
  		goto out_putf;
@@ -652,6 +655,10 @@
  		lo_flags |= LO_FLAGS_READ_ONLY;

  	error = -EINVAL;
+	/* new backing store mustn't be the loop device it's being mapped to */
+	if(inode->i_rdev == bdev->bd_dev)
+		goto out_putf;
+
  	if (S_ISREG(inode->i_mode) || S_ISBLK(inode->i_mode)) {
  		struct address_space_operations *aops = mapping->a_ops;
  		/*
