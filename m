Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUENXjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUENXjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUENXiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:38:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:28645 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264561AbUENXaE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:04 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773572660@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <10845773571402@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.6, 2004/05/01 23:04:01-07:00, stefan.eletzhofer@eletztrick.de

[PATCH] I2C: add I2C epson 8564 RTC chip driver

Add support for the Epson 8564 RTC chip.


 drivers/i2c/chips/Kconfig   |   10 +
 drivers/i2c/chips/Makefile  |    1 
 drivers/i2c/chips/rtc8564.c |  396 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/rtc8564.h |   78 ++++++++
 4 files changed, 485 insertions(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri May 14 16:20:55 2004
+++ b/drivers/i2c/chips/Kconfig	Fri May 14 16:20:55 2004
@@ -230,4 +230,14 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8591.
 
+config SENSORS_RTC8564
+	tristate "Epson 8564 RTC chip"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for the Epson 8564 RTC chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-rtc8564.
+
 endmenu
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Fri May 14 16:20:55 2004
+++ b/drivers/i2c/chips/Makefile	Fri May 14 16:20:55 2004
@@ -21,6 +21,7 @@
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/rtc8564.c	Fri May 14 16:20:55 2004
@@ -0,0 +1,396 @@
+/*
+ *  linux/drivers/i2c/chips/rtc8564.c
+ *
+ *  Copyright (C) 2002-2004 Stefan Eletzhofer
+ *
+ *	based on linux/drivers/acron/char/pcf8583.c
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver for system3's EPSON RTC 8564 chip
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/rtc.h>		/* get the user-level API */
+#include <linux/init.h>
+#include <linux/init.h>
+
+#include "rtc8564.h"
+
+#ifdef DEBUG
+# define _DBG(x, fmt, args...) do{ if (debug>=x) printk(KERN_DEBUG"%s: " fmt "\n", __FUNCTION__, ##args); } while(0);
+#else
+# define _DBG(x, fmt, args...) do { } while(0);
+#endif
+
+#define _DBGRTCTM(x, rtctm) if (debug>=x) printk("%s: secs=%d, mins=%d, hours=%d, mday=%d, " \
+			"mon=%d, year=%d, wday=%d VL=%d\n", __FUNCTION__, \
+			(rtctm).secs, (rtctm).mins, (rtctm).hours, (rtctm).mday, \
+			(rtctm).mon, (rtctm).year, (rtctm).wday, (rtctm).vl);
+
+struct rtc8564_data {
+	struct i2c_client client;
+	u16 ctrl;
+};
+
+static inline u8 _rtc8564_ctrl1(struct i2c_client *client)
+{
+	struct rtc8564_data *data = i2c_get_clientdata(client);
+	return data->ctrl & 0xff;
+}
+static inline u8 _rtc8564_ctrl2(struct i2c_client *client)
+{
+	struct rtc8564_data *data = i2c_get_clientdata(client);
+	return (data->ctrl & 0xff00) >> 8;
+}
+
+#define CTRL1(c) _rtc8564_ctrl1(c)
+#define CTRL2(c) _rtc8564_ctrl2(c)
+
+#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
+#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
+
+static int debug = 0;
+MODULE_PARM(debug, "i");
+
+static struct i2c_driver rtc8564_driver;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0x51, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c		= normal_addr,
+	.normal_i2c_range	= ignore,
+	.probe			= ignore,
+	.probe_range		= ignore,
+	.ignore			= ignore,
+	.ignore_range		= ignore,
+	.force			= ignore,
+};
+
+static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem);
+static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem);
+
+static int rtc8564_read(struct i2c_client *client, unsigned char adr,
+			unsigned char *buf, unsigned char len)
+{
+	int ret = -EIO;
+	unsigned char addr[1] = { adr };
+	struct i2c_msg msgs[2] = {
+		{client->addr, 0, 1, addr},
+		{client->addr, I2C_M_RD, len, buf}
+	};
+
+	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, buf, len);
+
+	if (!buf || !client) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret == 2) {
+		ret = 0;
+	}
+
+done:
+	return ret;
+}
+
+static int rtc8564_write(struct i2c_client *client, unsigned char adr,
+			 unsigned char *data, unsigned char len)
+{
+	int ret = 0;
+	unsigned char _data[16];
+	struct i2c_msg wr;
+	int i;
+
+	if (!client || !data || len > 15) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, data, len);
+
+	_data[0] = adr;
+	for (i = 0; i < len; i++) {
+		_data[i + 1] = data[i];
+		_DBG(5, "data[%d] = 0x%02x (%d)", i, data[i], data[i]);
+	}
+
+	wr.addr = client->addr;
+	wr.flags = 0;
+	wr.len = len + 1;
+	wr.buf = _data;
+
+	ret = i2c_transfer(client->adapter, &wr, 1);
+	if (ret == 1) {
+		ret = 0;
+	}
+
+done:
+	return ret;
+}
+
+static int rtc8564_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	int ret;
+	struct i2c_client *new_client;
+	struct rtc8564_data *d;
+	unsigned char data[10];
+	unsigned char ad[1] = { 0 };
+	struct i2c_msg ctrl_wr[1] = {
+		{addr, 0, 2, data}
+	};
+	struct i2c_msg ctrl_rd[2] = {
+		{addr, 0, 1, ad},
+		{addr, I2C_M_RD, 2, data}
+	};
+
+	d = kmalloc(sizeof(struct rtc8564_data), GFP_KERNEL);
+	if (!d) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	memset(d, 0, sizeof(struct rtc8564_data));
+	new_client = &d->client;
+
+	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
+	i2c_set_clientdata(new_client, d);
+	new_client->id = rtc8564_driver.id;
+	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
+	new_client->addr = addr;
+	new_client->adapter = adap;
+	new_client->driver = &rtc8564_driver;
+
+	_DBG(1, "client=%p", new_client);
+	_DBG(1, "client.id=%d", new_client->id);
+
+	/* init ctrl1 reg */
+	data[0] = 0;
+	data[1] = 0;
+	ret = i2c_transfer(new_client->adapter, ctrl_wr, 1);
+	if (ret != 1) {
+		printk(KERN_INFO "rtc8564: cant init ctrl1\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	/* read back ctrl1 and ctrl2 */
+	ret = i2c_transfer(new_client->adapter, ctrl_rd, 2);
+	if (ret != 2) {
+		printk(KERN_INFO "rtc8564: cant read ctrl\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	d->ctrl = data[0] | (data[1] << 8);
+
+	_DBG(1, "RTC8564_REG_CTRL1=%02x, RTC8564_REG_CTRL2=%02x",
+	     data[0], data[1]);
+
+	ret = i2c_attach_client(new_client);
+done:
+	if (ret) {
+		kfree(d);
+	}
+	return ret;
+}
+
+static int rtc8564_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, rtc8564_attach);
+}
+
+static int rtc8564_detach(struct i2c_client *client)
+{
+	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static int rtc8564_get_datetime(struct i2c_client *client, struct rtc_tm *dt)
+{
+	int ret = -EIO;
+	unsigned char buf[15];
+
+	_DBG(1, "client=%p, dt=%p", client, dt);
+
+	if (!dt || !client)
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = rtc8564_read(client, 0, buf, 15);
+	if (ret)
+		return ret;
+
+	/* century stored in minute alarm reg */
+	dt->year = BCD_TO_BIN(buf[RTC8564_REG_YEAR]);
+	dt->year += 100 * BCD_TO_BIN(buf[RTC8564_REG_AL_MIN] & 0x3f);
+	dt->mday = BCD_TO_BIN(buf[RTC8564_REG_DAY] & 0x3f);
+	dt->wday = BCD_TO_BIN(buf[RTC8564_REG_WDAY] & 7);
+	dt->mon = BCD_TO_BIN(buf[RTC8564_REG_MON_CENT] & 0x1f);
+
+	dt->secs = BCD_TO_BIN(buf[RTC8564_REG_SEC] & 0x7f);
+	dt->vl = (buf[RTC8564_REG_SEC] & 0x80) == 0x80;
+	dt->mins = BCD_TO_BIN(buf[RTC8564_REG_MIN] & 0x7f);
+	dt->hours = BCD_TO_BIN(buf[RTC8564_REG_HR] & 0x3f);
+
+	_DBGRTCTM(2, *dt);
+
+	return 0;
+}
+
+static int
+rtc8564_set_datetime(struct i2c_client *client, struct rtc_tm *dt, int datetoo)
+{
+	int ret, len = 5;
+	unsigned char buf[15];
+
+	_DBG(1, "client=%p, dt=%p", client, dt);
+
+	if (!dt || !client)
+		return -EINVAL;
+
+	_DBGRTCTM(2, *dt);
+
+	buf[RTC8564_REG_CTRL1] = CTRL1(client) | RTC8564_CTRL1_STOP;
+	buf[RTC8564_REG_CTRL2] = CTRL2(client);
+	buf[RTC8564_REG_SEC] = BIN_TO_BCD(dt->secs);
+	buf[RTC8564_REG_MIN] = BIN_TO_BCD(dt->mins);
+	buf[RTC8564_REG_HR] = BIN_TO_BCD(dt->hours);
+
+	if (datetoo) {
+		len += 5;
+		buf[RTC8564_REG_DAY] = BIN_TO_BCD(dt->mday);
+		buf[RTC8564_REG_WDAY] = BIN_TO_BCD(dt->wday);
+		buf[RTC8564_REG_MON_CENT] = BIN_TO_BCD(dt->mon) & 0x1f;
+		/* century stored in minute alarm reg */
+		buf[RTC8564_REG_YEAR] = BIN_TO_BCD(dt->year % 100);
+		buf[RTC8564_REG_AL_MIN] = BIN_TO_BCD(dt->year / 100);
+	}
+
+	ret = rtc8564_write(client, 0, buf, len);
+	if (ret) {
+		_DBG(1, "error writing data! %d", ret);
+	}
+
+	buf[RTC8564_REG_CTRL1] = CTRL1(client);
+	ret = rtc8564_write(client, 0, buf, 1);
+	if (ret) {
+		_DBG(1, "error writing data! %d", ret);
+	}
+
+	return ret;
+}
+
+static int rtc8564_get_ctrl(struct i2c_client *client, unsigned int *ctrl)
+{
+	struct rtc8564_data *data = i2c_get_clientdata(client);
+
+	if (!ctrl || !client)
+		return -1;
+
+	*ctrl = data->ctrl;
+	return 0;
+}
+
+static int rtc8564_set_ctrl(struct i2c_client *client, unsigned int *ctrl)
+{
+	struct rtc8564_data *data = i2c_get_clientdata(client);
+	unsigned char buf[2];
+
+	if (!ctrl || !client)
+		return -1;
+
+	buf[0] = *ctrl & 0xff;
+	buf[1] = (*ctrl & 0xff00) >> 8;
+	data->ctrl = *ctrl;
+
+	return rtc8564_write(client, 0, buf, 2);
+}
+
+static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem)
+{
+
+	if (!mem || !client)
+		return -EINVAL;
+
+	return rtc8564_read(client, mem->loc, mem->data, mem->nr);
+}
+
+static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem)
+{
+
+	if (!mem || !client)
+		return -EINVAL;
+
+	return rtc8564_write(client, mem->loc, mem->data, mem->nr);
+}
+
+static int
+rtc8564_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+
+	_DBG(1, "cmd=%d", cmd);
+
+	switch (cmd) {
+	case RTC_GETDATETIME:
+		return rtc8564_get_datetime(client, arg);
+
+	case RTC_SETTIME:
+		return rtc8564_set_datetime(client, arg, 0);
+
+	case RTC_SETDATETIME:
+		return rtc8564_set_datetime(client, arg, 1);
+
+	case RTC_GETCTRL:
+		return rtc8564_get_ctrl(client, arg);
+
+	case RTC_SETCTRL:
+		return rtc8564_set_ctrl(client, arg);
+
+	case MEM_READ:
+		return rtc8564_read_mem(client, arg);
+
+	case MEM_WRITE:
+		return rtc8564_write_mem(client, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct i2c_driver rtc8564_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "RTC8564",
+	.id		= I2C_DRIVERID_RTC8564,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = rtc8564_probe,
+	.detach_client	= rtc8564_detach,
+	.command	= rtc8564_command
+};
+
+static __init int rtc8564_init(void)
+{
+	return i2c_add_driver(&rtc8564_driver);
+}
+
+static __exit void rtc8564_exit(void)
+{
+	i2c_del_driver(&rtc8564_driver);
+}
+
+MODULE_AUTHOR("Stefan Eletzhofer <Stefan.Eletzhofer@eletztrick.de>");
+MODULE_DESCRIPTION("EPSON RTC8564 Driver");
+MODULE_LICENSE("GPL");
+
+module_init(rtc8564_init);
+module_exit(rtc8564_exit);
diff -Nru a/drivers/i2c/chips/rtc8564.h b/drivers/i2c/chips/rtc8564.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/rtc8564.h	Fri May 14 16:20:55 2004
@@ -0,0 +1,78 @@
+/*
+ *  linux/drivers/i2c/chips/rtc8564.h
+ *
+ *  Copyright (C) 2002-2004 Stefan Eletzhofer
+ *
+ *	based on linux/drivers/acron/char/pcf8583.h
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+struct rtc_tm {
+	unsigned char	secs;
+	unsigned char	mins;
+	unsigned char	hours;
+	unsigned char	mday;
+	unsigned char	mon;
+	unsigned short	year; /* xxxx 4 digits :) */
+	unsigned char	wday;
+	unsigned char	vl;
+};
+
+struct mem {
+	unsigned int	loc;
+	unsigned int	nr;
+	unsigned char	*data;
+};
+
+#define RTC_GETDATETIME	0
+#define RTC_SETTIME	1
+#define RTC_SETDATETIME	2
+#define RTC_GETCTRL	3
+#define RTC_SETCTRL	4
+#define MEM_READ	5
+#define MEM_WRITE	6
+
+#define RTC8564_REG_CTRL1		0x0 /* T  0 S 0 | T 0 0 0 */
+#define RTC8564_REG_CTRL2		0x1 /* 0  0 0 TI/TP | AF TF AIE TIE */
+#define RTC8564_REG_SEC			0x2 /* VL 4 2 1 | 8 4 2 1 */
+#define RTC8564_REG_MIN			0x3 /* x  4 2 1 | 8 4 2 1 */
+#define RTC8564_REG_HR			0x4 /* x  x 2 1 | 8 4 2 1 */
+#define RTC8564_REG_DAY			0x5 /* x  x 2 1 | 8 4 2 1 */
+#define RTC8564_REG_WDAY		0x6 /* x  x x x | x 4 2 1 */
+#define RTC8564_REG_MON_CENT	0x7 /* C  x x 1 | 8 4 2 1 */
+#define RTC8564_REG_YEAR		0x8 /* 8  4 2 1 | 8 4 2 1 */
+#define RTC8564_REG_AL_MIN		0x9 /* AE 4 2 1 | 8 4 2 1 */
+#define RTC8564_REG_AL_HR		0xa /* AE 4 2 1 | 8 4 2 1 */
+#define RTC8564_REG_AL_DAY		0xb /* AE x 2 1 | 8 4 2 1 */
+#define RTC8564_REG_AL_WDAY		0xc /* AE x x x | x 4 2 1 */
+#define RTC8564_REG_CLKOUT		0xd /* FE x x x | x x FD1 FD0 */
+#define RTC8564_REG_TCTL		0xe /* TE x x x | x x FD1 FD0 */
+#define RTC8564_REG_TIMER		0xf /* 8 bit binary */
+
+/* Control reg */
+#define RTC8564_CTRL1_TEST1		(1<<3)
+#define RTC8564_CTRL1_STOP		(1<<5)
+#define RTC8564_CTRL1_TEST2		(1<<7)
+
+#define RTC8564_CTRL2_TIE		(1<<0)
+#define RTC8564_CTRL2_AIE		(1<<1)
+#define RTC8564_CTRL2_TF		(1<<2)
+#define RTC8564_CTRL2_AF		(1<<3)
+#define RTC8564_CTRL2_TI_TP		(1<<4)
+
+/* CLKOUT frequencies */
+#define RTC8564_FD_32768HZ		(0x0)
+#define RTC8564_FD_1024HZ		(0x1)
+#define RTC8564_FD_32			(0x2)
+#define RTC8564_FD_1HZ			(0x3)
+
+/* Timer CTRL */
+#define RTC8564_TD_4096HZ		(0x0)
+#define RTC8564_TD_64HZ			(0x1)
+#define RTC8564_TD_1HZ			(0x2)
+#define RTC8564_TD_1_60HZ		(0x3)
+
+#define I2C_DRIVERID_RTC8564 0xf000

