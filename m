Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVBNKnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVBNKnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVBNKnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:43:17 -0500
Received: from black.click.cz ([62.141.0.10]:27371 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261384AbVBNKnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:43:08 -0500
From: Michal Rokos <michal@rokos.info>
To: linux-kernel@vger.kernel.org
Subject: Re: avoiding pci_disable_device()...
Date: Mon, 14 Feb 2005 11:43:02 +0100
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141143.02205.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Currently, in almost every PCI driver, if pci_request_regions() fails -- 
> indicating another driver is using the hardware -- then 
> pci_disable_device() is called on the error path, disabling a device 
> that another driver is using
> 
> To call this "rather rude" is an understatement :)

I believe this is needed for natsemi to be inline with $SUBJ.

Signed-off-by: Michal Rokos <michal@rokos.info>

--- linux-2.6/drivers/net/natsemi.c     2005-02-14 11:34:53.000000000 +0100
+++ linux-2.6-mr/drivers/net/natsemi.c  2005-02-14 11:36:00.000000000 +0100
@@ -811,6 +811,7 @@
        void __iomem *ioaddr;
        const int pcibar = 1; /* PCI base address register */
        int prev_eedata;
+       int pci_dev_busy = 0;
        u32 tmp;

 /* when built into the kernel, we only print version if device is found */
@@ -821,7 +822,13 @@
 #endif

        i = pci_enable_device(pdev);
-       if (i) return i;
+       if (i) goto out;
+
+       i = pci_request_regions(pdev, DRV_NAME);
+       if (i) {
+               pci_dev_busy = 1;
+               goto err_pci_request_regions;
+       }

        /* natsemi has a non-standard PM control register
         * in PCI config space.  Some boards apparently need
@@ -843,15 +850,13 @@
                pci_set_master(pdev);

        dev = alloc_etherdev(sizeof (struct netdev_private));
-       if (!dev)
-               return -ENOMEM;
+       if (!dev) {
+               i = -ENOMEM;
+               goto err_alloc_etherdev;
+       }
        SET_MODULE_OWNER(dev);
        SET_NETDEV_DEV(dev, &pdev->dev);

-       i = pci_request_regions(pdev, DRV_NAME);
-       if (i)
-               goto err_pci_request_regions;
-
        ioaddr = ioremap(iostart, iosize);
        if (!ioaddr) {
                i = -ENOMEM;
@@ -992,15 +997,20 @@
        }
        return 0;

- err_register_netdev:
+err_register_netdev:
        iounmap(ioaddr);

- err_ioremap:
-       pci_release_regions(pdev);
+err_ioremap:
        pci_set_drvdata(pdev, NULL);
-
- err_pci_request_regions:
        free_netdev(dev);
+
+err_alloc_etherdev:
+       pci_release_regions(pdev);
+
+err_pci_request_regions:
+       if (!pci_dev_busy)
+               pci_disable_device(pdev);
+out:
        return i;
 }
