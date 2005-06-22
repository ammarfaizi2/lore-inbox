Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVFVFQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVFVFQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVFVFOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:14:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:31127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262741AbVFVFMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:13 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.
In-Reply-To: <1119417127267@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <11194171271261@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.

Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit be57ce267fd558c52d2389530c15618681b7cfa7
tree 74b9d71873a9bd3152c955114b846c251f7216a9
parent 4e470aa9642d49230bcdfbb393cf5a81da333aba
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:21:46 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:10 -0700

 drivers/w1/w1_int.c |    8 ++++++
 drivers/w1/w1_io.c  |   70 ++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/w1/w1_io.h  |    4 +--
 3 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -121,6 +121,14 @@ int w1_add_master_device(struct w1_bus_m
 	int retval = 0;
 	struct w1_netlink_msg msg;
 
+        /* validate minimum functionality */
+        if (!(master->touch_bit && master->reset_bus) &&
+            !(master->write_bit && master->read_bit))
+        {
+           printk(KERN_ERR "w1_add_master_device: invalid function set\n");
+           return(-EINVAL);
+        }
+
 	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
 	if (!dev)
 		return -ENOMEM;
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -55,15 +55,29 @@ void w1_delay(unsigned long tm)
 	udelay(tm * w1_delay_parm);
 }
 
+static void w1_write_bit(struct w1_master *dev, int bit);
+static u8 w1_read_bit(struct w1_master *dev);
+
+/**
+ * Generates a write-0 or write-1 cycle and samples the level.
+ */
 u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
-	else
+	else if (bit)
 		return w1_read_bit(dev);
+	else {
+		w1_write_bit(dev, 0);
+		return(0);
+	}
 }
 
-void w1_write_bit(struct w1_master *dev, int bit)
+/**
+ * Generates a write-0 or write-1 cycle.
+ * Only call if dev->bus_master->touch_bit is NULL
+ */
+static void w1_write_bit(struct w1_master *dev, int bit)
 {
 	if (bit) {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
@@ -78,6 +92,12 @@ void w1_write_bit(struct w1_master *dev,
 	}
 }
 
+/**
+ * Writes 8 bits.
+ *
+ * @param dev     the master device
+ * @param byte    the byte to write
+ */
 void w1_write_8(struct w1_master *dev, u8 byte)
 {
 	int i;
@@ -86,10 +106,15 @@ void w1_write_8(struct w1_master *dev, u
 		dev->bus_master->write_byte(dev->bus_master->data, byte);
 	else
 		for (i = 0; i < 8; ++i)
-			w1_write_bit(dev, (byte >> i) & 0x1);
+			w1_touch_bit(dev, (byte >> i) & 0x1);
 }
 
-u8 w1_read_bit(struct w1_master *dev)
+
+/**
+ * Generates a write-1 cycle and samples the level.
+ * Only call if dev->bus_master->touch_bit is NULL
+ */
+static u8 w1_read_bit(struct w1_master *dev)
 {
 	int result;
 
@@ -104,6 +129,12 @@ u8 w1_read_bit(struct w1_master *dev)
 	return result & 0x1;
 }
 
+/**
+ * Reads 8 bits.
+ *
+ * @param dev     the master device
+ * @return        the byte read
+ */
 u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
@@ -113,12 +144,20 @@ u8 w1_read_8(struct w1_master * dev)
 		res = dev->bus_master->read_byte(dev->bus_master->data);
 	else
 		for (i = 0; i < 8; ++i)
-			res |= (w1_read_bit(dev) << i);
+			res |= (w1_touch_bit(dev,1) << i);
 
 	return res;
 }
 
-void w1_write_block(struct w1_master *dev, u8 *buf, int len)
+/**
+ * Writes a series of bytes.
+ *
+ * @param dev     the master device
+ * @param buf     pointer to the data to write
+ * @param len     the number of bytes to write
+ * @return        the byte read
+ */
+void w1_write_block(struct w1_master *dev, const u8 *buf, int len)
 {
 	int i;
 
@@ -129,6 +168,14 @@ void w1_write_block(struct w1_master *de
 			w1_write_8(dev, buf[i]);
 }
 
+/**
+ * Reads a series of bytes.
+ *
+ * @param dev     the master device
+ * @param buf     pointer to the buffer to fill
+ * @param len     the number of bytes to read
+ * @return        the number of bytes read
+ */
 u8 w1_read_block(struct w1_master *dev, u8 *buf, int len)
 {
 	int i;
@@ -145,9 +192,15 @@ u8 w1_read_block(struct w1_master *dev, 
 	return ret;
 }
 
+/**
+ * Issues a reset bus sequence.
+ *
+ * @param  dev The bus master pointer
+ * @return     0=Device present, 1=No device present or error
+ */
 int w1_reset_bus(struct w1_master *dev)
 {
-	int result = 0;
+	int result;
 
 	if (dev->bus_master->reset_bus)
 		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
@@ -183,9 +236,8 @@ void w1_search_devices(struct w1_master 
 		w1_search(dev);
 }
 
-EXPORT_SYMBOL(w1_write_bit);
+EXPORT_SYMBOL(w1_touch_bit);
 EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_bit);
 EXPORT_SYMBOL(w1_read_8);
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h
+++ b/drivers/w1/w1_io.h
@@ -26,13 +26,11 @@
 
 void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
-void w1_write_bit(struct w1_master *, int);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_bit(struct w1_master *);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
-void w1_write_block(struct w1_master *, u8 *, int);
+void w1_write_block(struct w1_master *, const u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
 

