Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVKQBGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVKQBGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVKQBGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:06:38 -0500
Received: from fmr24.intel.com ([143.183.121.16]:57515 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161053AbVKQBGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:06:38 -0500
Date: Wed, 16 Nov 2005 17:06:22 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: PCI: remove bogus resource collision error
Message-ID: <20051116170622.A10589@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to hotadd a PCI card with a bridge on it, I saw
the kernel reporting resource collision errors even when there were
really no collisions. The problem is that the code doesn't skip
over "invalid" resources with their resource type flag not set.
Others have reported similar problems at boot time and for
non-bridge PCI card hotplug too, where the code flags a
resource collision for disabled ROMs. This patch fixes both
problems. Please consider applying.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/i386/pci/i386.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc1/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/pci/i386.c
+++ linux-2.6.15-rc1/arch/i386/pci/i386.c
@@ -212,6 +212,7 @@ int pcibios_enable_resources(struct pci_
 	u16 cmd, old_cmd;
 	int idx;
 	struct resource *r;
+	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
@@ -221,6 +222,11 @@ int pcibios_enable_resources(struct pci_
 			continue;
 
 		r = &dev->resource[idx];
+		if (!(r->flags & type_mask))
+			continue;
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
 		if (!r->start && r->end) {
 			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
 			return -EINVAL;
@@ -230,8 +236,6 @@ int pcibios_enable_resources(struct pci_
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
