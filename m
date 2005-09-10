Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVIJKzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVIJKzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVIJKzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:55:40 -0400
Received: from [85.21.88.2] ([85.21.88.2]:34011 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750747AbVIJKzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:55:39 -0400
Message-ID: <4322BB9E.5020309@rbcmail.ru>
Date: Sat, 10 Sep 2005 14:55:26 +0400
From: Vital <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Underwood <basicmark@yahoo.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@ru.mvista.com
Subject: Re: [RFC][PATCH] SPI subsystem
References: <20050903101341.23080.qmail@web30307.mail.mud.yahoo.com>
In-Reply-To: <20050903101341.23080.qmail@web30307.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Underwood wrote:

<snip>

>+static int spi_test_probe(struct device *dev)
>+{
>+	struct spi_adapter *sadap;
>+	struct platform_device *pdev = to_platform_device(dev);	
>+	int stat;
>+	
>+	printk("spi_test_probe\n");
>+
>+	sadap = kmalloc(sizeof(struct spi_adapter), GFP_KERNEL);
>+	if(!sadap)
>+	{
>+		return -ENOMEM;
>+	}
>+	memset(sadap, 0, sizeof(struct spi_adapter));
>+
>+	sadap->spi_adap_cs = NULL;
>+	sadap->cs_table = ((struct spi_platform_data*) (pdev->dev.platform_data))->cs_table;
>+	sadap->max_cs = ((struct spi_platform_data*) (pdev->dev.platform_data))->max_cs;
>  
>
What if pdev->dev.platform_data is NULL?

<snip>

>diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/chips/spi-bar.c linux-2.6.10/drivers/spi/chips/spi-bar.c
>--- linux-2.6.10.orig/drivers/spi/chips/spi-bar.c	1970-01-01 01:00:00.000000000 +0100
>+++ linux-2.6.10/drivers/spi/chips/spi-bar.c	2005-09-02 17:29:16.000000000 +0100
>  
>
I'm afraid the example provided can not give any idea on the intended usage.

>diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/spi-core.c linux-2.6.10/drivers/spi/spi-core.c
>--- linux-2.6.10.orig/drivers/spi/spi-core.c	1970-01-01 01:00:00.000000000 +0100
>+++ linux-2.6.10/drivers/spi/spi-core.c	2005-09-02 17:29:50.000000000 +0100
>@@ -0,0 +1,613 @@
>+/*
>+ *  linux/driver/spi/spi-core.c - The spi subsystem core layer
>+ *
>+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ *
>+ * Authors:
>+ *	Mark Underwood
>+ */
>+
>+#include <linux/device.h>
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/err.h>
>+#include <linux/spi.h>
>+#include <linux/idr.h>
>+
>+#define SPI_CORE_NONE	0
>+#define SPI_CORE_BUS	1
>+#define SPI_CORE_DRIVER	2
>+#define SPI_CORE_CLASS	3
>+#define SPI_CORE_DONE	4
>+
>+static DEFINE_IDR(spi_adapter_idr);
>+
>+void __spi_device_unregister(struct spi_device * sdev);
>+int __spi_device_register(struct spi_device * sdev);
>  
>
Shouldn't those be static?

<snip>

>+
>+		memset(new_device,0,sizeof(struct spi_device));
>  
>
Spaces after semicolon please.

<snip>

>+fail1:
>+	for (j=0;j<(i-1);j++)
>  
>
Spaces again. How about using lindent?

<snip>

>+        flush_workqueue(adap->work_queue);
>  
>
Indentation/tabs.

<snip>

>+static int spi_suspend(struct device * dev, u32 state)
>+{
>+	struct device *child;
>+	int ret = 0;
>+
>+	/* First suspend all the children */
>+	list_for_each_entry(child, &dev->children, node) {
>+		if (child->driver && child->driver->suspend) {
>+			ret = child->driver->suspend(child, state, SUSPEND_DISABLE);
>+			if (ret == 0)
>+				ret = child->driver->suspend(child, state, SUSPEND_SAVE_STATE);
>+			if (ret == 0)
>+				ret = child->driver->suspend(child, state, SUSPEND_POWER_DOWN);
>+		}
>+	}
>  
>
Oh my God. It will be called 3 times for each child entry, isn't it?!

>+
>+	if (ret)
>+		return ret;
>+
>+	/* Then the adapter */
>+	if (dev->driver && dev->driver->suspend) {
>+		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
>+		if (ret == 0)
>+			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
>+		if (ret == 0)
>+			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
>+	}
>+
>+	return ret;
>+}
>  
>
Can you please clarify what is 'adapter' here: is it a bus or what?

>+
>+static int spi_resume(struct device * dev)
>+{
>+	int ret = 0;
>+	struct device *child;
>+
>+	/* First resume the adapter */
>+	if (dev->driver && dev->driver->resume) {
>+		ret = dev->driver->resume(dev, RESUME_POWER_ON);
>+		if (ret == 0)
>+			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
>+		if (ret == 0)
>+			ret = dev->driver->resume(dev, RESUME_ENABLE);
>+	}
>+
>+	if (ret)
>+		return ret;
>+
>+	/* Then all the children */
>+	list_for_each_entry(child, &dev->children, node) {
>+		if (child->driver && child->driver->resume) {
>+			ret = child->driver->resume(child, RESUME_POWER_ON);
>+			if (ret == 0)
>+				ret = child->driver->resume(child, RESUME_RESTORE_STATE);
>+			if (ret == 0)
>+				ret = child->driver->resume(child, RESUME_ENABLE);
>+			if (ret)
>+				break;
>+		}
>+	}
>+
>  
>
Same as for suspend.

And the basic idea anyway looks wrong and not LDM'ish.
What if your driver

+static struct device_driver spi_adapter_driver = {
+	.name =	"spi_adapter",
+	.bus = &spi_bus_type,
+	.probe = spi_adapter_probe,
+	.remove = spi_adapter_remove,
+};

presents also suspend/resume functions (what it should have done anyway).

Won't it be in a clash with your suspend/resume technique?

Also:

Can you please specify what is the difference between 'bus' and 'chip' 
in your model?
It's not clear to me how the following situation is handled. Suppose you 
have two SPI 'busses' with same devices (for instance, 2 SD card 
adapters) attached to different busses.
The work queues approach is also not quite clear.

But the main thing that seems to be not thought about at all is power 
management for the SPI busses/devices.
I'm afraid your approach needs serious rework in this area.

Best regards,
   Vitaly

