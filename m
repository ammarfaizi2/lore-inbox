Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRKFNqe>; Tue, 6 Nov 2001 08:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279305AbRKFNqZ>; Tue, 6 Nov 2001 08:46:25 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:52491 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S279303AbRKFNqK>;
	Tue, 6 Nov 2001 08:46:10 -0500
Date: Tue, 6 Nov 2001 16:46:07 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS support for OPL3-SA1 sound driver (update)
Message-ID: <20011106164607.A1722@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:29pm  up 5 days,  3:10,  1 user,  load average: 0.00, 0.02, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

updated patch attached. Fixed small typo (dma2 assignment) and io, irq and =
dma
printk added.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-opl3sa-pnpbios3
Content-Transfer-Encoding: quoted-printable

diff -urN linux.vanilla/drivers/sound/opl3sa.c linux/drivers/sound/opl3sa.c
--- linux.vanilla/drivers/sound/opl3sa.c	Mon Oct 29 13:30:14 2001
+++ linux/drivers/sound/opl3sa.c	Tue Nov  6 11:09:50 2001
@@ -23,6 +23,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
=20
+#include <linux/pnp_bios.h>
+
 #undef  SB_OK
=20
 #include "sound_config.h"
@@ -35,35 +37,37 @@
 static int sb_initialized =3D 0;
 #endif
=20
-static int kilroy_was_here =3D 0;	/* Don't detect twice */
-static int mpu_initialized =3D 0;
+static int kilroy_was_here;	/* Don't detect twice */
+static int mpu_initialized;
+
+static int *opl3sa_osp;
=20
-static int *opl3sa_osp =3D NULL;
+static int ctrl_port =3D 0xf86;
=20
-static unsigned char opl3sa_read(int addr)
+static unsigned char __init opl3sa_read(int addr)
 {
 	unsigned long flags;
 	unsigned char tmp;
=20
 	save_flags(flags);
 	cli();
-	outb((0x1d), 0xf86);	/* password */
-	outb(((unsigned char) addr), 0xf86);	/* address */
-	tmp =3D inb(0xf87);	/* data */
+	outb((0x1d), ctrl_port);			/* password */
+	outb(((unsigned char) addr), ctrl_port);	/* address */
+	tmp =3D inb(ctrl_port + 1);			/* data */
 	restore_flags(flags);
=20
 	return tmp;
 }
=20
-static void opl3sa_write(int addr, int data)
+static void __init opl3sa_write(int addr, int data)
 {
 	unsigned long flags;
=20
 	save_flags(flags);
 	cli();
-	outb((0x1d), 0xf86);	/* password */
-	outb(((unsigned char) addr), 0xf86);	/* address */
-	outb(((unsigned char) data), 0xf87);	/* data */
+	outb((0x1d), ctrl_port);			/* password */
+	outb(((unsigned char) addr), ctrl_port);	/* address */
+	outb(((unsigned char) data), ctrl_port + 1);	/* data */
 	restore_flags(flags);
 }
=20
@@ -73,7 +77,7 @@
=20
 	if (((tmp =3D opl3sa_read(0x01)) & 0xc4) !=3D 0x04)
 	{
-		DDB(printk("OPL3-SA detect error 1 (%x)\n", opl3sa_read(0x01)));
+		DDB(printk(KERN_DEBUG "OPL3-SA detect error 1 (%x)\n", opl3sa_read(0x01)=
));
 		/* return 0; */
 	}
=20
@@ -83,17 +87,17 @@
 =09
 	if (inb(0xf87) =3D=3D tmp)
 	{
-		DDB(printk("OPL3-SA detect failed 2 (%x/%x)\n", tmp, inb(0xf87)));
+		DDB(printk(KERN_DEBUG "OPL3-SA detect failed 2 (%x/%x)\n", tmp, inb(0xf8=
7)));
 		return 0;
 	}
 	tmp =3D (opl3sa_read(0x04) & 0xe0) >> 5;
=20
 	if (tmp !=3D 0 && tmp !=3D 1)
 	{
-		DDB(printk("OPL3-SA detect failed 3 (%d)\n", tmp));
+		DDB(printk(KERN_DEBUG "OPL3-SA detect failed 3 (%d)\n", tmp));
 		return 0;
 	}
-	DDB(printk("OPL3-SA mode %x detected\n", tmp));
+	DDB(printk(KERN_DEBUG "OPL3-SA mode %x detected\n", tmp));
=20
 	opl3sa_write(0x01, 0x00);	/* Disable MSS */
 	opl3sa_write(0x02, 0x00);	/* Disable SB */
@@ -112,7 +116,7 @@
 	int ret;
 	unsigned char tmp =3D 0x24;	/* WSS enable */
=20
-	if (check_region(0xf86, 2))	/* Control port is busy */
+	if (check_region(ctrl_port, 2))	/* Control port is busy */
 		return 0;
 	/*
 	 * Check if the IO port returns valid signature. The original MS Sound
@@ -157,7 +161,7 @@
=20
 	ret =3D probe_ms_sound(hw_config);
 	if (ret)
-		request_region(0xf86, 2, "OPL3-SA");
+		request_region(ctrl_port, 2, "OPL3-SA");
=20
 	return ret;
 }
@@ -189,7 +193,7 @@
=20
 	if (mpu_initialized)
 	{
-		DDB(printk("OPL3-SA: MPU mode already initialized\n"));
+		DDB(printk(KERN_DEBUG "OPL3-SA: MPU mode already initialized\n"));
 		return 0;
 	}
 	if (hw_config->irq > 10)
@@ -238,7 +242,7 @@
 	if (dma2 =3D=3D -1)
 		dma2 =3D hw_config->dma;
=20
-	release_region(0xf86, 2);
+	release_region(ctrl_port, 2);
 	release_region(hw_config->io_base, 4);
=20
 	ad1848_unload(hw_config->io_base + 4,
@@ -280,11 +284,79 @@
 MODULE_PARM(mpu_io,"i");
 MODULE_PARM(mpu_irq,"i");
=20
+#ifdef CONFIG_PNPBIOS
+
+struct opl3sa_pnpbios_dev {
+	char *name;
+	int io, ctrl, irq, dma, dma2, mpu_io, mpu_irq;
+};
+
+static struct opl3sa_pnpbios_dev opl3sa_devs[] __initdata =3D {
+	{ "YMF701B on motherboard", 1, -1, 0, 0, 1, 2, 1 },
+};
+
+static struct pnpbios_device_id opl3sa_pnpbios_table[] __initdata =3D {
+	{ "YMH0007", (unsigned long) &opl3sa_devs[0] },
+	{ "PNP0401", (unsigned long) &opl3sa_devs[0] },
+	{ }
+};
+MODULE_DEVICE_TABLE(pnpbios, opl3sa_pnpbios_table);
+
+#define field(f) ((struct opl3sa_pnpbios_dev *) dev_id->driver_data)->##f
+
+#define pnp_resource_start(dev, type, bar) \
+	((##dev##)->##type##_resource[(bar)].start)
+
+static int __init opl3sa_pnpbios_probe(void)
+{
+	struct pnpbios_device_id *dev_id =3D opl3sa_pnpbios_table;
+	struct pci_dev *dev =3D NULL;
+
+	while (dev_id->driver_data) {
+		if ((dev =3D pnpbios_find_device(dev_id->id, dev))) {
+			printk(KERN_NOTICE "opl3sa: PnP BIOS reports %s\n", field(name));
+
+			io =3D pci_resource_start(dev, field(io));
+			if (field(ctrl) !=3D -1)
+				ctrl_port =3D pci_resource_start(dev, field(ctrl));
+
+			irq =3D pnp_resource_start(dev, irq, field(irq));
+			dma =3D pnp_resource_start(dev, dma, field(dma));
+
+			printk(KERN_NOTICE "opl3sa: WSS at i/o %#x, %#x, irq %d, dma %d",
+				io, ctrl_port, irq, dma);
+
+			if (field(dma2) !=3D -1) {
+				dma2 =3D pnp_resource_start(dev, dma, field(dma2));
+				printk(", %d", dma2);
+			}
+
+			mpu_io =3D pci_resource_start(dev, field(mpu_io));
+			mpu_irq =3D pnp_resource_start(dev, irq, field(mpu_irq));
+
+			printk(". MPU401 at i/o %#x, irq %d\n", mpu_io, mpu_irq);
+
+			return 0;
+		}
+		dev_id++;
+	}
+
+	printk(KERN_NOTICE "opl3sa: No PnP BIOS devices found\n");
+	return -ENODEV;
+}
+
+#endif
+
 static int __init init_opl3sa(void)
 {
 	if (io =3D=3D -1 || irq =3D=3D -1 || dma =3D=3D -1) {
-		printk(KERN_ERR "opl3sa: dma, irq and io must be set.\n");
-		return -EINVAL;
+#ifdef CONFIG_PNPBIOS
+		if (opl3sa_pnpbios_probe())
+#endif
+		{
+			printk(KERN_ERR "opl3sa: dma, irq and io must be set.\n");
+			return -EINVAL;
+		}
 	}
=20
 	cfg.io_base =3D io;

--FL5UXtIhxfXey3p5--

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE75+mfBm4rlNOo3YgRAv7QAJ0fUUsJ5vLGqcuHmotukbuey4SkcwCfbxS5
rNCZ+16/lBcujt1MZ2mA+b0=
=jCgz
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
