Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWE0NDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWE0NDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 09:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWE0NDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 09:03:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44181 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751508AbWE0NC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 09:02:59 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 27 May 2006 15:01:59 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.18 2/4] sbp2: consolidate workarounds, part two
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.0ce6aaa18134ec31@s5r6.in-berlin.de>
Message-ID: <tkrat.7f23ff12ead1dc67@s5r6.in-berlin.de>
References: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
 <tkrat.0ce6aaa18134ec31@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.882) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rest of the original patch

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
rediff for -stable, from commit 24d3bf884e093f9de52d31c97187f4b9b4ad7dcb

 Documentation/feature-removal-schedule.txt |    9 +++
 drivers/ieee1394/sbp2.c                    |   76 ++++++++++++++---------------
 drivers/ieee1394/sbp2.h                    |    9 ---
 3 files changed, 48 insertions(+), 46 deletions(-)

Index: linux-2.6.16.18/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/sbp2.h	2006-05-27 13:24:17.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/sbp2.h	2006-05-27 13:26:01.000000000 +0200
@@ -227,11 +227,6 @@ struct sbp2_status_block {
 #define SBP2_SW_VERSION_ENTRY					0x00010483
 
 /*
- * Other misc defines
- */
-#define SBP2_128KB_BROKEN_FIRMWARE				0xa0b800
-
-/*
  * SCSI specific stuff
  */
 
@@ -273,10 +268,6 @@ struct sbp2_command_info {
 
 };
 
-/* A list of flags for detected oddities and brokeness. */
-#define SBP2_BREAKAGE_128K_MAX_TRANSFER		0x1
-#define SBP2_BREAKAGE_INQUIRY_HACK		0x2
-
 struct sbp2scsi_host_info;
 
 /*
Index: linux-2.6.16.18/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/sbp2.c	2006-05-27 13:24:17.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/sbp2.c	2006-05-27 13:26:01.000000000 +0200
@@ -118,7 +118,8 @@ MODULE_PARM_DESC(serialize_io, "Serializ
  */
 static int max_sectors = SBP2_MAX_SECTORS;
 module_param(max_sectors, int, 0444);
-MODULE_PARM_DESC(max_sectors, "Change max sectors per I/O supported (default = 255)");
+MODULE_PARM_DESC(max_sectors, "Change max sectors per I/O supported (default = "
+		 __stringify(SBP2_MAX_SECTORS) ")");
 
 /*
  * Exclusive login to sbp2 device? In most cases, the sbp2 driver should
@@ -135,6 +136,22 @@ static int exclusive_login = 1;
 module_param(exclusive_login, int, 0644);
 MODULE_PARM_DESC(exclusive_login, "Exclusive login to sbp2 device (default = 1)");
 
+/*
+ * If any of the following workarounds is required for your device to work,
+ * please submit the kernel messages logged by sbp2 to the linux1394-devel
+ * mailing list.
+ *
+ * - 128kB max transfer
+ *   Limit transfer size. Necessary for some old bridges.
+ *
+ * - 36 byte inquiry
+ *   When scsi_mod probes the device, let the inquiry command look like that
+ *   from MS Windows.
+ *
+ * - skip mode page 8
+ *   Suppress sending of mode_sense for mode page 8 if the device pretends to
+ *   support the SCSI Primary Block commands instead of Reduced Block Commands.
+ */
 static int sbp2_default_workarounds;
 module_param_named(workarounds, sbp2_default_workarounds, int, 0644);
 MODULE_PARM_DESC(workarounds, "Work around device bugs (default = 0"
@@ -143,19 +160,10 @@ MODULE_PARM_DESC(workarounds, "Work arou
 	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
 	", or a combination)");
 
-/*
- * SCSI inquiry hack for really badly behaved sbp2 devices. Turn this on
- * if your sbp2 device is not properly handling the SCSI inquiry command.
- * This hack makes the inquiry look more like a typical MS Windows inquiry
- * by enforcing 36 byte inquiry and avoiding access to mode_sense page 8.
- *
- * If force_inquiry_hack=1 is required for your device to work,
- * please submit the logged sbp2_firmware_revision value of this device to
- * the linux1394-devel mailing list.
- */
+/* legacy parameter */
 static int force_inquiry_hack;
 module_param(force_inquiry_hack, int, 0644);
-MODULE_PARM_DESC(force_inquiry_hack, "Force SCSI inquiry hack (default = 0)");
+MODULE_PARM_DESC(force_inquiry_hack, "Deprecated, use 'workarounds'");
 
 /*
  * Export information about protocols/devices supported by this driver.
@@ -274,8 +282,11 @@ static struct hpsb_protocol_driver sbp2_
 };
 
 /*
- * List of device firmwares that require the inquiry hack.
- * Yields a few false positives but did not break other devices so far.
+ * List of devices with known bugs.
+ *
+ * The firmware_revision field, masked with 0xffff00, is the best indicator
+ * for the type of bridge chip of a device.  It yields a few false positives
+ * but this did not break correctly behaving devices so far.
  */
 static const struct {
 	u32 firmware_revision;
@@ -1555,12 +1566,8 @@ static void sbp2_parse_unit_directory(st
 		case SBP2_FIRMWARE_REVISION_KEY:
 			/* Firmware revision */
 			firmware_revision = kv->value.immediate;
-			if (force_inquiry_hack)
-				SBP2_INFO("sbp2_firmware_revision = %x",
-					  (unsigned int)firmware_revision);
-			else
-				SBP2_DEBUG("sbp2_firmware_revision = %x",
-					   (unsigned int)firmware_revision);
+			SBP2_DEBUG("sbp2_firmware_revision = %x",
+				   (unsigned int)firmware_revision);
 			break;
 
 		default:
@@ -1568,24 +1575,12 @@ static void sbp2_parse_unit_directory(st
 		}
 	}
 
-	/* This is the start of our broken device checking. We try to hack
-	 * around oddities and known defects.  */
 	workarounds = sbp2_default_workarounds;
-
-	/* If the vendor id is 0xa0b8 (Symbios vendor id), then we have a
-	 * bridge with 128KB max transfer size limitation. For sanity, we
-	 * only voice this when the current max_sectors setting
-	 * exceeds the 128k limit. By default, that is not the case.
-	 *
-	 * It would be really nice if we could detect this before the scsi
-	 * host gets initialized. That way we can down-force the
-	 * max_sectors to account for it. That is not currently
-	 * possible.  */
-	/* Check for a blacklisted set of devices that require us to force
-	 * a 36 byte host inquiry. This can be overriden as a module param
-	 * (to force all hosts).  */
-	if (force_inquiry_hack)
+	if (force_inquiry_hack) {
+		SBP2_WARN("force_inquiry_hack is deprecated. "
+			  "Use parameter 'workarounds' instead.");
 		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
 		if (sbp2_workarounds_table[i].firmware_revision !=
@@ -1595,6 +1590,14 @@ static void sbp2_parse_unit_directory(st
 		break;
 	}
 
+	if (workarounds)
+		SBP2_INFO("Workarounds for node " NODE_BUS_FMT ": "
+			  "0x%x (firmware_revision 0x%x)",
+			  NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid),
+			  workarounds, firmware_revision);
+
+	/* We would need one SCSI host template for each target to adjust
+	 * max_sectors on the fly, therefore warn only. */
 	if (workarounds & SBP2_WORKAROUND_128K_MAX_TRANS &&
 	    (max_sectors * 512) > (128 * 1024))
 		SBP2_WARN("Node " NODE_BUS_FMT ": Bridge only supports 128KB "
@@ -2662,7 +2665,6 @@ static int sbp2_module_init(void)
 		scsi_driver_template.cmd_per_lun = 1;
 	}
 
-	/* Set max sectors (module load option). Default is 255 sectors. */
 	if (sbp2_default_workarounds & SBP2_WORKAROUND_128K_MAX_TRANS &&
 	    (max_sectors * 512) > (128 * 1024))
 		max_sectors = 128 * 1024 / 512;
Index: linux-2.6.16.18/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.16.18.orig/Documentation/feature-removal-schedule.txt	2006-05-27 13:23:23.000000000 +0200
+++ linux-2.6.16.18/Documentation/feature-removal-schedule.txt	2006-05-27 13:26:50.000000000 +0200
@@ -56,6 +56,15 @@ Who:	Jody McIntyre <scjody@steamballoon.
 
 ---------------------------
 
+What:	sbp2: module parameter "force_inquiry_hack"
+When:	July 2006
+Why:	Superceded by parameter "workarounds". Both parameters are meant to be
+	used ad-hoc and for single devices only, i.e. not in modprobe.conf,
+	therefore the impact of this feature replacement should be low.
+Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
+
+---------------------------
+
 What:	Video4Linux API 1 ioctls and video_decoder.h from Video devices.
 When:	July 2006
 Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to 2.6


