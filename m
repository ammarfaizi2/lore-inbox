Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVBRIdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVBRIdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 03:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBRIdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 03:33:37 -0500
Received: from soundwarez.org ([217.160.171.123]:17329 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261301AbVBRIdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 03:33:21 -0500
Date: Fri, 18 Feb 2005 09:33:16 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, David Zeuthen <david@fubar.dk>
Subject: [PATCH] add I/O error uevent for block devices
Message-ID: <20050218083316.GA6619@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For HAL we want to get notified about I/O errors of block devices.
This is especially useful for devices we are unable to poll and
therefore can't know if something goes wrong here.

Signed-off-by: David Zeuthen <david@fubar.dk>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== fs/buffer.c 1.270 vs edited =====
--- 1.270/fs/buffer.c	2005-01-21 06:02:13 +01:00
+++ edited/fs/buffer.c	2005-02-17 22:56:05 +01:00
@@ -105,6 +105,7 @@ static void buffer_io_error(struct buffe
 	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
 			bdevname(bh->b_bdev, b),
 			(unsigned long long)bh->b_blocknr);
+	kobject_uevent(&bh->b_bdev->bd_disk->kobj, KOBJ_IO_ERROR, NULL);
 }
 
 /*
@@ -550,7 +551,8 @@ static void end_buffer_async_read(struct
 		set_buffer_uptodate(bh);
 	} else {
 		clear_buffer_uptodate(bh);
-		buffer_io_error(bh);
+		if (printk_ratelimit())
+			buffer_io_error(bh);
 		SetPageError(page);
 	}
 
===== include/linux/kobject_uevent.h 1.6 vs edited =====
--- 1.6/include/linux/kobject_uevent.h	2004-11-08 20:43:30 +01:00
+++ edited/include/linux/kobject_uevent.h	2005-02-17 23:10:05 +01:00
@@ -29,6 +29,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
+	KOBJ_IO_ERROR	= (__force kobject_action_t) 0x08,	/* I/O error for devices */
 };
 
 
===== lib/kobject_uevent.c 1.18 vs edited =====
--- 1.18/lib/kobject_uevent.c	2005-01-08 06:44:13 +01:00
+++ edited/lib/kobject_uevent.c	2005-02-17 22:52:03 +01:00
@@ -44,6 +44,8 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_IO_ERROR:
+		return "io_error";
 	default:
 		return NULL;
 	}

