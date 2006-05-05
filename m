Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWEESnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWEESnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWEESnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:43:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:25751 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751209AbWEESnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:43:41 -0400
X-Authenticated: #20450766
Date: Fri, 5 May 2006 20:43:39 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alessandro Zummo <azummo-lists@towertech.it>
cc: Russell King <rmk@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/acorn/char/pcf8583.[hc] vs. RTC subsystem
In-Reply-To: <20060503132301.52a75dcd@inspiron>
Message-ID: <Pine.LNX.4.60.0605052036360.4241@poirot.grange>
References: <20060331100423.175139000@towertech.it>
 <Pine.LNX.4.63.0605030826290.1846@pcgl.dsa-ac.de> <20060503105816.65f309f8@inspiron>
 <Pine.LNX.4.63.0605031120570.1846@pcgl.dsa-ac.de> <20060503121354.61bf3558@inspiron>
 <Pine.LNX.4.63.0605031223350.1846@pcgl.dsa-ac.de> <20060503122555.5337523f@inspiron>
 <Pine.LNX.4.63.0605031242020.1846@pcgl.dsa-ac.de> <20060503132301.52a75dcd@inspiron>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Guennadi Liakhovetski wrote:

> On Wed, 3 May 2006, Russell King wrote:
> 
> > I doubt we could switch - we need to read the year from the memory part
> > and that's specific to Acorn machines.  The PCF8583 has a 2 bit year
> > counter which is totally useless, so Acorn machines keep track of the
> > year in the CMOS part of the chip.
> 
> The driver I've submitted does exactly this. It is a CMOS built into the pcf,
> so, why not just use it for that?
> 
> > Hence to _correctly_ interpret the time and date from the clock, you
> > _have_ to have this special knowledge built in to the driver.  That
> > won't be suitable for other setups, so I don't see how you could
> > sanely combine the drivers and keep the functionality.
> 
> Why do you think it is unsuitable for others?

Russell, as you haven't replied, I take it as an agreement with this 
patch, leaving the original driver under drivers/acorn so far alone.

On Wed, 3 May 2006, Alessandro Zummo wrote:

> On Wed, 3 May 2006 12:49:16 +0200 (CEST)
> Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
> > 
> > Ok, the patch is attached (sorry, this my pine is still not configured 
> > properly for inlining, if it is a problem, will resend from home), so the 
> > interested parties can already review it, but I would still wait for 
> > Russell's opinion, I am not quite excited by the idea of having 2 drivers 
> > for pcf8583 in the kernel:-)
> 
>  ok.  here is my
> 
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> 
>  when you feel ready, you can send it to Andrew Morton
>  for inclusion in -mm.

The unmodified patch is below. Andrew, please, apply.

Thanks
Guennadi
---
Guennadi Liakhovetski

Signed-off-by: G. Liakhovetski <gl@dsa-ac.de>

diff -u /dev/null b/drivers/rtc/rtc-pcf8583.c
--- /dev/null	2004-06-30 21:04:37.000000000
+++ b/drivers/rtc/rtc-pcf8583.c	2006-05-03 12:31:03.147332245
@@ -0,0 +1,394 @@
+/*
+ *  drivers/rtc/rtc-pcf8583.c
+ *
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Driver for PCF8583 RTC & RAM chip
+ *
+ *  Converted to the generic RTC susbsystem by G. Liakhovetski (2006)
+ */
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/mc146818rtc.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/bcd.h>
+
+struct rtc_mem {
+	unsigned int	loc;
+	unsigned int	nr;
+	unsigned char	*data;
+};
+
+struct pcf8583 {
+	struct i2c_client client;
+	struct rtc_device *rtc;
+	unsigned char ctrl;
+};
+
+#define CTRL_STOP	0x80
+#define CTRL_HOLD	0x40
+#define CTRL_32KHZ	0x00
+#define CTRL_MASK	0x08
+#define CTRL_ALARMEN	0x04
+#define CTRL_ALARM	0x02
+#define CTRL_TIMER	0x01
+
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+
+/* Module parameters */
+I2C_CLIENT_INSMOD;
+
+static struct i2c_driver pcf8583_driver;
+
+#define get_ctrl(x)    ((struct pcf8583 *)i2c_get_clientdata(x))->ctrl
+#define set_ctrl(x, v) get_ctrl(x) = v
+
+#define CMOS_YEAR	(64 + 128)
+#define CMOS_CHECKSUM	(63)
+
+static int pcf8583_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	unsigned char buf[8], addr[1] = { 1 };
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = addr,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = 6,
+			.buf = buf,
+		}
+	};
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret == 2) {
+		dt->tm_year = buf[4] >> 6;
+		dt->tm_wday = buf[5] >> 5;
+
+		buf[4] &= 0x3f;
+		buf[5] &= 0x1f;
+
+		dt->tm_sec = BCD_TO_BIN(buf[1]);
+		dt->tm_min = BCD_TO_BIN(buf[2]);
+		dt->tm_hour = BCD_TO_BIN(buf[3]);
+		dt->tm_mday = BCD_TO_BIN(buf[4]);
+		dt->tm_mon = BCD_TO_BIN(buf[5]);
+	}
+
+	return ret == 2 ? 0 : -EIO;
+}
+
+static int pcf8583_set_datetime(struct i2c_client *client, struct rtc_time *dt, int datetoo)
+{
+	unsigned char buf[8];
+	int ret, len = 6;
+
+	buf[0] = 0;
+	buf[1] = get_ctrl(client) | 0x80;
+	buf[2] = 0;
+	buf[3] = BIN_TO_BCD(dt->tm_sec);
+	buf[4] = BIN_TO_BCD(dt->tm_min);
+	buf[5] = BIN_TO_BCD(dt->tm_hour);
+
+	if (datetoo) {
+		len = 8;
+		buf[6] = BIN_TO_BCD(dt->tm_mday) | (dt->tm_year << 6);
+		buf[7] = BIN_TO_BCD(dt->tm_mon)  | (dt->tm_wday << 5);
+	}
+
+	ret = i2c_master_send(client, (char *)buf, len);
+	if (ret != len)
+		return -EIO;
+
+	buf[1] = get_ctrl(client);
+	ret = i2c_master_send(client, (char *)buf, 2);
+
+	return ret == 2 ? 0 : -EIO;
+}
+
+static int pcf8583_get_ctrl(struct i2c_client *client, unsigned char *ctrl)
+{
+	*ctrl = get_ctrl(client);
+	return 0;
+}
+
+static int pcf8583_set_ctrl(struct i2c_client *client, unsigned char *ctrl)
+{
+	unsigned char buf[2];
+
+	buf[0] = 0;
+	buf[1] = *ctrl;
+	set_ctrl(client, *ctrl);
+
+	return i2c_master_send(client, (char *)buf, 2);
+}
+
+static int pcf8583_read_mem(struct i2c_client *client, struct rtc_mem *mem)
+{
+	unsigned char addr[1];
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = addr,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = mem->nr,
+			.buf = mem->data,
+		}
+	};
+
+	if (mem->loc < 8)
+		return -EINVAL;
+
+	addr[0] = mem->loc;
+
+	return i2c_transfer(client->adapter, msgs, 2) == 2 ? 0 : -EIO;
+}
+
+static int pcf8583_write_mem(struct i2c_client *client, struct rtc_mem *mem)
+{
+	unsigned char addr[1];
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = addr,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_NOSTART,
+			.len = mem->nr,
+			.buf = mem->data,
+		}
+	};
+
+	if (mem->loc < 8)
+		return -EINVAL;
+
+	addr[0] = mem->loc;
+
+	return i2c_transfer(client->adapter, msgs, 2) == 2 ? 0 : -EIO;
+}
+
+static int pcf8583_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned char ctrl, year[2];
+	struct rtc_mem mem = { CMOS_YEAR, sizeof(year), year };
+	int real_year, year_offset, err;
+
+	/*
+	 * Ensure that the RTC is running.
+	 */
+	pcf8583_get_ctrl(client, &ctrl);
+	if (ctrl & (CTRL_STOP | CTRL_HOLD)) {
+		unsigned char new_ctrl = ctrl & ~(CTRL_STOP | CTRL_HOLD);
+
+		printk(KERN_WARNING "RTC: resetting control %02x -> %02x\n",
+		       ctrl, new_ctrl);
+
+		if ((err = pcf8583_set_ctrl(client, &new_ctrl)) < 0)
+			return err;
+	}
+
+	if (pcf8583_get_datetime(client, tm) ||
+	    pcf8583_read_mem(client, &mem))
+		return -EIO;
+
+	real_year = year[0];
+
+	/*
+	 * The RTC year holds the LSB two bits of the current
+	 * year, which should reflect the LSB two bits of the
+	 * CMOS copy of the year.  Any difference indicates
+	 * that we have to correct the CMOS version.
+	 */
+	year_offset = tm->tm_year - (real_year & 3);
+	if (year_offset < 0)
+		/*
+		 * RTC year wrapped.  Adjust it appropriately.
+		 */
+		year_offset += 4;
+
+	tm->tm_year = real_year + year_offset + year[1] * 100;
+
+	return 0;
+}
+
+static int pcf8583_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned char year[2], chk;
+	struct rtc_mem cmos_year  = { CMOS_YEAR, sizeof(year), year };
+	struct rtc_mem cmos_check = { CMOS_CHECKSUM, 1, &chk };
+	int ret;
+
+	/*
+	 * The RTC's own 2-bit year must reflect the least
+	 * significant two bits of the CMOS year.
+	 */
+
+	ret = pcf8583_set_datetime(client, tm, 1);
+	if (ret)
+		return ret;
+
+	ret = pcf8583_read_mem(client, &cmos_check);
+	if (ret)
+		return ret;
+
+	ret = pcf8583_read_mem(client, &cmos_year);
+	if (ret)
+		return ret;
+
+	chk -= year[1] + year[0];
+
+	year[1] = tm->tm_year / 100;
+	year[0] = tm->tm_year % 100;
+
+	chk += year[1] + year[0];
+
+	ret = pcf8583_write_mem(client, &cmos_year);
+
+	if (ret)
+		return ret;
+
+	ret = pcf8583_write_mem(client, &cmos_check);
+
+	return ret;
+}
+
+static struct rtc_class_ops pcf8583_rtc_ops = {
+	.read_time	= pcf8583_rtc_read_time,
+	.set_time	= pcf8583_rtc_set_time,
+};
+
+static int pcf8583_probe(struct i2c_adapter *adap, int addr, int kind);
+
+static int pcf8583_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, pcf8583_probe);
+}
+
+static int pcf8583_detach(struct i2c_client *client)
+{
+	int err;
+	struct pcf8583 *pcf = i2c_get_clientdata(client);
+	struct rtc_device *rtc = pcf->rtc;
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(pcf);
+	return 0;
+}
+
+static struct i2c_driver pcf8583_driver = {
+	.driver = {
+		.name	= "pcf8583",
+	},
+	.id		= I2C_DRIVERID_PCF8583,
+	.attach_adapter	= pcf8583_attach,
+	.detach_client	= pcf8583_detach,
+};
+
+static int pcf8583_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct pcf8583 *pcf;
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+	unsigned char buf[1], ad[1] = { 0 };
+	int err;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = addr,
+			.flags = 0,
+			.len = 1,
+			.buf = ad,
+		}, {
+			.addr = addr,
+			.flags = I2C_M_RD,
+			.len = 1,
+			.buf = buf,
+		}
+	};
+
+	pcf = kzalloc(sizeof(*pcf), GFP_KERNEL);
+	if (!pcf)
+		return -ENOMEM;
+
+	client = &pcf->client;
+
+	client->addr		= addr;
+	client->adapter	= adap;
+	client->driver	= &pcf8583_driver;
+
+	strlcpy(client->name, pcf8583_driver.driver.name, I2C_NAME_SIZE);
+
+	if (i2c_transfer(client->adapter, msgs, 2) != 2) {
+		err = -EIO;
+		goto exit_kfree;
+	}
+
+	err = i2c_attach_client(client);
+
+	if (err)
+		goto exit_kfree;
+
+	rtc = rtc_device_register(pcf8583_driver.driver.name, &client->dev,
+				  &pcf8583_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		err = PTR_ERR(rtc);
+		goto exit_detach;
+	}
+
+	pcf->rtc = rtc;
+	i2c_set_clientdata(client, pcf);
+	set_ctrl(client, buf[0]);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(client);
+
+exit_kfree:
+	kfree(pcf);
+
+	return err;
+}
+
+static __init int pcf8583_init(void)
+{
+	return i2c_add_driver(&pcf8583_driver);
+}
+
+static __exit void pcf8583_exit(void)
+{
+	i2c_del_driver(&pcf8583_driver);
+}
+
+module_init(pcf8583_init);
+module_exit(pcf8583_exit);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("PCF8583 I2C RTC driver");
+MODULE_LICENSE("GPL");
diff -u a/drivers/rtc/Makefile b/drivers/rtc/Makefile
--- a/drivers/rtc/Makefile	2006-04-28 15:28:20.000000000
+++ b/drivers/rtc/Makefile	2006-05-02 15:06:47.000000000
@@ -15,6 +15,7 @@
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
+obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
diff -u a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig	2006-04-28 15:28:20.000000000
+++ b/drivers/rtc/Kconfig	2006-05-03 12:34:21.593469115
@@ -107,6 +107,16 @@
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8563.
 
+config RTC_DRV_PCF8583
+	tristate "Philips PCF8583"
+	depends on RTC_CLASS && I2C
+	help
+	  If you say yes here you get support for the
+	  Philips PCF8583 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf8583.
+
 config RTC_DRV_RS5C372
 	tristate "Ricoh RS5C372A/B"
 	depends on RTC_CLASS && I2C
