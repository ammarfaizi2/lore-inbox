Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310306AbSCMMZq>; Wed, 13 Mar 2002 07:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310319AbSCMMZh>; Wed, 13 Mar 2002 07:25:37 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:33037 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S310306AbSCMMZX>;
	Wed, 13 Mar 2002 07:25:23 -0500
Date: Wed, 13 Mar 2002 15:29:33 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i82092 PCMCIA driver cleanup
Message-ID: <20020313122933.GA291@pazke.ipt>
Mail-Followup-To: arjanv@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch contains some minor changes to i82092.c PCMCIA driver:
	- MODULE_DEVICE_TABLE() added;
	- request_region() and pci_enable_device() return value checks added;
	- some printk() cleanups.

Untested, but compiles and looks correct.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i82092-3
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/pcmcia/i82092.c linu=
x/drivers/pcmcia/i82092.c
--- linux.vanilla/drivers/pcmcia/i82092.c	Tue Dec  4 12:44:22 2001
+++ linux/drivers/pcmcia/i82092.c	Fri Mar  8 23:25:11 2002
@@ -37,6 +37,7 @@
 	 },
 	 {}=20
 };
+MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
=20
 static struct pci_driver i82092aa_pci_drv =3D {
 	name:           "i82092aa",
@@ -91,42 +92,41 @@
 static int __init i82092aa_pci_probe(struct pci_dev *dev, const struct pci=
_device_id *id)
 {
 	unsigned char configbyte;
-	int i;
+	int i, ret;
 =09
 	enter("i82092aa_pci_probe");
 =09
-	if (pci_enable_device(dev))
-		return -EIO;
+	if ((ret =3D pci_enable_device(dev)))
+		return ret;
 	=09
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Contr=
ol */
 	switch(configbyte&6) {
 		case 0:
-			printk(KERN_INFO "i82092aa: configured as a 2 socket device.\n");
 			socket_count =3D 2;
 			break;
 		case 2:
-			printk(KERN_INFO "i82092aa: configured as a 1 socket device.\n");
 			socket_count =3D 1;
 			break;
 		case 4:
 		case 6:
-			printk(KERN_INFO "i82092aa: configured as a 4 socket device.\n");
 			socket_count =3D 4;
 			break;
 		=09
 		default:
 			printk(KERN_ERR "i82092aa: Oops, you did something we didn't think of.\=
n");
-			return -EIO;
-			break;
+			ret =3D -EIO;
+			goto err_out_disable;
+	}
+	printk(KERN_INFO "i82092aa: configured as a %d socket device.\n", socket_=
count);
+
+	if (request_region(pci_resource_start(dev, 0), 2, "i82092aa")) {
+		ret =3D -EBUSY;
+		goto err_out_disable;
 	}
 =09
 	for (i =3D 0;i<socket_count;i++) {
 		sockets[i].card_state =3D 1; /* 1 =3D present but empty */
-		sockets[i].io_base =3D (dev->resource[0].start & ~1);
-		 if (sockets[i].io_base > 0)=20
-		 	request_region(sockets[i].io_base, 2, "i82092aa");
-		=20
-	=09
+		sockets[i].io_base =3D pci_resource_start(dev, 0);
 		sockets[i].cap.features |=3D SS_CAP_PCCARD;
 		sockets[i].cap.map_size =3D 0x1000;
 		sockets[i].cap.irq_mask =3D 0;
@@ -144,20 +144,28 @@
 	configbyte =3D 0xFF; /* bitmask, one bit per event, 1 =3D PCI interrupt, =
0 =3D ISA interrupt */
 	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Re=
gister */
=20
-
 	/* Register the interrupt handler */
 	dprintk(KERN_DEBUG "Requesting interrupt %i \n",dev->irq);
-	if (request_irq(dev->irq, i82092aa_interrupt, SA_SHIRQ, "i82092aa", i8209=
2aa_interrupt)) {
+	if ((ret =3D request_irq(dev->irq, i82092aa_interrupt, SA_SHIRQ, "i82092a=
a", i82092aa_interrupt))) {
 		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->=
irq);
-		return -EIO;
+		goto err_out_free_res;
 	}
 		=20
-=09
-	if (register_ss_entry(socket_count, &i82092aa_operations) !=3D 0)
-		printk(KERN_NOTICE "i82092aa: register_ss_entry() failed\n");
+	if ((ret =3D register_ss_entry(socket_count, &i82092aa_operations) !=3D 0=
)) {
+		printk(KERN_ERR "i82092aa: register_ss_entry() failed\n");
+		goto err_out_free_irq;
+	}
=20
 	leave("i82092aa_pci_probe");
 	return 0;
+
+err_out_free_irq:
+	free_irq(dev->irq, i82092aa_interrupt);
+err_out_free_res:
+	release_region(pci_resource_start(dev, 0), 2);
+err_out_disable:
+	pci_disable_device(dev);
+	return ret;		=09
 }
=20
 static void __exit i82092aa_pci_remove(struct pci_dev *dev)

--8t9RHnE3ZwKMSgU+--

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8j0YtBm4rlNOo3YgRAr1wAJsFqSMiY6XJXWHML0JGqrWncDpEVwCeMuN0
Fpw2Q0DIukYO6WpHBDvF+DM=
=VEG7
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
