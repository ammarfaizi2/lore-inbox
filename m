Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTBUAlh>; Thu, 20 Feb 2003 19:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBUAlh>; Thu, 20 Feb 2003 19:41:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20742 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267255AbTBUAlc>;
	Thu, 20 Feb 2003 19:41:32 -0500
Date: Thu, 20 Feb 2003 16:44:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI fixes for 2.5.62
Message-ID: <20030221004424.GB26723@kroah.com>
References: <20030221004344.GA26723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221004344.GA26723@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1003, 2003/02/20 14:23:27-08:00, greg@kroah.com

[PATCH] PCI: remove large stack usage in pci_do_scan_bus()


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Feb 20 16:46:35 2003
+++ b/drivers/pci/probe.c	Thu Feb 20 16:46:35 2003
@@ -505,23 +505,30 @@
 {
 	unsigned int devfn, max, pass;
 	struct list_head *ln;
-	struct pci_dev *dev, dev0;
+	struct pci_dev *dev;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
+		return 0;
+	}
 
 	DBG("Scanning bus %02x\n", bus->number);
 	max = bus->secondary;
 
 	/* Create a device template */
-	memset(&dev0, 0, sizeof(dev0));
-	dev0.bus = bus;
-	dev0.sysdata = bus->sysdata;
-	dev0.dev.parent = bus->dev;
-	dev0.dev.bus = &pci_bus_type;
+	memset(dev, 0, sizeof(*dev));
+	dev->bus = bus;
+	dev->sysdata = bus->sysdata;
+	dev->dev.parent = bus->dev;
+	dev->dev.bus = &pci_bus_type;
 
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 0x100; devfn += 8) {
-		dev0.devfn = devfn;
-		pci_scan_slot(&dev0);
+		dev->devfn = devfn;
+		pci_scan_slot(dev);
 	}
+	kfree(dev);
 
 	/*
 	 * After performing arch-dependent fixup of the bus, look behind
