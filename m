Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbSIRUFx>; Wed, 18 Sep 2002 16:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbSIRUFx>; Wed, 18 Sep 2002 16:05:53 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:29312 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S267844AbSIRUFw>; Wed, 18 Sep 2002 16:05:52 -0400
Date: Wed, 18 Sep 2002 13:11:20 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Support tera byte disk
Message-ID: <20020918131120.A5120@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For a 1.8TB SCSI HD, kernel reports:

SCSI device sda: -773086208 512-byte hdwr sectors (-395819 MB)

Here is a patch to fix it. BTW, I don't think it will work with > 2TB,
which requires bigger changes.


H.J.

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-tera.patch"

--- linux-2.4.18-14.2/drivers/scsi/sd.c.tera	Wed Sep 18 11:55:53 2002
+++ linux-2.4.18-14.2/drivers/scsi/sd.c	Wed Sep 18 12:42:36 2002
@@ -1018,8 +1018,16 @@ static int sd_init_onedisk(int i)
 			 * Jacques Gelinas (Jacques@solucorp.qc.ca)
 			 */
 			int m;
-			int hard_sector = sector_size;
-			int sz = rscsi_disks[i].capacity * (hard_sector/256);
+			unsigned hard_sector = sector_size;
+			unsigned sz = rscsi_disks[i].capacity * (hard_sector/256);
+
+			/* Check for overflow.  */
+			if (sz < rscsi_disks[i].capacity) {
+				sz = (rscsi_disks[i].capacity/1950) * (hard_sector/256);
+				sz = sz/2 - sz/1250 + 974;
+			}
+			else
+				sz = (sz/2 - sz/1250 + 974)/1950;
 
 			/* There are 16 minors allocated for each major device */
 			for (m = i << 4; m < ((i + 1) << 4); m++) {
@@ -1027,9 +1035,9 @@ static int sd_init_onedisk(int i)
 			}
 
 			printk("SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
+			       "%u %u-byte hdwr sectors (%u MB)\n",
 			       nbuff, rscsi_disks[i].capacity,
-			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+			       hard_sector, sz);
 		}
 
 		/* Rescale capacity to 512-byte units */

--oyUTqETQ0mS9luUI--
