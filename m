Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUHDVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUHDVHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUHDVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:07:39 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:52742 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267424AbUHDVHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:07:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [3 of 6]
Date: Wed, 4 Aug 2004 16:06:56 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436094@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [3 of 6]
Thread-index: AcR6Zvf77wpuDNNmTE6H4E5kSuBGXA==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 21:07:00.0237 (UTC) FILETIME=[FBC39BD0:01C47A66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 6
Name: p003_proc_fixes_for_268rc2.patch

This patch fixes our calculations for volume size displayed in /proc. There was some
truncation going on that resulted in volume sizes of 0. Also changed GB to 1000^3.
That's the value disk makers use.
Also fixes the RAID level display.
Please consider this for inclusion. Patch applies to 2.6.8-rc2.
Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------------
diff -burpN lx268-rc2-p002/drivers/block/cciss.c lx268-rc2-p003/drivers/block/cciss.c
--- lx268-rc2-p002/drivers/block/cciss.c        2004-07-30 11:19:33.000000000 -0500
+++ lx268-rc2-p003/drivers/block/cciss.c        2004-08-04 11:29:45.796928760 -0500
@@ -191,10 +191,10 @@ static inline CommandList_struct *remove
 /*
  * Report information about this controller.
  */
-#define ENG_GIG 1048576000
+#define ENG_GIG 1000000000
 #define ENG_GIG_FACTOR (ENG_GIG/512)
 #define RAID_UNKNOWN 6
-static const char *raid_label[] = {"0","4","1(0+1)","5","5+1","ADG",
+static const char *raid_label[] = {"0","4","1(1+0)","5","5+1","ADG",
                                           "UNKNOWN"};

 static struct proc_dir_entry *proc_cciss;
@@ -208,7 +208,7 @@ static int cciss_proc_get_info(char *buf
         ctlr_info_t *h = (ctlr_info_t*)data;
         drive_info_struct *drv;
        unsigned long flags;
-       unsigned int vol_sz, vol_sz_frac;
+        sector_t vol_sz, vol_sz_frac;

         ctlr = h->ctlr;

@@ -245,32 +245,21 @@ static int cciss_proc_get_info(char *buf
         pos += size; len += size;
        cciss_proc_tape_report(ctlr, buffer, &pos, &len);
        for(i=0; i<=h->highest_lun; i++) {
-               sector_t tmp;

                 drv = &h->drv[i];
                if (drv->block_size == 0)
                        continue;
-               vol_sz = drv->nr_blocks;
-               sector_div(vol_sz, ENG_GIG_FACTOR);
-
-               /*
-                * Awkwardly do this:
-                * vol_sz_frac =
-                *     (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;
-                */
-               tmp = drv->nr_blocks;
-               vol_sz_frac = sector_div(tmp, ENG_GIG_FACTOR);
-
-               /* Now, vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR) */

+               vol_sz = drv->nr_blocks;
+               vol_sz_frac = sector_div(vol_sz, ENG_GIG_FACTOR);
                vol_sz_frac *= 100;
                sector_div(vol_sz_frac, ENG_GIG_FACTOR);

                if (drv->raid_level > 5)
                        drv->raid_level = RAID_UNKNOWN;
                size = sprintf(buffer+len, "cciss/c%dd%d:"
-                               "\t%4d.%02dGB\tRAID %s\n",
-                               ctlr, i, vol_sz,vol_sz_frac,
+                               "\t%4u.%02uGB\tRAID %s\n",
+                               ctlr, i, (int)vol_sz, (int)vol_sz_frac,
                                raid_label[drv->raid_level]);
                 pos += size; len += size;
         }
@@ -1489,6 +1478,7 @@ static void cciss_geometry_inquiry(int c
                        drv->sectors = inq_buff->data_byte[7];
                        drv->cylinders = (inq_buff->data_byte[4] & 0xff) << 8;
                        drv->cylinders += inq_buff->data_byte[5];
+                       drv->raid_level = inq_buff->data_byte[8];
                }
        } else { /* Get geometry failed */
                printk(KERN_WARNING "cciss: reading geometry failed, "
m
