Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWJJFse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWJJFse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWJJFse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:48:34 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:40911 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S964999AbWJJFsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:48:33 -0400
Message-ID: <452B3417.7050106@keyaccess.nl>
Date: Tue, 10 Oct 2006 07:48:07 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driver,platform,firmware,system, data data data ....
References: <1160451368.32237.78.camel@localhost.localdomain>
In-Reply-To: <1160451368.32237.78.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000902090000040400020403"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902090000040400020403
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

[ device->platform_data ]

> So except for the size of the patch and boredom of going through all
> of them fixing them, do you see any reason why this later one
> shouldn't be moved out to platform_driver ? (I haven't actually
> checked at all the occurences in the tree though).

You'll find it being used in drivers/base/isa.c for one. I only used it 
there because it was available and made for slightly nicer code though. 
If platform_data is going away (and assuming you wouldn't want similar 
abuse of your new system_data) it wouldn't be a problem to move the 
driver pointer to the private struct isa_dev as in the attached.

Rene.

--------------000902090000040400020403
Content-Type: text/plain;
 name="isa_bus_platform_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isa_bus_platform_data.diff"

Index: local/drivers/base/isa.c
===================================================================
--- local.orig/drivers/base/isa.c	2006-09-16 20:43:03.000000000 +0200
+++ local/drivers/base/isa.c	2006-10-10 07:03:54.000000000 +0200
@@ -16,6 +16,7 @@
 struct isa_dev {
 	struct device dev;
 	struct device *next;
+	struct isa_driver *isa_driver;
 	unsigned int id;
 };
 
@@ -23,61 +24,66 @@
 
 static int isa_bus_match(struct device *dev, struct device_driver *driver)
 {
-	struct isa_driver *isa_driver = to_isa_driver(driver);
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
-	if (dev->platform_data == isa_driver) {
-		if (!isa_driver->match ||
-			isa_driver->match(dev, to_isa_dev(dev)->id))
+	if (isa_driver == to_isa_driver(driver))  {
+		if (!isa_driver->match || isa_driver->match(dev, isa_dev->id))
 			return 1;
-		dev->platform_data = NULL;
+		isa_dev->isa_driver = NULL;
 	}
 	return 0;
 }
 
 static int isa_bus_probe(struct device *dev)
 {
-	struct isa_driver *isa_driver = dev->platform_data;
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
 	if (isa_driver->probe)
-		return isa_driver->probe(dev, to_isa_dev(dev)->id);
+		return isa_driver->probe(dev, isa_dev->id);
 
 	return 0;
 }
 
 static int isa_bus_remove(struct device *dev)
 {
-	struct isa_driver *isa_driver = dev->platform_data;
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
 	if (isa_driver->remove)
-		return isa_driver->remove(dev, to_isa_dev(dev)->id);
+		return isa_driver->remove(dev, isa_dev->id);
 
 	return 0;
 }
 
 static void isa_bus_shutdown(struct device *dev)
 {
-	struct isa_driver *isa_driver = dev->platform_data;
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
 	if (isa_driver->shutdown)
-		isa_driver->shutdown(dev, to_isa_dev(dev)->id);
+		isa_driver->shutdown(dev, isa_dev->id);
 }
 
 static int isa_bus_suspend(struct device *dev, pm_message_t state)
 {
-	struct isa_driver *isa_driver = dev->platform_data;
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
 	if (isa_driver->suspend)
-		return isa_driver->suspend(dev, to_isa_dev(dev)->id, state);
+		return isa_driver->suspend(dev, isa_dev->id, state);
 
 	return 0;
 }
 
 static int isa_bus_resume(struct device *dev)
 {
-	struct isa_driver *isa_driver = dev->platform_data;
+	struct isa_dev *isa_dev = to_isa_dev(dev);
+	struct isa_driver *isa_driver = isa_dev->isa_driver;
 
 	if (isa_driver->resume)
-		return isa_driver->resume(dev, to_isa_dev(dev)->id);
+		return isa_driver->resume(dev, isa_dev->id);
 
 	return 0;
 }
@@ -137,9 +143,9 @@
 		snprintf(isa_dev->dev.bus_id, BUS_ID_SIZE, "%s.%u",
 				isa_driver->driver.name, id);
 
-		isa_dev->dev.platform_data	= isa_driver;
-		isa_dev->dev.release		= isa_dev_release;
-		isa_dev->id			= id;
+		isa_dev->dev.release	= isa_dev_release;
+		isa_dev->isa_driver	= isa_driver;
+		isa_dev->id		= id;
 
 		error = device_register(&isa_dev->dev);
 		if (error) {
@@ -147,7 +153,7 @@
 			break;
 		}
 
-		if (isa_dev->dev.platform_data) {
+		if (isa_dev->isa_driver) {
 			isa_dev->next = isa_driver->devices;
 			isa_driver->devices = &isa_dev->dev;
 		} else

--------------000902090000040400020403--
