Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVGAVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVGAVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:59:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:52449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262763AbVGAUtk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:40 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: Fix up PCI routing in parent bridge
In-Reply-To: <20050701204741.GA1137@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:31 -0700
Message-Id: <11202509113838@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Fix up PCI routing in parent bridge

When the cardbus bridge is behind another bridge change the routing
in the parent bridge for new cards.  This fixes Cardbus on various AMD64
laptops.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 26f674ae0e37190bf61c988e52911e4372fdb5f5
tree 625b05e5edd627a5cce0289e78057ca5ccf2290c
parent ef6689eff4b58273fed9e54293a3da983b321e9a
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 02 Jun 2005 15:41:48 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:49 -0700

 drivers/pci/probe.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -398,6 +398,16 @@ static void pci_enable_crs(struct pci_de
 	pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
 }
 
+static void __devinit pci_fixup_parent_subordinate_busnr(struct pci_bus *child, int max)
+{
+	struct pci_bus *parent = child->parent;
+	while (parent->parent && parent->subordinate < max) {
+		parent->subordinate = max;
+		pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, max);
+		parent = parent->parent;
+	}
+}
+
 unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
 
 /*
@@ -499,7 +509,13 @@ int __devinit pci_scan_bridge(struct pci
 
 		if (!is_cardbus) {
 			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
-
+			/*
+			 * Adjust subordinate busnr in parent buses.
+			 * We do this before scanning for children because
+			 * some devices may not be detected if the bios
+			 * was lazy.
+			 */
+			pci_fixup_parent_subordinate_busnr(child, max);
 			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
 		} else {
@@ -513,6 +529,7 @@ int __devinit pci_scan_bridge(struct pci
 							max+i+1))
 					break;
 			max += i;
+			pci_fixup_parent_subordinate_busnr(child, max);
 		}
 		/*
 		 * Set the subordinate bus number to its real value.

