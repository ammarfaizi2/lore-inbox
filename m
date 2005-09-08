Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVIHWYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVIHWYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVIHWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:24:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:43198 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965055AbVIHWW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:58 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added DS2433 driver.
In-Reply-To: <11262181623532@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181621949@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added DS2433 driver.

Work by Ben Gardner <bgardner@wabtec.com>.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 80895392c83e54653540e72e7d40573aac7ee690
tree 3fb57983caf779f0648baebf18672f232a3c8c58
parent 7c8f5703de91ade517d4fd6c3cc8e08dbba2b739
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 drivers/w1/Kconfig     |    7 ++
 drivers/w1/Makefile    |    1 
 drivers/w1/w1_ds2433.c |  222 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -54,4 +54,11 @@ config W1_SMEM
 	  Say Y here if you want to connect 1-wire
 	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
 
+config W1_DS2433
+	tristate "4kb EEPROM family support (DS2433)"
+	depends on W1
+	help
+	  Say Y here if you want to use a 1-wire
+	  4kb EEPROM family device (DS2433).
+
 endmenu
diff --git a/drivers/w1/Makefile b/drivers/w1/Makefile
--- a/drivers/w1/Makefile
+++ b/drivers/w1/Makefile
@@ -18,3 +18,4 @@ ds9490r-objs    := dscore.o
 
 obj-$(CONFIG_W1_DS9490_BRIDGE)	+= ds_w1_bridge.o
 
+obj-$(CONFIG_W1_DS2433)		+= w1_ds2433.o
diff --git a/drivers/w1/w1_ds2433.c b/drivers/w1/w1_ds2433.c
new file mode 100644
--- /dev/null
+++ b/drivers/w1/w1_ds2433.c
@@ -0,0 +1,222 @@
+/*
+ *	w1_ds2433.c - w1 family 23 (DS2433) driver
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include "w1.h"
+#include "w1_io.h"
+#include "w1_int.h"
+#include "w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
+
+#define W1_EEPROM_SIZE		512
+#define W1_PAGE_SIZE		32
+#define W1_PAGE_BITS		5
+#define W1_PAGE_MASK		0x1F
+
+#define W1_F23_READ_EEPROM	0xF0
+#define W1_F23_WRITE_SCRATCH	0x0F
+#define W1_F23_READ_SCRATCH	0xAA
+#define W1_F23_COPY_SCRATCH	0x55
+
+/**
+ * Check the file size bounds and adjusts count as needed.
+ * This may not be needed if the sysfs layer checks bounds.
+ */
+static inline size_t w1_f23_fix_count(loff_t off, size_t count, size_t size)
+{
+	if (off > size)
+		return 0;
+
+	if ((off + count) > size)
+		return (size - off);
+
+	return count;
+}
+
+static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	u8 wrbuf[3];
+
+	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
+		return 0;
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out_dec;
+	}
+
+	/* read directly from the EEPROM */
+	if (w1_reset_select_slave(sl)) {
+		count = -EIO;
+		goto out_up;
+	}
+
+	wrbuf[0] = W1_F23_READ_EEPROM;
+	wrbuf[1] = off & 0xff;
+	wrbuf[2] = off >> 8;
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_read_block(sl->master, buf, count);
+
+out_up:
+	up(&sl->master->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+/**
+ * Writes to the scratchpad and reads it back for verification.
+ * The master must be locked.
+ *
+ * @param sl	The slave structure
+ * @param addr	Address for the write
+ * @param len   length must be <= (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
+ * @param data	The data to write
+ * @return	0=Success -1=failure
+ */
+static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
+{
+	u8 wrbuf[4];
+	u8 rdbuf[W1_PAGE_SIZE + 3];
+	u8 es = (addr + len - 1) & 0x1f;
+
+	/* Write the data to the scratchpad */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F23_WRITE_SCRATCH;
+	wrbuf[1] = addr & 0xff;
+	wrbuf[2] = addr >> 8;
+
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_write_block(sl->master, data, len);
+
+	/* Read the scratchpad and verify */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	w1_write_8(sl->master, W1_F23_READ_SCRATCH);
+	w1_read_block(sl->master, rdbuf, len + 3);
+
+	/* Compare what was read against the data written */
+	if ((rdbuf[0] != wrbuf[1]) || (rdbuf[1] != wrbuf[2]) ||
+	    (rdbuf[2] != es) || (memcmp(data, &rdbuf[3], len) != 0))
+		return -1;
+
+	/* Copy the scratchpad to EEPROM */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F23_COPY_SCRATCH;
+	wrbuf[3] = es;
+	w1_write_block(sl->master, wrbuf, 4);
+
+	/* Sleep for 5 ms to wait for the write to complete */
+	msleep(5);
+
+	/* Reset the bus to wake up the EEPROM (this may not be needed) */
+	w1_reset_bus(sl->master);
+
+	return 0;
+}
+
+static ssize_t w1_f23_write_bin(struct kobject *kobj, char *buf, loff_t off,
+				size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int addr, len, idx;
+
+	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
+		return 0;
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out_dec;
+	}
+
+	/* Can only write data to one page at a time */
+	idx = 0;
+	while (idx < count) {
+		addr = off + idx;
+		len = W1_PAGE_SIZE - (addr & W1_PAGE_MASK);
+		if (len > (count - idx))
+			len = count - idx;
+
+		if (w1_f23_write(sl, addr, len, &buf[idx]) < 0) {
+			count = -EIO;
+			goto out_up;
+		}
+		idx += len;
+	}
+
+out_up:
+	up(&sl->master->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+static struct bin_attribute w1_f23_bin_attr = {
+	.attr = {
+		.name = "eeprom",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = W1_EEPROM_SIZE,
+	.read = w1_f23_read_bin,
+	.write = w1_f23_write_bin,
+};
+
+static int w1_f23_add_slave(struct w1_slave *sl)
+{
+	return sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+}
+
+static void w1_f23_remove_slave(struct w1_slave *sl)
+{
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+}
+
+static struct w1_family_ops w1_f23_fops = {
+	.add_slave      = w1_f23_add_slave,
+	.remove_slave   = w1_f23_remove_slave,
+};
+
+static struct w1_family w1_family_23 = {
+	.fid = W1_EEPROM_DS2433,
+	.fops = &w1_f23_fops,
+};
+
+static int __init w1_f23_init(void)
+{
+	return w1_register_family(&w1_family_23);
+}
+
+static void __exit w1_f23_fini(void)
+{
+	w1_unregister_family(&w1_family_23);
+}
+
+module_init(w1_f23_init);
+module_exit(w1_f23_fini);

