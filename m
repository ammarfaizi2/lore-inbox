Return-Path: <linux-kernel-owner+w=401wt.eu-S964884AbXADPFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbXADPFq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbXADPFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:05:46 -0500
Received: from usul.saidi.cx ([204.11.33.34]:53047 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964884AbXADPFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:05:45 -0500
Message-ID: <459D178F.8000607@overt.org>
Date: Thu, 04 Jan 2007 07:04:47 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>
CC: Alex Dubov <oakad@yahoo.com>, Pavel Pisa <ppisa@pikron.com>
Subject: [PATCH 2.6.19] mmc: Fix handling of response types in imxmmc and
 tifm drivers
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change depends on my SDHC patch and fixes a bug that was revealed during the
development of that patch. The R6 response type should be identical to R1 (and R7)
but was incorrectly defined differently. Fixing the R6 definition breaks assumptions
in these two drivers that response type flags are unique. Pierre and Alex both
believe that treating R6 and R7 as R1 will be sufficient. ie: The controllers do
not care about the differences between them. Due to lack of hardware, I have done
no testing.

Signed-off-by: Philip Langdale <philipl@overt.org>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Pavel Pisa <ppisa@pikron.com>
---
 drivers/mmc/imxmmc.c    |    3 ---
 drivers/mmc/omap.c      |    2 +-
 drivers/mmc/pxamci.c    |    2 +-
 drivers/mmc/tifm_sd.c   |    3 ---
 include/linux/mmc/mmc.h |    2 +-
 5 files changed, 3 insertions(+), 9 deletions(-)

diff -ur linux-2.6.19-sdhc/drivers/mmc/imxmmc.c linux-2.6.19-rspfix/drivers/mmc/imxmmc.c
--- linux-2.6.19-sdhc/drivers/mmc/imxmmc.c	2007-01-04 06:52:12.000000000 -0800
+++ linux-2.6.19-rspfix/drivers/mmc/imxmmc.c	2007-01-04 06:53:16.000000000 -0800
@@ -351,9 +351,6 @@
 	case MMC_RSP_R3: /* short */
 		cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R3;
 		break;
-	case MMC_RSP_R6: /* short CRC */
-		cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R6;
-		break;
 	default:
 		break;
 	}
diff -ur linux-2.6.19-sdhc/drivers/mmc/omap.c linux-2.6.19-rspfix/drivers/mmc/omap.c
--- linux-2.6.19-sdhc/drivers/mmc/omap.c	2007-01-04 06:52:12.000000000 -0800
+++ linux-2.6.19-rspfix/drivers/mmc/omap.c	2007-01-04 05:46:24.000000000 -0800
@@ -206,7 +206,7 @@
 	/* Our hardware needs to know exact type */
 	switch (RSP_TYPE(mmc_resp_type(cmd))) {
 	case RSP_TYPE(MMC_RSP_R1):
-		/* resp 1, resp 1b */
+		/* resp 1, 1b, 6, 7 */
 		resptype = 1;
 		break;
 	case RSP_TYPE(MMC_RSP_R2):
diff -ur linux-2.6.19-sdhc/drivers/mmc/pxamci.c linux-2.6.19-rspfix/drivers/mmc/pxamci.c
--- linux-2.6.19-sdhc/drivers/mmc/pxamci.c	2007-01-04 06:52:12.000000000 -0800
+++ linux-2.6.19-rspfix/drivers/mmc/pxamci.c	2007-01-04 05:46:36.000000000 -0800
@@ -171,7 +171,7 @@

 #define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
 	switch (RSP_TYPE(mmc_resp_type(cmd))) {
-	case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6 */
+	case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6, r7 */
 		cmdat |= CMDAT_RESP_SHORT;
 		break;
 	case RSP_TYPE(MMC_RSP_R3):
diff -ur linux-2.6.19-sdhc/drivers/mmc/tifm_sd.c linux-2.6.19-rspfix/drivers/mmc/tifm_sd.c
--- linux-2.6.19-sdhc/drivers/mmc/tifm_sd.c	2007-01-04 06:52:12.000000000 -0800
+++ linux-2.6.19-rspfix/drivers/mmc/tifm_sd.c	2007-01-04 06:53:38.000000000 -0800
@@ -173,9 +173,6 @@
 	case MMC_RSP_R3:
 		rc |= TIFM_MMCSD_RSP_R3;
 		break;
-	case MMC_RSP_R6:
-		rc |= TIFM_MMCSD_RSP_R6;
-		break;
 	default:
 		BUG();
 	}
diff -ur linux-2.6.19-sdhc/include/linux/mmc/mmc.h linux-2.6.19-rspfix/include/linux/mmc/mmc.h
--- linux-2.6.19-sdhc/include/linux/mmc/mmc.h	2007-01-04 06:51:09.000000000 -0800
+++ linux-2.6.19-rspfix/include/linux/mmc/mmc.h	2007-01-04 05:41:49.000000000 -0800
@@ -42,7 +42,7 @@
 #define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_PRESENT)
-#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
+#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
