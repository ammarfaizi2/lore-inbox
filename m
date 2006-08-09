Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWHIIzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWHIIzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWHIIzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:55:04 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:25570 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964967AbWHIIzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:55:01 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] MTD: Convert Atmel PRI information to AMD format
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 09 Aug 2006 10:54:44 +0200
Message-Id: <11551136843896-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel flash chips don't have PRI information in the same format as
AMD flash chips. This patch installs a fixup for all Atmel chips that
converts the relevant PRI fields into AMD format.

Only the fields that are actually used by the command set is actually
converted. The rest are initialized to zero (which should be safe)

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |   21 +++++++++++++++++++++
 include/linux/mtd/cfi.h             |   13 +++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 70ad7cf..9d3c5af 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -166,6 +166,26 @@ static void fixup_use_write_buffers(stru
 	}
 }
 
+/* Atmel chips don't use the same PRI format as AMD chips */
+static void fixup_convert_atmel_pri(struct mtd_info *mtd, void *param)
+{
+	struct map_info *map = mtd->priv;
+	struct cfi_private *cfi = map->fldrv_priv;
+	struct cfi_pri_amdstd *extp = cfi->cmdset_priv;
+	struct cfi_pri_atmel atmel_pri;
+
+	memcpy(&atmel_pri, extp, sizeof(atmel_pri));
+	memset(extp + 5, 0, sizeof(*extp) - 5);
+
+	if (atmel_pri.Features & 0x02)
+		extp->EraseSuspend = 2;
+
+	if (atmel_pri.BottomBoot)
+		extp->TopBottom = 2;
+	else
+		extp->TopBottom = 3;
+}
+
 static void fixup_use_secsi(struct mtd_info *mtd, void *param)
 {
 	/* Setup for chips with a secsi area */
@@ -207,6 +227,7 @@ #endif
 #if !FORCE_WORD_WRITE
 	{ CFI_MFR_ANY, CFI_ID_ANY, fixup_use_write_buffers, NULL, },
 #endif
+	{ CFI_MFR_ATMEL, CFI_ID_ANY, fixup_convert_atmel_pri, NULL },
 	{ 0, 0, NULL, NULL }
 };
 static struct cfi_fixup jedec_fixup_table[] = {
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 09bfae6..123948b 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -199,6 +199,18 @@ struct cfi_pri_amdstd {
 	uint8_t  TopBottom;
 } __attribute__((packed));
 
+/* Vendor-Specific PRI for Atmel chips (command set 0x0002) */
+
+struct cfi_pri_atmel {
+	uint8_t pri[3];
+	uint8_t MajorVersion;
+	uint8_t MinorVersion;
+	uint8_t Features;
+	uint8_t BottomBoot;
+	uint8_t BurstMode;
+	uint8_t PageMode;
+} __attribute__((packed));
+
 struct cfi_pri_query {
 	uint8_t  NumFields;
 	uint32_t ProtField[1]; /* Not host ordered */
@@ -464,6 +476,7 @@ #define CFI_MFR_ANY 0xffff
 #define CFI_ID_ANY  0xffff
 
 #define CFI_MFR_AMD 0x0001
+#define CFI_MFR_ATMEL 0x001F
 #define CFI_MFR_ST  0x0020 	/* STMicroelectronics */
 
 void cfi_fixup(struct mtd_info *mtd, struct cfi_fixup* fixups);
-- 
1.4.0

