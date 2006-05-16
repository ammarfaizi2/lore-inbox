Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWEPVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWEPVqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEPVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:46:19 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:61373 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932174AbWEPVqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:46:19 -0400
Date: Tue, 16 May 2006 14:48:13 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] Add driver for ARM AMBA PL031 RTC
Message-ID: <20060516214813.GA28414@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a driver for the ARM PL031 RTC found on some ARM SOCs.
The driver is fairly trivial as the RTC only provides a read/write and
alarm capability.

Signed-off-by: Deepak <dsaxena@plexity.net>

---

Alessandro: What userland tool do I use to test alarm capability?

 drivers/rtc/Kconfig     |   10 ++
 drivers/rtc/Makefile    |    1 
 drivers/rtc/rtc-pl031.c |  245 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-pl031.c

4b821f9e1daffb15e4d102bab44660c3debe46e9
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..875ff5e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -157,6 +157,16 @@ config RTC_DRV_VR41XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-vr41xx.
 
+config RTC_DRV_PL031
+	tristate "ARM AMBA PL031 RTC"
+	depends on RTC_CLASS && ARM_AMBA
+	help
+	  If you say Y here you will get access to ARM AMBA
+	  PrimeCell PL031 RTC found on certain ARM SOCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-pl031.
+
 config RTC_DRV_TEST
 	tristate "Test driver/device"
 	depends on RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a9ca0f1..1b3f32e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
+obj-$(CONFIG_RTC_DRV_PL031)	+= rtc-pl031.o
diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
new file mode 100644
index 0000000..022ea36
--- /dev/null
+++ b/drivers/rtc/rtc-pl031.c
@@ -0,0 +1,245 @@
+/*
+ * drivers/rtc/rtc-pl031.c
+ *
+ * Real Time Clock interface for ARM AMBA PrimeCell 031 RTC
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2006 (c) MontaVista Software, Inc. 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/pm.h>
+
+#include <linux/amba/bus.h>
+
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/rtc.h>
+
+/*
+ * Register definitions
+ */
+#define	RTC_DR		0x00	/* Data read register */
+#define	RTC_MR		0x04	/* Match register */
+#define	RTC_LR		0x08	/* Data load register */
+#define	RTC_CR		0x0c	/* Control register */
+#define	RTC_IMSC	0x10	/* Interrupt mask and set register */
+#define	RTC_RIS		0x14	/* Raw interrupt status register */
+#define	RTC_MIS		0x18	/* Masked interrupt status register */
+#define	RTC_ICR		0x1c	/* Interrupt clear register */
+
+struct pl031_local {
+	struct rtc_device *rtc;
+	void __iomem *base;
+};
+
+static irqreturn_t pl031_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct rtc_device *rtc = (struct rtc_device *)dev_id;
+
+	rtc_update_irq(&rtc->class_dev, 1, RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static int pl031_read_callback(struct device *dev, int data)
+{
+	return data;
+}
+
+static int pl031_open(struct device *dev)
+{
+	/*
+	 * We request IRQ in pl031_probe, so nothing to do here...
+	 */
+	return 0;
+}
+
+static void pl031_release(struct device *dev)
+{
+}
+
+static int pl031_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+		__raw_writel(1, ldata->base + RTC_MIS);
+		return 0;
+	case RTC_AIE_ON:
+		__raw_writel(0, ldata->base + RTC_MIS);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int pl031_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	rtc_time_to_tm(__raw_readl(ldata->base + RTC_DR), tm);
+
+	return 0;
+}
+
+static int pl031_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned long time;
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	rtc_tm_to_time(tm, &time);
+	__raw_writel(time, ldata->base + RTC_LR);
+
+	return 0;
+}
+
+static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	rtc_time_to_tm(__raw_readl(ldata->base + RTC_MR), &alarm->time);
+	alarm->pending = __raw_readl(ldata->base + RTC_RIS);
+	alarm->enabled = __raw_readl(ldata->base + RTC_IMSC);
+
+	return 0;
+}
+
+static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+	unsigned long time;
+
+	rtc_tm_to_time(&alarm->time, &time);
+
+	__raw_writel(time, ldata->base + RTC_MR);
+	__raw_writel(!alarm->enabled, ldata->base + RTC_MIS);
+
+	return 0;
+}
+
+static int pl031_proc(struct device *dev, struct seq_file *seq)
+{
+	return 0;
+}
+
+static struct rtc_class_ops pl031_ops = {
+	.open = pl031_open,
+	.read_callback = pl031_read_callback,
+	.release = pl031_release,
+	.ioctl = pl031_ioctl,
+	.read_time = pl031_read_time,
+	.set_time = pl031_set_time,
+	.read_alarm = pl031_read_alarm,
+	.set_alarm = pl031_set_alarm,
+	.proc = pl031_proc,
+};
+
+static int pl031_remove(struct amba_device *adev)
+{
+	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
+
+	if (ldata) {
+		dev_set_drvdata(&adev->dev, NULL);
+		free_irq(adev->irq[0], ldata->rtc);
+		rtc_device_unregister(ldata->rtc);
+		iounmap(ldata->base);
+		kfree(ldata);
+	}
+
+	return 0;
+}
+
+static int pl031_probe(struct amba_device *adev, void *id)
+{
+	int ret;
+	struct pl031_local *ldata;
+
+
+	ldata = kmalloc(sizeof(struct pl031_local), GFP_KERNEL);
+	if (!ldata) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	dev_set_drvdata(&adev->dev, ldata);
+
+	ldata->base = ioremap(adev->res.start, 
+			      adev->res.end - adev->res.start + 1);
+	if (!ldata->base) {
+		ret = -ENOMEM;
+		goto out_no_remap;
+	}
+
+	if (request_irq(adev->irq[0], pl031_interrupt, SA_INTERRUPT,
+			"rtc-pl031", ldata->rtc)) {
+		ret = -EIO;
+		goto out_no_irq;
+	}
+
+	ldata->rtc = rtc_device_register("pl031", &adev->dev, &pl031_ops, 
+					 THIS_MODULE);
+	if (IS_ERR(ldata->rtc)) {
+		ret = PTR_ERR(ldata->rtc);
+		goto out_no_rtc;
+	}
+
+	return 0;
+
+out_no_rtc:
+	free_irq(adev->irq[0], ldata->rtc);
+out_no_irq:
+	iounmap(ldata->base);
+out_no_remap:
+	dev_set_drvdata(&adev->dev, NULL);
+	kfree(ldata);
+out:
+	return ret;
+}
+
+static struct amba_id pl031_ids[] __initdata = {
+	{
+		 .id = 0x00041031,
+	 	.mask = 0x000fffff, },
+	{0, 0},
+};
+
+static struct amba_driver pl031_driver = {
+	.drv = {
+		.name = "rtc-pl031",
+	},
+	.id_table = pl031_ids,
+	.probe = pl031_probe,
+	.remove = pl031_remove,
+};
+
+static int __init pl031_init(void)
+{
+	return amba_driver_register(&pl031_driver);
+}
+
+static void __exit pl031_exit(void)
+{
+	amba_driver_unregister(&pl031_driver);
+}
+
+module_init(pl031_init);
+module_exit(pl031_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net");
+MODULE_DESCRIPTION("ARM AMBA PL031 RTC Driver");
+MODULE_LICENSE("GPL");
