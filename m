Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267331AbUHDQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267331AbUHDQYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUHDQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:24:08 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:38067 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267331AbUHDQXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:23:49 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH] idt77252.c: add missing pci_enable_device()
Date: Wed, 4 Aug 2004 10:23:28 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, ecd@atecom.com, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200408031350.21349.bjorn.helgaas@hp.com> <20040803215744.A11997@electric-eye.fr.zoreil.com>
In-Reply-To: <20040803215744.A11997@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041023.28922.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 1:57 pm, Francois Romieu wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> :
> [...]
> > ===== drivers/atm/idt77252.c 1.24 vs edited =====
> > --- 1.24/drivers/atm/idt77252.c	2004-07-12 02:01:05 -06:00
> > +++ edited/drivers/atm/idt77252.c	2004-07-30 13:45:42 -06:00
> > @@ -3684,6 +3684,11 @@
> >  	int i;
> >  
> >  
> > +	if (pci_enable_device(pcidev)) {
> > +		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
> > +		return -ENODEV;
> > +	}
> > +
> >  	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
> >  		printk("idt77252-%d: can't read PCI_REVISION_ID\n", index);
> >  		return -ENODEV;
> 
> It should be balanced by pci_disable_device() on close + error path.

OK, here's a revised version with the missing pci_disable_device() calls.
I should note that I don't have this hardware, so this has been compiled
but not tested.


Add pci_enable_device()/pci_disable_device().  In the past, drivers
often worked without this, but it is now required in order to route
PCI interrupts correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/atm/idt77252.c 1.24 vs edited =====
--- 1.24/drivers/atm/idt77252.c	2004-07-12 02:01:05 -06:00
+++ edited/drivers/atm/idt77252.c	2004-08-04 10:15:29 -06:00
@@ -3681,18 +3681,25 @@
 	struct idt77252_dev *card;
 	struct atm_dev *dev;
 	ushort revision = 0;
-	int i;
+	int i, err;
 
 
+	if (pci_enable_device(pcidev)) {
+		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
+		return -ENODEV;
+	}
+
 	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
 		printk("idt77252-%d: can't read PCI_REVISION_ID\n", index);
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 
 	card = kmalloc(sizeof(struct idt77252_dev), GFP_KERNEL);
 	if (!card) {
 		printk("idt77252-%d: can't allocate private data\n", index);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out_disable_pdev;
 	}
 	memset(card, 0, sizeof(struct idt77252_dev));
 
@@ -3718,23 +3725,21 @@
 	card->membase = (unsigned long) ioremap(membase, 1024);
 	if (!card->membase) {
 		printk("%s: can't ioremap() membase\n", card->name);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_free_card;
 	}
 
 	if (idt77252_preset(card)) {
 		printk("%s: preset failed\n", card->name);
-		iounmap((void *) card->membase);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_iounmap;
 	}
 
 	dev = atm_dev_register("idt77252", &idt77252_ops, -1, NULL);
 	if (!dev) {
 		printk("%s: can't register atm device\n", card->name);
-		iounmap((void *) card->membase);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_iounmap;
 	}
 	dev->dev_data = card;
 	card->atmdev = dev;
@@ -3743,9 +3748,8 @@
 	suni_init(dev);
 	if (!dev->phy) {
 		printk("%s: can't init SUNI\n", card->name);
-		deinit_card(card);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_deinit_card;
 	}
 #endif	/* CONFIG_ATM_IDT77252_USE_SUNI */
 
@@ -3756,9 +3760,8 @@
 			    ioremap(srambase | 0x200000 | (i << 18), 4);
 		if (!card->fbq[i]) {
 			printk("%s: can't ioremap() FBQ%d\n", card->name, i);
-			deinit_card(card);
-			kfree(card);
-			return -EIO;
+			err = -EIO;
+			goto err_out_deinit_card;
 		}
 	}
 
@@ -3769,9 +3772,8 @@
 
 	if (init_card(dev)) {
 		printk("%s: init_card failed\n", card->name);
-		deinit_card(card);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_deinit_card;
 	}
 
 	dev->ci_range.vpi_bits = card->vpibits;
@@ -3783,12 +3785,8 @@
 
 	if (idt77252_dev_open(card)) {
 		printk("%s: dev_open failed\n", card->name);
-
-		if (dev->phy->stop)
-			dev->phy->stop(dev);
-		deinit_card(card);
-		kfree(card);
-		return -EIO;
+		err = -EIO;
+		goto err_out_stop;
 	}
 
 	*last = card;
@@ -3796,6 +3794,23 @@
 	index++;
 
 	return 0;
+
+err_out_stop:
+	if (dev->phy->stop)
+		dev->phy->stop(dev);
+
+err_out_deinit_card:
+	deinit_card(card);
+
+err_out_iounmap:
+	iounmap((void *) card->membase);
+
+err_out_free_card:
+	kfree(card);
+
+err_out_disable_pdev:
+	pci_disable_device(pcidev);
+	return err;
 }
 
 static struct pci_device_id idt77252_pci_tbl[] =
@@ -3848,6 +3863,7 @@
 		if (dev->phy->stop)
 			dev->phy->stop(dev);
 		deinit_card(card);
+		pci_disable_device(card->pcidev);
 		kfree(card);
 	}
 
