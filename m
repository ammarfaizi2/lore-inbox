Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267873AbUHETev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267873AbUHETev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267885AbUHETev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:34:51 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:29455 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267873AbUHETeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:34:14 -0400
Subject: cciss updates [2/6] zero out buffer in passthru ioctls for HP
	utilities
From: mikem <mike.miller@hp.com>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091734413.4826.9.camel@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:33:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 6

This patch addresses a problem with our utilities.
We must zero out the buffer before copying their data into it
to prevent bogus info when switching between SCSI & SATA or SAS drives.
This patch applies to 2.6.8-rc3. Please consider this for inclusion.
Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p001/drivers/block/cciss.c
lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p001/drivers/block/cciss.c	2004-08-05 10:22:43.290646000
-0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 10:28:36.993875112 -0500
@@ -866,6 +866,8 @@ static int cciss_ioctl(struct inode *ino
 				kfree(buff);
 				return -EFAULT;
 			}
+		} else {
+			memset(buff, 0, iocommand.buf_size);
 		}
 		if ((c = cmd_alloc(host , 0)) == NULL)
 		{
@@ -1012,6 +1014,8 @@ static int cciss_ioctl(struct inode *ino
 				copy_from_user(buff[sg_used], data_ptr, sz)) {
 					status = -ENOMEM;
 					goto cleanup1;			
+			} else {
+				memset(buff[sg_used], 0, sz);
 			}
 			left -= sz;
 			data_ptr += sz;


