Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUFVU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUFVU2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUFVUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:25:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:31914 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265265AbUFVUWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:22:42 -0400
Subject: [PATCH] radeonfb: Fix panel detection on some laptops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087935369.1855.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 15:16:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The code in radeonfb looking for the BIOS image currently uses the
BIOS ROM if any, and falls back to the RAM image if not found. This
is unfortunatly not correct for a bunch of laptops where the real
panel data are only present in the RAM image.

This works around this problem by preferring the RAM image on mobility
chipsets. This is definitely not the best workaround, we need some arch
support for linking the RAM image to the PCI ID (preferrably by having
the arch snapshot it during boot, isolating us completely from the details
of where this image is in memory). I'll see how we can get such
an improvement later.

Please apply,

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== drivers/video/aty/radeon_base.c 1.20 vs edited =====
--- 1.20/drivers/video/aty/radeon_base.c	2004-06-18 11:36:48 -05:00
+++ edited/drivers/video/aty/radeon_base.c	2004-06-22 15:11:16 -05:00
@@ -2268,9 +2268,17 @@
 
 	/*
 	 * Map the BIOS ROM if any and retreive PLL parameters from
-	 * either BIOS or Open Firmware
+	 * the BIOS. We skip that on mobility chips as the real panel
+	 * values we need aren't in the ROM but in the BIOS image in
+	 * memory. This is definitely not the best meacnism though,
+	 * we really need the arch code to tell us which is the "primary"
+	 * video adapter to use the memory image (or better, the arch
+	 * should provide us a copy of the BIOS image to shield us from
+	 * archs who would store that elsewhere and/or could initialize
+	 * more than one adapter during boot).
 	 */
-	radeon_map_ROM(rinfo, pdev);
+	if (!rinfo->is_mobility)
+		radeon_map_ROM(rinfo, pdev);
 
 	/*
 	 * On x86, the primary display on laptop may have it's BIOS
@@ -2282,6 +2290,12 @@
 	if (rinfo->bios_seg == NULL)
 		radeon_find_mem_vbios(rinfo);
 #endif /* __i386__ */
+
+	/* If both above failed, try the BIOS ROM again for mobility
+	 * chips
+	 */
+	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
+		radeon_map_ROM(rinfo, pdev);
 
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);


