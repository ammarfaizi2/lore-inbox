Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUJCAnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUJCAnG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 20:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUJCAnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 20:43:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:28348 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267650AbUJCAm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 20:42:59 -0400
Subject: [PATCH] Fix booting on some recent G5s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1096763918.26914.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 10:38:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Some recent G5s have a problem with PCI/HT probing. They crash
(machine check) during the probe of some slot numbers, it seems
to be related to some functions beeing disabled by the firmware
inside the K2 ASIC.

This patch limits the config space accesses to devices that are
present in the OF device-tree. This fixes the problem and shouldn't
"add" any limitation. If you plug a "random" PCI card with no OF
driver, the firmware will still build a node for it with the
default set of properties created from the config space.

Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


--- 1.5/arch/ppc64/kernel/pmac_pci.c	2004-07-25 14:51:52 +10:00
+++ edited/arch/ppc64/kernel/pmac_pci.c	2004-08-04 10:26:07 +10:00
@@ -271,7 +271,7 @@
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn;
+	struct device_node *busdn, *dn;
 	unsigned long addr;
 
 	if (bus->self)
@@ -282,6 +282,16 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	hose = busdn->phb;
 	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* We only allow config cycles to devices that are in OF device-tree
+	 * as we are apparently having some weird things going on with some
+	 * revs of K2 on recent G5s
+	 */
+	for (dn = busdn->child; dn; dn = dn->sibling)
+		if (dn->devfn == devfn)
+			break;
+	if (dn == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
--- 1.21/arch/ppc/platforms/pmac_pci.c	2004-07-29 14:58:35 +10:00
+++ edited/arch/ppc/platforms/pmac_pci.c	2004-08-17 14:18:09 +10:00
@@ -315,6 +315,10 @@
 	unsigned int addr;
 	int i;
 
+	struct device_node *np = pci_busdev_to_OF_node(bus, devfn);
+	if (np == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	/*
 	 * When a device in K2 is powered down, we die on config
 	 * cycle accesses. Fix that here.
@@ -362,6 +366,9 @@
 	unsigned int addr;
 	int i;
 
+	struct device_node *np = pci_busdev_to_OF_node(bus, devfn);
+	if (np == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	/*
 	 * When a device in K2 is powered down, we die on config
 	 * cycle accesses. Fix that here.


