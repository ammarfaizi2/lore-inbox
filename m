Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbTGDCAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbTGDB6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:58:39 -0400
Received: from granite.he.net ([216.218.226.66]:26126 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265659AbTGDByy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845532384@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845532869@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1368, 2003/07/03 15:51:59-07:00, willy@debian.org

[PATCH] PCI: arch/i386/pci/legacy.c: use raw_pci_ops
Make pcibios_fixup_peer_bridges() use raw_pci_ops directly instead of
faking pci_bus and pci_dev.


 arch/i386/pci/legacy.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)


diff -Nru a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
--- a/arch/i386/pci/legacy.c	Thu Jul  3 18:16:40 2003
+++ b/arch/i386/pci/legacy.c	Thu Jul  3 18:16:40 2003
@@ -11,40 +11,26 @@
  */
 static void __devinit pcibios_fixup_peer_bridges(void)
 {
-	int n;
-	struct pci_bus *bus;
-	struct pci_dev *dev;
-	u16 l;
+	int n, devfn;
 
 	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
 		return;
 	DBG("PCI: Peer bridge fixup\n");
 
-	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
-	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
-	if (!bus || !dev) {
-		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
-		goto exit;
-	}
-
 	for (n=0; n <= pcibios_last_bus; n++) {
+		u32 l;
 		if (pci_find_bus(0, n))
 			continue;
-		bus->number = n;
-		bus->ops = &pci_root_ops;
-		dev->bus = bus;
-		for (dev->devfn=0; dev->devfn<256; dev->devfn += 8)
-			if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
+		for (devfn = 0; devfn < 256; devfn += 8) {
+			if (!raw_pci_ops->read(0, n, devfn, PCI_VENDOR_ID, 2, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, dev->devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, &pci_root_ops, NULL);
 				break;
 			}
+		}
 	}
-exit:
-	kfree(dev);
-	kfree(bus);
 }
 
 static int __init pci_legacy_init(void)

