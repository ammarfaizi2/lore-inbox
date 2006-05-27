Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWE0NBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWE0NBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 09:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWE0NBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 09:01:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40085 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751505AbWE0NBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 09:01:48 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 27 May 2006 15:00:30 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.18 1/4] sbp2: consolidate workarounds, part one
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
Message-ID: <tkrat.0ce6aaa18134ec31@s5r6.in-berlin.de>
References: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.881) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch is required for the subsequent patch "sbp2: add read_capacity
workaround for iPod". For better readability, the patch is split into
the functional part (this one) and a merely cosmetic part (following).

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
rediff for -stable, from commit 24d3bf884e093f9de52d31c97187f4b9b4ad7dcb

 drivers/ieee1394/sbp2.c |   86 +++++++++++++++++++++++++++++++-----------------
 drivers/ieee1394/sbp2.h |    7 +++
 2 files changed, 63 insertions(+), 30 deletions(-)

Index: linux-2.6.16.18/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/sbp2.h	2006-05-27 13:23:24.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/sbp2.h	2006-05-27 13:24:17.000000000 +0200
@@ -239,6 +239,11 @@ struct sbp2_status_block {
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
@@ -345,7 +350,7 @@ struct scsi_id_instance_data {
 	struct Scsi_Host *scsi_host;
 
 	/* Device specific workarounds/brokeness */
-	u32 workarounds;
+	unsigned workarounds;
 };
 
 /* Sbp2 host data structure (one per IEEE1394 host) */
Index: linux-2.6.16.18/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/sbp2.c	2006-05-27 13:23:50.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/sbp2.c	2006-05-27 13:24:17.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
@@ -134,6 +135,14 @@ static int exclusive_login = 1;
 module_param(exclusive_login, int, 0644);
 MODULE_PARM_DESC(exclusive_login, "Exclusive login to sbp2 device (default = 1)");
 
+static int sbp2_default_workarounds;
+module_param_named(workarounds, sbp2_default_workarounds, int, 0644);
+MODULE_PARM_DESC(workarounds, "Work around device bugs (default = 0"
+	", 128kB max transfer = " __stringify(SBP2_WORKAROUND_128K_MAX_TRANS)
+	", 36 byte inquiry = "    __stringify(SBP2_WORKAROUND_INQUIRY_36)
+	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
+	", or a combination)");
+
 /*
  * SCSI inquiry hack for really badly behaved sbp2 devices. Turn this on
  * if your sbp2 device is not properly handling the SCSI inquiry command.
@@ -268,11 +277,23 @@ static struct hpsb_protocol_driver sbp2_
  * List of device firmwares that require the inquiry hack.
  * Yields a few false positives but did not break other devices so far.
  */
-static u32 sbp2_broken_inquiry_list[] = {
-	0x00002800,	/* Stefan Richter <stefanr@s5r6.in-berlin.de> */
-			/* DViCO Momobay CX-1 */
-	0x00000200	/* Andreas Plesch <plesch@fas.harvard.edu> */
-			/* QPS Fire DVDBurner */
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
@@ -1477,7 +1498,8 @@ static void sbp2_parse_unit_directory(st
 	struct csr1212_dentry *dentry;
 	u64 management_agent_addr;
 	u32 command_set_spec_id, command_set, unit_characteristics,
-	    firmware_revision, workarounds;
+	    firmware_revision;
+	unsigned workarounds;
 	int i;
 
 	SBP2_DEBUG("sbp2_parse_unit_directory");
@@ -1548,7 +1570,7 @@ static void sbp2_parse_unit_directory(st
 
 	/* This is the start of our broken device checking. We try to hack
 	 * around oddities and known defects.  */
-	workarounds = 0x0;
+	workarounds = sbp2_default_workarounds;
 
 	/* If the vendor id is 0xa0b8 (Symbios vendor id), then we have a
 	 * bridge with 128KB max transfer size limitation. For sanity, we
@@ -1559,29 +1581,28 @@ static void sbp2_parse_unit_directory(st
 	 * host gets initialized. That way we can down-force the
 	 * max_sectors to account for it. That is not currently
 	 * possible.  */
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
 	/* Check for a blacklisted set of devices that require us to force
 	 * a 36 byte host inquiry. This can be overriden as a module param
 	 * (to force all hosts).  */
-	for (i = 0; i < ARRAY_SIZE(sbp2_broken_inquiry_list); i++) {
-		if ((firmware_revision & 0xffff00) ==
-				sbp2_broken_inquiry_list[i]) {
-			SBP2_WARN("Node " NODE_BUS_FMT ": Using 36byte inquiry workaround",
-					NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid));
-			workarounds |= SBP2_BREAKAGE_INQUIRY_HACK;
-			break; /* No need to continue. */
-		}
+	if (force_inquiry_hack)
+		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
+
+	for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
+		if (sbp2_workarounds_table[i].firmware_revision !=
+		    (firmware_revision & 0xffff00))
+			continue;
+		workarounds |= sbp2_workarounds_table[i].workarounds;
+		break;
 	}
 
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
@@ -2481,19 +2502,23 @@ static int sbp2scsi_slave_alloc(struct s
 
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
 
@@ -2638,6 +2663,9 @@ static int sbp2_module_init(void)
 	}
 
 	/* Set max sectors (module load option). Default is 255 sectors. */
+	if (sbp2_default_workarounds & SBP2_WORKAROUND_128K_MAX_TRANS &&
+	    (max_sectors * 512) > (128 * 1024))
+		max_sectors = 128 * 1024 / 512;
 	scsi_driver_template.max_sectors = max_sectors;
 
 	/* Register our high level driver with 1394 stack */


