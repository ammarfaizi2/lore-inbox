Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUHXAj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUHXAj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHWTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:36:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:56515 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266898AbUHWSge convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860871178@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <1093286087677@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.24, 2004/08/06 15:25:13-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added w1_read_block() and w1_write_block() callbacks.

Added w1_read_block() and w1_write_block().
w1_therm.c now uses them.
w1_therm: Chnaged snprintf to sprintf in w1_therm_read_bin() and added max_trying -
        number of tryings to read temperature before failng. By default it is 10.
        Added w1_therm_check_rom() - checks if read rom is in black list.
        If rom is in black list it is probably due to unsufficient of "power" in the sensor -
        either add strong pullup or connect it to Vcc.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.h       |   10 ++++
 drivers/w1/w1_io.c    |   71 +++++++++++++++++++++++++++++------
 drivers/w1/w1_io.h    |    3 +
 drivers/w1/w1_therm.c |  101 ++++++++++++++++++++++++++++----------------------
 4 files changed, 131 insertions(+), 54 deletions(-)


diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2004-08-23 11:04:19 -07:00
+++ b/drivers/w1/w1.h	2004-08-23 11:04:19 -07:00
@@ -73,6 +73,16 @@
 
 	u8			(*read_bit)(unsigned long);
 	void			(*write_bit)(unsigned long, u8);
+  	
+	u8			(*read_byte)(unsigned long);
+  	void			(*write_byte)(unsigned long, u8);
+  	
+	u8			(*read_block)(unsigned long, u8 *, int);
+	void			(*write_block)(unsigned long, u8 *, int);
+	
+  	u8			(*touch_bit)(unsigned long, u8);
+  
+  	u8			(*reset_bus)(unsigned long);
 };
 
 struct w1_master
diff -Nru a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c	2004-08-23 11:04:19 -07:00
+++ b/drivers/w1/w1_io.c	2004-08-23 11:04:19 -07:00
@@ -55,6 +55,14 @@
 	udelay(tm * w1_delay_parm);
 }
 
+u8 w1_touch_bit(struct w1_master *dev, int bit)
+{
+	if (dev->bus_master->touch_bit)
+		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
+	else
+		return w1_read_bit(dev);
+}
+
 void w1_write_bit(struct w1_master *dev, int bit)
 {
 	if (bit) {
@@ -74,8 +82,11 @@
 {
 	int i;
 
-	for (i = 0; i < 8; ++i)
-		w1_write_bit(dev, (byte >> i) & 0x1);
+	if (dev->bus_master->write_byte)
+		dev->bus_master->write_byte(dev->bus_master->data, byte);
+	else
+		for (i = 0; i < 8; ++i)
+			w1_write_bit(dev, (byte >> i) & 0x1);
 }
 
 u8 w1_read_bit(struct w1_master *dev)
@@ -98,23 +109,59 @@
 	int i;
 	u8 res = 0;
 
-	for (i = 0; i < 8; ++i)
-		res |= (w1_read_bit(dev) << i);
+	if (dev->bus_master->read_byte)
+		res = dev->bus_master->read_byte(dev->bus_master->data);
+	else
+		for (i = 0; i < 8; ++i)
+			res |= (w1_read_bit(dev) << i);
 
 	return res;
 }
 
+void w1_write_block(struct w1_master *dev, u8 *buf, int len)
+{
+	int i;
+
+	if (dev->bus_master->write_block)
+		dev->bus_master->write_block(dev->bus_master->data, buf, len);
+	else
+		for (i = 0; i < len; ++i)
+			w1_write_8(dev, buf[i]);
+}
+
+u8 w1_read_block(struct w1_master *dev, u8 *buf, int len)
+{
+	int i;
+	u8 ret;
+
+	if (dev->bus_master->read_block)
+		ret = dev->bus_master->read_block(dev->bus_master->data, buf, len);
+	else
+	{
+		for (i = 0; i < len; ++i)
+			buf[i] = w1_read_8(dev);
+		ret = len;
+	}
+
+	return ret;
+}
+
 int w1_reset_bus(struct w1_master *dev)
 {
-	int result;
+	int result = 0;
 
-	dev->bus_master->write_bit(dev->bus_master->data, 0);
-	w1_delay(480);
-	dev->bus_master->write_bit(dev->bus_master->data, 1);
-	w1_delay(70);
+	if (dev->bus_master->reset_bus)
+		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
+	else
+	{
+		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		w1_delay(480);
+		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		w1_delay(70);
 
-	result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
-	w1_delay(410);
+		result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
+		w1_delay(410);
+	}
 
 	return result;
 }
@@ -136,3 +183,5 @@
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
 EXPORT_SYMBOL(w1_delay);
+EXPORT_SYMBOL(w1_read_block);
+EXPORT_SYMBOL(w1_write_block);
diff -Nru a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h	2004-08-23 11:04:19 -07:00
+++ b/drivers/w1/w1_io.h	2004-08-23 11:04:19 -07:00
@@ -25,11 +25,14 @@
 #include "w1.h"
 
 void w1_delay(unsigned long);
+u8 w1_touch_bit(struct w1_master *, int);
 void w1_write_bit(struct w1_master *, int);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_bit(struct w1_master *);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
+void w1_write_block(struct w1_master *, u8 *, int);
+u8 w1_read_block(struct w1_master *, u8 *, int);
 
 #endif /* __W1_IO_H */
diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c	2004-08-23 11:04:19 -07:00
+++ b/drivers/w1/w1_therm.c	2004-08-23 11:04:19 -07:00
@@ -36,6 +36,11 @@
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
 
+static u8 bad_roms[][9] = {
+				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87}, 
+				{}
+			};
+
 static ssize_t w1_therm_read_name(struct device *, char *);
 static ssize_t w1_therm_read_temp(struct device *, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
@@ -69,14 +74,24 @@
 	return sprintf(buf, "%d\n", temp * 1000);
 }
 
+static int w1_therm_check_rom(u8 rom[9])
+{
+	int i;
+
+	for (i=0; i<sizeof(bad_roms)/9; ++i)
+		if (!memcmp(bad_roms[i], rom, 9))
+			return 1;
+
+	return 0;
+}
+
 static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
 			      			struct w1_slave, dev);
 	struct w1_master *dev = sl->master;
 	u8 rom[9], crc, verdict;
-	size_t icount;
-	int i;
+	int i, max_trying = 10;
 	u16 temp;
 
 	atomic_inc(&sl->refcnt);
@@ -89,10 +104,10 @@
 		count = 0;
 		goto out;
 	}
-	if (off + count > W1_SLAVE_DATA_SIZE)
-		count = W1_SLAVE_DATA_SIZE - off;
-
-	icount = count;
+	if (off + count > W1_SLAVE_DATA_SIZE) {
+		count = 0;
+		goto out;
+	}
 
 	memset(buf, 0, count);
 	memset(rom, 0, sizeof(rom));
@@ -100,56 +115,56 @@
 	count = 0;
 	verdict = 0;
 	crc = 0;
-	if (!w1_reset_bus(dev)) {
-		u64 id = *(u64 *) & sl->reg_num;
-		int count = 0;
-
-		w1_write_8(dev, W1_MATCH_ROM);
-		for (i = 0; i < 8; ++i)
-			w1_write_8(dev, (id >> i * 8) & 0xff);
-
-		w1_write_8(dev, W1_CONVERT_TEMP);
-
-		while (dev->bus_master->read_bit(dev->bus_master->data) == 0
-		       && count < 10) {
-			w1_delay(1);
-			count++;
-		}
-
-		if (count < 10) {
-			if (!w1_reset_bus(dev)) {
-				w1_write_8(dev, W1_MATCH_ROM);
-				for (i = 0; i < 8; ++i)
-					w1_write_8(dev,
-						   (id >> i * 8) & 0xff);
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				for (i = 0; i < 9; ++i)
-					rom[i] = w1_read_8(dev);
 
-				crc = w1_calc_crc8(rom, 8);
-
-				if (rom[8] == crc && rom[0])
-					verdict = 1;
+	while (max_trying--)	
+	{
+		if (!w1_reset_bus (dev)) {
+			int count = 0;
+			u8 match[9] = {W1_MATCH_ROM, };
+
+			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
+			
+			w1_write_block(dev, match, 9);
+
+			w1_write_8(dev, W1_CONVERT_TEMP);
+
+			if (count < 10) {
+				if (!w1_reset_bus(dev)) {
+					w1_write_block(dev, match, 9);
+
+					w1_write_8(dev, W1_READ_SCRATCHPAD);
+					if ((count = w1_read_block(dev, rom, 9)) != 9)
+					{
+						dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
+					}
+
+					crc = w1_calc_crc8(rom, 8);
+
+					if (rom[8] == crc && rom[0])
+						verdict = 1;
+				}
 			}
+			else
+				dev_warn(&dev->dev,
+					  "18S20 doesn't respond to CONVERT_TEMP.\n");
 		}
-		else
-			dev_warn(&dev->dev,
-				  "18S20 doesn't respond to CONVERT_TEMP.\n");
+
+		if (!w1_therm_check_rom(rom))
+			break;
 	}
 
 	for (i = 0; i < 9; ++i)
-		count += snprintf(buf + count, icount - count, "%02x ", rom[i]);
-	count += snprintf(buf + count, icount - count, ": crc=%02x %s\n",
+		count += sprintf(buf + count, "%02x ", rom[i]);
+	count += sprintf(buf + count, ": crc=%02x %s\n",
 			   crc, (verdict) ? "YES" : "NO");
 	if (verdict)
 		memcpy(sl->rom, rom, sizeof(sl->rom));
 	for (i = 0; i < 9; ++i)
-		count += snprintf(buf + count, icount - count, "%02x ", sl->rom[i]);
+		count += sprintf(buf + count, "%02x ", sl->rom[i]);
 	temp = 0;
 	temp <<= sl->rom[1] / 2;
 	temp |= sl->rom[0] / 2;
-	count += snprintf(buf + count, icount - count, "t=%u\n", temp);
+	count += sprintf(buf + count, "t=%u\n", temp);
 out:
 	up(&dev->mutex);
 out_dec:

