Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVF1IMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVF1IMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVF1GNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:13:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:36076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261884AbVF1Fdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:53 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Fix pci_enable_device() for p2p bridges
In-Reply-To: <11199367721003@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:52 -0700
Message-Id: <11199367721790@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Fix pci_enable_device() for p2p bridges

When checking if a PCI to PCI bridge should be enabled to decode memory and/or
IO resources, we need to look at all device resources not just the first 6.
This is needed to allow PCI bridges to pass down memory and IO accesses to
child devices even when the bridge itself does not consume resources in its
PCI BARs.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fab3fb0ac8c83072465b28ca859c420da6c6511c
tree f4d0dc0b7e9a8bd3611e1bf7f64dfd3cb55a950c
parent c431ada45d65b305a6aab4557067e564b23ce5a5
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:45 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:39 -0700

 arch/ia64/pci/pci.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -418,18 +418,24 @@ pcibios_enable_resources (struct pci_dev
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
@@ -441,8 +447,6 @@ pcibios_enable_resources (struct pci_dev
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);

