Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWJEAbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWJEAbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWJEAbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:31:52 -0400
Received: from zoot.lnxi.com ([63.145.151.20]:6831 "EHLO zoot.lnxi.com")
	by vger.kernel.org with ESMTP id S1751263AbWJEAbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:31:51 -0400
Date: Wed, 4 Oct 2006 18:31:46 -0600
From: Ryan Jackson <rjackson@lnxi.com>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MTD] CHIPS: Support for SST 49LF040B flash chip
Message-ID: <20061005003145.GG3345@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add CFI and JEDEC probe support for the SST 49LF040B flash chip.

Signed-off-by: Ryan Jackson <rjackson@lnxi.com>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    8 ++++++--
 drivers/mtd/chips/jedec_probe.c     |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index a482e89..0e90176 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -48,6 +48,7 @@ #define MANUFACTURER_AMD	0x0001
 #define MANUFACTURER_ATMEL	0x001F
 #define MANUFACTURER_SST	0x00BF
 #define SST49LF004B	        0x0060
+#define SST49LF040B	        0x0050
 #define SST49LF008A		0x005a
 #define AT49BV6416		0x00d6
 
@@ -232,6 +233,7 @@ #endif
 };
 static struct cfi_fixup jedec_fixup_table[] = {
 	{ MANUFACTURER_SST, SST49LF004B, fixup_use_fwh_lock, NULL, },
+	{ MANUFACTURER_SST, SST49LF040B, fixup_use_fwh_lock, NULL, },
 	{ MANUFACTURER_SST, SST49LF008A, fixup_use_fwh_lock, NULL, },
 	{ 0, 0, NULL, NULL }
 };
@@ -518,10 +520,12 @@ static int get_chip(struct map_info *map
 		if (mode == FL_WRITING) /* FIXME: Erase-suspend-program appears broken. */
 			goto sleep;
 
-		if (!(mode == FL_READY || mode == FL_POINT
+		if (!(   mode == FL_READY
+		      || mode == FL_POINT
 		      || !cfip
 		      || (mode == FL_WRITING && (cfip->EraseSuspend & 0x2))
-		      || (mode == FL_WRITING && (cfip->EraseSuspend & 0x1))))
+		      || (mode == FL_WRITING && (cfip->EraseSuspend & 0x1)
+		    )))
 			goto sleep;
 
 		/* We could check to see if we're trying to access the sector
diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 1154dac..63d1287 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -154,6 +154,7 @@ #define SST39LF040	0x00D7
 #define SST39SF010A	0x00B5
 #define SST39SF020A	0x00B6
 #define SST49LF004B	0x0060
+#define SST49LF040B	0x0050
 #define SST49LF008A	0x005a
 #define SST49LF030A	0x001C
 #define SST49LF040A	0x0051
@@ -1401,6 +1402,20 @@ static const struct amd_flash_info jedec
 		}
 	}, {
 		.mfr_id		= MANUFACTURER_SST,
+		.dev_id         = SST49LF040B,
+		.name           = "SST 49LF040B",
+		.uaddr          = {
+			[0] = MTD_UADDR_0x5555_0x2AAA /* x8 */
+		},
+		.DevSize        = SIZE_512KiB,
+		.CmdSet         = P_ID_AMD_STD,
+		.NumEraseRegions= 1,
+		.regions        = {
+			ERASEINFO(0x01000,128),
+		}
+	}, {
+
+		.mfr_id		= MANUFACTURER_SST,
 		.dev_id		= SST49LF004B,
 		.name		= "SST 49LF004B",
  		.uaddr		= {
-- 
1.4.2.1

