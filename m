Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVF1GPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVF1GPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVF1GOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:14:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:37612 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261900AbVF1Fdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:54 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge
In-Reply-To: <1119936772835@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:52 -0700
Message-Id: <11199367724120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge

When hot-plugging a root bridge, as we try to assign bus numbers we may find
that the hotplugged hieratchy has more PCI to PCI bridges (i.e.  bus
requirements) than available.  Make sure we don't step over an existing bus
when that happens.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cc57450f5c044270d2cf1dd437c1850422262109
tree 418c7546c443cfc80601da045731f6b5a9f23442
parent 71c3511c22e8e0648094672abec898b3bf84c18b
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:47 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:40 -0700

 drivers/pci/probe.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -411,7 +411,7 @@ int __devinit pci_scan_bridge(struct pci
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
-	u32 buses;
+	u32 buses, i;
 	u16 bctl;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
@@ -470,6 +470,10 @@ int __devinit pci_scan_bridge(struct pci
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		/* Prevent assigning a bus number that already exists.
+		 * This can happen when a bridge is hot-plugged */
+		if (pci_find_bus(pci_domain_nr(bus), max+1))
+			return max;
 		child = pci_alloc_child_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
@@ -501,7 +505,11 @@ int __devinit pci_scan_bridge(struct pci
 			 * as cards with a PCI-to-PCI bridge can be
 			 * inserted later.
 			 */
-			max += CARDBUS_RESERVE_BUSNR;
+			for (i=0; i<CARDBUS_RESERVE_BUSNR; i++)
+				if (pci_find_bus(pci_domain_nr(bus),
+							max+i+1))
+					break;
+			max += i;
 		}
 		/*
 		 * Set the subordinate bus number to its real value.

