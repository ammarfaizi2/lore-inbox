Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUDORcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUDORai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:30:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:18350 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263018AbUDORYJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:09 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498253817@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <1082049825923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.5, 2004/03/26 16:32:52-08:00, willy@debian.org

[PATCH] PCI Hotplug: Rewrite acpiphp detect_used_resource

There are two unrelated problems in acpiphp that are fixed by this patch.
First, acpiphp can be a module, so it is unsafe to probe the BARs of each
device while it initialises -- the device may be active at the time.
Second, it does not know about PCI-PCI bridge registers and so it reads
garbage for the last 4 registers of the PCI-PCI bridge card and doesn't
take into account the ranges that are forwarded by the bridge.

This patch avoids all that by using the struct resources embedded in
the pci_dev.  Note that we no longer need to recurse as all the devices
on the other side of a PCI-PCI bridge have their resources entirely
contained within the PCI-PCI bridge's ranges.


 drivers/pci/hotplug/acpiphp_pci.c |  110 ++++++++------------------------------
 1 files changed, 26 insertions(+), 84 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Thu Apr 15 10:05:40 2004
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Thu Apr 15 10:05:40 2004
@@ -198,106 +198,42 @@
 /* detect_used_resource - subtract resource under dev from bridge */
 static int detect_used_resource (struct acpiphp_bridge *bridge, struct pci_dev *dev)
 {
-	u32 bar, len;
-	u64 base;
-	u32 address[] = {
-		PCI_BASE_ADDRESS_0,
-		PCI_BASE_ADDRESS_1,
-		PCI_BASE_ADDRESS_2,
-		PCI_BASE_ADDRESS_3,
-		PCI_BASE_ADDRESS_4,
-		PCI_BASE_ADDRESS_5,
-		0
-	};
 	int count;
-	struct pci_resource *res;
 
 	dbg("Device %s\n", pci_name(dev));
 
-	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword(dev, address[count], &bar);
+	for (count = 0; count < DEVICE_COUNT_RESOURCE; count++) {
+		struct pci_resource *res;
+		struct pci_resource **head;
+		unsigned long base = dev->resource[count].start;
+		unsigned long len = dev->resource[count].end - base + 1;
+		unsigned long flags = dev->resource[count].flags;
 
-		if (!bar)	/* This BAR is not implemented */
+		if (!flags)
 			continue;
 
-		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
-		pci_read_config_dword(dev, address[count], &len);
+		dbg("BAR[%d] 0x%lx - 0x%lx (0x%lx)\n", count, base,
+				base + len - 1, flags);
 
-		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
-			/* This is IO */
-			base = bar & 0xFFFFFFFC;
-			len = len & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
-			len = len & ~(len - 1);
-
-			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
-
-			spin_lock(&bridge->res_lock);
-			res = acpiphp_get_resource_with_base(&bridge->io_head, base, len);
-			spin_unlock(&bridge->res_lock);
-			if (res)
-				kfree(res);
+		if (flags & IORESOURCE_IO) {
+			head = &bridge->io_head;
+		} else if (flags & IORESOURCE_PREFETCH) {
+			head = &bridge->p_mem_head;
 		} else {
-			/* This is Memory */
-			base = bar & 0xFFFFFFF0;
-			if (len & PCI_BASE_ADDRESS_MEM_PREFETCH) {
-				/* pfmem */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg("prefetch mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource_with_base(&bridge->p_mem_head, base, len);
-				spin_unlock(&bridge->res_lock);
-				if (res)
-					kfree(res);
-			} else {
-				/* regular memory */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					dbg("mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource_with_base(&bridge->mem_head, base, len);
-				spin_unlock(&bridge->res_lock);
-				if (res)
-					kfree(res);
-			}
+			head = &bridge->mem_head;
 		}
 
-		pci_write_config_dword(dev, address[count], bar);
+		spin_lock(&bridge->res_lock);
+		res = acpiphp_get_resource_with_base(head, base, len);
+		spin_unlock(&bridge->res_lock);
+		if (res)
+			kfree(res);
 	}
 
 	return 0;
 }
 
 
-/* detect_pci_resource_bus - subtract resource under pci_bus */
-static void detect_used_resource_bus(struct acpiphp_bridge *bridge, struct pci_bus *bus)
-{
-	struct list_head *l;
-	struct pci_dev *dev;
-
-	list_for_each (l, &bus->devices) {
-		dev = pci_dev_b(l);
-		detect_used_resource(bridge, dev);
-		/* XXX recursive call */
-		if (dev->subordinate)
-			detect_used_resource_bus(bridge, dev->subordinate);
-	}
-}
-
-
 /**
  * acpiphp_detect_pci_resource - detect resources under bridge
  * @bridge: detect all resources already used under this bridge
@@ -306,7 +242,13 @@
  */
 int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge)
 {
-	detect_used_resource_bus(bridge, bridge->pci_bus);
+	struct list_head *l;
+	struct pci_dev *dev;
+
+	list_for_each (l, &bridge->pci_bus->devices) {
+		dev = pci_dev_b(l);
+		detect_used_resource(bridge, dev);
+	}
 
 	return 0;
 }

