Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966275AbWKZBfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966275AbWKZBfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966097AbWKZBfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:35:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967126AbWKZBe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:34:59 -0500
Date: Sun, 26 Nov 2006 02:35:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] better CONFIG_W1_SLAVE_DS2433_CRC handling
Message-ID: <20061126013503.GE15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_W1_SLAVE_DS2433_CRC can be used directly, there's no reason for 
the indirection of defining a different variable in the Makefile.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/w1/Makefile           |    4 ----
 drivers/w1/slaves/Makefile    |    4 ----
 drivers/w1/slaves/w1_ds2433.c |   30 +++++++++++++++---------------
 3 files changed, 15 insertions(+), 23 deletions(-)

--- linux-2.6.19-rc6-mm1/drivers/w1/Makefile.old	2006-11-26 02:08:24.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/w1/Makefile	2006-11-26 02:08:34.000000000 +0100
@@ -1,13 +1,9 @@
 #
 # Makefile for the Dallas's 1-wire bus.
 #
 
-ifeq ($(CONFIG_W1_DS2433_CRC), y)
-EXTRA_CFLAGS	+= -DCONFIG_W1_F23_CRC
-endif
-
 obj-$(CONFIG_W1)	+= wire.o
 wire-objs		:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
 
 obj-y			+= masters/ slaves/
 
--- linux-2.6.19-rc6-mm1/drivers/w1/slaves/Makefile.old	2006-11-26 02:08:42.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/w1/slaves/Makefile	2006-11-26 02:08:52.000000000 +0100
@@ -1,12 +1,8 @@
 #
 # Makefile for the Dallas's 1-wire slaves.
 #
 
-ifeq ($(CONFIG_W1_SLAVE_DS2433_CRC), y)
-EXTRA_CFLAGS += -DCONFIG_W1_F23_CRC
-endif
-
 obj-$(CONFIG_W1_SLAVE_THERM)	+= w1_therm.o
 obj-$(CONFIG_W1_SLAVE_SMEM)	+= w1_smem.o
 obj-$(CONFIG_W1_SLAVE_DS2433)	+= w1_ds2433.o
 
--- linux-2.6.19-rc6-mm1/drivers/w1/slaves/w1_ds2433.c.old	2006-11-26 02:09:02.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/w1/slaves/w1_ds2433.c	2006-11-26 02:09:31.000000000 +0100
@@ -11,11 +11,11 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 #include <linux/crc16.h>
 
 #define CRC16_INIT		0
 #define CRC16_VALID		0xb001
 
@@ -60,11 +60,11 @@
 		return (size - off);
 
 	return count;
 }
 
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
 				int block)
 {
 	u8	wrbuf[3];
 	int	off = block * W1_PAGE_SIZE;
@@ -87,17 +87,17 @@
 	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) == CRC16_VALID)
 		data->validcrc |= (1 << block);
 
 	return 0;
 }
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off,
 			       size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *data = sl->family_data;
 	int i, min_page, max_page;
 #else
 	u8 wrbuf[3];
 #endif
@@ -105,11 +105,11 @@
 	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
 		return 0;
 
 	mutex_lock(&sl->master->mutex);
 
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 
 	min_page = (off >> W1_PAGE_BITS);
 	max_page = (off + count - 1) >> W1_PAGE_BITS;
 	for (i = min_page; i <= max_page; i++) {
 		if (w1_f23_refresh_block(sl, data, i)) {
@@ -117,11 +117,11 @@
 			goto out_up;
 		}
 	}
 	memcpy(buf, &data->memory[off], count);
 
-#else 	/* CONFIG_W1_F23_CRC */
+#else 	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 	/* read directly from the EEPROM */
 	if (w1_reset_select_slave(sl)) {
 		count = -EIO;
 		goto out_up;
@@ -131,11 +131,11 @@
 	wrbuf[1] = off & 0xff;
 	wrbuf[2] = off >> 8;
 	w1_write_block(sl->master, wrbuf, 3);
 	w1_read_block(sl->master, buf, count);
 
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 out_up:
 	mutex_unlock(&sl->master->mutex);
 
 	return count;
@@ -206,11 +206,11 @@
 	int addr, len, idx;
 
 	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
 		return 0;
 
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	/* can only write full blocks in cached mode */
 	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
 		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%zd\n",
 			(int)off, count);
 		return -EINVAL;
@@ -221,11 +221,11 @@
 		if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) != CRC16_VALID) {
 			dev_err(&sl->dev, "bad CRC at offset %d\n", (int)off);
 			return -EINVAL;
 		}
 	}
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 	mutex_lock(&sl->master->mutex);
 
 	/* Can only write data to one page at a time */
 	idx = 0;
@@ -260,37 +260,37 @@
 };
 
 static int w1_f23_add_slave(struct w1_slave *sl)
 {
 	int err;
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *data;
 
 	data = kmalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	memset(data, 0, sizeof(struct w1_f23_data));
 	sl->family_data = data;
 
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
 
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	if (err)
 		kfree(data);
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 	return err;
 }
 
 static void w1_f23_remove_slave(struct w1_slave *sl)
 {
-#ifdef CONFIG_W1_F23_CRC
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	kfree(sl->family_data);
 	sl->family_data = NULL;
-#endif	/* CONFIG_W1_F23_CRC */
+#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
 }
 
 static struct w1_family_ops w1_f23_fops = {
 	.add_slave      = w1_f23_add_slave,

