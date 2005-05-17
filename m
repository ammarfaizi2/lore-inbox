Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVEQEl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEQEl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEQEjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:39:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:19692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261684AbVEQEhr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:37:47 -0400
Cc: petero2@telia.com
Subject: [PATCH] Fix root hole in pktcdvd
In-Reply-To: <11163046681444@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 16 May 2005 21:37:49 -0700
Message-Id: <11163046692974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix root hole in pktcdvd

ioctl_by_bdev may only be used INSIDE the kernel.  If the "arg" argument
refers to memory that is accessed by put_user/get_user in the ioctl
function, the memory needs to be in the kernel address space (that's the
set_fs(KERNEL_DS) doing in the ioctl_by_bdev).  This works on i386 because
even with set_fs(KERNEL_DS) the user space memory is still accessible with
put_user/get_user.  That is not true for s390.  In short the ioctl
implementation of the pktcdvd device driver is horribly broken.

Signed-off-by: Peter Osterlund <petero2@telia.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 118326e940bdecef6c459d42ccf05256ba86daa7
tree 13b1e48f4f3700603ed258c41e9e39978babf5ee
parent 68f66feb300423bb9ee5daecb1951af394425a38
author Peter Osterlund <petero2@telia.com> Sat, 14 May 2005 00:58:30 -0700
committer Greg KH <gregkh@suse.de> Mon, 16 May 2005 21:07:31 -0700

 drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: drivers/block/pktcdvd.c
===================================================================
--- ae5ce87f061f76da06cb78ce5c9cf3c8284fc0fc/drivers/block/pktcdvd.c  (mode:100644)
+++ 13b1e48f4f3700603ed258c41e9e39978babf5ee/drivers/block/pktcdvd.c  (mode:100644)
@@ -2406,7 +2406,7 @@
 	case CDROM_LAST_WRITTEN:
 	case CDROM_SEND_PACKET:
 	case SCSI_IOCTL_SEND_COMMAND:
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	case CDROMEJECT:
 		/*
@@ -2414,7 +2414,7 @@
 		 * have to unlock it or else the eject command fails.
 		 */
 		pkt_lock_door(pd, 0);
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:
 		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);

