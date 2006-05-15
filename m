Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWEOUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWEOUJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWEOUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:09:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34450 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965209AbWEOUJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:09:17 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 May 2006 22:06:37 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/4 resend] sbp2: add read_capacity workaround for iPod
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.c18c8124a53a8d1d@s5r6.in-berlin.de>
Message-ID: <tkrat.7e87b6d07dda409e@s5r6.in-berlin.de>
References: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
 <tkrat.c18c8124a53a8d1d@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.876) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apple decided to copy some USB stupidity over to FireWire.
The sector number returned by iPods from read_capacity is one too many.
This may cause I/O errors, especially if the kernel is configured for EFI
partition support. We use the same workaround as usb-storage but have to
check for different model IDs.
http://marc.theaimsgroup.com/?t=114233262300001
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=187409

Acknowledgements: Diagnosis and therapy by Mathieu Chouquet-Stringer
<ml2news@free.fr>, additional data about affected and unaffected Apple
hardware from Vladimir Kotal, Sander De Graaf, Bryan Olmstead, Hugh Dixon.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
First posted on 2006-03-19, updated on 2006-04-14 (more iPods added).
This patch is already in -mm.

Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.h	2006-05-15 21:48:38.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.h	2006-05-15 21:51:13.000000000 +0200
@@ -238,6 +238,7 @@ struct sbp2_status_block {
 #define SBP2_WORKAROUND_128K_MAX_TRANS	0x1
 #define SBP2_WORKAROUND_INQUIRY_36	0x2
 #define SBP2_WORKAROUND_MODE_SENSE_8	0x4
+#define SBP2_WORKAROUND_FIX_CAPACITY	0x8
 
 /* This is the two dma types we use for cmd_dma below */
 enum cmd_dma_types {
Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.c	2006-05-15 21:48:38.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.c	2006-05-15 21:51:13.000000000 +0200
@@ -151,6 +151,11 @@ MODULE_PARM_DESC(exclusive_login, "Exclu
  * - skip mode page 8
  *   Suppress sending of mode_sense for mode page 8 if the device pretends to
  *   support the SCSI Primary Block commands instead of Reduced Block Commands.
+ *
+ * - fix capacity
+ *   Tell sd_mod to correct the last sector number reported by read_capacity.
+ *   Avoids access beyond actual disk limits on devices with an off-by-one bug.
+ *   Don't use this with devices which don't have this bug.
  */
 static int sbp2_default_workarounds;
 module_param_named(workarounds, sbp2_default_workarounds, int, 0644);
@@ -158,6 +163,7 @@ MODULE_PARM_DESC(workarounds, "Work arou
 	", 128kB max transfer = " __stringify(SBP2_WORKAROUND_128K_MAX_TRANS)
 	", 36 byte inquiry = "    __stringify(SBP2_WORKAROUND_INQUIRY_36)
 	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
+	", fix capacity = "       __stringify(SBP2_WORKAROUND_FIX_CAPACITY)
 	", or a combination)");
 
 /* legacy parameter */
@@ -291,6 +297,7 @@ static struct hpsb_protocol_driver sbp2_
  */
 static const struct {
 	u32 firmware_revision;
+	u32 model_id;
 	unsigned workarounds;
 } sbp2_workarounds_table[] = {
 	/* TSB42AA9 */ {
@@ -305,6 +312,31 @@ static const struct {
 	/* Symbios bridge */ {
 		.firmware_revision	= 0xa0b800,
 		.workarounds		= SBP2_WORKAROUND_128K_MAX_TRANS,
+	},
+	/*
+	 * Note about the following Apple iPod blacklist entries:
+	 *
+	 * There are iPods (2nd gen, 3rd gen) with model_id==0.  Since our
+	 * matching logic treats 0 as a wildcard, we cannot match this ID
+	 * without rewriting the matching routine.  Fortunately these iPods
+	 * do not feature the read_capacity bug according to one report.
+	 * Read_capacity behaviour as well as model_id could change due to
+	 * Apple-supplied firmware updates though.
+	 */
+	/* iPod 4th generation */ {
+		.firmware_revision	= 0x0a2700,
+		.model_id		= 0x000021,
+		.workarounds		= SBP2_WORKAROUND_FIX_CAPACITY,
+	},
+	/* iPod mini */ {
+		.firmware_revision	= 0x0a2700,
+		.model_id		= 0x000023,
+		.workarounds		= SBP2_WORKAROUND_FIX_CAPACITY,
+	},
+	/* iPod Photo */ {
+		.firmware_revision	= 0x0a2700,
+		.model_id		= 0x00007e,
+		.workarounds		= SBP2_WORKAROUND_FIX_CAPACITY,
 	}
 };
 
@@ -1556,18 +1588,25 @@ static void sbp2_parse_unit_directory(st
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
-		if (sbp2_workarounds_table[i].firmware_revision !=
+		if (sbp2_workarounds_table[i].firmware_revision &&
+		    sbp2_workarounds_table[i].firmware_revision !=
 		    (firmware_revision & 0xffff00))
 			continue;
+		if (sbp2_workarounds_table[i].model_id &&
+		    sbp2_workarounds_table[i].model_id != ud->model_id)
+			continue;
 		workarounds |= sbp2_workarounds_table[i].workarounds;
 		break;
 	}
 
 	if (workarounds)
-		SBP2_INFO("Workarounds for node " NODE_BUS_FMT ": "
-			  "0x%x (firmware_revision 0x%x)",
+		SBP2_INFO("Workarounds for node " NODE_BUS_FMT ": 0x%x "
+			  "(firmware_revision 0x%06x, vendor_id 0x%06x,"
+			  " model_id 0x%06x)",
 			  NODE_BUS_ARGS(ud->ne->host, ud->ne->nodeid),
-			  workarounds, firmware_revision);
+			  workarounds, firmware_revision,
+			  ud->vendor_id ? ud->vendor_id : ud->ne->vendor_id,
+			  ud->model_id);
 
 	/* We would need one SCSI host template for each target to adjust
 	 * max_sectors on the fly, therefore warn only. */
@@ -2488,6 +2527,8 @@ static int sbp2scsi_slave_configure(stru
 	if (sdev->type == TYPE_DISK &&
 	    scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)
 		sdev->skip_ms_page_8 = 1;
+	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
+		sdev->fix_capacity = 1;
 	return 0;
 }
 


