Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUHJQOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUHJQOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUHJQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:10:51 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:9222 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267503AbUHJQGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:06:39 -0400
Date: Tue, 10 Aug 2004 11:05:56 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [3/8] /proc fixes for RAID level & size
Message-ID: <20040810160556.GC19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 3 of 8

This patch fixes our output in /proc to display the logical volume
sizes and RAID levels correctly. Without this patch RAID level will
always be 0 and size may be displayed as 0GB.
Applies to 2.6.8-rc4. Please apply in order.
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p002/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p002/drivers/block/cciss.c	2004-08-05 10:28:36.993875000 -0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 10:40:00.865910760 -0500
@@ -192,10 +192,10 @@ static inline CommandList_struct *remove
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
@@ -209,7 +209,7 @@ static int cciss_proc_get_info(char *buf
         ctlr_info_t *h = (ctlr_info_t*)data;
         drive_info_struct *drv;
 	unsigned long flags;
-	unsigned int vol_sz, vol_sz_frac;
+        sector_t vol_sz, vol_sz_frac;
 
         ctlr = h->ctlr;
 
@@ -246,32 +246,21 @@ static int cciss_proc_get_info(char *buf
         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
 	for(i=0; i<=h->highest_lun; i++) {
-		sector_t tmp;
 
                 drv = &h->drv[i];
 		if (drv->block_size == 0)
 			continue;
-		vol_sz = drv->nr_blocks;
-		sector_div(vol_sz, ENG_GIG_FACTOR);
-
-		/*
-		 * Awkwardly do this:
-		 * vol_sz_frac =
-		 *     (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;
-		 */
-		tmp = drv->nr_blocks;
-		vol_sz_frac = sector_div(tmp, ENG_GIG_FACTOR);
-
-		/* Now, vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR) */
 
+		vol_sz = drv->nr_blocks;
+		vol_sz_frac = sector_div(vol_sz, ENG_GIG_FACTOR);
 		vol_sz_frac *= 100;
 		sector_div(vol_sz_frac, ENG_GIG_FACTOR);
 
 		if (drv->raid_level > 5)
 			drv->raid_level = RAID_UNKNOWN;
 		size = sprintf(buffer+len, "cciss/c%dd%d:"
-				"\t%4d.%02dGB\tRAID %s\n",
-				ctlr, i, vol_sz,vol_sz_frac,
+				"\t%4u.%02uGB\tRAID %s\n",
+				ctlr, i, (int)vol_sz, (int)vol_sz_frac,
 				raid_label[drv->raid_level]);
                 pos += size; len += size;
         }
@@ -1487,6 +1476,7 @@ static void cciss_geometry_inquiry(int c
 			drv->sectors = inq_buff->data_byte[7];
 			drv->cylinders = (inq_buff->data_byte[4] & 0xff) << 8;
 			drv->cylinders += inq_buff->data_byte[5];
+			drv->raid_level = inq_buff->data_byte[8];
 		}
 	} else { /* Get geometry failed */
 		printk(KERN_WARNING "cciss: reading geometry failed, "
