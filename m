Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbWHIJGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWHIJGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbWHIJGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:06:24 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:17352 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030595AbWHIJGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:06:23 -0400
Date: Wed, 9 Aug 2006 11:06:07 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD: Add lock/unlock operations for Atmel AT49BV6416
Message-ID: <20060809110607.244db551@cad-250-152.norway.atmel.com>
In-Reply-To: <1154680873.31031.182.camel@shinybook.infradead.org>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	<1154680114836-git-send-email-hskinnemoen@atmel.com>
	<1154680873.31031.182.camel@shinybook.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 16:41:12 +0800
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2006-08-04 at 10:28 +0200, Haavard Skinnemoen wrote:
> > What's the best way to do this? Unlock the flash in the
> > board-specific mapping driver perhaps? 
> 
> That's what we used to do. If more people are emulating the Intel
> brain damage and having chips which render the lock operation entirely
> pointless by locking the chips at every power cycle, then I suppose we
> ought to consider making auto-unlock a function of the chip type.

It appears that Atmel has reverted this in later chips, like the
AT49BV642D. Updated patch below, if you still want it. Please disregard
the jedec_probe patch as I've got AT49BV6416 working in CFI mode now.

This patch depends on "MTD: Convert Atmel PRI information to AMD
format" which I just submitted, as it needs the definition
of CFI_MFR_ATMEL.

Haavard

---

[PATCH] MTD: Add lock/unlock operations for Atmel AT49BV6416

The AT49BV6416 is locked by default, so we really need to provide
at least the unlock() operation for write and erase to work. This
patch implements both ->lock() and ->unlock() and provides a fixup
to install them when an AT49BV6416 chip is detected.

These functions are probably valid on more Atmel chips, but I believe
it's mostly obsolete ones. The AT49BV6416 is in fact obsolete, but
it's used on all current AT32STK1000 development boards.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |   90 ++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

Index: linux-2.6.18-rc3-mm2/drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/mtd/chips/cfi_cmdset_0002.c	2006-08-09 10:28:27.000000000 +0200
+++ linux-2.6.18-rc3-mm2/drivers/mtd/chips/cfi_cmdset_0002.c	2006-08-09 10:32:04.000000000 +0200
@@ -45,9 +45,11 @@
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
@@ -199,6 +204,16 @@ static void fixup_use_erase_chip(struct 
 
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
@@ -228,6 +243,7 @@ static struct cfi_fixup fixup_table[] = 
 	 * we know that is the case.
 	 */
 	{ CFI_MFR_ANY, CFI_ID_ANY, fixup_use_erase_chip, NULL },
+	{ CFI_MFR_ATMEL, AT49BV6416, fixup_use_atmel_lock, NULL },
 	{ 0, 0, NULL, NULL }
 };
 
@@ -1628,6 +1644,80 @@ static int cfi_amdstd_erase_chip(struct 
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
+	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
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
+	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
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
