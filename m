Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUIMDxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUIMDxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUIMDxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:53:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:23213 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265222AbUIMDxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:53:25 -0400
Date: Mon, 13 Sep 2004 12:55:18 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <20040909173349.GA14633@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41451A26.40405@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
 <413E7925.1010801@jp.fujitsu.com>
 <1094647195.11723.5.camel@localhost.localdomain>
 <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com>
 <41403075.1010103@jp.fujitsu.com> <20040909173349.GA14633@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated patch for missing pci_disable_device().
Greg, please apply.

Thanks,
Kenji Kaneshige


As mentioned in Documentaion/pci.txt, pci device driver should call
pci_disable_device() when it decides to stop using the device. But
there are some drivers that don't use pci_disable_device() so far.

This patch adds warning messages that are displayed if the device is
removed without properly calling pci_disable_device().

'WARN_ON(1)' is commented out for now because I guess many people
(including some distros) enables 'CONFIG_DEBUG_KERNEL'. People might
be surprised if many stack dumps are displayed on their console.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc1-kanesige/drivers/pci/pci-driver.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN drivers/pci/pci-driver.c~force_pci_disable_device drivers/pci/pci-driver.c
--- linux-2.6.9-rc1/drivers/pci/pci-driver.c~force_pci_disable_device	2004-09-13 12:41:23.588330045 +0900
+++ linux-2.6.9-rc1-kanesige/drivers/pci/pci-driver.c	2004-09-13 12:41:23.591259749 +0900
@@ -291,6 +291,19 @@ static int pci_device_remove(struct devi
 			drv->remove(pci_dev);
 		pci_dev->driver = NULL;
 	}
+
+#ifdef CONFIG_DEBUG_KERNEL
+	/*
+	 * If the driver decides to stop using the device, it should
+	 * call pci_disable_device().
+	 */
+	if (pci_dev->is_enabled) {
+		dev_warn(&pci_dev->dev, "Device was removed without properly "
+			 "calling pci_disable_device(). This may need fixing.\n");
+		/* WARN_ON(1); */
+	}
+#endif /* CONFIG_DEBUG_KERNEL */
+
 	pci_dev_put(pci_dev);
 	return 0;
 }

_


