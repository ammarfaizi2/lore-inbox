Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUHDVYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUHDVYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267437AbUHDVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:24:38 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:30479 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267436AbUHDVYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:24:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [4 of 6]
Date: Wed, 4 Aug 2004 16:24:20 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436095@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [4 of 6]
Thread-index: AcR6aWddeDJoUsO/SKCpcOObk1SDXQ==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 21:24:20.0789 (UTC) FILETIME=[67FB3E50:01C47A69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 6
Name: p004_cyl_calc_fix_for_268rc2-2.patch

This patch fixes our cylinder calculations so they match fdisk and
other utilities.
Applies to 2.6.8-rc2. Please apply in order.

Thanks,
mikem
------------------------------------------------------------------------------
diff -burpN lx268-rc2-p003/drivers/block/cciss.c lx268-rc2-test/drivers/block/cciss.c
--- lx268-rc2-p003/drivers/block/cciss.c        2004-08-04 15:55:14.612491784 -0500
+++ lx268-rc2-test/drivers/block/cciss.c        2004-08-04 16:08:31.350369216 -0500
@@ -1472,6 +1472,8 @@ static void cciss_geometry_inquiry(int c
                        drv->sectors = 32; // Sectors per track
                        drv->cylinders = total_size / 255 / 32;
                } else {
+                       unsigned int t;
+
                        drv->block_size = block_size;
                        drv->nr_blocks = total_size;
                        drv->heads = inq_buff->data_byte[6];
@@ -1479,6 +1481,10 @@ static void cciss_geometry_inquiry(int c
                        drv->cylinders = (inq_buff->data_byte[4] & 0xff) << 8;
                        drv->cylinders += inq_buff->data_byte[5];
                        drv->raid_level = inq_buff->data_byte[8];
+                       t = drv->heads * drv->sectors;
+                       if (t > 1) {
+                               drv->cylinders = total_size/t;
+                       }
                }
        } else { /* Get geometry failed */
                printk(KERN_WARNING "cciss: reading geometry failed, "
