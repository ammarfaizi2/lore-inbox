Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWFASTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWFASTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWFASTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:19:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:7977 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750878AbWFASTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:19:22 -0400
X-IronPort-AV: i="4.05,199,1146466800"; 
   d="scan'208"; a="45575625:sNHT59900470"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>, <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
Subject: RE: + big-kernel-lock-contention-in-do_open-and-blkdev_put.patchadded to -mm tree
Date: Thu, 1 Jun 2006 11:19:20 -0700
Message-ID: <000001c685a7$e738a680$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaFU4A82aga35xUQbabUCOtBrLEEgAUfzAQ
In-Reply-To: <1149149691.3115.17.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote on Thursday, June 01, 2006 1:15 AM
> > Out of the 63 hits I see in 2.6.17-rc4 with
> > block_device_operations->open(), floppy driver seems to be the only one
> > that mucks around with a global Variable without any protection.  We can
> > add a spin lock there.
> > ---
> > 
> >  fs/block_dev.c |    6 ------
> >  1 file changed, 6 deletions(-)
> 
> the fix to floppy.c is missing!

See below for the follow on patch that adds a lock in amiga floppy
open/release method.


> (also I highly question the validity of this patch, last time the BKL
> got dropped from open quite a few rootholes got opened... )

I will be watching bug report on this.  If I miss any, I would appreciate
people forward bug report to me and I will fix it!



[patch] add BKL in amiga floppy open/release method since the generic
        block device open/release method no longer holds the BKL.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./drivers/block/amiflop.c.orig	2006-06-01 11:43:42.000000000 -0700
+++ ./drivers/block/amiflop.c	2006-06-01 12:10:23.000000000 -0700
@@ -64,6 +64,7 @@
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
+#include <linux/smp_lock.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
@@ -1591,10 +1592,21 @@ static int floppy_open(struct inode *ino
 	return 0;
 }
 
+static int floppy_open_lock(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	lock_kernel();
+	ret = floppy_open(inode, filp);
+	unlock_kernel();
+	return ret;
+}
+
 static int floppy_release(struct inode * inode, struct file * filp)
 {
 	int drive = iminor(inode) & 3;
 
+	lock_kernel();
 	if (unit[drive].dirty == 1) {
 		del_timer (flush_track_timer + drive);
 		non_int_flush_track (drive);
@@ -1608,6 +1620,7 @@ static int floppy_release(struct inode *
 /* the mod_use counter is handled this way */
 	floppy_off (drive | 0x40000000);
 #endif
+	unlock_kernel();
 	return 0;
 }
 
@@ -1647,7 +1660,7 @@ static int amiga_floppy_change(struct ge
 
 static struct block_device_operations floppy_fops = {
 	.owner		= THIS_MODULE,
-	.open		= floppy_open,
+	.open		= floppy_open_lock,
 	.release	= floppy_release,
 	.ioctl		= fd_ioctl,
 	.getgeo		= fd_getgeo,
