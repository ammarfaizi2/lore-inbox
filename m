Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTBUAly>; Thu, 20 Feb 2003 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBUAly>; Thu, 20 Feb 2003 19:41:54 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21510 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267288AbTBUAls>;
	Thu, 20 Feb 2003 19:41:48 -0500
Date: Thu, 20 Feb 2003 16:44:42 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.62
Message-ID: <20030221004442.GC26723@kroah.com>
References: <20030221004344.GA26723@kroah.com> <20030221004424.GB26723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221004424.GB26723@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1004, 2003/02/20 14:23:43-08:00, greg@kroah.com

[PATCH] PCI i386: remove large stack usage in pci_sanity_check()


diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Thu Feb 20 16:46:31 2003
+++ b/arch/i386/pci/direct.c	Thu Feb 20 16:46:31 2003
@@ -196,21 +196,35 @@
 static int __devinit pci_sanity_check(struct pci_ops *o)
 {
 	u32 x = 0;
-	struct pci_bus bus;		/* Fake bus and device */
-	struct pci_dev dev;
+	int retval = 0;
+	struct pci_bus *bus;		/* Fake bus and device */
+	struct pci_dev *dev;
 
 	if (pci_probe & PCI_NO_CHECKS)
 		return 1;
-	bus.number = 0;
-	dev.bus = &bus;
-	for(dev.devfn=0; dev.devfn < 0x100; dev.devfn++)
-		if ((!o->read(&bus, dev.devfn, PCI_CLASS_DEVICE, 2, &x) &&
+
+	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
+	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
+	if (!bus || !dev) {
+		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
+		goto exit;
+	}
+
+	bus->number = 0;
+	dev->bus = bus;
+	for(dev->devfn=0; dev->devfn < 0x100; dev->devfn++)
+		if ((!o->read(bus, dev->devfn, PCI_CLASS_DEVICE, 2, &x) &&
 		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read(&bus, dev.devfn, PCI_VENDOR_ID, 2, &x) &&
-		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)))
-			return 1;
+		    (!o->read(bus, dev->devfn, PCI_VENDOR_ID, 2, &x) &&
+		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ))) {
+			retval = 1;
+			goto exit;
+		}
 	DBG("PCI: Sanity check failed\n");
-	return 0;
+exit:
+	kfree(dev);
+	kfree(bus);
+	return retval;
 }
 
 static int __init pci_direct_init(void)
