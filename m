Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUHJQ0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUHJQ0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHJQJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:09:21 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:42505 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267523AbUHJQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:08:30 -0400
Date: Tue, 10 Aug 2004 11:07:50 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [4/8] cylinder calculation fix
Message-ID: <20040810160750.GD19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 4 of 8

This patch fixes our cylinder calculations. Without his fix the number
of cylinders maxes out at 65535.
Aplies against 2.6.8-rc4. Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p003/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p003/drivers/block/cciss.c	2004-08-05 10:40:00.865910000 -0500
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
