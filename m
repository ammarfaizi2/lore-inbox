Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVIHWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVIHWWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVIHWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:22:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:31934 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965043AbVIHWWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:53 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1_ds2433: Added crc16 protection and read caching.
In-Reply-To: <11262181611117@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181623559@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1_ds2433: Added crc16 protection and read caching.

The changes to ds2433 to add CRC16 protection and read caching.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0a25e4d5647003a32ba5496f9d0f40ba9c1e3863
tree 678a0f192d7b72270ea3431f642baca9566a249b
parent a45f105ad4b456f99f622642056ae533f70710b7
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Wed, 17 Aug 2005 15:24:37 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 drivers/w1/Kconfig     |    9 ++++
 drivers/w1/Makefile    |    6 ++
 drivers/w1/w1_ds2433.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -61,4 +61,13 @@ config W1_DS2433
 	  Say Y here if you want to use a 1-wire
 	  4kb EEPROM family device (DS2433).
 
+config W1_DS2433_CRC
+	bool "Protect DS2433 data with a CRC16"
+	depends on W1_DS2433
+	select CRC16
+	help
+	  Say Y here to protect DS2433 data with a CRC16.
+	  Each block has 30 bytes of data and a two byte CRC16.
+	  Full block writes are only allowed if the CRC is valid.
+
 endmenu
diff --git a/drivers/w1/Makefile b/drivers/w1/Makefile
--- a/drivers/w1/Makefile
+++ b/drivers/w1/Makefile
@@ -6,6 +6,10 @@ ifneq ($(CONFIG_NET), y)
 EXTRA_CFLAGS	+= -DNETLINK_DISABLED
 endif
 
+ifeq ($(CONFIG_W1_DS2433_CRC), y)
+EXTRA_CFLAGS	+= -DCONFIG_W1_F23_CRC
+endif
+
 obj-$(CONFIG_W1)	+= wire.o
 wire-objs		:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
 
@@ -13,7 +17,7 @@ obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
 obj-$(CONFIG_W1_SMEM)		+= w1_smem.o
 
-obj-$(CONFIG_W1_DS9490)		+= ds9490r.o 
+obj-$(CONFIG_W1_DS9490)		+= ds9490r.o
 ds9490r-objs    := dscore.o
 
 obj-$(CONFIG_W1_DS9490_BRIDGE)	+= ds_w1_bridge.o
diff --git a/drivers/w1/w1_ds2433.c b/drivers/w1/w1_ds2433.c
--- a/drivers/w1/w1_ds2433.c
+++ b/drivers/w1/w1_ds2433.c
@@ -3,9 +3,8 @@
  *
  * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the smems of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
@@ -14,6 +13,9 @@
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/delay.h>
+#ifdef CONFIG_W1_F23_CRC
+#include <linux/crc16.h>
+#endif
 
 #include "w1.h"
 #include "w1_io.h"
@@ -25,18 +27,26 @@ MODULE_AUTHOR("Ben Gardner <bgardner@wab
 MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
 
 #define W1_EEPROM_SIZE		512
+#define W1_PAGE_COUNT		16
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
 
+#define W1_F23_TIME		300
+
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
 #define W1_F23_READ_SCRATCH	0xAA
 #define W1_F23_COPY_SCRATCH	0x55
 
+struct w1_f23_data {
+	u8	memory[W1_EEPROM_SIZE];
+	u32	validcrc;
+};
+
 /**
  * Check the file size bounds and adjusts count as needed.
- * This may not be needed if the sysfs layer checks bounds.
+ * This would not be needed if the file size didn't reset to 0 after a write.
  */
 static inline size_t w1_f23_fix_count(loff_t off, size_t count, size_t size)
 {
@@ -49,10 +59,45 @@ static inline size_t w1_f23_fix_count(lo
 	return count;
 }
 
-static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
+#ifdef CONFIG_W1_F23_CRC
+static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
+				int block)
+{
+	u8	wrbuf[3];
+	int	off = block * W1_PAGE_SIZE;
+
+	if (data->validcrc & (1 << block))
+		return 0;
+
+	if (w1_reset_select_slave(sl)) {
+		data->validcrc = 0;
+		return -EIO;
+	}
+
+	wrbuf[0] = W1_F23_READ_EEPROM;
+	wrbuf[1] = off & 0xff;
+	wrbuf[2] = off >> 8;
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_read_block(sl->master, &data->memory[off], W1_PAGE_SIZE);
+
+	/* cache the block if the CRC is valid */
+	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) == CRC16_VALID)
+		data->validcrc |= (1 << block);
+
+	return 0;
+}
+#endif	/* CONFIG_W1_F23_CRC */
+
+static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off,
+			       size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+#ifdef CONFIG_W1_F23_CRC
+	struct w1_f23_data *data = sl->family_data;
+	int i, min_page, max_page;
+#else
 	u8 wrbuf[3];
+#endif
 
 	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
 		return 0;
@@ -63,6 +108,20 @@ static ssize_t w1_f23_read_bin(struct ko
 		goto out_dec;
 	}
 
+#ifdef CONFIG_W1_F23_CRC
+
+	min_page = (off >> W1_PAGE_BITS);
+	max_page = (off + count - 1) >> W1_PAGE_BITS;
+	for (i = min_page; i <= max_page; i++) {
+		if (w1_f23_refresh_block(sl, data, i)) {
+			count = -EIO;
+			goto out_up;
+		}
+	}
+	memcpy(buf, &data->memory[off], count);
+
+#else 	/* CONFIG_W1_F23_CRC */
+
 	/* read directly from the EEPROM */
 	if (w1_reset_select_slave(sl)) {
 		count = -EIO;
@@ -75,6 +134,8 @@ static ssize_t w1_f23_read_bin(struct ko
 	w1_write_block(sl->master, wrbuf, 3);
 	w1_read_block(sl->master, buf, count);
 
+#endif	/* CONFIG_W1_F23_CRC */
+
 out_up:
 	up(&sl->master->mutex);
 out_dec:
@@ -85,6 +146,8 @@ out_dec:
 
 /**
  * Writes to the scratchpad and reads it back for verification.
+ * Then copies the scratchpad to EEPROM.
+ * The data must be on one page.
  * The master must be locked.
  *
  * @param sl	The slave structure
@@ -148,6 +211,23 @@ static ssize_t w1_f23_write_bin(struct k
 	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
 		return 0;
 
+#ifdef CONFIG_W1_F23_CRC
+	/* can only write full blocks in cached mode */
+	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
+		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%d\n",
+			(int)off, count);
+		return -EINVAL;
+	}
+
+	/* make sure the block CRCs are valid */
+	for (idx = 0; idx < count; idx += W1_PAGE_SIZE) {
+		if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) != CRC16_VALID) {
+			dev_err(&sl->dev, "bad CRC at offset %d\n", (int)off);
+			return -EINVAL;
+		}
+	}
+#endif	/* CONFIG_W1_F23_CRC */
+
 	atomic_inc(&sl->refcnt);
 	if (down_interruptible(&sl->master->mutex)) {
 		count = 0;
@@ -190,11 +270,36 @@ static struct bin_attribute w1_f23_bin_a
 
 static int w1_f23_add_slave(struct w1_slave *sl)
 {
-	return sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+	int err;
+#ifdef CONFIG_W1_F23_CRC
+	struct w1_f23_data *data;
+
+	data = kmalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	memset(data, 0, sizeof(struct w1_f23_data));
+	sl->family_data = data;
+
+#endif	/* CONFIG_W1_F23_CRC */
+
+	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+
+#ifdef CONFIG_W1_F23_CRC
+	if (err)
+		kfree(data);
+#endif	/* CONFIG_W1_F23_CRC */
+
+	return err;
 }
 
 static void w1_f23_remove_slave(struct w1_slave *sl)
 {
+#ifdef CONFIG_W1_F23_CRC
+	if (sl->family_data) {
+		kfree(sl->family_data);
+		sl->family_data = NULL;
+	}
+#endif	/* CONFIG_W1_F23_CRC */
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
 }
 

