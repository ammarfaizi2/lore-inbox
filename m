Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUD2SPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUD2SPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUD2SPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:15:47 -0400
Received: from linux.us.dell.com ([143.166.224.162]:33149 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264912AbUD2SPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:15:25 -0400
Date: Thu, 29 Apr 2004 13:15:13 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: EDD: follow sysfs convention, MODULE_VERSION, remove dead SCSI symlink
Message-ID: <20040429181513.GA15106@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrew, the patch below cleans up the edd.c driver.

* use kobject_set_name() instead of snprintf() per GregKH's recommendation.
* Add MODULE_VERSION()
* s/driverfs/sysfs/ in Kconfig
* Remove report URL message, as there have been too many BIOSs reported,
  virtually none of which are EDD-capable.  This may return if/when I
  develop a better reporting method and database to capture/store the
  data from users.
* Remove the unused code for creating a symlink to the scsi_device.
  This never worked right, and I'm going to show the relationship from
  a userspace tool which uses libsysfs instead.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D drivers/firmware/Kconfig 1.3 vs edited =3D=3D=3D=3D=3D
--- 1.3/drivers/firmware/Kconfig	Tue Apr 27 00:07:43 2004
+++ edited/drivers/firmware/Kconfig	Wed Apr 28 07:41:23 2004
@@ -12,7 +12,7 @@
 	help
 	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
 	  Services real mode BIOS calls to determine which disk
-	  BIOS tries boot from.  This information is then exported via driverfs.
+	  BIOS tries boot from.  This information is then exported via sysfs.
=20
 	  This option is experimental, but believed to be safe,
 	  and most disk controller BIOS vendors do not yet implement this feature.
=3D=3D=3D=3D=3D drivers/firmware/edd.c 1.24 vs edited =3D=3D=3D=3D=3D
--- 1.24/drivers/firmware/edd.c	Thu Apr 22 03:40:34 2004
+++ edited/drivers/firmware/edd.c	Thu Apr 29 12:56:25 2004
@@ -15,9 +15,8 @@
  * made in setup.S, copied to safe structures in setup.c,
  * and presents it in sysfs.
  *
- * Please see http://domsch.com/linux/edd30/results.html for
+ * Please see http://linux.dell.com/edd30/results.html for
  * the list of BIOSs which have been reported to implement EDD.
- * If you don't see yours listed, please send a report as described there.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published =
by
@@ -30,15 +29,6 @@
  *
  */
=20
-/*
- * Known issues:
- * - refcounting of struct device objects could be improved.
- *
- * TODO:
- * - Add IDE and USB disk device support
- * - move edd.[ch] to better locations if/when one is decided
- */
-
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -57,13 +47,13 @@
 #include <../drivers/scsi/scsi.h>
 #include <../drivers/scsi/hosts.h>
=20
+#define EDD_VERSION "0.14"
+#define EDD_DATE    "2004-Apr-28"
+
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
-
-#define EDD_VERSION "0.13 2004-Mar-09"
-#define EDD_DEVICE_NAME_SIZE 16
-#define REPORT_URL "http://linux.dell.com/edd/results.html"
+MODULE_VERSION(EDD_VERSION);
=20
 #define left (PAGE_SIZE - (p - buf) - 1)
=20
@@ -690,103 +680,6 @@
 	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
 }
=20
-/*
- * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
- * scsi_bus list.  The following functions could possibly mis-access
- * memory in that case.  This is actually a problem with the SCSI
- * layer, which is being addressed there.  Until then, don't use the
- * SCSI functions.
- */
-
-#undef CONFIG_SCSI
-#undef CONFIG_SCSI_MODULE
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-
-struct edd_match_data {
-	struct edd_device	* edev;
-	struct scsi_device	* sd;
-};
-
-/**
- * edd_match_scsidev()
- * @edev - EDD device is a known SCSI device
- * @sd - scsi_device with host who's parent is a PCI controller
- *
- * returns 1 if a match is found, 0 if not.
- */
-static int edd_match_scsidev(struct device * dev, void * d)
-{
-	struct edd_match_data * data =3D (struct edd_match_data *)d;
-	struct edd_info *info =3D edd_dev_get_info(data->edev);
-	struct scsi_device * sd =3D to_scsi_device(dev);
-
-	if (info) {
-		if ((sd->channel =3D=3D info->params.interface_path.pci.channel) &&
-		    (sd->id =3D=3D info->params.device_path.scsi.id) &&
-		    (sd->lun =3D=3D info->params.device_path.scsi.lun)) {
-			data->sd =3D sd;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/**
- * edd_find_matching_device()
- * @edev - edd_device to match
- *
- * Search the SCSI devices for a drive that matches the EDD
- * device descriptor we have. If we find a match, return it,
- * otherwise, return NULL.
- */
-
-static struct scsi_device *
-edd_find_matching_scsi_device(struct edd_device *edev)
-{
-	struct edd_match_data data;
-	struct bus_type * scsi_bus =3D find_bus("scsi");
-
-	if (!scsi_bus) {
-		return NULL;
-	}
-
-	data.edev =3D edev;
-
-	if (edd_dev_is_type(edev, "SCSI")) {
-		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
-			return data.sd;
-	}
-	return NULL;
-}
-
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	struct pci_dev *pci_dev;
-	int rc =3D -EINVAL;
-
-	pci_dev =3D edd_get_pci_dev(edev);
-	if (pci_dev) {
-		struct scsi_device * sdev =3D edd_find_matching_scsi_device(edev);
-		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
-			rc =3D sysfs_create_link(&edev->kobj,
-					       &sdev->sdev_driverfs_dev.kobj,
-					       "disc");
-			put_device(&sdev->sdev_driverfs_dev);
-		}
-	}
-	return rc;
-}
-
-#else
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	return -ENOSYS;
-}
-#endif
-
-
 static inline void
 edd_device_unregister(struct edd_device *edev)
 {
@@ -807,7 +700,6 @@
=20
 	if (!error) {
 		edd_create_symlink_to_pcidev(edev);
-		edd_create_symlink_to_scsidev(edev);
 	}
 }
=20
@@ -820,8 +712,8 @@
 		return 1;
 	memset(edev, 0, sizeof (*edev));
 	edd_dev_set_info(edev, &edd[i]);
-	snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
-		 edd[i].device);
+	kobject_set_name(&edev->kobj, "int13_dev%02x",
+			 edd[i].device);
 	kobj_set_kset_s(edev,edd_subsys);
 	error =3D kobject_register(&edev->kobj);
 	if (!error)
@@ -842,9 +734,8 @@
 	int rc=3D0;
 	struct edd_device *edev;
=20
-	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
-	       EDD_VERSION, eddnr);
-	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
+	printk(KERN_INFO "BIOS EDD facility v%s %s, %d devices found\n",
+	       EDD_VERSION, EDD_DATE, eddnr);
=20
 	if (!eddnr) {
 		printk(KERN_INFO "EDD information not available.\n");

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAkUYxIavu95Lw/AkRAsaoAJ41aqzvnVx+t0u27rf6Cw+B2U0tbgCfZ7hU
lqPnvJ86Yh1JUIOR8fmmiBY=
=a1ra
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
