Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWHDOBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWHDOBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWHDOBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:01:11 -0400
Received: from serv07.server-center.de ([83.220.153.152]:44777 "EHLO
	serv07.server-center.de") by vger.kernel.org with ESMTP
	id S1161206AbWHDOBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:01:10 -0400
From: Alexander Bigga <ab@mycable.de>
Organization: mycable GmbH
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Fri, 4 Aug 2006 16:01:02 +0200
User-Agent: KMail/1.7.2
Cc: "Mark A. Greer" <mgreer@mvista.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, khali@linux-fr.org, akpm@osdl.org
References: <20060804.002146.88700683.anemo@mba.ocn.ne.jp> <20060804.004259.48803564.anemo@mba.ocn.ne.jp> <20060804002112.GB9109@mag.az.mvista.com>
In-Reply-To: <20060804002112.GB9109@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041601.03218.ab@mycable.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atsushi,


like you, I started recently with Mark's m41t00.c driver to add support for 
the new rtc-subsystem. Mark reviewed it and I added his changes.

There is still the question, if the code for the interrupt context 
(workqueues) should stay or not. You bracketed all this with CONFIG_GEN_RTC. 
I can't say, if this is a good idea. Maybe somebody else has some good 
comments.

The driver supports now four different STM rtc chips: M41T00, M41T80, M41T81 
and M41ST85. The chips M41ST84/85/87/94 should work similar as far the driver 
supports them. Maybe even more.

That's why I named the driver rtc-m41txx.c and not m41t00.c as the original 
one.

There is for sure still some work to do, so I appreciate any comments. 
The enclosed patch was tested with linux-2.6.18-rc3 on an embedded Alchemy 
MIPS-processor board (XXS1500).


Alexander


On Friday 04 August 2006 02:21, Mark A. Greer wrote:
> Atsushi,
>
> Alexander Bigga <ab@mycable.de> has been working on moving this driver
> over to [its proper place in] drivers/rtc.  Please sync up with him.
>
> I've included him on the cc list so he can see your email.
>
> Mark

--- linux-2.6.18-rc3/drivers/rtc/Makefile	2006-07-30 20:57:47.000000000 +0200
+++ linux-2.6.18-rc3-mips-dev/drivers/rtc/Makefile	2006-08-02 
11:16:44.000000000 +0200
@@ -23,6 +23,7 @@
 obj-$(CONFIG_RTC_DRV_S3C)	+= rtc-s3c.o
 obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
+obj-$(CONFIG_RTC_DRV_M41TXX)	+= rtc-m41txx.o
 obj-$(CONFIG_RTC_DRV_DS1553)	+= rtc-ds1553.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
--- linux-2.6.18-rc3/drivers/rtc/Kconfig	2006-07-30 20:57:47.000000000 +0200
+++ linux-2.6.18-rc3-mips-dev/drivers/rtc/Kconfig	2006-08-04 
14:26:12.000000000 +0200
@@ -218,6 +218,17 @@
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-m48t86.
 
+config RTC_DRV_M41TXX
+	tristate "ST M41Txx series RTC"
+	depends on RTC_CLASS
+	help
+	  If you say Y here you will get support for the
+	  ST M41T00 RTC chips series. Currently the following chips are
+	  supported: M41T00, M41T80, M41T81 and M41ST85
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-m41txx.
+
 config RTC_DRV_EP93XX
 	tristate "Cirrus Logic EP93XX"
 	depends on RTC_CLASS && ARCH_EP93XX
--- linux-2.6.18-rc3/drivers/rtc/rtc-m41txx.c	1970-01-01 01:00:00.000000000 
+0100
+++ linux-2.6.18-rc3-mips-dev/drivers/rtc/rtc-m41txx.c	2006-08-04 
14:23:08.000000000 +0200
@@ -0,0 +1,568 @@
+/*
+ * I2C client/driver for the ST M41T00 family of i2c rtc chips.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *         Alexander Bigga <ab@mycable.de>
+ *
+ * Based on m41t00.c by Mark A. Greer
+ *
+ * 2005, 2006 (c) MontaVista Software, Inc.
+ * 2006 (c) mycable GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/m41t00.h>
+#include <asm/time.h>
+#include <asm/rtc.h>
+
+#define M41TXX_SEC_ST		(1 << 7)	/* ST: Stop Bit */
+#define M41TXX_HOUR_CB		(1 << 6)	/* CB: Century Bit */
+#define M41TXX_HOUR_CEB		(1 << 7)	/* CEB: Century Enable Bit */
+#define M41TXX_ALHOUR_HT	(1 << 6)	/* HT: Halt Update Bit */
+#define M41TXX_FLAGS_BATT_LOW	(1 << 4)	/* BL: Battery Low Bit */
+
+#define M41TXX_FEATURE_HT	(1 << 0)
+#define M41TXX_FEATURE_BL	(1 << 1)
+
+#define DRV_VERSION "0.03"
+
+
+static struct i2c_driver m41txx_driver;
+static struct i2c_client *save_client;
+
+static unsigned short normal_i2c[] = { M41T00_I2C_ADDR, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD;
+
+/* Prototypes */
+static int m41txx_attach(struct i2c_adapter *adapter);
+static int m41txx_detach(struct i2c_client *client);
+static int m41txx_probe(struct i2c_adapter *adapter, int address,
+			int kind);
+
+/* exports the i2c_client structure; used by a m41t85 watchdog-driver. */
+struct i2c_client *m41txx_get_i2c_client(void)
+{
+	return save_client;
+}
+EXPORT_SYMBOL(m41txx_get_i2c_client);
+
+static struct i2c_driver m41txx_driver = {
+	.driver = {
+		   .name = M41T00_DRV_NAME,
+		   },
+	.id = I2C_DRIVERID_STM41T00,
+	.attach_adapter = &m41txx_attach,
+	.detach_client = &m41txx_detach,
+};
+
+struct m41txx_chip_info {
+	u8 type;
+	char *name;
+	u8 read_limit;
+	u8 sec;			/* Offsets for chip regs */
+	u8 min;
+	u8 hour;
+	u8 wday;
+	u8 day;
+	u8 mon;
+	u8 year;
+	u8 alarm_mon;
+	u8 alarm_hour;
+	u8 flags;
+	u8 sqw;
+	u8 sqw_freq;
+	u8 features;
+};
+
+static struct m41txx_chip_info m41txx_chip_info_tbl[] = {
+	{ /* M41T00/11 */
+	 .type		= M41T00_TYPE_M41T00,
+	 .name		= "m41t00",
+	 .read_limit	= 5,
+	 .sec		= 0,
+	 .min		= 1,
+	 .hour		= 2,
+	 .wday		= 3,
+	 .day		= 4,
+	 .mon		= 5,
+	 .year		= 6,
+	 .features	= 0,
+	 },
+	 { /* M41T80 */
+	 .type		= M41T00_TYPE_M41T80,
+	 .name		= "m41t80",
+	 .read_limit 	= 1,
+	 .sec		= 1,
+	 .min		= 2,
+	 .hour		= 3,
+	 .wday		= 4,
+	 .day		= 5,
+	 .mon		= 6,
+	 .year		= 7,
+	 .alarm_mon	= 0xa,
+	 .alarm_hour	= 0xc,
+	 .flags		= 0xf,
+	 .sqw		= 0x13,
+	 .features	= 0,
+	 },
+	 { /* M41T81 */
+	 .type		= M41T00_TYPE_M41T81,
+	 .name		= "m41t81",
+	 .read_limit 	= 1,
+	 .sec		= 1,
+	 .min		= 2,
+	 .hour		= 3,
+	 .wday		= 4,
+	 .day		= 5,
+	 .mon		= 6,
+	 .year		= 7,
+	 .alarm_mon	= 0xa,
+	 .alarm_hour	= 0xc,
+	 .flags		= 0xf,
+	 .sqw		= 0x13,
+	 .features	= M41TXX_FEATURE_HT,
+	 },
+	 { /* M41ST84/85/87/94 */
+	 .type		= M41T00_TYPE_M41T85,
+	 .name		= "m41t85",
+	 .read_limit	= 1,
+	 .sec		= 1,
+	 .min		= 2,
+	 .hour		= 3,
+	 .wday		= 4,
+	 .day		= 5,
+	 .mon		= 6,
+	 .year		= 7,
+	 .alarm_mon	= 0xa,
+	 .alarm_hour	= 0xc,
+	 .flags		= 0xf,
+	 .sqw		= 0x13,
+	 .features	= M41TXX_FEATURE_HT | M41TXX_FEATURE_BL,
+	 },
+};
+static struct m41txx_chip_info *m41txx_chip;
+
+static int m41txx_get_datetime(struct i2c_client *client,
+			       struct rtc_time *tm)
+{
+
+	s32 sec, min, hour, day, mon, year;
+	s32 sec1, min1, hour1, day1, mon1, year1;
+	u8 reads = 0;
+	u8 buf[8], dt_addr[1] = { 0 };	/* offset into rtc's regs */
+
+	struct i2c_msg msgs[] = {
+		{
+		 .addr 	= client->addr,
+		 .flags = 0,
+		 .len 	= 1,
+		 .buf 	= dt_addr,
+		 },
+		{
+		 .addr 	= client->addr,
+		 .flags = I2C_M_RD,
+		 .len 	= 8,
+		 .buf 	= buf,
+		 },
+	};
+
+	sec = min = hour = day = mon = year = 0;
+
+	do {
+		if (i2c_transfer(client->adapter, msgs, 2) < 0)
+			goto read_err;
+
+		sec1 = sec;
+		min1 = min;
+		hour1 = hour;
+		day1 = day;
+		mon1 = mon;
+		year1 = year;
+
+		sec = buf[m41txx_chip->sec] & 0x7f;
+		min = buf[m41txx_chip->min] & 0x7f;
+		hour = buf[m41txx_chip->hour] & 0x3f;
+		day = buf[m41txx_chip->day] & 0x3f;
+		mon = buf[m41txx_chip->mon] & 0x1f;
+		year = buf[m41txx_chip->year];
+
+	} while ((++reads < m41txx_chip->read_limit) && ((sec != sec1)
+			|| (min != min1) || (hour != hour1) || (day != day1)
+			|| (mon != mon1) || (year != year1)));
+
+	if ((m41txx_chip->read_limit > 1)
+	    && ((sec != sec1) || (min != min1)
+		|| (hour != hour1) || (day != day1) || (mon != mon1)
+		|| (year != year1)))
+		goto read_err;
+
+	tm->tm_sec = BCD2BIN(sec);
+	tm->tm_min = BCD2BIN(min);
+	tm->tm_hour = BCD2BIN(hour);
+	tm->tm_mday = BCD2BIN(day);
+	tm->tm_wday = buf[m41txx_chip->wday] & 0x07;
+	tm->tm_mon = BCD2BIN(mon) - 1;
+
+	if (buf[m41txx_chip->hour] & M41TXX_HOUR_CB)
+		tm->tm_year = BCD2BIN(year) + 100;
+	else
+		tm->tm_year = BCD2BIN(year);
+
+	return 0;
+
+read_err:
+	dev_err(&client->dev, "m41txx_get_datetime: Read error\n");
+	return 0;
+}
+
+
+/* Sets the given date and time to the real time clock. */
+int m41txx_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned char buf[8];
+	unsigned char wbuf[8];
+	unsigned char dt_addr[1] = { 0 };	/* offset into rtc's regs */
+
+	struct i2c_msg msgs_in[] = {
+		{
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= dt_addr,
+		},
+		{
+		.addr	= client->addr,
+		.flags	= I2C_M_RD,
+		.len	= 8,
+		.buf	= wbuf,
+		},
+	};
+	struct i2c_msg msgs[] = {
+		{
+		 .addr = client->addr,
+		 .flags = 0,
+		 .len = 8,
+		 .buf = buf,
+		 },
+	};
+
+	/* Read current reg values into wbuf[0..8] */
+	if (i2c_transfer(client->adapter, msgs_in, 2) < 0)
+		goto read_err;
+
+	/* Merge time-data and register flags into buf[0..8] */
+	buf[0] = 0x01;
+	buf[m41txx_chip->sec] = BIN2BCD(tm->tm_sec)
+					| (wbuf[m41txx_chip->sec] & ~0x7f);
+	buf[m41txx_chip->min] = BIN2BCD(tm->tm_min)
+					| (wbuf[m41txx_chip->min] & ~0x7f);
+	if (tm->tm_year > 100) {
+		/* M41T85_REG_HOUR_CB enables the CENTURY Bit (CB) */
+		buf[m41txx_chip->hour] = BIN2BCD(tm->tm_hour)
+			| M41TXX_HOUR_CB | M41TXX_HOUR_CEB ;
+		buf[m41txx_chip->year] = BIN2BCD(tm->tm_year - 100);
+	} else {
+		buf[m41txx_chip->hour] = BIN2BCD(tm->tm_hour);
+		buf[m41txx_chip->year] = BIN2BCD(tm->tm_year);
+	}
+	buf[m41txx_chip->wday] = (tm->tm_wday & 0x07)
+					| (wbuf[m41txx_chip->wday] & ~0x07);
+	buf[m41txx_chip->day] = BIN2BCD(tm->tm_mday)
+					| (wbuf[m41txx_chip->day] & ~0x3f);
+	buf[m41txx_chip->mon] = BIN2BCD(tm->tm_mon + 1)
+					| (wbuf[m41txx_chip->mon] & ~0x1f);
+
+	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
+		dev_err(&client->dev, "%s: write error\n", __FUNCTION__);
+		return -EIO;
+	}
+	return 0;
+read_err:
+	dev_err(&client->dev, "m41txx_set_datetime: Read error\n");
+	return 0;
+}
+
+ulong m41t00_get_rtc_time(void)
+{
+	struct rtc_time tm;
+
+	m41txx_get_datetime(save_client, &tm);
+
+	return mktime(tm.tm_year, tm.tm_mon,
+		      tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
+EXPORT_SYMBOL_GPL(m41t00_get_rtc_time);
+
+static void m41txx_set(void *arg)
+{
+	struct rtc_time tm;
+	int nowtime = *(int *) arg;
+
+	to_tm(nowtime, &tm);
+	m41txx_set_datetime(save_client, &tm);
+
+}
+
+static ulong new_time;
+static struct workqueue_struct *m41txx_wq;
+static DECLARE_WORK(m41txx_work, m41txx_set, &new_time);
+
+int m41t00_set_rtc_time(ulong nowtime)
+{
+	new_time = nowtime;
+
+	if (in_interrupt())
+		queue_work(m41txx_wq, &m41txx_work);
+	else
+		m41txx_set(&new_time);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(m41t00_set_rtc_time);
+
+/*
+ 
*****************************************************************************
+ *
+ *	platform_data Driver Interface
+ *
+ 
*****************************************************************************
+ */
+static int __init m41txx_platform_probe(struct platform_device *pdev)
+{
+	struct m41t00_platform_data *pdata;
+	int i;
+
+	if (pdev && (pdata = pdev->dev.platform_data)) {
+		normal_i2c[0] = pdata->i2c_addr;
+
+		for (i = 0; i < ARRAY_SIZE(m41txx_chip_info_tbl); i++)
+			if (m41txx_chip_info_tbl[i].type == pdata->type) {
+				m41txx_chip = &m41txx_chip_info_tbl[i];
+				m41txx_chip->sqw_freq = pdata->sqw_freq;
+				return i2c_add_driver(&m41txx_driver);
+			}
+	}
+	return -ENODEV;
+}
+
+static int __exit m41txx_platform_remove(struct platform_device *pdev)
+{
+	return i2c_del_driver(&m41txx_driver);
+}
+
+static struct platform_driver m41txx_platform_driver = {
+	.probe = m41txx_platform_probe,
+	.remove = m41txx_platform_remove,
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = M41T00_DRV_NAME,
+		   },
+};
+
+static int m41txx_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	unsigned char reg;
+
+	if (m41txx_chip->flags & M41TXX_FEATURE_BL ) {
+		reg = i2c_smbus_read_byte_data(to_i2c_client(dev),
+							m41txx_chip->flags);
+		seq_printf(seq, "battery\t\t: %s\n",
+			(reg & M41TXX_FLAGS_BATT_LOW) ? "exhausted" : "ok");
+	}
+	return 0;
+}
+
+static int m41txx_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return m41txx_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int m41txx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return m41txx_set_datetime(to_i2c_client(dev), tm);
+}
+
+
+static struct rtc_class_ops m41txx_rtc_ops = {
+	.read_time = m41txx_rtc_read_time,
+	.set_time = m41txx_rtc_set_time,
+	.proc = m41txx_rtc_proc,
+};
+
+/*
+ 
*****************************************************************************
+ *
+ *	Driver Interface
+ *
+ 
*****************************************************************************
+ */
+static int m41txx_probe(struct i2c_adapter *adapter, int address, int kind)
+{
+	int rc = 0;
+
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+	struct rtc_time tm;
+
+	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C
+				     | I2C_FUNC_SMBUS_BYTE_DATA)) {
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	if (!(client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	/* I2C client */
+	strlcpy(client->name, m41txx_chip->name, I2C_NAME_SIZE);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &m41txx_driver;
+
+	/* Inform the i2c layer */
+	if ((rc = i2c_attach_client(client)))
+		goto exit_kfree;
+
+	dev_info(&client->dev,
+		 "chip found, driver version " DRV_VERSION "\n");
+
+	rtc = rtc_device_register(m41txx_chip->name, &client->dev,
+				  &m41txx_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		rc = PTR_ERR(rtc);
+		goto exit_detach;
+	}
+
+	i2c_set_clientdata(client, rtc);
+
+	if (m41txx_chip->type != M41T00_TYPE_M41T00) {
+		/* If asked, disable SQW, set SQW frequency & re-enable */
+		if (m41txx_chip->sqw_freq)
+			if (((rc = i2c_smbus_read_byte_data(client,
+					m41txx_chip->alarm_mon)) < 0)
+			 || ((rc = i2c_smbus_write_byte_data(client,
+					m41txx_chip->alarm_mon,
+					rc & ~0x40)) < 0)
+			 || ((rc = i2c_smbus_write_byte_data(client,
+					m41txx_chip->sqw,
+					m41txx_chip->sqw_freq)) < 0)
+			 || ((rc = i2c_smbus_write_byte_data(client,
+					m41txx_chip->alarm_mon,
+					rc | 0x40)) < 0))
+				goto sqw_err;
+
+		/* Make sure HT (Halt Update) bit is cleared */
+		if ((rc = i2c_smbus_read_byte_data(client,
+				m41txx_chip->alarm_hour)) < 0)
+			goto ht_err;
+
+		if (rc & M41TXX_ALHOUR_HT) {
+			if (m41txx_chip->features & M41TXX_FEATURE_HT) {
+				m41txx_get_datetime(client, &tm);
+				dev_info(&client->dev,
+					  "%s HT bit was set!\n", __FUNCTION__);
+				dev_info(&client->dev,
+					"%s Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
+					__FUNCTION__, tm.tm_year + 1900,
+					tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
+					tm.tm_min, tm.tm_sec);
+			}
+			if ((rc = i2c_smbus_write_byte_data(client,
+					m41txx_chip->alarm_hour,
+					rc & ~M41TXX_ALHOUR_HT)) < 0)
+				goto ht_err;
+		}
+	}
+
+	/* Make sure ST (stop) bit is cleared */
+	if ((rc = i2c_smbus_read_byte_data(client, m41txx_chip->sec)) < 0)
+		goto st_err;
+
+	if (rc & M41TXX_SEC_ST)
+		if ((rc = i2c_smbus_write_byte_data(client, m41txx_chip->sec,
+		     rc & ~M41TXX_SEC_ST)) < 0)
+			goto st_err;
+
+	m41txx_wq = create_singlethread_workqueue(m41txx_chip->name);
+	save_client = client;
+	return 0;
+
+st_err:
+	dev_err(&client->dev, "%s: Can't clear ST bit\n", __FUNCTION__);
+	goto exit_detach;
+ht_err:
+	dev_err(&client->dev, "%s: Can't clear HT bit\n", __FUNCTION__);
+	goto exit_detach;
+sqw_err:
+	dev_err(&client->dev, "%s: Can't set SQW Frequency\n",
+		__FUNCTION__);
+
+exit_detach:
+	i2c_detach_client(client);
+exit_kfree:
+	kfree(client);
+exit:
+	return rc;
+}
+
+static int m41txx_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, m41txx_probe);
+}
+
+static int m41txx_detach(struct i2c_client *client)
+{
+	int rc;
+
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	if ((rc = i2c_detach_client(client)) == 0) {
+		if (m41txx_wq)
+			destroy_workqueue(m41txx_wq);
+		kfree(client);
+	}
+
+	return rc;
+}
+
+static int __init m41txx_rtc_init(void)
+{
+	return platform_driver_register(&m41txx_platform_driver);
+}
+
+
+static void __exit m41txx_rtc_exit(void)
+{
+	platform_driver_unregister(&m41txx_platform_driver);
+}
+
+MODULE_AUTHOR
+    ("Mark A. Greer <mgreer@mvista.com>, Alexander Bigga <ab@mycable.de>");
+MODULE_DESCRIPTION("ST Microelectronics M41T00 RTC I2C Client Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(m41txx_rtc_init);
+module_exit(m41txx_rtc_exit);
--- linux-2.6.18-rc3/include/linux/m41t00.h	2006-07-30 20:57:47.000000000 
+0200
+++ linux-2.6.18-rc3-mips-dev/include/linux/m41t00.h	2006-08-04 
11:50:19.000000000 +0200
@@ -16,6 +16,7 @@
 #define	M41T00_I2C_ADDR		0x68
 
 #define	M41T00_TYPE_M41T00	0
+#define	M41T00_TYPE_M41T80	80
 #define	M41T00_TYPE_M41T81	81
 #define	M41T00_TYPE_M41T85	85
 
-- 
Alexander Bigga     Tel: +49 4873 90 10 866
mycable GmbH        Fax: +49 4873 901 976
Boeker Stieg 43
D-24613 Aukrug      eMail: ab@mycable.de

