Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWJLBu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWJLBu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWJLBu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:50:26 -0400
Received: from havoc.gtf.org ([69.61.125.42]:14560 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422686AbWJLBuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:50:25 -0400
Date: Wed, 11 Oct 2006 21:50:24 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB/gadget/net2280: handle sysfs errors
Message-ID: <20061012015024.GA13093@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/usb/gadget/net2280.c |   20 ++++++++++++++++----

diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index d954daa..7cfe0e5 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -2044,8 +2044,10 @@ int usb_gadget_register_driver (struct u
 		return retval;
 	}
 
-	device_create_file (&dev->pdev->dev, &dev_attr_function);
-	device_create_file (&dev->pdev->dev, &dev_attr_queues);
+	retval = device_create_file (&dev->pdev->dev, &dev_attr_function);
+	if (retval) goto err_unbind;
+	retval = device_create_file (&dev->pdev->dev, &dev_attr_queues);
+	if (retval) goto err_func;
 
 	/* ... then enable host detection and ep0; and we're ready
 	 * for set_configuration as well as eventual disconnect.
@@ -2060,6 +2062,14 @@ int usb_gadget_register_driver (struct u
 
 	/* pci writes may still be posted */
 	return 0;
+
+err_func:
+	device_remove_file (&dev->pdev->dev, &dev_attr_function);
+err_unbind:
+	driver->unbind (&dev->gadget);
+	dev->gadget.dev.driver = NULL;
+	dev->driver = NULL;
+	return retval;
 }
 EXPORT_SYMBOL (usb_gadget_register_driver);
 
@@ -2974,8 +2984,10 @@ static int net2280_probe (struct pci_dev
 				: "disabled");
 	the_controller = dev;
 
-	device_register (&dev->gadget.dev);
-	device_create_file (&pdev->dev, &dev_attr_registers);
+	retval = device_register (&dev->gadget.dev);
+	if (retval) goto done;
+	retval = device_create_file (&pdev->dev, &dev_attr_registers);
+	if (retval) goto done;
 
 	return 0;
 
