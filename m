Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUHFSC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUHFSC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHFSCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:02:12 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:19717 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268227AbUHFSA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:00:57 -0400
Date: Thu, 5 Aug 2004 16:28:03 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates again [4/6] cylinder calc fixes for 2.6.8-rc3
Message-ID: <20040805212803.GC6578@beardog.americas.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 4 of 6

This patch fixes our cylinder calculations. Without his fix the number
of cylinders maxes out at 65535.
Aplies against 2.6.8-rc3. Please apply patches in order.

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
