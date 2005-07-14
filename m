Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVGNJS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVGNJS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVGNJGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:06:48 -0400
Received: from peabody.ximian.com ([130.57.169.10]:10889 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262972AbVGNJFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:34 -0400
Subject: [RFC][PATCH] PCI root bridge detection fix [7/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:30 -0400
Message-Id: <1121331330.3398.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents the root bridge drivers from using the legacy API.
It also updates the PCI<->PCI bridge driver to better coexist with the
legacy code.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/pci-bridge.c	2005-07-14 02:17:04.735566464 -0400
+++ b/drivers/pci/bus/pci-bridge.c	2005-07-14 02:24:29.577940144 -0400
@@ -128,6 +128,10 @@
 	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
 		return -ENODEV;
 
+	/* don't bind to devices controlled by legacy code */
+	if (dev->subordinate)
+		return -ENODEV;
+
 	bus = ppb_detect_bus(dev);
 	if (!bus)
 		return -ENODEV;
--- a/drivers/pci/bus/probe.c	2005-07-14 02:26:30.660532792 -0400
+++ b/drivers/pci/bus/probe.c	2005-07-14 02:25:20.455205624 -0400
@@ -395,6 +395,7 @@
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	int error;
+	unsigned int devfn;
 	struct pci_bus *b;
 	struct device *dev;
 
@@ -440,7 +441,9 @@
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(b);
 
-	b->subordinate = pci_scan_child_bus(b);
+	/* Go find them, Rover! */
+	for (devfn = 0; devfn < 0x100; devfn += 8)
+		pci_scan_slot(b, devfn);
 
 	return b;
 


