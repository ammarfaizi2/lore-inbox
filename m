Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbTCDOsh>; Tue, 4 Mar 2003 09:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269161AbTCDOsg>; Tue, 4 Mar 2003 09:48:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269154AbTCDOsf>;
	Tue, 4 Mar 2003 09:48:35 -0500
Date: Tue, 4 Mar 2003 08:35:05 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Dominik Brodowski <linux@brodo.de>
cc: <torvalds@transmeta.com>, <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <mika.penttila@kolumbus.fi>
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH
 2.5] : i82365 & platform_bus_type]
In-Reply-To: <20030304095447.GA1408@brodo.de>
Message-ID: <Pine.LNX.4.33.0303040831120.992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Mar 2003, Dominik Brodowski wrote:

> Hi Pat,
> 
> How is it supposed to work then? I thought adding a platform_device and
> platform_driver with the same name and bus_id causes the platform_driver to
> be bound to the platform_device?

Erm yes. Color me lazy, I just hadn't implemented that yet.. You've hit 
something else no one had used before. 

This patch is completley untested, but it should work. 

	-pat

===== drivers/base/platform.c 1.5 vs edited =====
--- 1.5/drivers/base/platform.c	Fri Oct 18 13:27:29 2002
+++ edited/drivers/base/platform.c	Tue Mar  4 08:34:10 2003
@@ -41,9 +41,29 @@
 	if (pdev)
 		device_unregister(&pdev->dev);
 }
-	
+
+
+/**
+ *	platform_match - bind platform device to platform driver.
+ *	@dev:	device.
+ *	@drv:	driver.
+ *
+ *	Platform device IDs are assumed to be encoded like this: 
+ *	"<name><instance>", where <name> is a short description of the 
+ *	type of device, like "pci" or "floppy", and <instance> is the 
+ *	enumerated instance of the device, like '0' or '42'.
+ *	Driver IDs are simply "<name>". 
+ *	So, extract the <name> from the device, and compare it against 
+ *	the name of the driver. Return whether they match or not.
+ */
+
 static int platform_match(struct device * dev, struct device_driver * drv)
 {
+	char name[BUS_ID_SIZE];
+
+	if (sscanf(dev->bus_id,"%s",name))
+		return (strcmp(name,drv->name) == 0);
+
 	return 0;
 }
 

