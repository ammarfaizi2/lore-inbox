Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVIJLyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIJLyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVIJLyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:54:51 -0400
Received: from web30303.mail.mud.yahoo.com ([68.142.200.96]:12161 "HELO
	web30303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750760AbVIJLyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:54:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Dcb/66hmS+GNX/vAQq6rLP2YryxemT23yPOryJ8V/vvAJubBHGenlXc7pMM0iZR7MGESgs5Xf4WazEbN0D2Q3agOHL/6NbRmnE2Cohpl/s+SGpp7x7dE+TQoj+o5q2wvggYqSRaUeMa7yROhn/X1gAIuzIZ9HgCGJ11bRMNx12U=  ;
Message-ID: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com>
Date: Sat, 10 Sep 2005 12:54:34 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: Vital <vitalhome@rbcmail.ru>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@ru.mvista.com
In-Reply-To: <4322BB9E.5020309@rbcmail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vital <vitalhome@rbcmail.ru> wrote:

> Mark Underwood wrote:
> 
> <snip>
> 
> >+static int spi_test_probe(struct device *dev)
> >+{
> >+ struct spi_adapter *sadap;
> >+ struct platform_device *pdev =
> to_platform_device(dev); 
> >+ int stat;
> >+ 
> >+ printk("spi_test_probe\n");
> >+
> >+ sadap = kmalloc(sizeof(struct spi_adapter),
> GFP_KERNEL);
> >+ if(!sadap)
> >+ {
> >+  return -ENOMEM;
> >+ }
> >+ memset(sadap, 0, sizeof(struct spi_adapter));
> >+
> >+ sadap->spi_adap_cs = NULL;
> >+ sadap->cs_table = ((struct spi_platform_data*)
> (pdev->dev.platform_data))->cs_table;
> >+ sadap->max_cs = ((struct spi_platform_data*)
> (pdev->dev.platform_data))->max_cs;
> >  
> >
> What if pdev->dev.platform_data is NULL?

Thanks for pointing this one out:).

> 
> <snip>
> 
> >diff -uprN -X dontdiff
> linux-2.6.10.orig/drivers/spi/chips/spi-bar.c
> linux-2.6.10/drivers/spi/chips/spi-bar.c
> >--- linux-2.6.10.orig/drivers/spi/chips/spi-bar.c
> 1970-01-01 01:00:00.000000000 +0100
> >+++ linux-2.6.10/drivers/spi/chips/spi-bar.c
> 2005-09-02 17:29:16.000000000 +0100
> >  
> >
> I'm afraid the example provided can not give any
> idea on the intended usage.

I know! I said that this only shows the registration &
unregistration of SPI devices and adapters, the
transfer routines will be coming next!

> 
> >diff -uprN -X dontdiff
> linux-2.6.10.orig/drivers/spi/spi-core.c
> linux-2.6.10/drivers/spi/spi-core.c
> >--- linux-2.6.10.orig/drivers/spi/spi-core.c
> 1970-01-01 01:00:00.000000000 +0100
> >+++ linux-2.6.10/drivers/spi/spi-core.c 2005-09-02
> 17:29:50.000000000 +0100
> >@@ -0,0 +1,613 @@
> >+/*
> >+ *  linux/driver/spi/spi-core.c - The spi
> subsystem core layer
> >+ *
> >+ *  Copyright (C) 2005 Philips Semicondutors, All
> Rights Reserved.
> >+ *
> >+ * This program is free software; you can
> redistribute it and/or modify
> >+ * it under the terms of the GNU General Public
> License version 2 as
> >+ * published by the Free Software Foundation.
> >+ *
> >+ * Authors:
> >+ * Mark Underwood
> >+ */
> >+
> >+#include <linux/device.h>
> >+#include <linux/module.h>
> >+#include <linux/init.h>
> >+#include <linux/err.h>
> >+#include <linux/spi.h>
> >+#include <linux/idr.h>
> >+
> >+#define SPI_CORE_NONE 0
> >+#define SPI_CORE_BUS 1
> >+#define SPI_CORE_DRIVER 2
> >+#define SPI_CORE_CLASS 3
> >+#define SPI_CORE_DONE 4
> >+
> >+static DEFINE_IDR(spi_adapter_idr);
> >+
> >+void __spi_device_unregister(struct spi_device *
> sdev);
> >+int __spi_device_register(struct spi_device *
> sdev);
> >  
> >
> Shouldn't those be static?

Yep.

> 
> <snip>
> 
> >+
> >+  memset(new_device,0,sizeof(struct spi_device));
> >  
> >
> Spaces after semicolon please.
> 
> <snip>
> 
> >+fail1:
> >+ for (j=0;j<(i-1);j++)
> >  
> >
> Spaces again. How about using lindent?

Cheers, this is my first patch posted on the LKML, I
still don't know about all the tools.

> 
> <snip>
> 
> >+        flush_workqueue(adap->work_queue);
> >  
> >
> Indentation/tabs.
> 
> <snip>
> 
> >+static int spi_suspend(struct device * dev, u32
> state)
> >+{
> >+ struct device *child;
> >+ int ret = 0;
> >+
> >+ /* First suspend all the children */
> >+ list_for_each_entry(child, &dev->children, node)
> {
> >+  if (child->driver && child->driver->suspend) {
> >+   ret = child->driver->suspend(child, state,
> SUSPEND_DISABLE);
> >+   if (ret == 0)
> >+    ret = child->driver->suspend(child, state,
> SUSPEND_SAVE_STATE);
> >+   if (ret == 0)
> >+    ret = child->driver->suspend(child, state,
> SUSPEND_POWER_DOWN);
> >+  }
> >+ }
> >  
> >
> Oh my God. It will be called 3 times for each child
> entry, isn't it?!

OK. This stuff is probably wrong. I used the platform
subsystem as an example. I need to do more research
into how much work the driver core does for you.

> 
> >+
> >+ if (ret)
> >+  return ret;
> >+
> >+ /* Then the adapter */
> >+ if (dev->driver && dev->driver->suspend) {
> >+  ret = dev->driver->suspend(dev, state,
> SUSPEND_DISABLE);
> >+  if (ret == 0)
> >+   ret = dev->driver->suspend(dev, state,
> SUSPEND_SAVE_STATE);
> >+  if (ret == 0)
> >+   ret = dev->driver->suspend(dev, state,
> SUSPEND_POWER_DOWN);
> >+ }
> >+
> >+ return ret;
> >+}
> >  
> >
> Can you please clarify what is 'adapter' here: is it
> a bus or what?

Yes, it is a bus master and/or slave.

> 
> >+
> >+static int spi_resume(struct device * dev)
> >+{
> >+ int ret = 0;
> >+ struct device *child;
> >+
> >+ /* First resume the adapter */
> >+ if (dev->driver && dev->driver->resume) {
> >+  ret = dev->driver->resume(dev, RESUME_POWER_ON);
> >+  if (ret == 0)
> >+   ret = dev->driver->resume(dev,
> RESUME_RESTORE_STATE);
> >+  if (ret == 0)
> >+   ret = dev->driver->resume(dev, RESUME_ENABLE);
> >+ }
> >+
> >+ if (ret)
> >+  return ret;
> >+
> >+ /* Then all the children */
> >+ list_for_each_entry(child, &dev->children, node)
> {
> >+  if (child->driver && child->driver->resume) {
> >+   ret = child->driver->resume(child,
> RESUME_POWER_ON);
> >+   if (ret == 0)
> >+    ret = child->driver->resume(child,
> RESUME_RESTORE_STATE);
> >+   if (ret == 0)
> >+    ret = child->driver->resume(child,
> RESUME_ENABLE);
> >+   if (ret)
> >+    break;
> >+  }
> >+ }
> >+
> >  
> >
> Same as for suspend.
> 
> And the basic idea anyway looks wrong and not
> LDM'ish.
> What if your driver
> 
> +static struct device_driver spi_adapter_driver = {
> + .name = "spi_adapter",
> + .bus = &spi_bus_type,
> + .probe = spi_adapter_probe,
> + .remove = spi_adapter_remove,
> +};
> 
> presents also suspend/resume functions (what it
> should have done anyway).
> 
> Won't it be in a clash with your suspend/resume
> technique?

Probably as I said above I don't know enough about
this area yet. Maybe you could help me to do this
correctly?

> 
> Also:
> 
> Can you please specify what is the difference
> between 'bus' and 'chip' 
> in your model?

My current terminology is:

spi adapter: A device that sits on an bus (platform,
PCI, USB etc) and is a SPI master and/or slave (I
haven't done any work on the slave part yet).

spi device: A SPI device (e.g. a SPI eeprom) which one
or more of are connected to a spi adapter.

> It's not clear to me how the following situation is
> handled. Suppose you 
> have two SPI 'busses' with same devices (for
> instance, 2 SD card 
> adapters) attached to different busses.

I don't understand your question here. You would have
two instances of a SD card adapter. In sysfs it would
look like:

SD card 0
/sys/devices/platform/spi-0/0-0000

SD card 1
/sys/devices/platform/spi-1/1-0002

As far as the SD card driver is concernedit doesn't
need to know which one its driving or even how many of
them they are. The big advantage of using the LDM.

> The work queues approach is also not quite clear.

This will become clearer in the next patch set which
will show how to do transfers.

> 
> But the main thing that seems to be not thought
> about at all is power 
> management for the SPI busses/devices.
> I'm afraid your approach needs serious rework in
> this area.

I know, any help would be great :). At the moment I'm
trying to get the registration and transfer model
sorted and then I'll have a look at PM.

Mark

> 
> Best regards,
>    Vitaly
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
