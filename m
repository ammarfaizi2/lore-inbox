Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSGOJaT>; Mon, 15 Jul 2002 05:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGOJaS>; Mon, 15 Jul 2002 05:30:18 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:206 "EHLO lmail.actcom.co.il")
	by vger.kernel.org with ESMTP id <S317402AbSGOJaP>;
	Mon, 15 Jul 2002 05:30:15 -0400
Date: Mon, 15 Jul 2002 12:28:25 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: split up ide-pci.c:setup_host_channel to silence unused variable warning
Message-ID: <20020715122824.A6996@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compiling the kernel with -Werror, compilation dies in ide-pci.c
with 'unused variable dma_base'. The variable is only used if
CONFIG_BLK_DEV_IDEDMA is defined, and unused otherwise.=20

Attached is a patch to refactor setup_host_channel() into two
functions, setup_host_channel() and setup_channel_dma(), which is only
implemented if CONFIG_BLK_DEV_IDEDMA is defined, and is empty
otherwise. Since dma_base is only declared and used in
setup_channel_dma, the warning is silenced.=20

Patch is against 2.5.25 and compiles fine. It does not change
behaviour in any way, only a code cleanup. Comments appreciated.

--- linux-2.5.25-vanilla/drivers/ide/ide-pci.c	Sat Jul  6 02:42:33 2002
+++ linux-2.5.25-mx/drivers/ide/ide-pci.c	Mon Jul 15 12:05:23 2002
@@ -158,6 +158,87 @@
 	return 0;
 }
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA
+/*
+ * Setup DMA transfers on the channel.
+ */
+static void __init setup_channel_dma(struct pci_dev *dev,=20
+		struct ata_pci_device* d,=20
+		int autodma,=20
+		struct ata_channel *ch)
+{
+	unsigned long dma_base;=20
+=09
+	if (d->flags & ATA_F_NOADMA)
+		autodma =3D 0;
+=09
+	if (autodma)
+		ch->autodma =3D 1;
+
+	if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) =3D=3D PCI_CLASS_STORA=
GE_IDE && (dev->class & 0x80))))
+		return;=20
+
+	/*
+	 * Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space:
+	 */
+	dma_base =3D pci_resource_start(dev, 4);
+	if (dma_base) {
+		/* PDC20246, PDC20262, HPT343, & HPT366 */
+		if ((ch->unit =3D=3D ATA_PRIMARY) && d->extra) {
+			request_region(dma_base + 16, d->extra, dev->name);
+			ch->dma_extra =3D d->extra;
+		}
+	=09
+		/* If we are on the second channel, the dma base address will
+		 * be one entry away from the primary interface.
+		 */
+		if (ch->unit =3D=3D ATA_SECONDARY)
+				dma_base +=3D 8;
+	=09
+		if (d->flags & ATA_F_SIMPLEX) {
+			outb(inb(dma_base + 2) & 0x60, dma_base + 2);
+			if (inb(dma_base + 2) & 0x80)
+				printk(KERN_INFO "%s: simplex device: DMA forced\n", dev->name);
+		} else {
+			/* If the device claims "simplex" DMA, this means only
+			 * one of the two interfaces can be trusted with DMA at
+			 * any point in time.  So we should enable DMA only on
+			 * one of the two interfaces.
+			 */
+			if ((inb(dma_base + 2) & 0x80)) {
+				if ((!ch->drives[0].present && !ch->drives[1].present) ||
+				    ch->unit =3D=3D ATA_SECONDARY) {
+					printk(KERN_INFO "%s: simplex device:  DMA disabled\n", dev->name);
+					dma_base =3D 0;
+				}
+			}
+		}
+	} else {
+		printk(KERN_INFO "%s: %s Bus-Master DMA was disabled by BIOS\n",
+		       ch->name, dev->name);
+	=09
+		return;=20
+	}
+
+	/* The function below will check itself whatever there is something to
+	 * be done or not. We don't have therefore to care whatever it was
+	 * already enabled by the primary channel run.
+	 */
+	pci_set_master(dev);
+	if (d->init_dma)
+		d->init_dma(ch, dma_base);
+	else
+		ata_init_dma(ch, dma_base);
+}
+#else=20
+static void __init setup_channel_dma(struct pci_dev *dev,=20
+		struct ata_pci_device* d,=20
+		int autodma,=20
+		struct ata_channel *ch)
+{
+}
+#endif /* CONFIG_BLK_DEV_IDEDMA */=20
+			   =20
 /*
  * Setup a particular port on an ATA host controller.
  *
@@ -171,7 +252,6 @@
 		int autodma)
 {
 	unsigned long base =3D 0;
-	unsigned long dma_base;
 	unsigned long ctl =3D 0;
 	ide_pci_enablebit_t *e =3D &(d->enablebits[port]);
 	struct ata_channel *ch;
@@ -264,71 +344,11 @@
 		if (d->ata66_check)
 			ch->udma_four =3D d->ata66_check(ch);
 	}
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	/*
-	 * Setup DMA transfers on the channel.
-	 */
-	if (d->flags & ATA_F_NOADMA)
-		autodma =3D 0;
-
-	if (autodma)
-		ch->autodma =3D 1;
-
-	if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) =3D=3D PCI_CLASS_STORA=
GE_IDE && (dev->class & 0x80))))
-		goto no_dma;
-	/*
-	 * Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space:
-	 */
-	dma_base =3D pci_resource_start(dev, 4);
-	if (dma_base) {
-		/* PDC20246, PDC20262, HPT343, & HPT366 */
-		if ((ch->unit =3D=3D ATA_PRIMARY) && d->extra) {
-			request_region(dma_base + 16, d->extra, dev->name);
-			ch->dma_extra =3D d->extra;
-		}
-
-		/* If we are on the second channel, the dma base address will
-		 * be one entry away from the primary interface.
-		 */
-		if (ch->unit =3D=3D ATA_SECONDARY)
-			dma_base +=3D 8;
-
-		if (d->flags & ATA_F_SIMPLEX) {
-			outb(inb(dma_base + 2) & 0x60, dma_base + 2);
-			if (inb(dma_base + 2) & 0x80)
-				printk(KERN_INFO "%s: simplex device: DMA forced\n", dev->name);
-		} else {
-			/* If the device claims "simplex" DMA, this means only
-			 * one of the two interfaces can be trusted with DMA at
-			 * any point in time.  So we should enable DMA only on
-			 * one of the two interfaces.
-			 */
-			if ((inb(dma_base + 2) & 0x80)) {
-				if ((!ch->drives[0].present && !ch->drives[1].present) ||
-						ch->unit =3D=3D ATA_SECONDARY) {
-					printk(KERN_INFO "%s: simplex device:  DMA disabled\n", dev->name);
-					dma_base =3D 0;
-				}
-			}
-		}
-	} else {
-		printk(KERN_INFO "%s: %s Bus-Master DMA was disabled by BIOS\n",
-				ch->name, dev->name);
-
-		goto no_dma;
-	}
-
-	/* The function below will check itself whatever there is something to
-	 * be done or not. We don't have therefore to care whatever it was
-	 * already enabled by the primary channel run.
+=09
+        /*
+         * Setup DMA transfers on the channel (if CONFIG_BLK_DEV_IDEDMA is=
 defined)
 	 */
-	pci_set_master(dev);
-	if (d->init_dma)
-		d->init_dma(ch, dma_base);
-	else
-		ata_init_dma(ch, dma_base);
-#endif
+	setup_channel_dma(dev, d, autodma, ch);=20
=20
 no_dma:
 	/* Call chipset-specific routine for each enabled channel. */

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9MpW4KRs727/VN8sRAoq8AJ40TX1wQ+vM8kZyUNlakN4pSTIRlwCfSevu
7XLOQ0QW/t1DU1xpVZLcAgU=
=7knm
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
