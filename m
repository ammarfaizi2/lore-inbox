Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTBUAnp>; Thu, 20 Feb 2003 19:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTBUAnn>; Thu, 20 Feb 2003 19:43:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21766 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267300AbTBUAmG>;
	Thu, 20 Feb 2003 19:42:06 -0500
Date: Thu, 20 Feb 2003 16:45:00 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.62
Message-ID: <20030221004500.GD26723@kroah.com>
References: <20030221004344.GA26723@kroah.com> <20030221004424.GB26723@kroah.com> <20030221004442.GC26723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221004442.GC26723@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1005, 2003/02/20 14:23:58-08:00, greg@kroah.com

[PATCH] PCI i386: remove large stack usage in pcibios_fixup_peer_bridges()


diff -Nru a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
--- a/arch/i386/pci/legacy.c	Thu Feb 20 16:46:27 2003
+++ b/arch/i386/pci/legacy.c	Thu Feb 20 16:46:27 2003
@@ -12,28 +12,39 @@
 static void __devinit pcibios_fixup_peer_bridges(void)
 {
 	int n;
-	struct pci_bus bus;
-	struct pci_dev dev;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
 	u16 l;
 
 	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
 		return;
 	DBG("PCI: Peer bridge fixup\n");
+
+	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
+	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
+	if (!bus || !dev) {
+		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
+		goto exit;
+	}
+
 	for (n=0; n <= pcibios_last_bus; n++) {
 		if (pci_bus_exists(&pci_root_buses, n))
 			continue;
-		bus.number = n;
-		bus.ops = pci_root_ops;
-		dev.bus = &bus;
-		for(dev.devfn=0; dev.devfn<256; dev.devfn += 8)
-			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
+		bus->number = n;
+		bus->ops = pci_root_ops;
+		dev->bus = bus;
+		for (dev->devfn=0; dev->devfn<256; dev->devfn += 8)
+			if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
-				DBG("Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
+				DBG("Found device at %02x:%02x [%04x]\n", n, dev->devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, pci_root_ops, NULL);
 				break;
 			}
 	}
+exit:
+	kfree(dev);
+	kfree(bus);
 }
 
 static int __init pci_legacy_init(void)
