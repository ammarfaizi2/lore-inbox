Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWDNNAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDNNAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 09:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDNNAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 09:00:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:3293 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751242AbWDNNAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 09:00:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 14 Apr 2006 15:00:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 4/4] sbp2: add ability to override hardwired blacklist
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, Jody McIntyre <scjody@modernduck.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.69177281aa563e69@s5r6.in-berlin.de>
Message-ID: <tkrat.89199526a110d4b4@s5r6.in-berlin.de>
References: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
 <tkrat.f5439c0f83c7da87@s5r6.in-berlin.de>
 <tkrat.2b0bd1ffd757d1b9@s5r6.in-berlin.de>
 <tkrat.69177281aa563e69@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.057) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: add ability to override hardwired blacklist

In case the blacklist with workarounds for device bugs yields a false
positive, the module load parameter can now also be used as an override
instead of an addition to the blacklist.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

 drivers/ieee1394/sbp2.c |   29 ++++++++++++++++++-----------
 drivers/ieee1394/sbp2.h |    1 +
 2 files changed, 19 insertions(+), 11 deletions(-)


Index: linux-2.6.17-rc1/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc1.orig/drivers/ieee1394/sbp2.h	2006-04-14 13:20:13.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ieee1394/sbp2.h	2006-04-14 13:20:27.000000000 +0200
@@ -239,6 +239,7 @@ struct sbp2_status_block {
 #define SBP2_WORKAROUND_INQUIRY_36	0x2
 #define SBP2_WORKAROUND_MODE_SENSE_8	0x4
 #define SBP2_WORKAROUND_FIX_CAPACITY	0x8
+#define SBP2_WORKAROUND_OVERRIDE	0x100
 
 /* This is the two dma types we use for cmd_dma below */
 enum cmd_dma_types {
Index: linux-2.6.17-rc1/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/ieee1394/sbp2.c	2006-04-14 13:20:22.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ieee1394/sbp2.c	2006-04-14 13:20:27.000000000 +0200
@@ -156,6 +156,11 @@ MODULE_PARM_DESC(exclusive_login, "Exclu
  *   Tell sd_mod to correct the last sector number reported by read_capacity.
  *   Avoids access beyond actual disk limits on devices with an off-by-one bug.
  *   Don't use this with devices which don't have this bug.
+ *
+ * - override internal blacklist
+ *   Instead of adding to the built-in blacklist, use only the workarounds
+ *   specified in the module load parameter.
+ *   Useful if a blacklist entry interfered with a non-broken device.
  */
 static int sbp2_default_workarounds;
 module_param_named(workarounds, sbp2_default_workarounds, int, 0644);
@@ -164,6 +169,7 @@ MODULE_PARM_DESC(workarounds, "Work arou
 	", 36 byte inquiry = "    __stringify(SBP2_WORKAROUND_INQUIRY_36)
 	", skip mode page 8 = "   __stringify(SBP2_WORKAROUND_MODE_SENSE_8)
 	", fix capacity = "       __stringify(SBP2_WORKAROUND_FIX_CAPACITY)
+	", override internal blacklist = " __stringify(SBP2_WORKAROUND_OVERRIDE)
 	", or a combination)");
 
 /* legacy parameter */
@@ -1588,17 +1594,18 @@ static void sbp2_parse_unit_directory(st
 		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
-		if (sbp2_workarounds_table[i].firmware_revision &&
-		    sbp2_workarounds_table[i].firmware_revision !=
-		    (firmware_revision & 0xffff00))
-			continue;
-		if (sbp2_workarounds_table[i].model_id &&
-		    sbp2_workarounds_table[i].model_id != ud->model_id)
-			continue;
-		workarounds |= sbp2_workarounds_table[i].workarounds;
-		break;
-	}
+	if (!(workarounds & SBP2_WORKAROUND_OVERRIDE))
+		for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
+			if (sbp2_workarounds_table[i].firmware_revision &&
+			    sbp2_workarounds_table[i].firmware_revision !=
+			    (firmware_revision & 0xffff00))
+				continue;
+			if (sbp2_workarounds_table[i].model_id &&
+			    sbp2_workarounds_table[i].model_id != ud->model_id)
+				continue;
+			workarounds |= sbp2_workarounds_table[i].workarounds;
+			break;
+		}
 
 	if (workarounds)
 		SBP2_INFO("Workarounds for node " NODE_BUS_FMT ": 0x%x "


