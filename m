Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUK0G6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUK0G6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKZTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:08:56 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:28068 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261213AbUKZTFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:05:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=KkxBFwleUOuhfaekUUNd5veJcXKY1NZa6RHhHJJuJlhEyO45yilaO5b3hQObxXC+hrGRHH4isppTxyJEB8uVDtbfu9vQBNr2k7+8HSJ1UwnqClmEPamVRyu5bA9cbROa8SFGIhQ8o1IDP31kIysF7hRDNtS/u6FdoTa5PdaAGgw=
Message-ID: <1f729c4804112502595b98ed08@mail.gmail.com>
Date: Thu, 25 Nov 2004 11:59:10 +0100
From: Marc Leeman <marc.leeman@gmail.com>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] number of rd's in Kconfig
Cc: Marc Leeman <marc.leeman@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_0_20063233.1101380350284"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_0_20063233.1101380350284
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In dedicated systems or small systems; the number of required ramdisks
is by default (16) too large. Like the size of the ramdisks; these
patches add that the number of rds can be configured in the kernel
configuration.

These patches are against the 2.6.9

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul

------=_Part_0_20063233.1101380350284
Content-Type: text/x-patch; name="Kconfig.2.6.9.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="Kconfig.2.6.9.diff"

--- linux-2.6.9/drivers/block/Kconfig=092004-10-18 23:53:43.000000000 +0200
+++ linux-2.6.9.barco/drivers/block/Kconfig=092004-11-25 09:00:56.000000000=
 +0100
@@ -329,6 +329,15 @@ config BLK_DEV_RAM
 =09  Most normal users won't need the RAM disk functionality, and can
 =09  thus say N here.
=20
+config BLK_DEV_RAM_COUNT
+=09int "Default number of RAM disks"
+=09depends on BLK_DEV_RAM
+=09default "16"
+=09help
+=09  The default value is 16 RAM disks. Change this if you know what=20
+=09  are doing. If you boot from a filesystem that needs to be extracted
+=09  in memory, you will need at least one RAM disk (e.g. root on cramfs).
+
 config BLK_DEV_RAM_SIZE
 =09int "Default RAM disk size (kbytes)"
 =09depends on BLK_DEV_RAM

------=_Part_0_20063233.1101380350284
Content-Type: text/x-patch; name="rd.c.2.6.9.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="rd.c.2.6.9.diff"

--- linux-2.6.9/drivers/block/rd.c=092004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.9.barco/drivers/block/rd.c=092004-11-25 09:02:02.000000000 +0=
100
@@ -60,15 +60,12 @@
=20
 #include <asm/uaccess.h>
=20
-/* The RAM disk size is now a parameter */
-#define NUM_RAMDISKS 16=09=09/* This cannot be overridden (yet) */
-
 /* Various static variables go here.  Most are used only in the RAM disk c=
ode.
  */
=20
-static struct gendisk *rd_disks[NUM_RAMDISKS];
-static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data=
 */
-static struct request_queue *rd_queue[NUM_RAMDISKS];
+static struct gendisk *rd_disks[CONFIG_BLK_DEV_RAM_COUNT];
+static struct block_device *rd_bdev[CONFIG_BLK_DEV_RAM_COUNT];/* Protected=
 device data */
+static struct request_queue *rd_queue[CONFIG_BLK_DEV_RAM_COUNT];
=20
 /*
  * Parameters for the boot-loading of the RAM disk.  These are set by
@@ -402,7 +399,7 @@ static void __exit rd_cleanup(void)
 {
 =09int i;
=20
-=09for (i =3D 0; i < NUM_RAMDISKS; i++) {
+=09for (i =3D 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 =09=09struct block_device *bdev =3D rd_bdev[i];
 =09=09rd_bdev[i] =3D NULL;
 =09=09if (bdev) {
@@ -432,7 +429,7 @@ static int __init rd_init(void)
 =09=09rd_blocksize =3D BLOCK_SIZE;
 =09}
=20
-=09for (i =3D 0; i < NUM_RAMDISKS; i++) {
+=09for (i =3D 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 =09=09rd_disks[i] =3D alloc_disk(1);
 =09=09if (!rd_disks[i])
 =09=09=09goto out;
@@ -445,7 +442,7 @@ static int __init rd_init(void)
=20
 =09devfs_mk_dir("rd");
=20
-=09for (i =3D 0; i < NUM_RAMDISKS; i++) {
+=09for (i =3D 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 =09=09struct gendisk *disk =3D rd_disks[i];
=20
 =09=09rd_queue[i] =3D blk_alloc_queue(GFP_KERNEL);
@@ -470,7 +467,7 @@ static int __init rd_init(void)
 =09/* rd_size is given in kB */
 =09printk("RAMDISK driver initialized: "
 =09=09"%d RAM disks of %dK size %d blocksize\n",
-=09=09NUM_RAMDISKS, rd_size, rd_blocksize);
+=09=09CONFIG_BLK_DEV_RAM_COUNT, rd_size, rd_blocksize);
=20
 =09return 0;
 out_queue:

------=_Part_0_20063233.1101380350284--
