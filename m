Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVGNJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVGNJGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVGNJGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:06:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12937 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262975AbVGNJFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:37 -0400
Subject: [RFC][PATCH] basic PCI<->PCI bridge PM (suspend/resume) [9/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:59 -0400
Message-Id: <1121331359.3398.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds very simplistic suspend/resume support for the PCI
bridge driver.  Soon this will be replaced with bridge specific code,
but for now we'll try using pci_save/restore_state().

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/pci-bridge.c	2005-07-14 04:22:13.000000000 -0400
+++ b/drivers/pci/bus/pci-bridge.c	2005-07-14 04:26:17.257004064 -0400
@@ -159,11 +159,29 @@
 	pci_remove_bus(dev->subordinate);
 }
 
+static int ppb_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	pci_save_state(dev);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
+
+	return 0;
+}
+
+static int ppb_resume(struct pci_dev *dev)
+{
+	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
+
+	return 0;
+}
+
 static struct pci_driver ppb_driver = {
 	.name		= "pci-bridge",
 	.id_table	= ppb_id_tbl,
 	.probe		= ppb_probe,
 	.remove		= ppb_remove,
+	.suspend	= ppb_suspend,
+	.resume		= ppb_resume,
 };
 
 static int __init ppb_init(void)


