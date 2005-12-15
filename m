Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVLOPMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVLOPMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLOPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:12:24 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:1994 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750754AbVLOPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:12:24 -0500
Message-ID: <43A187DC.8010305@anagramm.de>
Date: Thu, 15 Dec 2005 16:12:28 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] I2C RTC8564/PCF8563 compatibility and century bit usage
Content-Type: multipart/mixed;
 boundary="------------070201070000020006060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201070000020006060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

This is about the I2C-Bus Real Time Clock chip driver 
linux/drivers/i2c/chips/rtc8564.c in current 2.6.15-rc5.

According to the datasheets for the RTC8564 and the PCF8563
http://www.e-lab.de/downloads/DOCs/RTC8564.pdf
http://www.semiconductors.philips.com/acrobat_download/datasheets/PCF8563-04.pdf
the rtc memory content is the same and compatible.

While merging/porting a pcf8563.c driver which is used on
my embedded ppc board to the rtc8564.c, I had to realize that the
century bit isn't used in the current driver. Instead, the
alarm-minute-register is misused to get the century correct.
So, I suggest the following patch to use the century bit as intended
and add some notes about the pcf8653 compatibility. I've left the
century bit polarity "as is" from the pcf8563 driver to avoid any
existing changes, but that behaviour could be changed according
to the datasheet.
rtc8564_do_command() will be used by my platform initialization code.
(some more patches follow)

Thanks!

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
-- 


--------------070201070000020006060206
Content-Type: text/plain;
 name="rtc8564-century.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc8564-century.patch"

--- linux-2.6.15-rc5-pm854/drivers/i2c/chips/rtc8564.c.ori	2005-12-15 15:43:02.000000000 +0100
+++ linux-2.6.15-rc5-pm854/drivers/i2c/chips/rtc8564.c	2005-12-15 16:03:43.000000000 +0100
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  *
  * Driver for system3's EPSON RTC 8564 chip
+ * this driver is also compatible to the Philips PCF 8563 chip
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -35,9 +36,12 @@
 
 struct rtc8564_data {
 	struct i2c_client client;
+	struct list_head list;
 	u16 ctrl;
 };
 
+static LIST_HEAD(rtc8564_clients);
+
 static inline u8 _rtc8564_ctrl1(struct i2c_client *client)
 {
 	struct rtc8564_data *data = i2c_get_clientdata(client);
@@ -55,7 +59,7 @@ static inline u8 _rtc8564_ctrl2(struct i
 #define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
 #define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
 
-static int debug;;
+static int debug;
 module_param(debug, int, S_IRUGO | S_IWUSR);
 
 static struct i2c_driver rtc8564_driver;
@@ -153,6 +157,8 @@ static int rtc8564_attach(struct i2c_ada
 		ret = -ENOMEM;
 		goto done;
 	}
+	INIT_LIST_HEAD(&d->list);
+	
 	new_client = &d->client;
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
@@ -188,6 +194,9 @@ static int rtc8564_attach(struct i2c_ada
 	     data[0], data[1]);
 
 	ret = i2c_attach_client(new_client);
+	/* Add client to local list */
+	list_add(&d->list, &rtc8564_clients);
+	
 done:
 	if (ret) {
 		kfree(d);
@@ -202,8 +211,11 @@ static int rtc8564_probe(struct i2c_adap
 
 static int rtc8564_detach(struct i2c_client *client)
 {
+	struct rtc8564_data *data = i2c_get_clientdata(client);
+
 	i2c_detach_client(client);
 	kfree(i2c_get_clientdata(client));
+	list_del(&data->list);
 	return 0;
 }
 
@@ -222,10 +234,25 @@ static int rtc8564_get_datetime(struct i
 	ret = rtc8564_read(client, 0, buf, 15);
 	if (ret)
 		return ret;
-
+#if 0
 	/* century stored in minute alarm reg */
 	dt->year = BCD_TO_BIN(buf[RTC8564_REG_YEAR]);
 	dt->year += 100 * BCD_TO_BIN(buf[RTC8564_REG_AL_MIN] & 0x3f);
+#endif
+	/* century stored in the century bit
+	 * RTC8564 datasheet: his bit indicates change of century. When the
+	 * year digit data overflows from 99 to 00, this bit is set. By
+	 * presetting it to 0 while still in the 20th century, it will be
+	 * set in year 2000, but in fact the first year in the 21 century
+	 * should be 2001.
+	 * PCF8563 datasheet: this bit is toggled when the years register
+	 * overflows from 99 to 00
+	 * 0 indicates the century is 20xx
+	 * 1 indicates the century is 19xx */
+	dt->year = 1900 + BCD_TO_BIN(buf[RTC8564_REG_YEAR]);
+	if (buf[RTC8564_REG_MON_CENT] & 0x80)
+		dt->year += 100;
+
 	dt->mday = BCD_TO_BIN(buf[RTC8564_REG_DAY] & 0x3f);
 	dt->wday = BCD_TO_BIN(buf[RTC8564_REG_WDAY] & 7);
 	dt->mon = BCD_TO_BIN(buf[RTC8564_REG_MON_CENT] & 0x1f);
@@ -245,7 +272,8 @@ rtc8564_set_datetime(struct i2c_client *
 {
 	int ret, len = 5;
 	unsigned char buf[15];
-
+	unsigned char val;
+	
 	_DBG(1, "client=%p, dt=%p", client, dt);
 
 	if (!dt)
@@ -264,9 +292,19 @@ rtc8564_set_datetime(struct i2c_client *
 		buf[RTC8564_REG_DAY] = BIN_TO_BCD(dt->mday);
 		buf[RTC8564_REG_WDAY] = BIN_TO_BCD(dt->wday);
 		buf[RTC8564_REG_MON_CENT] = BIN_TO_BCD(dt->mon) & 0x1f;
+#if 0
 		/* century stored in minute alarm reg */
 		buf[RTC8564_REG_YEAR] = BIN_TO_BCD(dt->year % 100);
 		buf[RTC8564_REG_AL_MIN] = BIN_TO_BCD(dt->year / 100);
+#endif
+		/* century stored in the century bit */
+		if (dt->tm_year >= 2000) {
+			val = dt->tm_year - 2000;
+			buf[RTC8564_REG_MON_CENT] |= (1 << 7);
+		} else {
+			val = dt->tm_year - 1900;
+		}
+		buf[RTC8564_REG_YEAR] = BIN_TO_BCD(val);
 	}
 
 	ret = rtc8564_write(client, 0, buf, len);
@@ -360,6 +398,23 @@ rtc8564_command(struct i2c_client *clien
 	}
 }
 
+/*
+ * Public API for access to specific device. Useful for low-level
+ * RTC access from kernel code.
+ */
+int rtc8564_do_command(int bus, int cmd, void *arg)
+{
+	struct list_head *walk;
+	struct list_head *tmp;
+	struct rtc8564_data *data;
+	list_for_each_safe(walk, tmp, &rtc8564_clients) {
+		data = list_entry(walk, struct rtc8564_data, list);
+		if (data->client.adapter->nr == bus)
+			return rtc8564_command(&data->client, cmd, arg);
+	}
+	return -ENODEV;
+}
+
 static struct i2c_driver rtc8564_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "RTC8564",

--------------070201070000020006060206--
