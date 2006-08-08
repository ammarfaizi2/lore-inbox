Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWHHPjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWHHPjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWHHPjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:39:48 -0400
Received: from the.earth.li ([193.201.200.66]:15326 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S964963AbWHHPjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:39:47 -0400
Date: Tue, 8 Aug 2006 16:39:44 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [MTD] NAND: Fix ams-delta after core conversion
Message-ID: <20060808153944.GA8126@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent hwctrl core conversion for MTD NAND devices broke the Amstrad
Delta driver. This fixes it up and uses the existing control line
defines rather than unclear magic numbers.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index d7897dc..a0ba07c 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -130,11 +130,13 @@ static void ams_delta_hwcontrol(struct m
 	if (ctrl & NAND_CTRL_CHANGE) {
 		unsigned long bits;
 
-		bits = (~ctrl & NAND_NCE) << 2;
-		bits |= (ctrl & NAND_CLE) << 7;
-		bits |= (ctrl & NAND_ALE) << 6;
+		bits = (~ctrl & NAND_NCE) ? AMS_DELTA_LATCH2_NAND_NCE : 0;
+		bits |= (ctrl & NAND_CLE) ? AMS_DELTA_LATCH2_NAND_CLE : 0;
+		bits |= (ctrl & NAND_ALE) ? AMS_DELTA_LATCH2_NAND_ALE : 0;
 
-		ams_delta_latch2_write(0xC2, bits);
+		ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_CLE |
+				AMS_DELTA_LATCH2_NAND_ALE |
+				AMS_DELTA_LATCH2_NAND_NCE, bits);
 	}
 
 	if (cmd != NAND_CMD_NONE)
-----

J.

-- 
] http://www.earth.li/~noodles/ []     "Hand me that solar-powered     [
]  PGP/GPG Key @ the.earth.li   []           flashlight..."            [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
