Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWEaSUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWEaSUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWEaSUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:20:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751224AbWEaSUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:20:09 -0400
Date: Wed, 31 May 2006 14:20:04 -0400
From: Kimball Murray <kimball.murray@gmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: Kimball Murray <kimball.murray@gmail.com>, <greg@kroah.com>
Message-Id: <20060531181358.6617.96108.sendpatchset@dhcp83-97.boston.redhat.com>
Subject: [git Patch 1/1] don't move ioapics below PCI bridge
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent Stratus x86_64 platform uses a system ioapic that is a PCI device
located below a PCI bridge.  Other platforms like this may exist.

This patch fixes a problem wherein the kernel's PCI setup code moves
the ioapic to an address other than that assigned by the BIOS.  It simply
adds another exclusion (which already includes classless devices and host
bridges) to the function pbus_assign_resources_sorted so that it will not
move the ioapic.

If the ioapic is moved, the fixmap mapping to it is broken, so the OS should
leave it alone.

--------------- SNIP ---------------------
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 28ce3a7..35086e8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -55,9 +55,10 @@ pbus_assign_resources_sorted(struct pci_
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
-		/* Don't touch classless devices and host bridges.  */
+		/* Don't touch classless devices or host bridges or ioapics.  */
 		if (class == PCI_CLASS_NOT_DEFINED ||
-		    class == PCI_CLASS_BRIDGE_HOST)
+		    class == PCI_CLASS_BRIDGE_HOST ||
+		    class == PCI_CLASS_SYSTEM_PIC)
 			continue;
 
 		pdev_sort_resources(dev, &head);
