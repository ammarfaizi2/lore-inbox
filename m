Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276583AbSIVFpY>; Sun, 22 Sep 2002 01:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbSIVFpY>; Sun, 22 Sep 2002 01:45:24 -0400
Received: from [218.245.211.9] ([218.245.211.9]:61074 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S276583AbSIVFpV>;
	Sun, 22 Sep 2002 01:45:21 -0400
Date: Sun, 22 Sep 2002 13:48:22 +0800
From: Hu Gang <hugang@soulinfo.com>
To: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch]Backport 82801CAM IDE support to 2.4.x
Message-Id: <20020922134822.6dbf3120.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.EM,KbW0ATy+ell"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.EM,KbW0ATy+ell
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__22_Sep_2002_13:48:22_+0800_084dbf80"


--Multipart_Sun__22_Sep_2002_13:48:22_+0800_084dbf80
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all:

At Thu, 12 Sep 2002 09:19:29 +0800, I sended this patch, Now it works fine in my machine. It make faster(~5X) than without it. Please apply.

@@@@@@@@@@@@@@@@ with patch @@@@@@@@@@@@@@
# hdparm -t /dev/hda
/dev/hda:
 Timing buffered disk reads:  64 MB in 15.76 seconds =  4.06 MB/sec
# dmesg 
*** Snip ****
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: (ide_setup_pci_device:) Could not enable device.
*** Snip ****

@@@@@@@@@@@@@@@@ with patch @@@@@@@@@@@@@@@@@@
# hdparm -t /dev/hda
/dev/hda:
 Timing buffered disk reads:  64 MB in  3.29 seconds = 19.45 MB/sec
# dmesg 
**** Snip ***

ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Assigned IRQ 5 for device 00:1f.1
ICH3M: chipset revision 2
***** Snip *****
(thanks for Frederic Garzon <garz@free.fr> reported)

I we can add it into 2.4.X kernel. here is it again.
----------------------------------------------

-- 
		- Hu Gang

--Multipart_Sun__22_Sep_2002_13:48:22_+0800_084dbf80
Content-Type: text/plain;
 name="ich3m.diff"
Content-Disposition: attachment;
 filename="ich3m.diff"
Content-Transfer-Encoding: 7bit

--- linux.old/drivers/ide/ide-pci.c	Sun Sep 22 13:45:13 2002
+++ linux/drivers/ide/ide-pci.c	Wed Sep 11 13:44:27 2002
@@ -951,6 +951,42 @@
 	ide_setup_pci_device(dev2, d2);
 }
 
+inline void ide_register_xp_fix(struct pci_dev *dev)
+{
+        int i;
+        unsigned short cmd;
+        unsigned long flags;
+        unsigned long base_address[4] = { 0x1f0, 0x3f4, 0x170, 0x374 };
+
+        local_irq_save(flags);
+        pci_read_config_word(dev, PCI_COMMAND, &cmd);
+        pci_write_config_word(dev, PCI_COMMAND, cmd & ~PCI_COMMAND_IO);
+        for (i=0; i<4; i++) {
+                dev->resource[i].start = 0;
+                dev->resource[i].end = 0;
+                dev->resource[i].flags = 0;
+        }                                                                        
+        for (i=0; i<4; i++) {                                                    
+                dev->resource[i].start = base_address[i];
+                dev->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
+                pci_write_config_dword(dev,
+                        (PCI_BASE_ADDRESS_0 + (i * 4)),
+                        dev->resource[i].start);
+        }
+        pci_write_config_word(dev, PCI_COMMAND, cmd);
+        local_irq_restore(flags);
+}
+
+void __init fixup_device_piix (struct pci_dev *dev, ide_pci_device_t *d)
+{
+        if (dev->resource[0].start != 0x01F1)
+                ide_register_xp_fix(dev);
+        printk("%s: IDE controller on PCI bus %02x dev %02x\n",
+                d->name, dev->bus->number, dev->devfn);
+        ide_setup_pci_device(dev, d);
+
+}
+
 /*
  * ide_scan_pcibus() gets invoked at boot time from ide.c.
  * It finds all PCI IDE controllers and calls ide_setup_pci_device for them.
@@ -977,6 +1013,8 @@
 		hpt366_device_order_fixup(dev, d);
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20270))
 		pdc20270_device_order_fixup(dev, d);
+        else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_ICH3M))
+                fixup_device_piix(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
 			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",

--Multipart_Sun__22_Sep_2002_13:48:22_+0800_084dbf80--

--=.EM,KbW0ATy+ell
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jVmmPM4uCy7bAJgRAqcIAJ0YWZ4Vy+4Q5P8N2d4NM7UX3LNIWACdFnLC
RFYpM3RV7t+IDlWrJseVV50=
=Xr19
-----END PGP SIGNATURE-----

--=.EM,KbW0ATy+ell--
