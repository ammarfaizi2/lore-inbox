Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUJUKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUJUKvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbUJUKs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:48:29 -0400
Received: from smtp4.vol.cz ([195.250.128.79]:22788 "EHLO smtp4.vol.cz")
	by vger.kernel.org with ESMTP id S270484AbUJUKoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:44:46 -0400
Message-ID: <41779315.7080306@rokos.info>
Date: Thu, 21 Oct 2004 12:44:37 +0200
From: Michal Rokos <michal@rokos.info>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Netdev List <netdev@oss.sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: [Patch 2.6] Natsemi -  add missing pci_disable_device() call
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

natsemi doesn't call pci_disable_device() during exit or error in init.

So this patch does it.

	Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/21 10:56:57+02:00 michal@rokos.ack-prg.csas.cz
#   [NATSEMI] Add missing pci_disable_device().
#
# drivers/net/natsemi.c
#   2004/10/21 10:56:45+02:00 michal@rokos.ack-prg.csas.cz +9 -3
#   Add missing pci_disable_device().
#
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c	2004-10-21 10:58:06 +02:00
+++ b/drivers/net/natsemi.c	2004-10-21 10:58:06 +02:00
@@ -821,7 +821,7 @@
  #endif

  	i = pci_enable_device(pdev);
-	if (i) return i;
+	if (i) goto out;

  	/* natsemi has a non-standard PM control register
  	 * in PCI config space.  Some boards apparently need
@@ -843,8 +843,10 @@
  		pci_set_master(pdev);

  	dev = alloc_etherdev(sizeof (struct netdev_private));
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		i = -ENOMEM;
+		goto err_alloc_etherdev;
+	}
  	SET_MODULE_OWNER(dev);
  	SET_NETDEV_DEV(dev, &pdev->dev);

@@ -1001,6 +1003,9 @@

   err_pci_request_regions:
  	free_netdev(dev);
+ err_alloc_etherdev:
+	pci_disable_device(pdev);
+ out:
  	return i;
  }

@@ -3133,6 +3138,7 @@
  	iounmap(ioaddr);
  	free_netdev (dev);
  	pci_set_drvdata(pdev, NULL);
+	pci_disable_device(pdev);
  }

  #ifdef CONFIG_PM
