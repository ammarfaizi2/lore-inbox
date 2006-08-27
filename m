Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWH0L37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWH0L37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWH0L37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:29:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40429 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750953AbWH0L36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:29:58 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 27 Aug 2006 13:26:50 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write protect
 bit of Initio firmware
To: Linus Torvalds <torvalds@osdl.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
Message-ID: <tkrat.94cecc462a778dde@s5r6.in-berlin.de>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another mode pages related bug of Initio firmwares was seen.
INIC-1530 with a firmware by Initio responded with garbage to MODE SENSE
(10).  Some HDDs were therefore incorrectly marked as write protected:
http://bugzilla.kernel.org/show_bug.cgi?id=6947

Sbp2 now tells scsi_lib to use MODE SENSE (6) for the one known
defective model.  The workaround could be expanded to other or perhaps
even all model IDs of Initio firmwares if necessary.  At least it worked
OK with an INIC-2430 with different model ID and without the MS(10) bug.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.h	2006-08-27 12:27:55.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.h	2006-08-27 12:35:40.000000000 +0200
@@ -237,8 +237,9 @@ struct sbp2_status_block {
 /* Flags for detected oddities and brokeness */
 #define SBP2_WORKAROUND_128K_MAX_TRANS	0x1
 #define SBP2_WORKAROUND_INQUIRY_36	0x2
-#define SBP2_WORKAROUND_MODE_SENSE_8	0x4
+#define SBP2_WORKAROUND_SKIP_PAGE_08	0x4
 #define SBP2_WORKAROUND_FIX_CAPACITY	0x8
+#define SBP2_WORKAROUND_MODE_SENSE_6	0x10
 #define SBP2_WORKAROUND_OVERRIDE	0x100
 
 /* This is the two dma types we use for cmd_dma below */
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.c	2006-08-27 12:27:59.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.c	2006-08-27 12:35:40.000000000 +0200
@@ -168,8 +168,9 @@ module_param_named(workarounds, sbp2_def
 MODULE_PARM_DESC(workarounds, "Work around device bugs (default = 0"
 	", 128kB max transfer = " __stringify(SBP2_WORKAROUND_128K_MAX_TRANS)
 	", 36 byte inquiry = "    __stringify(SBP2_WORKAROUND_INQUIRY_36)
-	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
+	", skip mode page 08 = "  __stringify(SBP2_WORKAROUND_SKIP_PAGE_08)
 	", fix capacity = "       __stringify(SBP2_WORKAROUND_FIX_CAPACITY)
+	", use mode sense 6 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_6)
 	", override internal blacklist = " __stringify(SBP2_WORKAROUND_OVERRIDE)
 	", or a combination)");
 
@@ -301,6 +302,10 @@ static struct hpsb_protocol_driver sbp2_
  * The firmware_revision field, masked with 0xffff00, is the best indicator
  * for the type of bridge chip of a device.  It yields a few false positives
  * but this did not break correctly behaving devices so far.
+ *
+ * The order of table entries is from special to general, like for example
+ * the Initio entries.  This order is necessary because once an entry matches,
+ * the rest of the table is skipped.
  */
 static const struct {
 	u32 firmware_revision;
@@ -311,7 +316,12 @@ static const struct {
 		.firmware_revision	= 0x002800,
 		.model_id		= 0x001010,
 		.workarounds		= SBP2_WORKAROUND_INQUIRY_36 |
-					  SBP2_WORKAROUND_MODE_SENSE_8,
+					  SBP2_WORKAROUND_SKIP_PAGE_08,
+	},
+	/* Initio INIC-1530 with a firmware apparently from Initio */ {
+		.firmware_revision	= 0x000200,
+		.model_id		= 0x000540,
+		.workarounds		= SBP2_WORKAROUND_MODE_SENSE_6,
 	},
 	/* Initio bridges, actually only needed for some older ones */ {
 		.firmware_revision	= 0x000200,
@@ -2511,10 +2521,12 @@ static int sbp2scsi_slave_configure(stru
 	sdev->use_10_for_ms = 1;
 
 	if (sdev->type == TYPE_DISK &&
-	    scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)
+	    scsi_id->workarounds & SBP2_WORKAROUND_SKIP_PAGE_08)
 		sdev->skip_ms_page_8 = 1;
 	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
 		sdev->fix_capacity = 1;
+	if (scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_6)
+		sdev->use_10_for_ms = 0;
 	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
 	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
 		sdev->allow_restart = 1;


