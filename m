Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277781AbRJRQB2>; Thu, 18 Oct 2001 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJRQBS>; Thu, 18 Oct 2001 12:01:18 -0400
Received: from lapi0061.lss.emc.com ([168.159.28.61]:6278 "EHLO
	lapi0061.lss.emc.com") by vger.kernel.org with ESMTP
	id <S277781AbRJRQAz>; Thu, 18 Oct 2001 12:00:55 -0400
To: Gary_Lerhaupt@Dell.com, Kevin_Burroughs@Dell.com,
        linux-kernel@vger.kernel.org, mbrown@emc.com, Michael_E_Brown@Dell.com,
        robert_macaulay@Dell.com
Subject: [PATCH] Add BLIST_SCSI2_8LUN flag (2.4.13-pre4)
Message-Id: <E15uFfi-0004lL-00@lapi0061.lss.emc.com>
From: "Michael F. Brown" <mbrown@emc.com>
Date: Thu, 18 Oct 2001 12:05:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My recent patch preventing scan_scsis() from sending INQUIRY's
to SCSI_2 devices at LUN > 7 showed up in linux-2.4.13-pre2.  It
does not take into account non-standard SCSI_2 devices which support
LUN > 7 (i.e. Dell PV 650F).  The following patch generated against
linux-2.4.13-pre4 adds a new 'BLIST_SCSI2_8LUN' for such devices.
Without this patch users of 2.4.13 and CLARiiON storage may discover
they are missing devices.  Folks at Dell have verified the patch
fixes the issue.  This was posted a few days ago to linux-scsi but
it hasn't shown up as of linux-2.4.13-pre4.  Please apply for 2.4.13.

-Michael F. Brown, EMC Corp.

Email:            mbrown@emc.com

"In theory, there is no difference between theory and practice,
 but in practice, there is."       - Jan L.A. van de Snepscheut

--- linux-2.4.13-pre4/drivers/scsi/scsi_scan.c	Thu Oct 18 11:38:47 2001
+++ linux/drivers/scsi/scsi_scan.c	Thu Oct 18 11:39:26 2001
@@ -38,6 +38,7 @@
 #define BLIST_MAX5LUN		0x080
 #define BLIST_ISDISK    	0x100
 #define BLIST_ISROM     	0x200
+#define BLIST_SCSI2_8LUN	0x400 /* SCSI_2 devices supporting LUN > 7 */
 
 static void print_inquiry(unsigned char *data);
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
@@ -146,12 +147,12 @@
  	{"TOSHIBA","CDROM","*", BLIST_ISROM},
  	{"TOSHIBA","CD-ROM","*", BLIST_ISROM},
 	{"MegaRAID", "LD", "*", BLIST_FORCELUN},
-	{"DGC",  "RAID",      "*", BLIST_SPARSELUN}, // Dell PV 650F (tgt @ LUN 0)
-	{"DGC",  "DISK",      "*", BLIST_SPARSELUN}, // Dell PV 650F (no tgt @ LUN 0) 
-	{"DELL", "PV660F",   "*", BLIST_SPARSELUN},
-	{"DELL", "PV660F   PSEUDO",   "*", BLIST_SPARSELUN},
-	{"DELL", "PSEUDO DEVICE .",   "*", BLIST_SPARSELUN}, // Dell PV 530F
-	{"DELL", "PV530F",    "*", BLIST_SPARSELUN}, // Dell PV 530F
+	{"DGC",  "RAID",      "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN}, // Dell PV 650F (tgt @ LUN 0)
+	{"DGC",  "DISK",      "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN}, // Dell PV 650F (no tgt @ LUN 0)
+	{"DELL", "PV660F",   "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN},
+	{"DELL", "PV660F   PSEUDO",   "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN},
+	{"DELL", "PSEUDO DEVICE .",   "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN}, // Dell PV 530F
+	{"DELL", "PV530F",    "*", BLIST_SPARSELUN | BLIST_SCSI2_8LUN}, // Dell PV 530F
 	{"EMC", "SYMMETRIX", "*", BLIST_SPARSELUN},
 	{"CMD", "CRA-7280", "*", BLIST_SPARSELUN},   // CMD RAID Controller
 	{"CNSI", "G7324", "*", BLIST_SPARSELUN},     // Chaparral G7324 RAID
@@ -421,10 +422,6 @@
 					 max_scsi_luns : shpnt->max_lun);
 					sparse_lun = 0;
 					for (lun = 0, lun0_sl = SCSI_2; lun < max_dev_lun; ++lun) {
-						/* don't probe further for luns > 7 for targets <= SCSI_2 */
-						if ((lun0_sl < SCSI_3) && (lun > 7))
-							break;
-
 						if (!scan_scsis_single(channel, order_dev, lun, lun0_sl,
 							 	       &max_dev_lun, &sparse_lun, &SDpnt, shpnt,
 								       scsi_result)
@@ -432,6 +429,13 @@
 							break;	/* break means don't probe further for luns!=0 */
 						if (SDpnt && (0 == lun))
 							lun0_sl = SDpnt->scsi_level;
+
+						/* don't probe further for luns > 7 for targets <= SCSI_2
+						 * except for BLIST_SCSI2_8LUN devices
+						 */
+						if (((lun0_sl < SCSI_3) && (lun >= 7)) &&
+						   !(get_device_flags (scsi_result) & BLIST_SCSI2_8LUN))
+							break;
 					}	/* for lun ends */
 				}	/* if this_id != id ends */
 			}	/* for dev ends */
