Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTFECDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTFECCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:02:06 -0400
Received: from granite.he.net ([216.218.226.66]:54790 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264383AbTFECB6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:01:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787482097@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787482556@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.11, 2003/06/04 10:29:42-07:00, greg@kroah.com

[PATCH] PCI: Grab reference count on pci_dev if the pci driver binds to the device.

And remember to decrement the count after remove() is called.


 drivers/pci/pci-driver.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Jun  4 18:11:37 2003
+++ b/drivers/pci/pci-driver.c	Wed Jun  4 18:11:37 2003
@@ -138,10 +138,11 @@
 
 	drv = to_pci_driver(dev->driver);
 	pci_dev = to_pci_dev(dev);
-	if (get_device(dev)) {
-		error = __pci_device_probe(drv, pci_dev);
-		put_device(dev);
-	}
+	pci_get_dev(pci_dev);
+	error = __pci_device_probe(drv, pci_dev);
+	if (error)
+		pci_put_dev(pci_dev);
+
 	return error;
 }
 
@@ -155,6 +156,7 @@
 			drv->remove(pci_dev);
 		pci_dev->driver = NULL;
 	}
+	pci_put_dev(pci_dev);
 	return 0;
 }
 

