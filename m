Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290869AbSBNID5>; Thu, 14 Feb 2002 03:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSBNIDt>; Thu, 14 Feb 2002 03:03:49 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:23314 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S290869AbSBNIDa>;
	Thu, 14 Feb 2002 03:03:30 -0500
Date: Thu, 14 Feb 2002 11:06:45 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys & legacy buses plus interrupt controller and IDE support
Message-ID: <20020214080645.GA281@pazke.ipt>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020212085954.GA618@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20020212085954.GA618@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.2-dj6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Tue, Feb 12, 2002 at 09:59:55AM +0100, Pavel Machek wrote:
> Here it goes. For now I only put one device on each bus (sys &
> legacy), but I'll quickly expand it once merged. Please apply,

please take a quick look at attached patch. It's your patch with
minor modification, hwif->pci_dev used as parent for ide interface.

I made it because it was strange to see HPT370 IDE interface
under legacy bus :))

Best regards.
=20
--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ide-driverfs
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/ide/ide-disk.c /linux/dri=
vers/ide/ide-disk.c
--- /linux.vanilla/drivers/ide/ide-disk.c	Wed Feb 13 21:47:39 2002
+++ /linux/drivers/ide/ide-disk.c	Wed Feb 13 21:49:20 2002
@@ -925,12 +925,16 @@
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_=
INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
=20
+static struct device_driver idedisk_device_driver =3D {
+};
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	int i;
 =09
 	struct hd_driveid *id =3D drive->id;
 	unsigned long capacity;
+	int myid =3D -1;
 =09
 	idedisk_add_settings(drive);
=20
@@ -953,11 +957,20 @@
 		ide_hwif_t *hwif =3D HWIF(drive);
=20
 		if (drive !=3D &hwif->drives[i]) continue;
+		myid =3D i;
 		hwif->gd->de_arr[i] =3D drive->de;
 		if (drive->removable)
 			hwif->gd->flags[i] |=3D GENHD_FL_REMOVABLE;
 		break;
 	}
+	{
+		ide_hwif_t *hwif =3D HWIF(drive);
+		sprintf(drive->device.bus_id, "%d", myid);
+		sprintf(drive->device.name, "ide-disk");
+		drive->device.driver =3D &idedisk_device_driver;
+		drive->device.parent =3D &hwif->device;
+		device_register(&drive->device);
+	}
=20
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
@@ -1033,6 +1046,7 @@
=20
 static int idedisk_cleanup (ide_drive_t *drive)
 {
+	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/ide/ide-pnp.c /linux/driv=
ers/ide/ide-pnp.c
--- /linux.vanilla/drivers/ide/ide-pnp.c	Wed Feb 13 21:47:39 2002
+++ /linux/drivers/ide/ide-pnp.c	Wed Feb 13 23:04:24 2002
@@ -57,6 +57,7 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
=20
 	if (!enable)
@@ -69,9 +70,10 @@
 			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL, DEV_IRQ(dev, 0));
=20
-	index =3D ide_register_hw(&hw, NULL);
+	index =3D ide_register_hw(&hw, &hwif);
=20
 	if (index !=3D -1) {
+		hwif->pci_dev =3D dev;
 	    	printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
 		return 0;
 	}
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/ide/ide-probe.c /linux/dr=
ivers/ide/ide-probe.c
--- /linux.vanilla/drivers/ide/ide-probe.c	Wed Feb 13 21:47:39 2002
+++ /linux/drivers/ide/ide-probe.c	Wed Feb 13 23:21:59 2002
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
=20
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -469,6 +470,14 @@
=20
 static void hwif_register (ide_hwif_t *hwif)
 {
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data =3D hwif;
+	if (hwif->pci_dev)
+		hwif->device.parent =3D &hwif->pci_dev->dev;
+	else
+		hwif->device.parent =3D &device_legacy;
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) =3D=3D
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/ide/ide.c /linux/drivers/=
ide/ide.c
--- /linux.vanilla/drivers/ide/ide.c	Wed Feb 13 21:47:39 2002
+++ /linux/drivers/ide/ide.c	Wed Feb 13 21:49:20 2002
@@ -2027,6 +2027,7 @@
 	hwif =3D &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit =3D 0; unit < MAX_DRIVES; ++unit) {
 		drive =3D &hwif->drives[unit];
 		if (!drive->present)

--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8a3AVBm4rlNOo3YgRAvemAJ9V2sGrPGRsSBOiI3bdDX1t0vqhVwCfZAhq
9FgB+SmTf6SjEVCKxvJJ4pM=
=X5QY
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
