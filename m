Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVDNSSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDNSSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVDNSSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:18:09 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:53729 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261152AbVDNSRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:17:45 -0400
Subject: Re: [PATCH] PC300 pci_enable_device fix
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: pc300@cyclades.com, lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050413150243.A26360@unix-os.sc.intel.com>
References: <1113427903.21308.3.camel@eeyore>
	 <20050413150243.A26360@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 12:17:32 -0600
Message-Id: <1113502652.22496.29.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 15:02 -0700, Ashok Raj wrote:
> On Wed, Apr 13, 2005 at 02:31:43PM -0700, Bjorn Helgaas wrote:
> > 
> >    Call pci_enable_device() before looking at IRQ and resources.
> >    The driver requires this fix or the "pci=routeirq" workaround
> >    on 2.6.10 and later kernels.

> the failure cases dont seem to worry about pci_disable_device()?
> in err_release_ram: etc?

True.  The failure paths were broken before, but here's a
revised patch that adds pci_disable_device() to them as
well.  Artur has tested this patch, too.


Call pci_enable_device() before looking at IRQ and resources.
The driver requires this fix or the "pci=routeirq" workaround
on 2.6.10 and later kernels.

Reported and tested by Artur Lipowski.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/wan/pc300_drv.c 1.24 vs edited =====
--- 1.24/drivers/net/wan/pc300_drv.c	2004-12-29 12:25:16 -07:00
+++ edited/drivers/net/wan/pc300_drv.c	2005-04-13 16:14:19 -06:00
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


