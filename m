Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbUBDHMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUBDHMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:12:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:28035 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266299AbUBDHMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:12:16 -0500
Subject: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Message-Id: <1075878713.992.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 18:12:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a "devspec" property to all PCI entries in sysfs
that provides the full "Open Firmware" path to each device on
PPC and PPC64 platforms that have Open Firmware support.

For various reasons, the OF path is and will still be different than
the sysfs path, and userland needs the OF path for various things,
ranging from bootloader setup to XFree needing to access some OF
properties provided by the graphic card F-Code driver, etc...

The "devspec" name is what we already use for "macio" type devices,
it doesn't clash with anything else.

If you are happy with it, please apply (independently of the rest
of the PowerMac patch), I need that to fix various things in XFree
(among others), so it would be nice to have it in by 2.6.3 final

Regards,
Ben.

diff -urN linux-2.5/drivers/pci/pci-sysfs.c linuxppc-2.5-benh/drivers/pci/pci-sysfs.c
--- linux-2.5/drivers/pci/pci-sysfs.c	2004-02-02 13:09:08.000000000 +1100
+++ linuxppc-2.5-benh/drivers/pci/pci-sysfs.c	2004-02-04 17:57:05.000000000 +1100
@@ -20,6 +20,24 @@
 
 #include "pci.h"
 
+#ifdef CONFIG_PPC_OF
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+
+static ssize_t pci_show_devspec(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev;
+	struct device_node *np;
+
+	pdev = to_pci_dev (dev);
+	np = pci_device_to_OF_node(pdev);
+	if (np == NULL || np->full_name == NULL)
+		return 0;
+	return sprintf(buf, "%s", np->full_name);
+}
+static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
+#endif /* CONFIG_PPC_OF */
+
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -179,5 +197,8 @@
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
+#ifdef CONFIG_PPC_OF
+	device_create_file (dev, &dev_attr_devspec);
+#endif
 	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
 }


