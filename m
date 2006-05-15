Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWEOUHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWEOUHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWEOUHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:07:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:25746 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965192AbWEOUHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:07:38 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 May 2006 22:04:59 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/4 resend] 
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
Message-ID: <tkrat.c18c8124a53a8d1d@s5r6.in-berlin.de>
References: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.875) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: consolidate workarounds

Grand unification of the three types of workarounds we have so far.

The "skip mode page 8" workaround is now limited to devices which
pretend to be of TYPE_DISK instead of TYPE_RBC. This workaround is no
longer enabled for Initio bridges.

Patch update in anticipation of more workarounds:
 - Add module parameter "workarounds".
 - Deprecate parameter "force_inquiry_hack".
 - Compose the blacklist of a compound type for better readability and
   extensibility.
 - Remove a now unused #define.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
First posted on 2006-02-23, updated on 2006-03-19.
This patch is already in -mm.

Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.c	2006-05-15 21:27:04.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.c	2006-05-15 21:48:38.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
@@ -117,7 +118,8 @@ MODULE_PARM_DESC(serialize_io, "Serializ
  */
 static int max_sectors = SBP2_MAX_SECTORS;
 module_param(max_sectors, int, 0444);
-MODULE_PARM_DESC(max_sectors, "Change max sectors per I/O supported (default = 255)");
+MODULE_PARM_DESC(max_sectors, "Change max sectors per I/O supported (default = "
+		 __stringify(SBP2_MAX_SECTORS) ")");
 
 /*
  * Exclusive login to sbp2 device? In most cases, the sbp2 driver should
@@ -135,18 +137,33 @@ module_param(exclusive_login, int, 0644)
 MODULE_PARM_DESC(exclusive_login, "Exclusive login to sbp2 device (default = 1)");
 
 /*
- * SCSI inquiry hack for really badly behaved sbp2 devices. Turn this on
- * if your sbp2 device is not properly handling the SCSI inquiry command.
- * This hack makes the inquiry look more like a typical MS Windows inquiry
- * by enforcing 36 byte inquiry and avoiding access to mode_sense page 8.
+ * If any of the following workarounds is required for your device to work,
+ * please submit the kernel messages logged by sbp2 to the linux1394-devel
+ * mailing list.
  *
- * If force_inquiry_hack=1 is required for your device to work,
- * please submit the logged sbp2_firmware_revision value of this device to
- * the linux1394-devel mailing list.
- */
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
+static int sbp2_default_workarounds;
+module_param_named(workarounds, sbp2_default_workarounds, int, 0644);
+MODULE_PARM_DESC(workarounds, "Work around device bugs (default = 0"
+	", 128kB max transfer = " __stringify(SBP2_WORKAROUND_128K_MAX_TRANS)
+	", 36 byte inquiry = "    __stringify(SBP2_WORKAROUND_INQUIRY_36)
+	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
+	", or a combination)");
+
+/* legacy parameter */
 static int force_inquiry_hack;
 module_param(force_inquiry_hack, int, 0644);
-MODULE_PARM_DESC(force_inquiry_hack, "Force SCSI inquiry hack (default = 0)");
+MODULE_PARM_DESC(force_inquiry_hack, "Deprecated, use 'workarounds'");
 
 /*
  * Export information about protocols/devices supported by this driver.
@@ -266,14 +283,29 @@ static struct hpsb_protocol_driver sbp2_
 };
 
 /*
- * List of device firmwares that require the inquiry hack.
- * Yields a few false positives but did not break other devices so far.
- */
-static u32 sbp2_broken_inquiry_list[] = {
-	0x00002800,	/* Stefan Richter <stefanr@s5r6.in-berlin.de> */
-			/* DViCO Momobay CX-1 */
-	0x00000200	/* Andreas Plesch <plesch@fas.harvard.edu> */
-			/* QPS Fire DVDBurner */
+ * List of devices with known bugs.
+ *
+ * The firmware_revision field, masked with 0xffff00, is the best indicator
+ * for the type of bridge chip of a device.  It yields a few false positives
+ * but this did not break correctly behaving devices so far.
+ */
+static const struct {
+	u32 firmware_revision;
+	unsigned workarounds;
+} sbp2_workarounds_table[] = {
+	/* TSB42AA9 */ {
+		.firmware_revision	= 0x002800,
+		.workarounds		= SBP2_WORKAROUND_INQUIRY_36 |
+					  SBP2_WORKAROUND_MODE_SENSE_8,
+	},
+	/* Initio bridges, actually only needed for some older ones */ {
+		.firmware_revision	= 0x000200,
+		.workarounds		= SBP2_WORKAROUND_INQUIRY_36,
+	},
+	/* Symbios bridge */ {
+		.firmware_revision	= 0xa0b800,
+		.workarounds		= SBP2_WORKAROUND_128K_MAX_TRANS,
+	}
 };
 
 /**************************************
@@ -1450,7 +1482,8 @@ static void sbp2_parse_unit_directory(st
 	struct csr1212_dentry *dentry;
 	u64 management_agent_addr;
 	u32 command_set_spec_id, command_set, unit_characteristics,
-	    firmware_revision, workarounds;
+	    firmware_revision;
+	unsigned workarounds;
 	int i;
 
 	SBP2_DEBUG_ENTER();
@@ -1506,12 +1539,8 @@ static void sbp2_parse_unit_directory(st
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
@@ -1519,42 +1548,37 @@ static void sbp2_parse_unit_directory(st
 		}
 	}
 
-	/* This is the start of our broken device checking. We try to hack
-	 * around oddities and known defects.  */
-	workarounds = 0x0;
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
-	if ((firmware_revision & 0xffff00) ==
-			SBP2_128KB_BROKEN_FIRMWARE &&
-			(max_sectors * 512) > (128*1024)) {
-		SBP2_WARN("Node " NODE_BUS_FMT ": Bridge only supports 128KB max transfer size.",
-				NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid));
-		SBP2_WARN("WARNING: Current max_sectors setting is larger than 128KB (%d sectors)!",
-				max_sectors);
-		workarounds |= SBP2_BREAKAGE_128K_MAX_TRANSFER;
-	}
-
-	/* Check for a blacklisted set of devices that require us to force
-	 * a 36 byte host inquiry. This can be overriden as a module param
-	 * (to force all hosts).  */
-	for (i = 0; i < ARRAY_SIZE(sbp2_broken_inquiry_list); i++) {
-		if ((firmware_revision & 0xffff00) ==
-				sbp2_broken_inquiry_list[i]) {
-			SBP2_WARN("Node " NODE_BUS_FMT ": Using 36byte inquiry workaround",
-					NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid));
-			workarounds |= SBP2_BREAKAGE_INQUIRY_HACK;
-			break; /* No need to continue. */
-		}
+	workarounds = sbp2_default_workarounds;
+	if (force_inquiry_hack) {
+		SBP2_WARN("force_inquiry_hack is deprecated. "
+			  "Use parameter 'workarounds' instead.");
+		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
+		if (sbp2_workarounds_table[i].firmware_revision !=
+		    (firmware_revision & 0xffff00))
+			continue;
+		workarounds |= sbp2_workarounds_table[i].workarounds;
+		break;
+	}
+
+	if (workarounds)
+		SBP2_INFO("Workarounds for node " NODE_BUS_FMT ": "
+			  "0x%x (firmware_revision 0x%x)",
+			  NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid),
+			  workarounds, firmware_revision);
+
+	/* We would need one SCSI host template for each target to adjust
+	 * max_sectors on the fly, therefore warn only. */
+	if (workarounds & SBP2_WORKAROUND_128K_MAX_TRANS &&
+	    (max_sectors * 512) > (128 * 1024))
+		SBP2_WARN("Node " NODE_BUS_FMT ": Bridge only supports 128KB "
+			  "max transfer size. WARNING: Current max_sectors "
+			  "setting is larger than 128KB (%d sectors)",
+			  NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid),
+			  max_sectors);
+
 	/* If this is a logical unit directory entry, process the parent
 	 * to get the values. */
 	if (ud->flags & UNIT_DIRECTORY_LUN_DIRECTORY) {
@@ -2447,19 +2471,23 @@ static int sbp2scsi_slave_alloc(struct s
 
 	scsi_id->sdev = sdev;
 
-	if (force_inquiry_hack ||
-	    scsi_id->workarounds & SBP2_BREAKAGE_INQUIRY_HACK) {
+	if (scsi_id->workarounds & SBP2_WORKAROUND_INQUIRY_36)
 		sdev->inquiry_len = 36;
-		sdev->skip_ms_page_8 = 1;
-	}
 	return 0;
 }
 
 static int sbp2scsi_slave_configure(struct scsi_device *sdev)
 {
+	struct scsi_id_instance_data *scsi_id =
+		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
+
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+
+	if (sdev->type == TYPE_DISK &&
+	    scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)
+		sdev->skip_ms_page_8 = 1;
 	return 0;
 }
 
@@ -2603,7 +2631,9 @@ static int sbp2_module_init(void)
 		scsi_driver_template.cmd_per_lun = 1;
 	}
 
-	/* Set max sectors (module load option). Default is 255 sectors. */
+	if (sbp2_default_workarounds & SBP2_WORKAROUND_128K_MAX_TRANS &&
+	    (max_sectors * 512) > (128 * 1024))
+		max_sectors = 128 * 1024 / 512;
 	scsi_driver_template.max_sectors = max_sectors;
 
 	/* Register our high level driver with 1394 stack */
Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.h	2006-05-15 21:27:04.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.h	2006-05-15 21:48:38.000000000 +0200
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
 
@@ -239,6 +234,11 @@ struct sbp2_status_block {
 #define SBP2_MAX_SECTORS		255	/* Max sectors supported */
 #define SBP2_MAX_CMDS			8	/* This should be safe */
 
+/* Flags for detected oddities and brokeness */
+#define SBP2_WORKAROUND_128K_MAX_TRANS	0x1
+#define SBP2_WORKAROUND_INQUIRY_36	0x2
+#define SBP2_WORKAROUND_MODE_SENSE_8	0x4
+
 /* This is the two dma types we use for cmd_dma below */
 enum cmd_dma_types {
 	CMD_DMA_NONE,
@@ -268,10 +268,6 @@ struct sbp2_command_info {
 
 };
 
-/* A list of flags for detected oddities and brokeness. */
-#define SBP2_BREAKAGE_128K_MAX_TRANSFER		0x1
-#define SBP2_BREAKAGE_INQUIRY_HACK		0x2
-
 struct sbp2scsi_host_info;
 
 /*
@@ -345,7 +341,7 @@ struct scsi_id_instance_data {
 	struct Scsi_Host *scsi_host;
 
 	/* Device specific workarounds/brokeness */
-	u32 workarounds;
+	unsigned workarounds;
 };
 
 /* Sbp2 host data structure (one per IEEE1394 host) */
Index: linux-2.6.17-rc4/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.17-rc4.orig/Documentation/feature-removal-schedule.txt	2006-05-15 21:27:04.000000000 +0200
+++ linux-2.6.17-rc4/Documentation/feature-removal-schedule.txt	2006-05-15 21:48:38.000000000 +0200
@@ -57,6 +57,15 @@ Who:	Jody McIntyre <scjody@steamballoon.
 
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


