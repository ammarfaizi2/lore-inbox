Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUL3AFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUL3AFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUL3AFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:05:23 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55173 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261450AbUL3AE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:04:59 -0500
Date: Thu, 30 Dec 2004 01:03:02 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-bk1 1/5] pci-ide: propagation of error code in ide setup
Message-ID: <20041230000302.GA4267@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e04122813152759d94f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Propagation of error code in ide setup

- Change the return value and the prototype of do_ide_setup_pci_device
  Due to lack of appropriate return status code, the current clients of
  do_ide_setup_pci_device() can not distinguish a failing invocation
  from a successfull one. The patch modify do_ide_setup_pci_device() so
  that it can propagate some of the errors from the lower layers.

- Make ide_setup_pci_device() aware of the change and propagate the news
  itself. I only gave a quick sight to create_proc_ide_interfaces() (and
  ide_remove_proc_entries()) but they do seem sane and it should not matter
  if it fails or not.

- ide_setup_pci_devices(): mostly the same thing than ide_setup_pci_device().
  do not look trivially suspect.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/ide/setup-pci.c~ata-010 drivers/ide/setup-pci.c
--- linux-2.6.10-bk1/drivers/ide/setup-pci.c~ata-010	2004-12-28 22:20:31.000000000 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/setup-pci.c	2004-12-29 23:15:36.148566659 +0100
@@ -643,14 +643,16 @@ EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
  * we "know" about, this information is in the ide_pci_device_t struct;
  * for all other chipsets, we just assume both interfaces are enabled.
  */
-static ata_index_t do_ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d, u8 noisy)
+static int do_ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d,
+				    ata_index_t *index, u8 noisy)
 {
-	int pciirq = 0;
+	static ata_index_t ata_index = { .b = { .low = 0xff, .high = 0xff } };
 	int tried_config = 0;
-	ata_index_t index = { .b = { .low = 0xff, .high = 0xff } };
-
-	if (ide_setup_pci_controller(dev, d, noisy, &tried_config) < 0)
-		return index;
+	int pciirq, ret;
+	
+	ret = ide_setup_pci_controller(dev, d, noisy, &tried_config);
+	if (ret < 0)
+		goto out;
 
 	/*
 	 * Can we trust the reported IRQ?
@@ -668,7 +670,10 @@ static ata_index_t do_ide_setup_pci_devi
 		 * space, place chipset into init-mode, and/or preserve
 		 * an interrupt if the card is not native ide support.
 		 */
-		pciirq = (d->init_chipset) ? d->init_chipset(dev, d->name) : 0;
+		ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
+		if (ret < 0)
+			goto out;
+		pciirq = ret;
 	} else if (tried_config) {
 		if (noisy)
 			printk(KERN_INFO "%s: will probe irqs later\n", d->name);
@@ -679,10 +684,10 @@ static ata_index_t do_ide_setup_pci_devi
 				d->name, pciirq);
 		pciirq = 0;
 	} else {
-		if (d->init_chipset)
-		{
-			if(d->init_chipset(dev, d->name) < 0)
-				return index;
+		if (d->init_chipset) {
+			ret = d->init_chipset(dev, d->name);
+			if (ret < 0)
+				goto out;
 		}
 		if (noisy)
 #ifdef __sparc__
@@ -694,17 +699,22 @@ static ata_index_t do_ide_setup_pci_devi
 #endif
 	}
 	
-	if(pciirq < 0)		/* Error not an IRQ */
-		return index;
-
-	ide_pci_setup_ports(dev, d, pciirq, &index);
-
-	return index;
+	/* FIXME: silent failure can happen */
+	
+	*index = ata_index;
+	ide_pci_setup_ports(dev, d, pciirq, index);
+out:
+	return ret;
 }
 
-void ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)
+int ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
+	ata_index_t index_list;
+	int ret;
+
+	ret = do_ide_setup_pci_device(dev, d, &index_list, 1);
+	if (ret < 0)
+		goto out;
 
 	if ((index_list.b.low & 0xf0) != 0xf0)
 		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.low], d->fixup);
@@ -712,25 +722,42 @@ void ide_setup_pci_device (struct pci_de
 		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.high], d->fixup);
 
 	create_proc_ide_interfaces();
+out:
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_device);
 
-void ide_setup_pci_devices (struct pci_dev *dev, struct pci_dev *dev2, ide_pci_device_t *d)
+int ide_setup_pci_devices (struct pci_dev *dev1, struct pci_dev *dev2,
+			   ide_pci_device_t *d)
 {
-	ata_index_t index_list  = do_ide_setup_pci_device(dev, d, 1);
-	ata_index_t index_list2 = do_ide_setup_pci_device(dev2, d, 0);
+	struct pci_dev *pdev[] = { dev1, dev2 };
+	ata_index_t index_list[2];
+	int ret, i;
 
-	if ((index_list.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.low]);
-	if ((index_list.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.high]);
-	if ((index_list2.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
-	if ((index_list2.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
+	for (i = 0; i < 2; i++) {
+		ret = do_ide_setup_pci_device(pdev[i], d, index_list + i, !i);
+		/*
+		 * FIXME: Mom, mom, they stole me the helper function to undo
+		 * do_ide_setup_pci_device() on the first device !
+		 */
+		if (ret < 0)
+			goto out;
+	}
+
+	for (i = 0; i < 2; i++) {
+		u8 idx[2] = { index_list[i].b.low, index_list[i].b.high };
+		int j;
+
+		for (j = 0; j < 2; j++) {
+			if ((idx[j] & 0xf0) != 0xf0)
+				probe_hwif_init(ide_hwifs + idx[j]);
+		}
+	}
 
 	create_proc_ide_interfaces();
+out:
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);
diff -puN include/linux/ide.h~ata-010 include/linux/ide.h
--- linux-2.6.10-bk1/include/linux/ide.h~ata-010	2004-12-28 23:44:41.000000000 +0100
+++ linux-2.6.10-bk1-fr/include/linux/ide.h	2004-12-29 23:15:33.338024718 +0100
@@ -1438,8 +1438,8 @@ typedef struct ide_pci_device_s {
 	u8			flags;
 } ide_pci_device_t;
 
-extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
-extern void ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
+extern int ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
+extern int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
 
 void ide_map_sg(ide_drive_t *, struct request *);
 void ide_init_sg_cmd(ide_drive_t *, struct request *);

_
