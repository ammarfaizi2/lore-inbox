Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUHETmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUHETmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHETmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:42:20 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:63248 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S267884AbUHETis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:38:48 -0400
Subject: cciss updates [4/6] cylinder calculation fix for 2.6.8-rc3
From: mikem <mike.miller@hp.com>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091734675.4826.16.camel@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:37:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 6

This patch fixes our cylinder calculations. Without his fix the number
of cylinders maxes out at 65535.
Aplies against 2.6.8-rc3. Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p003/drivers/block/cciss.c
lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p003/drivers/block/cciss.c	2004-08-05 10:40:00.865910000
-0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 11:16:03.222182640 -0500
@@ -1470,6 +1470,8 @@ static void cciss_geometry_inquiry(int c
 			drv->sectors = 32; // Sectors per track
 			drv->cylinders = total_size / 255 / 32;
 		} else {
+			unsigned int t;
+
 			drv->block_size = block_size;
 			drv->nr_blocks = total_size;
 			drv->heads = inq_buff->data_byte[6];
@@ -1477,6 +1479,10 @@ static void cciss_geometry_inquiry(int c
 			drv->cylinders = (inq_buff->data_byte[4] & 0xff) << 8;
 			drv->cylinders += inq_buff->data_byte[5];
 			drv->raid_level = inq_buff->data_byte[8];
+			t = drv->heads * drv->sectors;
+			if (t > 1) {
+				drv->cylinders = total_size/t;
+			}
 		}
 	} else { /* Get geometry failed */
 		printk(KERN_WARNING "cciss: reading geometry failed, "


