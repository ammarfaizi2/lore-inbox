Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269760AbUJHLA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269760AbUJHLA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJHLA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:00:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33432 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269760AbUJHLAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:00:13 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 8 Oct 2004 12:44:04 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] i2c bus power management support
Message-ID: <20041008104404.GA24760@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

The patch below adds power management support to the i2c bus.
It adds just two small functions which call down to the devices
power management functions if they are present, so the i2c device
drivers will receive the suspend and resume events.

  Gerd

Index: linux-2.6.8/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.8.orig/drivers/i2c/i2c-core.c	2004-08-18 12:11:55.000000000 +0200
+++ linux-2.6.8/drivers/i2c/i2c-core.c	2004-10-08 12:38:55.075642304 +0200
@@ -517,9 +517,29 @@ static int i2c_device_match(struct devic
 	return 1;
 }
 
+static int i2c_bus_suspend(struct device * dev, u32 state)
+{
+	int rc = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		rc = dev->driver->suspend(dev,state,0);
+	return rc;
+}
+
+static int i2c_bus_resume(struct device * dev)
+{
+	int rc = 0;
+	
+	if (dev->driver && dev->driver->resume)
+		rc = dev->driver->resume(dev,0);
+	return rc;
+}
+
 struct bus_type i2c_bus_type = {
 	.name =		"i2c",
 	.match =	i2c_device_match,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
 };
 
 static int __init i2c_init(void)
