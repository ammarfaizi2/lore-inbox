Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTJQUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJQUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:05:29 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:49332 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263585AbTJQUFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:05:20 -0400
Message-ID: <3F904B61.3020400@pacbell.net>
Date: Fri, 17 Oct 2003 13:04:49 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Peter Matthias <espi@epost.de>, Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ACM USB modem on Kernel 2.6.0-test
References: <3F8851A7.3000105@pacbell.net>
In-Reply-To: <3F8851A7.3000105@pacbell.net>
Content-Type: multipart/mixed;
 boundary="------------000103050000030705060606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000103050000030705060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> 
> Hmm ... maybe usbcore would be better off with a less
> naive algorithm for choosing defaults.  Like, preferring
> configurations without proprietary device protocols.
> That'd solve every cdc-acm case, and likely others.

In fact, here's a patch with that very change.  Does
it make current 2.6.0-test kernels work "out of the box"
again with your USB modems?

- Dave




--------------000103050000030705060606
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.143/drivers/usb/core/usb.c	Thu Sep 25 03:59:51 2003
+++ edited/drivers/usb/core/usb.c	Fri Oct 17 12:18:16 2003
@@ -991,6 +997,7 @@
 	int err = -EINVAL;
 	int i;
 	int j;
+	int config;
 
 	/*
 	 * Set the driver for the usb device to point to the "generic" driver.
@@ -1105,15 +1112,27 @@
 
 	/* choose and set the configuration. that registers the interfaces
 	 * with the driver core, and lets usb device drivers bind to them.
+	 * NOTE:  should interact with hub power budgeting.
 	 */
+	config = dev->config[0].desc.bConfigurationValue;
 	if (dev->descriptor.bNumConfigurations != 1) {
+		for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
+			/* heuristic:  Linux is more likely to have class
+			 * drivers, so avoid vendor-specific interfaces.
+			 */
+			if (dev->config[i].interface[0]->altsetting
+						->desc.bInterfaceClass
+					== USB_CLASS_VENDOR_SPEC)
+				continue;
+			config = dev->config[i].desc.bConfigurationValue;
+			break;
+		}
 		dev_info(&dev->dev,
 			"configuration #%d chosen from %d choices\n",
-			dev->config[0].desc.bConfigurationValue,
+			config,
 			dev->descriptor.bNumConfigurations);
 	}
-	err = usb_set_configuration(dev,
-			dev->config[0].desc.bConfigurationValue);
+	err = usb_set_configuration(dev, config);
 	if (err) {
 		dev_err(&dev->dev, "can't set config #%d, error %d\n",
 			dev->config[0].desc.bConfigurationValue, err);

--------------000103050000030705060606--


