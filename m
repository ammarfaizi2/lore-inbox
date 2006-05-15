Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWEOUKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWEOUKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWEOUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:10:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43410 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965184AbWEOUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:10:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 May 2006 22:08:09 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3/4 resend] sbp2: add ability to override hardwired blacklist
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.7e87b6d07dda409e@s5r6.in-berlin.de>
Message-ID: <tkrat.621eda7433bd0a08@s5r6.in-berlin.de>
References: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
 <tkrat.c18c8124a53a8d1d@s5r6.in-berlin.de>
 <tkrat.7e87b6d07dda409e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.045) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case the blacklist with workarounds for device bugs yields a false
positive, the module load parameter can now also be used as an override
instead of an addition to the blacklist.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
First posted on 2006-04-14.
This patch is already in -mm.

Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.h	2006-05-15 21:51:13.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.h	2006-05-15 21:52:18.000000000 +0200
@@ -239,6 +239,7 @@ struct sbp2_status_block {
 #define SBP2_WORKAROUND_INQUIRY_36	0x2
 #define SBP2_WORKAROUND_MODE_SENSE_8	0x4
 #define SBP2_WORKAROUND_FIX_CAPACITY	0x8
+#define SBP2_WORKAROUND_OVERRIDE	0x100
 
 /* This is the two dma types we use for cmd_dma below */
 enum cmd_dma_types {
Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.c	2006-05-15 21:51:13.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.c	2006-05-15 21:52:18.000000000 +0200
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
@@ -1587,17 +1593,18 @@ static void sbp2_parse_unit_directory(st
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


