Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVBRMpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVBRMpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRMpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:45:16 -0500
Received: from soundwarez.org ([217.160.171.123]:49356 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261352AbVBRMpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:45:04 -0500
Date: Fri, 18 Feb 2005 13:45:03 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, david@fubar.dk
Subject: Re: [PATCH] add I/O error uevent for block devices
Message-ID: <20050218124503.GA7705@vrfy.org>
References: <20050218083316.GA6619@vrfy.org> <20050218014621.0b453232.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218014621.0b453232.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 01:46:21AM -0800, Andrew Morton wrote:
> Kay Sievers <kay.sievers@vrfy.org> wrote:
> >
> > For HAL we want to get notified about I/O errors of block devices.
> >  This is especially useful for devices we are unable to poll and
> >  therefore can't know if something goes wrong here.

> - buffer_io_error() is called from interrupt context, and
>   kobject_uevent() does multiple GFP_KERNEL allocations.  You'll need to
>   use kobject_uevent_atomic().

Fixed.

> - the prink_ratelimit() fix in end_buffer_async_read() should be a
>   separate patch, really.  I'll fix that up.

Removed that part.

> - there are numerous other places where an I/O error can be detected:
>   grep the tree for b_end_io and bio_end_io.

You mean the mmap and direct-io stuff?

Thanks,
Kay

-----
For HAL we want to get notified about I/O errors of block devices.
This is especially useful for devices we are unable to poll and
therefore can't know if something goes wrong here.

Signed-off-by: David Zeuthen <david@fubar.dk>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== fs/buffer.c 1.270 vs edited =====
--- 1.270/fs/buffer.c	2005-01-21 06:02:13 +01:00
+++ edited/fs/buffer.c	2005-02-18 13:00:18 +01:00
@@ -105,6 +105,7 @@ static void buffer_io_error(struct buffe
 	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
 			bdevname(bh->b_bdev, b),
 			(unsigned long long)bh->b_blocknr);
+	kobject_uevent_atomic(&bh->b_bdev->bd_disk->kobj, KOBJ_IO_ERROR, NULL);
 }
 
 /*
===== include/linux/kobject_uevent.h 1.6 vs edited =====
--- 1.6/include/linux/kobject_uevent.h	2004-11-08 20:43:30 +01:00
+++ edited/include/linux/kobject_uevent.h	2005-02-18 12:59:18 +01:00
@@ -29,6 +29,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
+	KOBJ_IO_ERROR	= (__force kobject_action_t) 0x08,	/* I/O error for devices */
 };
 
 
===== lib/kobject_uevent.c 1.18 vs edited =====
--- 1.18/lib/kobject_uevent.c	2005-01-08 06:44:13 +01:00
+++ edited/lib/kobject_uevent.c	2005-02-18 12:59:18 +01:00
@@ -44,6 +44,8 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_IO_ERROR:
+		return "io_error";
 	default:
 		return NULL;
 	}

