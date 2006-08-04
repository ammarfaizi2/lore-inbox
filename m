Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWHDIbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWHDIbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWHDIbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:31:20 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:49652 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161105AbWHDIbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:31:19 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] MTD: Add lock/unlock operations for Atmel AT49BV6416
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Fri, 04 Aug 2006 10:28:34 +0200
Message-Id: <1154680114836-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11546801142874-git-send-email-hskinnemoen@atmel.com>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AT49BV6416 is locked by default, so we really need to provide
at least the unlock() operation for write and erase to work. This
patch implements both ->lock() and ->unlock() and provides a fixup
to install them when an AT49BV6416 chip is detected.

These functions are probably valid on more Atmel chips, but I don't
know exactly which ones. I can find out and add them if anyone cares.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---

Now, I'm not quite sure how to use this to make the flash usable for
jffs2, etc. At the moment, it works if I unlock the flash using the
flash_unlock utility before mounting a jffs2 file system, but this
obviously won't work when using jffs2 as a root file system.

What's the best way to do this? Unlock the flash in the board-specific
mapping driver perhaps?

Haavard

 drivers/mtd/chips/cfi_cmdset_0002.c |   90 +++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 9885726..70ad7cf 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -45,9 +45,11 @@ #define FORCE_WORD_WRITE 0
 #define MAX_WORD_RETRIES 3
 
 #define MANUFACTURER_AMD	0x0001
+#define MANUFACTURER_ATMEL	0x001F
 #define MANUFACTURER_SST	0x00BF
 #define SST49LF004B	        0x0060
 #define SST49LF008A		0x005a
+#define AT49BV6416		0x00d6
 
 static int cfi_amdstd_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_amdstd_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
@@ -68,6 +70,9 @@ static int get_chip(struct map_info *map
 static void put_chip(struct map_info *map, struct flchip *chip, unsigned long adr);
 #include "fwh_lock.h"
 
+static int cfi_atmel_lock(struct mtd_info *mtd, loff_t ofs, size_t len);
+static int cfi_atmel_unlock(struct mtd_info *mtd, loff_t ofs, size_t len);
+
 static struct mtd_chip_driver cfi_amdstd_chipdrv = {
 	.probe		= NULL, /* Not usable directly */
 	.destroy	= cfi_amdstd_destroy,
@@ -179,6 +184,16 @@ static void fixup_use_erase_chip(struct 
 
 }
 
+/*
+ * Some Atmel chips (e.g. the AT49BV6416) power-up with all sectors
+ * locked by default.
+ */
+static void fixup_use_atmel_lock(struct mtd_info *mtd, void *param)
+{
+	mtd->lock = cfi_atmel_lock;
+	mtd->unlock = cfi_atmel_unlock;
+}
+
 static struct cfi_fixup cfi_fixup_table[] = {
 #ifdef AMD_BOOTLOC_BUG
 	{ CFI_MFR_AMD, CFI_ID_ANY, fixup_amd_bootblock, NULL },
@@ -197,6 +212,7 @@ #endif
 static struct cfi_fixup jedec_fixup_table[] = {
 	{ MANUFACTURER_SST, SST49LF004B, fixup_use_fwh_lock, NULL, },
 	{ MANUFACTURER_SST, SST49LF008A, fixup_use_fwh_lock, NULL, },
+	{ MANUFACTURER_ATMEL, AT49BV6416, fixup_use_atmel_lock, NULL },
 	{ 0, 0, NULL, NULL }
 };
 
@@ -1607,6 +1623,80 @@ static int cfi_amdstd_erase_chip(struct 
 	return 0;
 }
 
+static int do_atmel_lock(struct map_info *map, struct flchip *chip,
+			 unsigned long adr, int len, void *thunk)
+{
+	struct cfi_private *cfi = map->fldrv_priv;
+	int ret;
+
+	spin_lock(chip->mutex);
+	ret = get_chip(map, chip, adr + chip->start, FL_LOCKING);
+	if (ret)
+		goto out_unlock;
+	chip->state = FL_LOCKING;
+
+	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): adr 0x%08lx len %d\n",
+	      __func__, adr, len);
+
+	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	cfi_send_gen_cmd(0x80, cfi->addr_unlock1, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	map_write(map, CMD(0x40), chip->start + adr);
+
+	chip->state = FL_READY;
+	put_chip(map, chip, adr + chip->start);
+	ret = 0;
+
+out_unlock:
+	spin_unlock(chip->mutex);
+	return ret;
+}
+
+static int do_atmel_unlock(struct map_info *map, struct flchip *chip,
+			   unsigned long adr, int len, void *thunk)
+{
+	struct cfi_private *cfi = map->fldrv_priv;
+	int ret;
+
+	spin_lock(chip->mutex);
+	ret = get_chip(map, chip, adr + chip->start, FL_UNLOCKING);
+	if (ret)
+		goto out_unlock;
+	chip->state = FL_UNLOCKING;
+
+	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): adr 0x%08lx len %d\n",
+	      __func__, adr, len);
+
+	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
+			 cfi->device_type, NULL);
+	map_write(map, CMD(0x70), adr);
+
+	chip->state = FL_READY;
+	put_chip(map, chip, adr + chip->start);
+	ret = 0;
+
+out_unlock:
+	spin_unlock(chip->mutex);
+	return ret;
+}
+
+static int cfi_atmel_lock(struct mtd_info *mtd, loff_t ofs, size_t len)
+{
+	return cfi_varsize_frob(mtd, do_atmel_lock, ofs, len, NULL);
+}
+
+static int cfi_atmel_unlock(struct mtd_info *mtd, loff_t ofs, size_t len)
+{
+	return cfi_varsize_frob(mtd, do_atmel_unlock, ofs, len, NULL);
+}
+
 
 static void cfi_amdstd_sync (struct mtd_info *mtd)
 {
-- 
1.4.0

