Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278985AbRKIBQ0>; Thu, 8 Nov 2001 20:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278986AbRKIBQH>; Thu, 8 Nov 2001 20:16:07 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:56035 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278985AbRKIBQE>; Thu, 8 Nov 2001 20:16:04 -0500
Date: Thu, 8 Nov 2001 17:14:42 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix 2.4.14 scanning past LUN 7
Message-ID: <20011108171442.A29813@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.14 is not scanning past LUN 7.

The setting of lun0_sl is broken in the current scsi_scan.c - if
we found a LUN 0, the just allocated SDpnt with a SDpnt->scsi_level 
of 0 is used to set lun0_sl.

With the addition of limiting the scanning past LUN 7 for SCSI-2 and
lower devices in 2.4.14, scanning does not go past LUN 7.

This patch fixes the problem.

Tested with an IBM 3542 (LSI Triton).

Also, output a little more SCSI logging information for the INQUIRY.

I'm not on linux-kernel, just linux-scsi, copy both if you reply.

-- 
Patrick Mansfield


--- linux-2.4.14/drivers/scsi/scsi_scan.c	Thu Oct 11 09:43:30 2001
+++ linux-2.4.14-lunfix/drivers/scsi/scsi_scan.c	Thu Nov  8 16:38:40 2001
@@ -41,7 +41,7 @@
 
 static void print_inquiry(unsigned char *data);
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
-		unsigned int lun, int lun0_scsi_level, 
+		unsigned int lun, int *lun0_scsi_level, 
 		unsigned int *max_scsi_dev, unsigned int *sparse_lun, 
 		Scsi_Device ** SDpnt, struct Scsi_Host *shpnt, 
 		char *scsi_result);
@@ -363,7 +363,7 @@
 			lun0_sl = SCSI_3; /* actually don't care for 0 == lun */
 		else
 			lun0_sl = find_lun0_scsi_level(channel, dev, shpnt);
-		scan_scsis_single(channel, dev, lun, lun0_sl, &max_dev_lun, 
+		scan_scsis_single(channel, dev, lun, &lun0_sl, &max_dev_lun, 
 				  &sparse_lun, &SDpnt, shpnt, scsi_result);
 		if (SDpnt != oldSDpnt) {
 
@@ -425,13 +425,11 @@
 						if ((lun0_sl < SCSI_3) && (lun > 7))
 							break;
 
-						if (!scan_scsis_single(channel, order_dev, lun, lun0_sl,
+						if (!scan_scsis_single(channel, order_dev, lun, &lun0_sl,
 							 	       &max_dev_lun, &sparse_lun, &SDpnt, shpnt,
 								       scsi_result)
 						    && !sparse_lun)
 							break;	/* break means don't probe further for luns!=0 */
-						if (SDpnt && (0 == lun))
-							lun0_sl = SDpnt->scsi_level;
 					}	/* for lun ends */
 				}	/* if this_id != id ends */
 			}	/* for dev ends */
@@ -488,7 +486,7 @@
  * Global variables used : scsi_devices(linked list)
  */
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
-		unsigned int lun, int lun0_scsi_level,
+		unsigned int lun, int *lun0_scsi_level,
 		unsigned int *max_dev_lun, unsigned int *sparse_lun, 
 		Scsi_Device ** SDpnt2, struct Scsi_Host *shpnt, 
 		char *scsi_result)
@@ -532,12 +530,15 @@
 	 * devices (and TEST_UNIT_READY to poll for media change). - Paul G.
 	 */
 
-	SCSI_LOG_SCAN_BUS(3, printk("scsi: performing INQUIRY\n"));
+	SCSI_LOG_SCAN_BUS(3, 
+		printk("scsi: INQUIRY to host %d; channel %d; id %d; lun %d\n",
+			shpnt->host_no, channel, dev, lun)
+	);
 	/*
 	 * Build an INQUIRY command block.
 	 */
 	scsi_cmd[0] = INQUIRY;
-	if ((lun > 0) && (lun0_scsi_level <= SCSI_2))
+	if ((lun > 0) && (*lun0_scsi_level <= SCSI_2))
 		scsi_cmd[1] = (lun << 5) & 0xe0;
 	else	
 		scsi_cmd[1] = 0;	/* SCSI_3 and higher, don't touch */
@@ -585,6 +586,17 @@
 	if (bflags & BLIST_SPARSELUN) {
 	  *sparse_lun = 1;
 	}
+
+	SDpnt->scsi_level = scsi_result[2] & 0x07;
+	if (SDpnt->scsi_level >= 2 ||
+	    (SDpnt->scsi_level == 1 &&
+	     (scsi_result[3] & 0x0f) == 1))
+		SDpnt->scsi_level++;
+
+	if (lun == 0) {
+		*lun0_scsi_level = SDpnt->scsi_level;
+	}
+
 	/*
 	 * Check the peripheral qualifier field - this tells us whether LUNS
 	 * are supported here or not.
@@ -666,12 +678,6 @@
 		if (sdtpnt->detect)
 			SDpnt->attached +=
 			    (*sdtpnt->detect) (SDpnt);
-
-	SDpnt->scsi_level = scsi_result[2] & 0x07;
-	if (SDpnt->scsi_level >= 2 ||
-	    (SDpnt->scsi_level == 1 &&
-	     (scsi_result[3] & 0x0f) == 1))
-		SDpnt->scsi_level++;
 
 	/*
 	 * Accommodate drivers that want to sleep when they should be in a polling
