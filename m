Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWFURdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFURdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWFURdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:33:04 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:24267 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750765AbWFURdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:33:02 -0400
Date: Thu, 22 Jun 2006 02:34:06 +0900 (JST)
Message-Id: <20060622.023406.55511892.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, akpm@osdl.org
Subject: [PATCH] RTC: add rtc-rs5c348 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SPI driver for the Ricoh RS5C348 RTC chip.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..c4d0ce7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -107,6 +107,16 @@ config RTC_DRV_PCF8563
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8563.
 
+config RTC_DRV_RS5C348
+	tristate "Ricoh RS5C348A/B"
+	depends on RTC_CLASS && SPI
+	help
+	  If you say yes here you get support for the
+	  Ricoh RS5C348A and RS5C348B RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-rs5c348.
+
 config RTC_DRV_RS5C372
 	tristate "Ricoh RS5C372A/B"
 	depends on RTC_CLASS && I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a9ca0f1..cfffe20 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
+obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
new file mode 100644
index 0000000..314c641
--- /dev/null
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -0,0 +1,280 @@
+/*
+ * A SPI driver for the Ricoh RS5C348 RTC
+ *
+ * Copyright (C) 2006 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bcd.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/rtc.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+
+#define DRV_VERSION "0.1"
+
+#define RS5C348_REG_SECS	0
+#define RS5C348_REG_MINS	1
+#define RS5C348_REG_HOURS	2
+#define RS5C348_REG_WDAY	3
+#define RS5C348_REG_DAY	4
+#define RS5C348_REG_MONTH	5
+#define RS5C348_REG_YEAR	6
+#define RS5C348_REG_CTL1	14
+#define RS5C348_REG_CTL2	15
+
+#define RS5C348_SECS_MASK	0x7f
+#define RS5C348_MINS_MASK	0x7f
+#define RS5C348_HOURS_MASK	0x3f
+#define RS5C348_WDAY_MASK	0x03
+#define RS5C348_DAY_MASK	0x3f
+#define RS5C348_MONTH_MASK	0x1f
+
+#define RS5C348_BIT_PM	0x20	/* REG_HOURS */
+#define RS5C348_BIT_Y2K	0x80	/* REG_MONTH */
+#define RS5C348_BIT_24H	0x20	/* REG_CTL1 */
+#define RS5C348_BIT_XSTP	0x10	/* REG_CTL2 */
+#define RS5C348_BIT_VDET	0x40	/* REG_CTL2 */
+
+#define RS5C348_CMD_W(addr)	(((addr) << 4) | 0x08)	/* single write */
+#define RS5C348_CMD_R(addr)	(((addr) << 4) | 0x0c)	/* single read */
+#define RS5C348_CMD_MW(addr)	(((addr) << 4) | 0x00)	/* burst write */
+#define RS5C348_CMD_MR(addr)	(((addr) << 4) | 0x04)	/* burst read */
+
+struct rs5c348_plat_data {
+	struct rtc_device *rtc;
+	int rtc_24h;
+	void *xferbuf;
+};
+
+static int
+rs5c348_io(struct spi_device *spi,
+	   const unsigned char *inbuf, unsigned char *outbuf,
+	   unsigned int count)
+{
+	struct spi_message m;
+	struct spi_transfer t;
+	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
+	int ret;
+
+	spi_message_init(&m);
+	memset(&t, 0, sizeof(t));
+	spi_message_add_tail(&t, &m);
+
+	memcpy(pdata->xferbuf, inbuf, count);
+	t.tx_buf = pdata->xferbuf;
+	t.rx_buf = pdata->xferbuf + count;
+	t.len = count;
+
+	ret = spi_sync(spi, &m);
+
+	udelay(62);	/* Tcsr 62us */
+	memcpy(outbuf, t.rx_buf, count);
+	return ret < 0 ? ret : m.status;
+}
+
+static int
+rs5c348_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
+	unsigned char inbuf[11], *inp;
+
+	inp = inbuf;
+	/* Transfer 4 bytes before writing SEC.  This gives 31us for carry. */
+	*inp++ = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	inp++;
+	*inp++ = RS5C348_CMD_MW(RS5C348_REG_CTL2); /* cmd, ctl2, sec, ... */
+	*inp++ = 0x57;	/* mask W0C bits */
+	*inp++ = BIN2BCD(tm->tm_sec);
+	*inp++ = BIN2BCD(tm->tm_min);
+
+	if (pdata->rtc_24h) {
+		*inp++ = BIN2BCD(tm->tm_hour);
+	} else {
+		/* hour 0 is AM12, noon is PM12 */
+		*inp++ = BIN2BCD((tm->tm_hour + 11) % 12 + 1) |
+			(tm->tm_hour >= 12 ? RS5C348_BIT_PM : 0);
+	}
+	*inp++ = BIN2BCD(tm->tm_wday);
+	*inp++ = BIN2BCD(tm->tm_mday);
+	*inp++ = BIN2BCD(tm->tm_mon + 1) |
+		(tm->tm_year >= 100 ? RS5C348_BIT_Y2K : 0);
+	*inp++ = BIN2BCD(tm->tm_year % 100);
+	/* write in one transfer to avoid data inconsistency */
+	return rs5c348_io(spi, inbuf, NULL, sizeof(inbuf));
+}
+
+static int
+rs5c348_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
+	unsigned char inbuf[11], outbuf[11], *outp;
+	unsigned int y2k;
+	int ret;
+
+	memset(inbuf, 0, sizeof(inbuf));
+	/* Transfer 4 byte befores reading SEC.  This gives 31us for carry. */
+	inbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
+	inbuf[2] = RS5C348_CMD_MR(RS5C348_REG_CTL2); /* cmd, ctl2, sec, ... */
+	/* read in one transfer to avoid data inconsistency */
+	ret = rs5c348_io(spi, inbuf, outbuf, sizeof(inbuf));
+	if (ret < 0)
+		return ret;
+	outp = outbuf + 4;	/* cmd, ctl2, cmd, ctl2 */
+	tm->tm_sec = BCD2BIN(*outp & RS5C348_SECS_MASK);
+	outp++;
+	tm->tm_min = BCD2BIN(*outp & RS5C348_MINS_MASK);
+	outp++;
+	tm->tm_hour = BCD2BIN(*outp & RS5C348_HOURS_MASK);
+	if (!pdata->rtc_24h) {
+		tm->tm_hour %= 12;
+		if (*outp & RS5C348_BIT_PM)
+			tm->tm_hour += 12;
+	}
+	outp++;
+	tm->tm_wday = BCD2BIN(*outp & RS5C348_WDAY_MASK);
+	outp++;
+	tm->tm_mday = BCD2BIN(*outp & RS5C348_DAY_MASK);
+	outp++;
+	y2k = *outp & RS5C348_BIT_Y2K;
+	tm->tm_mon = BCD2BIN(*outp & RS5C348_MONTH_MASK) - 1;
+	outp++;
+	/* year is 1900 + tm->tm_year */
+	tm->tm_year = BCD2BIN(*outp) + (y2k ? 100 : 0);
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(&spi->dev, "retrieved date/time is not valid.\n");
+		rtc_time_to_tm(0, tm);
+	}
+
+	return 0;
+}
+
+static struct rtc_class_ops rs5c348_rtc_ops = {
+	.read_time	= rs5c348_rtc_read_time,
+	.set_time	= rs5c348_rtc_set_time,
+};
+
+static struct spi_driver rs5c348_driver;
+
+static int __devinit rs5c348_probe(struct spi_device *spi)
+{
+	int ret;
+	struct rtc_device *rtc;
+	struct rs5c348_plat_data *pdata;
+
+	/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
+	spi->mode = SPI_MODE_1 | SPI_CS_HIGH;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	pdata = kzalloc(sizeof(struct rs5c348_plat_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	/* allocate a DMA-safe buffer */
+	pdata->xferbuf = kmalloc(32, GFP_KERNEL);
+	if (!pdata->xferbuf) {
+		ret = -ENOMEM;
+		goto kfree_exit;
+	}
+	spi->dev.platform_data = pdata;
+
+	/* Check D7 of SECOND register */
+	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_SECS));
+	if (ret < 0 || (ret & 0x80)) {
+		dev_err(&spi->dev, "not found.\n");
+		goto kfree_exit;
+	}
+
+	dev_info(&spi->dev, "chip found, driver version " DRV_VERSION "\n");
+	dev_info(&spi->dev, "spiclk %u KHz.\n",
+		 (spi->max_speed_hz + 500) / 1000);
+
+	/* turn RTC on if it was not on */
+	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL2));
+	if (ret < 0)
+		goto kfree_exit;
+	if (ret & (RS5C348_BIT_XSTP | RS5C348_BIT_VDET)) {
+		u8 buf[2];
+		if (ret & RS5C348_BIT_VDET)
+			dev_warn(&spi->dev, "voltage-low detected.\n");
+		buf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
+		buf[1] = 0;
+		ret = spi_write_then_read(spi, buf, sizeof(buf), NULL, 0);
+		if (ret < 0)
+			goto kfree_exit;
+	}
+
+	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL1));
+	if (ret < 0)
+		goto kfree_exit;
+	if (ret & RS5C348_BIT_24H)
+		pdata->rtc_24h = 1;
+
+	rtc = rtc_device_register(rs5c348_driver.driver.name, &spi->dev,
+				  &rs5c348_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto kfree_exit;
+	}
+
+	pdata->rtc = rtc;
+
+	return 0;
+ kfree_exit:
+	kfree(pdata->xferbuf);
+	kfree(pdata);
+	return ret;
+}
+
+static int __devexit rs5c348_remove(struct spi_device *spi)
+{
+	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
+	struct rtc_device *rtc = pdata->rtc;
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+	kfree(pdata->xferbuf);
+	kfree(pdata);
+	return 0;
+}
+
+static struct spi_driver rs5c348_driver = {
+	.driver = {
+		.name	= "rs5c348",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= rs5c348_probe,
+	.remove	= __devexit_p(rs5c348_remove),
+};
+
+static __init int rs5c348_init(void)
+{
+	return spi_register_driver(&rs5c348_driver);
+}
+
+static __exit void rs5c348_exit(void)
+{
+	spi_unregister_driver(&rs5c348_driver);
+}
+
+module_init(rs5c348_init);
+module_exit(rs5c348_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("Ricoh RS5C348 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
