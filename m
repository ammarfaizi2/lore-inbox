Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUIGBYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUIGBYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 21:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUIGBYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 21:24:38 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55462 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267490AbUIGBYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 21:24:36 -0400
Date: Tue, 07 Sep 2004 10:26:38 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] missing pci_disable_device()
To: greg@kroah.com, akpm@osdl.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org
Message-id: <413D0E4E.1000200@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As mentioned in Documentaion/pci.txt, pci device driver should call
pci_disable_device() to deallocate any IRQ resources, disable PCI
bus-mastering and etc. when it decides to stop using the device.
But there seems to be many drivers that don't use pci_disable_device()
properly so far.

The following patch changes pci_device_remove() to call
pci_disable_device() instead of the driver if the device has not been
disabled by the driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---

 linux-2.6.9-rc1-kanesige/drivers/pci/pci-driver.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/pci/pci-driver.c~force_pci_disable_device drivers/pci/pci-driver.c
--- linux-2.6.9-rc1/drivers/pci/pci-driver.c~force_pci_disable_device	2004-09-01 17:42:40.000000000 +0900
+++ linux-2.6.9-rc1-kanesige/drivers/pci/pci-driver.c	2004-09-02 14:54:39.824783993 +0900
@@ -291,6 +291,13 @@ static int pci_device_remove(struct devi
 			drv->remove(pci_dev);
 		pci_dev->driver = NULL;
 	}
+	/*
+	 * If the device has not been disabled, we call
+	 * pci_disable_device() instead of the driver.
+	 */
+	if (pci_dev->is_enabled)
+		pci_disable_device(pci_dev);
+
 	pci_dev_put(pci_dev);
 	return 0;
 }

