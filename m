Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUIAC7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUIAC7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUIAC7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:59:33 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:53403 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S267645AbUIAC7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:59:12 -0400
Message-ID: <7076215DFAA4574099E5CD59FE42226204FBC741@pcssrv42.pcs.pc.ome.toshiba.co.jp>
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Petr Sebor <petr@scssoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       petter.sundlof@findus.dhs.org, linux-kernel@vger.kernel.org,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: RE: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
Date: Wed, 1 Sep 2004 11:57:35 +0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ｈｉ　Jeff,

Sorry for not writing you soon.

Haruo> Combined mode can be set up by the SATA controller of ESB of Intel tip. 
Haruo> This mode is the mode which can use SATA and PATA simultaneously. 
Haruo> In ata_piix driver, when combined mode is specified, it does not work.
 
Jeff> May I request, again, information on this.  In the current kernel you 
Jeff> are the only one reporting this problem.
Jeff> Does 2.6.9-rc1-bk work for you?

2.6.9-rc1-bk7 has no problem. It is worked.
But, 2.4.28-pre2-bk1 is not work.
As 2.4.28-pre2-bk1, I created the patch for solving this problem. 
Is it right? The patch is as follows.

===== SATA combined mode patch for linux-2.4.28-pre2 =====

diff -urN linux-2.4.28-pre2-bk1orig/drivers/pci/quirks.c linux-2.4.28-pre2-bk1/drivers/pci/quirks.c
--- linux-2.4.28-pre2-bk1orig/drivers/pci/quirks.c	2004-08-31 15:11:08.000000000 +0900
+++ linux-2.4.28-pre2-bk1/drivers/pci/quirks.c	2004-09-01 09:33:11.000000000 +0900
@@ -719,6 +719,61 @@
 	}
 }
 
+#ifdef CONFIG_SCSI_SATA
+static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
+{
+	u8 prog, comb, tmp;
+
+	/*
+	 * Narrow down to Intel SATA PCI devices.
+	 */
+	switch (pdev->device) {
+	/* PCI ids taken from drivers/scsi/ata_piix.c */
+	case 0x24d1:
+	case 0x24df:
+	case 0x25a3:
+	case 0x25b0:
+	case 0x2651:
+	case 0x2652:
+		break;
+	default:
+		/* we do not handle this PCI device */
+		return;
+	}
+
+	/*
+	 * Read combined mode register.
+	 */
+	pci_read_config_byte(pdev, 0x90, &tmp); /* combined mode reg */
+	tmp &= 0x6;     /* interesting bits 2:1, PATA primary/secondary */
+	if (tmp == 0x4)         /* bits 10x */
+		comb = (1 << 0);                /* SATA port 0, PATA port 1 */
+	else if (tmp == 0x6)    /* bits 11x */
+		comb = (1 << 2);                /* PATA port 0, SATA port 1 */
+	else
+		return;                         /* not in combined mode */
+
+	/*
+	 * Read programming interface register.
+	 * (Tells us if it's legacy or native mode)
+	 */
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+	/* if SATA port is in native mode, we're ok. */
+	if (prog & comb)
+		return;
+
+	/* SATA port is in legacy mode.  Reserve port so that
+	 * IDE driver does not attempt to use it.  If request_region
+	 * fails, it will be obvious at boot time, so we don't bother
+	 * checking return values.
+	 */
+	if (comb == (1 << 0))
+		request_region(0x1f0, 8, "libata");     /* port 0 */
+	else
+		request_region(0x170, 8, "libata");     /* port 1 */
+}
+#endif
+
 /*
  *  The main table of quirks.
  */
@@ -797,6 +852,10 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,      PCI_DEVICE_ID_AMD_8131_APIC, 
 	  quirk_amd_8131_ioapic }, 
 #endif
+#ifdef CONFIG_SCSI_SATA
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,
+	  quirk_intel_ide_combined },
+#endif
 
 	/*
 	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
diff -urN linux-2.4.28-pre2-bk1orig/drivers/scsi/ata_piix.c linux-2.4.28-pre2-bk1/drivers/scsi/ata_piix.c
--- linux-2.4.28-pre2-bk1orig/drivers/scsi/ata_piix.c	2004-08-31 15:11:08.000000000 +0900
+++ linux-2.4.28-pre2-bk1/drivers/scsi/ata_piix.c	2004-09-01 12:07:22.000000000 +0900
@@ -620,8 +620,7 @@
 		port_info[pata_chan] = &piix_port_info[ich5_pata];
 		n_ports++;
 
-		printk(KERN_ERR DRV_NAME ": combined mode not supported\n");
-		return -ENODEV;
+		printk(KERN_WARNING DRV_NAME ": combined mode detected\n");
 	}
 
 	return ata_pci_init_one(pdev, port_info, n_ports);
diff -urN linux-2.4.28-pre2-bk1orig/drivers/scsi/libata-core.c linux-2.4.28-pre2-bk1/drivers/scsi/libata-core.c
--- linux-2.4.28-pre2-bk1orig/drivers/scsi/libata-core.c	2004-08-31 15:11:08.000000000 +0900
+++ linux-2.4.28-pre2-bk1/drivers/scsi/libata-core.c	2004-09-01 10:20:06.000000000 +0900
@@ -3296,14 +3296,27 @@
 		goto err_out;
 
 	if (legacy_mode) {
-		if (!request_region(0x1f0, 8, "libata"))
-			printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
-		else
+		if (!request_region(0x1f0, 8, "libata")) {
+			struct resource *conflict, res;
+			res.start = 0x1f0;
+			res.end = 0x1f0 + 8 - 1;
+			conflict = ____request_resource(&ioport_resource, &res);			if (!strcmp(conflict->name, "libata"))
+				legacy_mode |= (1 << 0);
+			else
+				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
+		} else
 			legacy_mode |= (1 << 0);
 
-		if (!request_region(0x170, 8, "libata"))
-			printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
-		else
+		if (!request_region(0x170, 8, "libata")) {
+			struct resource *conflict, res;
+			res.start = 0x170;
+			res.end = 0x170 + 8 - 1;
+			conflict = ____request_resource(&ioport_resource, &res);
+			if (!strcmp(conflict->name, "libata"))
+				legacy_mode |= (1 << 1);
+			else
+				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
+		} else
 			legacy_mode |= (1 << 1);
 	}
 
diff -urN linux-2.4.28-pre2-bk1orig/include/linux/ioport.h linux-2.4.28-pre2-bk1/include/linux/ioport.h
--- linux-2.4.28-pre2-bk1orig/include/linux/ioport.h	2003-11-29 03:26:21.000000000 +0900
+++ linux-2.4.28-pre2-bk1/include/linux/ioport.h	2004-09-01 09:51:25.000000000 +0900
@@ -85,6 +85,7 @@
 
 extern int check_resource(struct resource *root, unsigned long, unsigned long);
 extern int request_resource(struct resource *root, struct resource *new);
+extern struct resource * ____request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     unsigned long size,
diff -urN linux-2.4.28-pre2-bk1orig/kernel/ksyms.c linux-2.4.28-pre2-bk1/kernel/ksyms.c
--- linux-2.4.28-pre2-bk1orig/kernel/ksyms.c	2004-02-18 22:36:32.000000000 +0900
+++ linux-2.4.28-pre2-bk1/kernel/ksyms.c	2004-09-01 09:58:33.000000000 +0900
@@ -448,6 +448,7 @@
 #endif
 
 /* resource handling */
+EXPORT_SYMBOL(____request_resource);
 EXPORT_SYMBOL(request_resource);
 EXPORT_SYMBOL(release_resource);
 EXPORT_SYMBOL(allocate_resource);
diff -urN linux-2.4.28-pre2-bk1orig/kernel/resource.c linux-2.4.28-pre2-bk1/kernel/resource.c
--- linux-2.4.28-pre2-bk1orig/kernel/resource.c	2003-11-29 03:26:21.000000000 +0900
+++ linux-2.4.28-pre2-bk1/kernel/resource.c	2004-09-01 09:47:24.000000000 +0900
@@ -166,6 +166,16 @@
 	return conflict ? -EBUSY : 0;
 }
 
+struct resource *____request_resource(struct resource *root, struct resource *new)
+{
+struct resource *conflict;
+
+	write_lock(&resource_lock);
+	conflict = __request_resource(root, new);
+	write_unlock(&resource_lock);
+	return conflict;
+}
+
 int release_resource(struct resource *old)
 {
 	int retval;
