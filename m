Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbUCYWgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUCYWey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:34:54 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:17934 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263694AbUCYWds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:33:48 -0500
Date: Thu, 25 Mar 2004 16:46:41 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update for 2.6
Message-ID: <20040325224641.GE4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this patch for inclusion in the 2.6 kernel.

If no device is attached we now return -ENXIO instead of some bogus numbers.
Prevents applications from trying to access non-existent disks.
Also adds HDIO_GETGEO_BIG IOCTL that fdisk uses.

 cciss.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)
------------------------------------------------------------------------------
diff -burpN lx265-rc2.orig/drivers/block/cciss.c lx265-rc2-test2/drivers/block/cciss.c
--- lx265-rc2.orig/drivers/block/cciss.c	2004-03-12 10:10:47.000000000 -0600
+++ lx265-rc2-test2/drivers/block/cciss.c	2004-03-25 16:28:40.000000000 -0600
@@ -469,18 +469,30 @@ static int cciss_ioctl(struct inode *ino
                         driver_geo.heads = drv->heads;
                         driver_geo.sectors = drv->sectors;
                         driver_geo.cylinders = drv->cylinders;
-                } else {
-                        driver_geo.heads = 0xff;
-                        driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = (int)drv->nr_blocks / (0xff*0x3f);
-                }
+                } else 
+			return -ENXIO;
                 driver_geo.start= get_start_sect(inode->i_bdev);
                 if (copy_to_user((void *) arg, &driver_geo,
                                 sizeof( struct hd_geometry)))
                         return  -EFAULT;
                 return(0);
 	}
-
+        case HDIO_GETGEO_BIG:
+	{
+		struct hd_big_geometry driver_geo;
+		if (hba[ctlr]->drv[dsk].cylinders) {
+			driver_geo.heads = hba[ctlr]->drv[dsk].heads;
+			driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
+			driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
+			} else
+				return -ENXIO;
+			driver_geo.start=
+			hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect;
+			if (copy_to_user((void *) arg, &driver_geo,
+					sizeof( struct hd_big_geometry)))
+				return  -EFAULT;
+			return 0;
+	}
 	case CCISS_GETPCIINFO:
 	{
 		cciss_pci_info_struct pciinfo;
