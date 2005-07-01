Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVGAU5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVGAU5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAU4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:56:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:50913 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262710AbVGAUti convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:38 -0400
Cc: ink@jurassic.park.msu.ru
Subject: [PATCH] PCI: pci_assign_unassigned_resources() on x86
In-Reply-To: <11202509114020@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:31 -0700
Message-Id: <11202509112600@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: pci_assign_unassigned_resources() on x86

- Add sanity check for io[port,mem]_resource in setup-bus.c. These
  resources look like "free" as they have no parents, but obviously
  we must not touch them.
- In i386.c:pci_allocate_bus_resources(), if a bridge resource cannot be
  allocated for some reason, then clear its flags. This prevents any child
  allocations in this range, so the setup-bus code will work with a clean
  resource sub-tree.
- i386.c:pcibios_enable_resources() doesn't enable bridges, as it checks
  only resources 0-5, which looks like a clear bug to me. I suspect it
  might break hotplug as well in some cases.

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 299de0343c7d18448a69c635378342e9214b14af
tree 0a456358b5f919328e234868139c983813f4cb80
parent 90b54929b626c80056262d9d99b3f48522e404d0
author Ivan Kokshaysky <ink@jurassic.park.msu.ru> Wed, 15 Jun 2005 18:59:27 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:50 -0700

 arch/i386/pci/common.c  |    1 +
 arch/i386/pci/i386.c    |   11 ++++++++---
 drivers/pci/setup-bus.c |    2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -165,6 +165,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
diff --git a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c
+++ b/arch/i386/pci/i386.c
@@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->start)
+				if (!r->flags)
 					continue;
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0)
+				if (!r->start || !pr || request_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
+					/* Something is wrong with the region.
+					   Invalidate the resource to prevent child
+					   resource allocations in this range. */
+					r->flags = 0;
+				}
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
@@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
+	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -273,6 +273,8 @@ find_free_bus_resource(struct pci_bus *b
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}

