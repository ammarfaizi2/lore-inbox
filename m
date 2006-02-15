Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422754AbWBOLcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWBOLcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWBOLcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:32:14 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49574 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932449AbWBOLcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:32:13 -0500
Date: Wed, 15 Feb 2006 13:23:19 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
In-Reply-To: <20060215022523.1d21b9c9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
References: <1139935173.22151.2.camel@localhost> <20060215022523.1d21b9c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 15 Feb 2006, Andrew Morton wrote:
> Problem is, it doesn't resume correctly either with or without the patch:
> it needs rmmod+modprobe to get it going again.  (Which is better than the
> aic7xxx driver, which has a coronary and panics the kernel on post-resume
> reboot).

Hmm. Either I am totally confused or we don't even attempt suspend/resume 
for eisa and mca bus devices. Care to try this patch?

			Pekka

Index: 2.6/drivers/eisa/eisa-bus.c
===================================================================
--- 2.6.orig/drivers/eisa/eisa-bus.c
+++ 2.6/drivers/eisa/eisa-bus.c
@@ -128,9 +128,31 @@ static int eisa_bus_match (struct device
 	return 0;
 }
 
+static int eisa_bus_suspend(struct device * dev, pm_message_t state)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, state);
+
+	return ret;
+}
+
+static int eisa_bus_resume(struct device * dev)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->resume)
+		ret = dev->driver->resume(dev);
+
+	return ret;
+}
+
 struct bus_type eisa_bus_type = {
 	.name  = "eisa",
 	.match = eisa_bus_match,
+	.suspend = eisa_bus_suspend,
+	.resume = eisa_bus_resume,
 };
 
 int eisa_driver_register (struct eisa_driver *edrv)
Index: 2.6/drivers/mca/mca-bus.c
===================================================================
--- 2.6.orig/drivers/mca/mca-bus.c
+++ 2.6/drivers/mca/mca-bus.c
@@ -63,9 +63,32 @@ static int mca_bus_match (struct device 
 	return 0;
 }
 
+static int mca_bus_suspend(struct device * dev, pm_message_t state)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, state);
+
+	return ret;
+}
+
+static int mca_bus_resume(struct device * dev)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->resume)
+		ret = dev->driver->resume(dev);
+
+	return ret;
+}
+
+
 struct bus_type mca_bus_type = {
 	.name  = "MCA",
 	.match = mca_bus_match,
+	.suspend = mca_bus_suspend,
+	.resume = mca_bus_resume,
 };
 EXPORT_SYMBOL (mca_bus_type);
 
