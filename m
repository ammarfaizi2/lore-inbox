Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVDZT7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVDZT7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVDZT7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:59:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45726 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261764AbVDZT7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:59:12 -0400
Date: Tue, 26 Apr 2005 11:41:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH] PC300 pci_enable_device fix
Message-ID: <20050426144157.GB31915@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Call pci_enable_device() before looking at IRQ and resources, 
and pci_disable_device() when shutting the interface down.

The driver requires this fix or the "pci=routeirq" workaround
on 2.6.10 and later kernels.
                                                                                                                                                                                   
Reported and tested by Artur Lipowski.
                                                                                                                                                                                   
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Index: drivers/net/wan/pc300_drv.c
===================================================================
--- 5b6486ded5188e41ac9bc81ad4a5e2bd746f7ede/drivers/net/wan/pc300_drv.c  (mode:100644 sha1:d67be2587d4d33879d479f331ad4cb9d3ac33f75)
+++ uncommitted/drivers/net/wan/pc300_drv.c  (mode:100664)
@@ -3427,7 +3427,7 @@
 {
 	static int first_time = 1;
 	ucchar cpc_rev_id;
-	int err = 0, eeprom_outdated = 0;
+	int err, eeprom_outdated = 0;
 	ucshort device_id;
 	pc300_t *card;
 
@@ -3439,15 +3439,21 @@
 #endif
 	}
 
+	if ((err = pci_enable_device(pdev)) < 0)
+		return err;
+
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
 		printk("PC300 found at RAM 0x%08lx, "
 		       "but could not allocate card structure.\n",
 		       pci_resource_start(pdev, 3));
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_disable_dev;
 	}
 	memset(card, 0, sizeof(pc300_t));
 
+	err = -ENODEV;
+
 	/* read PCI configuration area */
 	device_id = ent->device;
 	card->hw.irq = pdev->irq;
@@ -3507,7 +3513,6 @@
 		printk("PC300 found at RAM 0x%08x, "
 		       "but could not allocate PLX mem region.\n",
 		       card->hw.ramphys);
-		err = -ENODEV;
 		goto err_release_io;
 	}
 	if (!request_mem_region(card->hw.ramphys, card->hw.alloc_ramsize,
@@ -3515,7 +3520,6 @@
 		printk("PC300 found at RAM 0x%08x, "
 		       "but could not allocate RAM mem region.\n",
 		       card->hw.ramphys);
-		err = -ENODEV;
 		goto err_release_plx;
 	}
 	if (!request_mem_region(card->hw.scaphys, card->hw.scasize,
@@ -3523,13 +3527,9 @@
 		printk("PC300 found at RAM 0x%08x, "
 		       "but could not allocate SCA mem region.\n",
 		       card->hw.ramphys);
-		err = -ENODEV;
 		goto err_release_ram;
 	}
 
-	if ((err = pci_enable_device(pdev)) != 0)
-		goto err_release_sca;
-
 	card->hw.plxbase = ioremap(card->hw.plxphys, card->hw.plxsize);
 	card->hw.rambase = ioremap(card->hw.ramphys, card->hw.alloc_ramsize);
 	card->hw.scabase = ioremap(card->hw.scaphys, card->hw.scasize);
@@ -3619,7 +3619,6 @@
 		iounmap(card->hw.falcbase);
 		release_mem_region(card->hw.falcphys, card->hw.falcsize);
 	}
-err_release_sca:
 	release_mem_region(card->hw.scaphys, card->hw.scasize);
 err_release_ram:
 	release_mem_region(card->hw.ramphys, card->hw.alloc_ramsize);
@@ -3628,7 +3627,9 @@
 err_release_io:
 	release_region(card->hw.iophys, card->hw.iosize);
 	kfree(card);
-	return -ENODEV;
+err_disable_dev:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void __devexit cpc_remove_one(struct pci_dev *pdev)
@@ -3662,6 +3663,7 @@
 		if (card->hw.irq)
 			free_irq(card->hw.irq, card);
 		kfree(card);
+		pci_disable_device(pdev);
 	}
 }
 


