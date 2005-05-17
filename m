Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVEQEim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVEQEim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEQEim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:38:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:19180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261678AbVEQEhp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:37:45 -0400
Cc: sct@redhat.com
Subject: [PATCH] Fix root hole in raw device
In-Reply-To: <11163046682662@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 16 May 2005 21:37:48 -0700
Message-Id: <11163046681444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix root hole in raw device

[Patch] Fix raw device ioctl pass-through

Raw character devices are supposed to pass ioctls through to the block
devices they are bound to.  Unfortunately, they are using the wrong
function for this: ioctl_by_bdev(), instead of blkdev_ioctl().

ioctl_by_bdev() performs a set_fs(KERNEL_DS) before calling the ioctl,
redirecting the user-space buffer access to the kernel address space.
This is, needless to say, a bad thing.

This was noticed first on s390, where raw IO was non-functioning.  The
s390 driver config does not actually allow raw IO to be enabled, which
was the first part of the problem.  Secondly, the s390 kernel address
space is distinct from user, causing legal raw ioctls to fail.  I've
reproduced this on a kernel built with 4G:4G split on x86, which fails
in the same way (-EFAULT if the address does not exist kernel-side;
returns success without actually populating the user buffer if it does.)

The patch below fixes both the config and address-space problems.  It's
based closely on a patch by Jan Glauber <jang@de.ibm.com>, which has
been tested on s390 at IBM.  I've tested it on x86 4G:4G (split address
space) and x86_64 (common address space).

Kernel-address-space access has been assigned CAN-2005-1264.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 68f66feb300423bb9ee5daecb1951af394425a38
tree ae5ce87f061f76da06cb78ce5c9cf3c8284fc0fc
parent a84a505956f5c795a9ab3d60d97b6b91a27aa571
author Stephen Tweedie <sct@redhat.com> Fri, 13 May 2005 23:31:19 -0400
committer Greg KH <gregkh@suse.de> Mon, 16 May 2005 21:07:21 -0700

 drivers/block/ioctl.c |    2 ++
 drivers/char/raw.c    |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: drivers/block/ioctl.c
===================================================================
--- 440fdf47fcddf8b0d615667b418981a511d16e30/drivers/block/ioctl.c  (mode:100644)
+++ ae5ce87f061f76da06cb78ce5c9cf3c8284fc0fc/drivers/block/ioctl.c  (mode:100644)
@@ -237,3 +237,5 @@
 	}
 	return ret;
 }
+
+EXPORT_SYMBOL_GPL(blkdev_ioctl);
Index: drivers/char/raw.c
===================================================================
--- 440fdf47fcddf8b0d615667b418981a511d16e30/drivers/char/raw.c  (mode:100644)
+++ ae5ce87f061f76da06cb78ce5c9cf3c8284fc0fc/drivers/char/raw.c  (mode:100644)
@@ -122,7 +122,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return ioctl_by_bdev(bdev, command, arg);
+	return blkdev_ioctl(bdev->bd_inode, filp, command, arg);
 }
 
 static void bind_device(struct raw_config_request *rq)

