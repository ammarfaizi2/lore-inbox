Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270086AbUJTGsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270086AbUJTGsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270183AbUJSXLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:11:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:6026 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270111AbUJSWq0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:26 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257353682@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257352301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.29, 2004/10/06 12:50:32-07:00, kaneshige.kenji@jp.fujitsu.com

[PATCH] PCI: warn of missing pci_disable_device()

As mentioned in Documentaion/pci.txt, pci device driver should call
pci_disable_device() when it decides to stop using the device. But
there are some drivers that don't use pci_disable_device() so far.

This patch adds warning messages that are displayed if the device is
removed without properly calling pci_disable_device().

'WARN_ON(1)' is commented out for now because I guess many people
(including some distros) enables 'CONFIG_DEBUG_KERNEL'. People might
be surprised if many stack dumps are displayed on their console.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 15:25:09 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 15:25:09 -07:00
@@ -291,6 +291,19 @@
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

