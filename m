Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVCRWAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVCRWAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCRV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:59:46 -0500
Received: from fmr23.intel.com ([143.183.121.15]:16793 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261467AbVCRV7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:59:23 -0500
Date: Fri, 18 Mar 2005 13:59:06 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [Patch 2/12] Fix pci_enable_device() for p2p bridges
Message-ID: <20050318135906.B1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When checking if a PCI to PCI bridge should be enabled to decode
memory and/or IO resources, we need to look at all device 
resources not just the first 6. This is needed to allow PCI
bridges to pass down memory and IO accesses to child devices
even when the bridge itself does not consume resources in its
PCI BARs.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff -puN arch/ia64/pci/pci.c~fix-ia64-pcibios_enable_resources arch/ia64/pci/pci.c
--- linux-2.6.11-mm4-iohp/arch/ia64/pci/pci.c~fix-ia64-pcibios_enable_resources	2005-03-16 13:07:02.055015329 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c	2005-03-16 13:07:02.164390328 -0800
@@ -436,18 +436,24 @@ pcibios_enable_resources (struct pci_dev
 	u16 cmd, old_cmd;
 	int idx;
 	struct resource *r;
+	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
 
 	if (!dev)
 		return -EINVAL;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx=0; idx<6; idx++) {
+	for (idx=0; idx<PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the desired resources.  */
 		if (!(mask & (1 << idx)))
 			continue;
 
 		r = &dev->resource[idx];
+		if (!(r->flags & type_mask))
+			continue;
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
 		if (!r->start && r->end) {
 			printk(KERN_ERR
 			       "PCI: Device %s not available because of resource collisions\n",
@@ -459,8 +465,6 @@ pcibios_enable_resources (struct pci_dev
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
_
