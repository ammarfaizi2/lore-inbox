Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271747AbTHHStH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271748AbTHHStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:49:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33216 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S271747AbTHHStE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:49:04 -0400
Message-ID: <3F33EFF8.6070203@us.ibm.com>
Date: Fri, 08 Aug 2003 13:46:16 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] testing for probe errors in pci-driver.c
Content-Type: multipart/mixed;
 boundary="------------070809070401060909060203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809070401060909060203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently if __pci_device_probe locates the correct
device driver, but receives an error from the static
drv->probe function, this error is not reported.

The attached patch reports the above error condition
to the caller.  Only when a match for the device in
the static tables is not found, is the dynamic driver 
table searched.

Janice




--------------070809070401060909060203
Content-Type: text/plain;
 name="pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.patch"

diff -Naur linux-2.6.0-test2.orig.pci/drivers/pci/pci-driver.c linux-2.6.0-test2.my.pci/drivers/pci/pci-driver.c
--- linux-2.6.0-test2.orig.pci/drivers/pci/pci-driver.c	2003-08-07 16:14:36.000000000 -0500
+++ linux-2.6.0-test2.my.pci/drivers/pci/pci-driver.c	2003-08-07 21:23:51.000000000 -0500
@@ -122,10 +122,8 @@
 
 	if (!pci_dev->driver && drv->probe) {
 		error = pci_device_probe_static(drv, pci_dev);
-		if (error >= 0)
-			return error;
-
-		error = pci_device_probe_dynamic(drv, pci_dev);
+		if (error == -ENODEV)
+			error = pci_device_probe_dynamic(drv, pci_dev);
 	}
 	return error;
 }

--------------070809070401060909060203--

