Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUBKRXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUBKRXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:23:40 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:60327 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266020AbUBKRXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:23:03 -0500
Date: Wed, 11 Feb 2004 18:12:48 +0100
From: Tim Vandermeersch <Tim.Vandermeersch@pandora.be>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCH] Make Krups javastation work with 2.6.2 [forgot patch :(]
Message-ID: <20040211171248.GA24148@pandora.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-system: Debian GNU/Linux
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch to make kerbel 2.6.2 work with krups javastation.

--=20
Regards,
Tim Vandermeersch

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="javastation.krups-2.6.2.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.2_orig/arch/sparc/kernel/pcic.c	2004-02-04 04:43:55.000000000=
 +0100
+++ linux-2.6.2_hack/arch/sparc/kernel/pcic.c	2004-02-11 17:35:37.000000000=
 +0100
@@ -35,9 +35,24 @@
 #include <asm/timer.h>
 #include <asm/uaccess.h>
=20
-
+/*
+ * When using ioremap in igafb.c the address 0x30000000 got mapped
+ * twice wich caused a panic
+ */
+static void __devinit pci_fixup_igafb(struct pci_dev *dev)
+{
+	prom_printf("pci_fixup_igafb();\n");
+	dev->resource[1].start =3D 1;
+	dev->resource[1].end   =3D 0;
+	dev->resource[1].flags =3D IORESOURCE_IO;
+}
+=20
 struct pci_fixup pcibios_fixups[] =3D {
-	{ 0 }
+	{
+		PCI_FIXUP_HEADER,
+		PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+		pci_fixup_igafb
+	}, { 0 }
 };
=20
 unsigned int pcic_pin_to_irq(unsigned int pin, char *name);
--- linux-2.6.2_orig/drivers/video/igafb.c	2004-02-04 04:43:56.000000000 +0=
100
+++ linux-2.6.2_hack/drivers/video/igafb.c	2004-02-11 17:39:58.000000000 +0=
100
@@ -327,6 +327,7 @@
 	.fb_fillrect	=3D cfb_fillrect,
 	.fb_copyarea	=3D cfb_copyarea,
 	.fb_imageblit	=3D cfb_imageblit,
+	.fb_cursor	=3D soft_cursor,
 #ifdef __sparc__
 	.fb_mmap 	=3D igafb_mmap,
 #endif
@@ -409,7 +410,8 @@
         memset(info, 0, size);
=20
 	par =3D (struct iga_par *) (info + 1);
-=09
+
+	info->par =3D par;=09
=20
 	if ((addr =3D pdev->resource[0].start) =3D=3D 0) {
                 printk("igafb_init: no memory start\n");
@@ -447,16 +449,21 @@
 	 */
 	if (iga2000) {
 		igafb_fix.mmio_start =3D par->frame_buffer_phys | 0x00800000;
-	} else {
-		igafb_fix.mmio_start =3D 0x30000000;	/* XXX */
-	}
-	if ((par->io_base =3D (int) ioremap(igafb_fix.mmio_start, igafb_fix.smem_=
len)) =3D=3D 0) {
-                printk("igafb_init: can't remap %lx[4K]\n", igafb_fix.mmio=
_start);
-		iounmap((void *)info->screen_base);
-		kfree(info);
-		return -ENXIO;
-	}
=20
+		if ((par->io_base =3D (int) ioremap(igafb_fix.mmio_start,=20
+						igafb_fix.smem_len)) =3D=3D 0) {
+        	        printk("igafb_init: can't remap %lx[4K]\n",=20
+					igafb_fix.mmio_start);
+			iounmap((void *)info->screen_base);
+			kfree(info);
+			return -ENXIO;
+		}
+	 } else {
+	 	/* fixup in arch/sparc/kernelpcic.c */
+		par->io_base =3D pdev->resource[1].start - 1;
+	 }
+
+=09
 	/*
 	 * Figure mmap addresses from PCI config space.
 	 * We need two regions: for video memory and for I/O ports.
--- linux-2.6.2_orig/drivers/input/serio/i8042-sparcio.h	2004-02-04 04:45:0=
2.000000000 +0100
+++ linux-2.6.2_hack/drivers/input/serio/i8042-sparcio.h	2004-02-11 17:43:1=
7.000000000 +0100
@@ -85,8 +85,10 @@
 			if (!strcmp(child->prom_name, OBP_PS2KBD_NAME1) ||
 			    !strcmp(child->prom_name, OBP_PS2KBD_NAME2)) {
 				i8042_kbd_irq =3D child->irqs[0];
+				/* tested on krups javastation */
 				kbd_iobase =3D (unsigned long)
-					ioremap(child->resource[0].start, 8);
+					(child->resource[0].start - 0x60);
+				 /* ioremap(child->resource[0].start, 8); */
 			}
 			if (!strcmp(child->prom_name, OBP_PS2MS_NAME1) ||
 			    !strcmp(child->prom_name, OBP_PS2MS_NAME2))

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKmKQxIv5fcynryoRAqwYAJ9e9RqXAUQ9XTlwIvjxs/KG04VlhwCfZCFC
WSTYu06fcjmDmJYZx7/XMU4=
=9e62
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
