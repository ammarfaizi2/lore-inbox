Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSGZPuX>; Fri, 26 Jul 2002 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317812AbSGZPuW>; Fri, 26 Jul 2002 11:50:22 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51554 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317797AbSGZPqq>; Fri, 26 Jul 2002 11:46:46 -0400
Date: Fri, 26 Jul 2002 17:49:48 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] sd_many done right (5/5)
Message-ID: <20020726154948.GH19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: multipart/mixed; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

here comes patch 5/5 from a series of patches to support more than 128 (and
optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driv=
er
to dynamically allocate memory and register block majors as disks get
attached.

The patches are all available at
http://www.suse.de/~garloff/linux/scsi-many/

This patch is by far the largest and does implement the dynamic allocation
of block majors for the sd driver. This allows to support SCSI 256 disks
(with the officially assigned majors) and more (by using dynamic majors).

With this patch, sd allocates storage and registers majors only when disks
actually are attached. Therefore the braind^Wugly CONFIG_SD_EXTRA_DEVS
has died. Instead we register majors 8, then 65--71, then 128--135 (the
newly assigned majors), and then dynamically ask for new majors. For devfs
systems, devfs_alloc_major() is used, otherwise we use get_blkfops() to
probe for free block majors. (Note that get_blkfops() triggers kmod,
which means that we also avoid taking away majors from loadable modules.)
The driver tries 144--254 (which are not yet registered), and then the
possibly conflicting 72--127, 136--143, 12--64. Of course, you need some
userspace app parsing extended /proc/scsi/scsi (see patch 1/5) or
/proc/partitions to create the device nodes beyond disk 256. Theoretically,
you get up to 244 sd majors (3904 disks) supported this way.

The maximum number of majors that the driver takes is configurable=20
CONFIG_SD_MAX_MAJORS and defaults to 16. Which means that only the
officially assigned majors are used by default.

sd never frees majors, except on module unload. This simplifies locking in
the driver. This could be changed, though I doubt it's worth the trouble.

The patch does not rely on devfs and does not incur the prohibitive storage
requirements of the devfs-based sd-many patch.

There's not much more to say. Things that could be discussed is reuse
of detached slots (device numbers). Currently, we immediately recycle=20
them.=20

The sd driver has been cleaned up to support different number of partitions
per disk by changing a define. But it's set to 1<<4 of course. More a matter
of cleanliness ...

The patch also includes:
* an added field in gendisk, allowing some callback to map kdev_t to
  device names. The corresponding change to fs/partitions/check has
  been made. If more gendisk providers would fill in this fields,
  the ugliness of disk_name() could be reduced significantly.
* a memset in IDE code (ide_probe.c:init_gendisk()), to avoid uninitialized
  fields in the gendisk structure.
* Changes to is_local_disk() heuristics in sysrq.c. (Thanks to Pete Zaitvec
  for inspiration!)
* a drives_dev function pointer in the scsi_device structure, that kills
  the ugly min_major/max_major hack in scsi_lib.
* fixed the buffer legnth =3D allocation length doing the scsi_wait_req in
  sd_init_onedisk(). (Thanks to Matt Darm for inspiration.)

Note that this patch should be complemented by a patch to sg to also allow
for more than 255 sg devices. I hope somebody will work on that.
Also note that a 2.5 port should be done ...

The patch is against 2.4.19-rc1 with patch 1/5 (and optionally 2--4)=20
applied. You will want to apply patch 4/5 (partition statistics) in order
to avoid significant consumption of memory when using many disks.

Marcelo, this patch is meant for inclusion into 2.4.20pre.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sd_many-6-2419rc1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.nohdstat/Documentation/Configure.help linux-2.4.18.S=
18.scsimany/Documentation/Configure.help
--- linux-2.4.18.nohdstat/Documentation/Configure.help	Sun Jul 14 17:26:34 =
2002
+++ linux-2.4.18.S18.scsimany/Documentation/Configure.help	Fri Jul 26 02:01=
:16 2002
@@ -7099,19 +7099,18 @@
   is located on a SCSI disk. In this case, do not compile the driver
   for your SCSI host adapter (below) as a module either.
=20
-Maximum number of SCSI disks that can be loaded as modules
-CONFIG_SD_EXTRA_DEVS
-  This controls the amount of additional space allocated in tables for
-  drivers that are loaded as modules after the kernel is booted.  In
-  the event that the SCSI core itself was loaded as a module, this
-  value is the number of additional disks that can be loaded after the
-  first host driver is loaded.
-
-  Admittedly this isn't pretty, but there are tons of race conditions
-  involved with resizing the internal arrays on the fly.  Someday this
-  flag will go away, and everything will work automatically.
-
-  If you don't understand what's going on, go with the default.
+CONFIG_SD_MAX_MAJORS
+  There are 16 block major numers assigned to SCSI disks which means
+  that you may attach up to 256 SCSI disks to one Linux machine.
+  The driver does allows to dynamically allocate more major numbers
+  when more disks get attached. You will need a userspace script to
+  parse /proc/partitions though to dynamically create the device
+  nodes then. The driver allocates the memory as disks get attached,
+  so there's no cost for allowing more majors here. The theoretical=20
+  maximum is 244.
+  However, it's not recommended to use values higher than 16, as you
+  will end using unassigned numbers. So, unless you'll potentially=20
+  connect more than 256 SCSI disks, stay with the default (16).
=20
 Maximum number of SCSI tapes that can be loaded as modules
 CONFIG_ST_EXTRA_DEVS
diff -uNr linux-2.4.18.nohdstat/drivers/char/sysrq.c linux-2.4.18.S18.scsim=
any/drivers/char/sysrq.c
--- linux-2.4.18.nohdstat/drivers/char/sysrq.c	Wed Jun 12 11:37:02 2002
+++ linux-2.4.18.S18.scsimany/drivers/char/sysrq.c	Fri Jul 26 02:42:04 2002
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/kdev_t.h>
 #include <linux/major.h>
+#include <linux/genhd.h>
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
 #include <linux/kbd_kern.h>
@@ -104,33 +105,31 @@
 /* do_emergency_sync helper function */
 /* Guesses if the device is a local hard drive */
 static int is_local_disk(kdev_t dev) {
-	unsigned int major;
-	major =3D MAJOR(dev);
-
-	switch (major) {
-	case IDE0_MAJOR:
-	case IDE1_MAJOR:
-	case IDE2_MAJOR:
-	case IDE3_MAJOR:
-	case IDE4_MAJOR:
-	case IDE5_MAJOR:
-	case IDE6_MAJOR:
-	case IDE7_MAJOR:
-	case IDE8_MAJOR:
-	case IDE9_MAJOR:
-	case SCSI_DISK0_MAJOR:
-	case SCSI_DISK1_MAJOR:
-	case SCSI_DISK2_MAJOR:
-	case SCSI_DISK3_MAJOR:
-	case SCSI_DISK4_MAJOR:
-	case SCSI_DISK5_MAJOR:
-	case SCSI_DISK6_MAJOR:
-	case SCSI_DISK7_MAJOR:
-	case XT_DISK_MAJOR:
-		return 1;
-	default:
-		return 0;
+	struct gendisk * gd =3D get_gendisk(dev);
+	if (gd && gd->major_name) {
+		if (!strcmp(gd->major_name, "hd"))	/* IDE_MAJOR_NAME */
+			return 1;
+		if (!strcmp(gd->major_name, "sd"))
+			return 1;
+		if (!strcmp(gd->major_name, "xd"))
+			return 1;
+		if (!strcmp(gd->major_name, "rd"))	/* DAC960 */
+			return 1;
+		if (!strcmp(gd->major_name, "dasd"))
+			return 1;
+		/*=20
+		 * FIXME: More real devices missing !
+		 * i2o, iseriesvd, ppdd, pd, ftl, ed, ad, mfm, cbd,=20
+		 * dos_hd, fd, pf
+		 *=20
+		 * What about meta devices, such as md, LVM, loop, ...=20
+		 *=20
+		 * Note that all disks with mounted filesystems are synced,=20
+		 * only the ones listed here are considered stable and=20
+		 * should be synced first.=20
+		 */
 	}
+	return 0;
 }
=20
 /* do_emergency_sync helper function */
diff -uNr linux-2.4.18.nohdstat/drivers/ide/ide-probe.c linux-2.4.18.S18.sc=
simany/drivers/ide/ide-probe.c
--- linux-2.4.18.nohdstat/drivers/ide/ide-probe.c	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.scsimany/drivers/ide/ide-probe.c	Wed Jul 17 14:49:29 2=
002
@@ -779,6 +779,7 @@
 	gd        =3D kmalloc (sizeof(struct gendisk), GFP_KERNEL);
 	if (!gd)
 		goto err_kmalloc_gd;
+	memset (gd, 0, sizeof(struct gendisk));
 	gd->sizes =3D kmalloc (minors * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/Config.in linux-2.4.18.S18.scs=
imany/drivers/scsi/Config.in
--- linux-2.4.18.nohdstat/drivers/scsi/Config.in	Wed Jun 12 11:37:14 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/Config.in	Fri Jul 26 01:51:49 20=
02
@@ -1,9 +1,8 @@
 comment 'SCSI support type (disk, tape, CD-ROM)'
=20
 dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
-
 if [ "$CONFIG_BLK_DEV_SD" !=3D "n" ]; then
-   int  'Maximum number of SCSI disks that can be loaded as modules' CONFI=
G_SD_EXTRA_DEVS 40
+   int  'Maximum number of SCSI major numbers' CONFIG_SD_MAX_MAJORS 16
 fi
=20
 dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/Makefile linux-2.4.18.S18.scsi=
many/drivers/scsi/Makefile
--- linux-2.4.18.nohdstat/drivers/scsi/Makefile	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/Makefile	Mon Jul 15 14:36:40 2002
@@ -162,7 +162,7 @@
 			scsi_obsolete.o scsi_queue.o scsi_lib.o \
 			scsi_merge.o scsi_dma.o scsi_scan.o \
 			scsi_syms.o
-sd_mod-objs	:=3D sd.o
+sd_mod-objs	:=3D sd.o sd_dynalloc.o
 sr_mod-objs	:=3D sr.o sr_ioctl.o sr_vendor.o
 initio-objs	:=3D ini9100u.o i91uscsi.o
 a100u2w-objs	:=3D inia100.o i60uscsi.o
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/hosts.h linux-2.4.18.S18.scsim=
any/drivers/scsi/hosts.h
--- linux-2.4.18.nohdstat/drivers/scsi/hosts.h	Mon Jul 15 15:48:28 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/hosts.h	Fri Jul 26 02:42:27 2002
@@ -516,8 +516,6 @@
     struct module * module;	  /* Used for loadable modules */
     unsigned char scsi_type;
     unsigned int major;
-    unsigned int min_major;      /* Minimum major in range. */=20
-    unsigned int max_major;      /* Maximum major in range. */
     unsigned int nr_dev;	  /* Number currently attached */
     unsigned int dev_noticed;	  /* Number of devices detected. */
     unsigned int dev_max;	  /* Current size of arrays */
@@ -531,6 +529,7 @@
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code.=20
                                            Selects command for blkdevs */
     int (*find_kdev)(Scsi_Device *, char*, kdev_t*);  /* find back dev. */
+    int (*drives_dev)(kdev_t);   /* Does HL driver drive this major? */
 };
=20
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/scsi_lib.c linux-2.4.18.S18.sc=
simany/drivers/scsi/scsi_lib.c
--- linux-2.4.18.nohdstat/drivers/scsi/scsi_lib.c	Sun Jul 14 17:34:01 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/scsi_lib.c	Tue Jul 16 12:07:05 2=
002
@@ -806,22 +806,8 @@
 		if (spnt->blk && spnt->major =3D=3D major) {
 			return spnt;
 		}
-		/*
-		 * I am still not entirely satisfied with this solution,
-		 * but it is good enough for now.  Disks have a number of
-		 * major numbers associated with them, the primary
-		 * 8, which we test above, and a secondary range of 7
-		 * different consecutive major numbers.   If this ever
-		 * becomes insufficient, then we could add another function
-		 * to the structure, and generalize this completely.
-		 */
-		if( spnt->min_major !=3D 0=20
-		    && spnt->max_major !=3D 0
-		    && major >=3D spnt->min_major
-		    && major <=3D spnt->max_major )
-		{
+		if (spnt->drives_dev && (spnt->drives_dev)(dev))
 			return spnt;
-		}
 	}
 	return NULL;
 }
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/sd.c linux-2.4.18.S18.scsimany=
/drivers/scsi/sd.c
--- linux-2.4.18.nohdstat/drivers/scsi/sd.c	Sun Jul 14 17:17:49 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/sd.c	Fri Jul 26 11:46:22 2002
@@ -28,6 +28,9 @@
  *=09
  *	 Modified by Alex Davis <letmein@erols.com>
  *       Fix problem where removable media could be ejected after sd_open.
+ *
+ *	 Modified by Kurt Garloff <garloff@suse.de>
+ *	 Dynamically allocate majors and support > 128 disks.
  */
=20
 #include <linux/config.h>
@@ -49,12 +52,12 @@
 #include <asm/system.h>
 #include <asm/io.h>
=20
-#define MAJOR_NR SCSI_DISK0_MAJOR
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include "scsi.h"
 #include "hosts.h"
 #include "sd.h"
+#include "sd_dynalloc.h"
 #include <scsi/scsi_ioctl.h>
 #include "constants.h"
 #include <scsi/scsicam.h>	/* must follow "hosts.h" */
@@ -65,21 +68,6 @@
  *  static const char RCSid[] =3D "$Header:";
  */
=20
-/* system major --> sd_gendisks index */
-#define SD_MAJOR_IDX(i)		(MAJOR(i) & SD_MAJOR_MASK)
-/* sd_gendisks index --> system major */
-#define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
-
-#define SD_PARTITION(dev)	((SD_MAJOR_IDX(dev) << 8) | (MINOR(dev) & 255))
-
-#define SCSI_DISKS_PER_MAJOR	16
-#define SD_MAJOR_NUMBER(i)	SD_MAJOR((i) >> 8)
-#define SD_MINOR_NUMBER(i)	((i) & 255)
-#define MKDEV_SD_PARTITION(i)	MKDEV(SD_MAJOR_NUMBER(i), (i) & 255)
-#define MKDEV_SD(index)		MKDEV_SD_PARTITION((index) << 4)
-#define N_USED_SCSI_DISKS  (sd_template.dev_max + SCSI_DISKS_PER_MAJOR - 1)
-#define N_USED_SD_MAJORS   (N_USED_SCSI_DISKS / SCSI_DISKS_PER_MAJOR)
-
 #define MAX_RETRIES 5
=20
 /*
@@ -89,19 +77,10 @@
 #define SD_TIMEOUT (60 * HZ)
 #define SD_MOD_TIMEOUT (75 * HZ)
=20
-static Scsi_Disk *rscsi_disks;
-static struct gendisk *sd_gendisks;
-static int *sd_sizes;
-static int *sd_blocksizes;
-static int *sd_hardsizes;	/* Hardware sector size */
-static int *sd_max_sectors;
-static char *sd_varyio;
-
 static int check_scsidisk_media_change(kdev_t);
 static int fop_revalidate_scsidisk(kdev_t);
=20
-static int sd_init_onedisk(int);
-
+static int sd_init_onedisk(int, int);
=20
 static int sd_init(void);
 static void sd_finish(void);
@@ -110,17 +89,13 @@
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
 static int sd_find_kdev(Scsi_Device*, char*, kdev_t*);
+static int sd_drives_dev(kdev_t);
=20
 static struct Scsi_Device_Template sd_template =3D {
 	name:"disk",
 	tag:"sd",
 	scsi_type:TYPE_DISK,
 	major:SCSI_DISK0_MAJOR,
-        /*
-         * Secondary range of majors that this driver handles.
-         */
-	min_major:SCSI_DISK1_MAJOR,
-	max_major:SCSI_DISK7_MAJOR,
 	blk:1,
 	detect:sd_detect,
 	init:sd_init,
@@ -129,6 +104,7 @@
 	detach:sd_detach,
 	init_command:sd_init_command,
 	find_kdev:sd_find_kdev,
+	drives_dev:sd_drives_dev,
 };
=20
=20
@@ -141,13 +117,19 @@
 kdev_t __init
 sd_find_target(void *host, int tgt)
 {
-    Scsi_Disk *dp;
-    int i;
-    for (dp =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; ++i, ++dp)
-        if (dp->device !=3D NULL && dp->device->host =3D=3D host
-            && dp->device->id =3D=3D tgt)
-            return MKDEV_SD(i);
-    return 0;
+    	SD_Major  *sd_major;
+	Scsi_Device *SDev;
+	int midx, didx;
+	for (midx =3D 0; midx < sd_majors; ++midx) {
+		sd_major =3D SD_MAJOR_PTR(midx);
+		for (didx =3D 0; didx < SCSI_DISKS_PER_MAJOR; ++didx) {
+			SDev =3D SD_DISK_PTR(sd_major, didx)->device;
+			if (SDev && SDev->device->host =3D=3D host
+			    && SDev->device->id =3D tgt)
+				return MDIDX_TO_KDEV(midx,didx);
+		}
+	}
+	return 0;
 }
 #endif
=20
@@ -157,8 +139,18 @@
 	struct Scsi_Host * host;
 	Scsi_Device * SDev;
 	int diskinfo[4];
+	int midx, didx;
+	SD_Major  *sd_major;
+	Scsi_Disk *scsi_disk;
    =20
-	SDev =3D rscsi_disks[DEVICE_NR(dev)].device;
+	midx =3D MAJOR_TO_MIDX(MAJOR(dev));
+	didx =3D MINOR_TO_DIDX(MINOR(dev));
+=09
+	if (midx =3D=3D SD_NO_MIDX)
+		return -ENODEV;
+	sd_major  =3D SD_MAJOR_PTR(midx);
+	scsi_disk =3D SD_DISK_PTR(sd_major,didx);
+	SDev =3D scsi_disk->device;
 	if (!SDev)
 		return -ENODEV;
=20
@@ -170,9 +162,7 @@
 	 */
=20
 	if( !scsi_block_when_processing_errors(SDev) )
-	{
 		return -ENODEV;
-	}
=20
 	switch (cmd)=20
 	{
@@ -182,29 +172,27 @@
 			if(!loc)
 				return -EINVAL;
=20
-			host =3D rscsi_disks[DEVICE_NR(dev)].device->host;
+			host =3D SDev->host;
 =09
 			/* default to most commonly used values */
 =09
 		        diskinfo[0] =3D 0x40;
 	        	diskinfo[1] =3D 0x20;
-	        	diskinfo[2] =3D rscsi_disks[DEVICE_NR(dev)].capacity >> 11;
+	        	diskinfo[2] =3D scsi_disk->capacity >> 11;
 =09
 			/* override with calculated, extended default, or driver values */
 =09
 			if(host->hostt->bios_param !=3D NULL)
-				host->hostt->bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					    dev,
-					    &diskinfo[0]);
-			else scsicam_bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					dev, &diskinfo[0]);
+				host->hostt->bios_param(scsi_disk,
+							dev, &diskinfo[0]);
+			else scsicam_bios_param(scsi_disk,
+						dev, &diskinfo[0]);
=20
 			if (put_user(diskinfo[0], &loc->heads) ||
-				put_user(diskinfo[1], &loc->sectors) ||
-				put_user(diskinfo[2], &loc->cylinders) ||
-				put_user(sd_gendisks[SD_MAJOR_IDX(
-				    inode->i_rdev)].part[MINOR(
-				    inode->i_rdev)].start_sect, &loc->start))
+			    put_user(diskinfo[1], &loc->sectors) ||
+			    put_user(diskinfo[2], &loc->cylinders) ||
+			    put_user(sd_major->sd_gendisk.part[MINOR(dev)].start_sect,
+				     &loc->start))
 				return -EFAULT;
 			return 0;
 		}
@@ -215,29 +203,27 @@
 			if(!loc)
 				return -EINVAL;
=20
-			host =3D rscsi_disks[DEVICE_NR(dev)].device->host;
+			host =3D SDev->host;
=20
 			/* default to most commonly used values */
=20
 			diskinfo[0] =3D 0x40;
 			diskinfo[1] =3D 0x20;
-			diskinfo[2] =3D rscsi_disks[DEVICE_NR(dev)].capacity >> 11;
+			diskinfo[2] =3D scsi_disk->capacity >> 11;
=20
 			/* override with calculated, extended default, or driver values */
=20
 			if(host->hostt->bios_param !=3D NULL)
-				host->hostt->bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					    dev,
-					    &diskinfo[0]);
-			else scsicam_bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					dev, &diskinfo[0]);
+				host->hostt->bios_param(scsi_disk,
+							dev, &diskinfo[0]);
+			else scsicam_bios_param(scsi_disk,
+						dev, &diskinfo[0]);
=20
 			if (put_user(diskinfo[0], &loc->heads) ||
-				put_user(diskinfo[1], &loc->sectors) ||
-				put_user(diskinfo[2], (unsigned int *) &loc->cylinders) ||
-				put_user(sd_gendisks[SD_MAJOR_IDX(
-				    inode->i_rdev)].part[MINOR(
-				    inode->i_rdev)].start_sect, &loc->start))
+			    put_user(diskinfo[1], &loc->sectors) ||
+			    put_user(diskinfo[2], (unsigned int *) &loc->cylinders) ||
+			    put_user(sd_major->sd_gendisk.part[MINOR(dev)].start_sect,=20
+				     &loc->start))
 				return -EFAULT;
 			return 0;
 		}
@@ -262,67 +248,106 @@
 			return revalidate_scsidisk(dev, 1);
=20
 		default:
-			return scsi_ioctl(rscsi_disks[DEVICE_NR(dev)].device , cmd, (void *) ar=
g);
+			return scsi_ioctl(SDev, cmd, (void *) arg);
 	}
 }
=20
-static void sd_devname(unsigned int disknum, char *buffer)
+int sd_devname(kdev_t dev, char *buffer)
 {
+	const unsigned int disknum =3D KDEV_TO_DISKNO(dev);
+	const unsigned int part =3D MINOR(dev) & (SCSI_DISK_MAX_PART-1);
+	if (disknum >=3D SD_NO_MIDX << SCSI_DISK_DISK_SHIFT)
+		return -1;
 	if (disknum < 26)
 		sprintf(buffer, "sd%c", 'a' + disknum);
-	else {
-		unsigned int min1;
-		unsigned int min2;
-		/*
-		 * For larger numbers of disks, we need to go to a new
-		 * naming scheme.
-		 */
-		min1 =3D disknum / 26;
-		min2 =3D disknum % 26;
-		sprintf(buffer, "sd%c%c", 'a' + min1 - 1, 'a' + min2);
+	else if (disknum < (26*27)) {
+		const unsigned int min1 =3D disknum / 26 - 1;
+		const unsigned int min2 =3D disknum % 26;
+		sprintf(buffer, "sd%c%c", 'a' + min1, 'a' + min2);
+	} else {
+		const unsigned int min1 =3D (disknum / 26 - 1) / 26 - 1;
+		const unsigned int min2 =3D (disknum / 26 - 1) % 26;
+		const unsigned int min3 =3D disknum % 26;
+		sprintf(buffer, "sd%c%c%c", 'a' + min1, 'a' + min2, 'a' + min3);
+	}
+	/* Used by fs/partition/check.c */
+	if (part) {
+		const int pos =3D strlen(buffer);
+		sprintf (buffer+pos, "%d", part);
 	}
+	return 0;
 }
=20
 static int sd_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
 {
-	Scsi_Disk *dp;=20
-	int i;
+	SD_Major  *sd_major;
+	int midx, didx;
 =09
 	if (sdp && (sdp->type =3D=3D TYPE_DISK || sdp->type =3D=3D TYPE_MOD)) {
-		for (dp =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; ++i, ++dp) {
-			if (dp->device =3D=3D sdp) {
-				sd_devname(i, nm);
-				*dev =3D MKDEV_SD(i);
-				return 0;
+		for (midx =3D 0; midx < sd_majors; ++midx) {
+			sd_major =3D SD_MAJOR_PTR(midx);
+			for (didx =3D 0; didx < SCSI_DISKS_PER_MAJOR; ++didx) {
+				if (SD_DISK_PTR(sd_major, didx)->device =3D=3D sdp) {
+					*dev =3D MDIDX_TO_KDEV(midx, didx);
+					sd_devname(*dev, nm);
+					return 0;
+				}
 			}
 		}
 	}
 	return 1;
 }
=20
-static request_queue_t *sd_find_queue(kdev_t dev)
+request_queue_t *sd_find_queue(kdev_t dev)
 {
 	Scsi_Disk *dpnt;
- 	int target;
- 	target =3D DEVICE_NR(dev);
-
-	dpnt =3D &rscsi_disks[target];
+	int midx, didx;
+=09
+	midx =3D MAJOR_TO_MIDX (MAJOR(dev));
+	didx =3D MINOR_TO_DIDX (MINOR(dev));
+	if (midx =3D=3D SD_NO_MIDX) {
+		printk (KERN_ERR "sd_find_queue %02x:%02x not found!\n",
+			MAJOR(dev), MINOR(dev));
+		return NULL;
+	}
+	dpnt =3D SD_DISK_PTR(SD_MAJOR_PTR(midx), didx);
 	if (!dpnt->device)
 		return NULL;	/* No such device */
 	return &dpnt->device->request_queue;
 }
=20
+static int sd_drives_dev(kdev_t dev)
+{
+	int midx =3D MAJOR_TO_MIDX(MAJOR(dev));
+	if (midx =3D=3D SD_NO_MIDX)
+		return 0;
+	else
+		return 1;
+}
+
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, block, this_count, hw_ssize;
+	int block, this_count, hw_ssize;
 	struct hd_struct *ppnt;
 	Scsi_Disk *dpnt;
 #if CONFIG_SCSI_LOGGING
-	char nbuff[6];
+	char nbuff[10];
 #endif
+	int midx, didx;
+	SD_Major  *sd_major;
=20
-	ppnt =3D &sd_gendisks[SD_MAJOR_IDX(SCpnt->request.rq_dev)].part[MINOR(SCp=
nt->request.rq_dev)];
-	dev =3D DEVICE_NR(SCpnt->request.rq_dev);
+	midx =3D MAJOR_TO_MIDX(MAJOR(SCpnt->request.rq_dev));
+	didx =3D MINOR_TO_DIDX(MINOR(SCpnt->request.rq_dev));
+	if (midx =3D=3D SD_NO_MIDX) {
+		printk ("Can not sd_init_command for dev %02x:%02x!\n",
+			MAJOR(SCpnt->request.rq_dev),=20
+			MINOR(SCpnt->request.rq_dev));
+		return 0;
+	}
+=09
+	sd_major =3D SD_MAJOR_PTR(midx);
+	dpnt =3D SD_DISK_PTR(sd_major, didx);
+	ppnt =3D sd_major->sd_gendisk.part+MINOR(SCpnt->request.rq_dev);
=20
 	block =3D SCpnt->request.sector;
 	this_count =3D SCpnt->request_bufflen >> 9;
@@ -333,13 +358,11 @@
 		return 0;
=20
 	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev =3D 0x%x, block =3D %d\=
n",
-	    SCpnt->request.rq_dev, block));
+				   SCpnt->request.rq_dev, block));
=20
-	dpnt =3D &rscsi_disks[dev];
-	if (dev >=3D sd_template.dev_max ||
-	    !dpnt->device ||
+	if (!dpnt->device ||
 	    !dpnt->device->online ||
- 	    block + SCpnt->request.nr_sectors > ppnt->nr_sects) {
+	    block + SCpnt->request.nr_sectors > ppnt->nr_sects) {
 		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_=
sectors));
 		SCSI_LOG_HLQUEUE(2, printk("Retry with 0x%p\n", SCpnt));
 		return 0;
@@ -353,9 +376,10 @@
 		/* printk("SCSI disk has been changed. Prohibiting further I/O.\n"); */
 		return 0;
 	}
-	SCSI_LOG_HLQUEUE(2, sd_devname(dev, nbuff));
-	SCSI_LOG_HLQUEUE(2, printk("%s : real dev =3D /dev/%d, block =3D %d\n",
-				   nbuff, dev, block));
+	SCSI_LOG_HLQUEUE(2, sd_devname(SCpnt->request.rq_dev, nbuff));
+	SCSI_LOG_HLQUEUE(2, printk("%s : %02x:%02x, block =3D %d\n",
+				   nbuff, MAJOR(SCpnt->request.rq_dev),
+				   MINOR(SCpnt->request.rq_dev), block));
=20
 	/*
 	 * If we have a 1K hardware sectorsize, prevent access to single
@@ -469,44 +493,54 @@
=20
 static int sd_open(struct inode *inode, struct file *filp)
 {
-	int target, retval =3D -ENXIO;
+	int retval =3D -ENXIO;
 	Scsi_Device * SDev;
-	target =3D DEVICE_NR(inode->i_rdev);
+	int midx, didx;
+	SD_Major  *sd_major;
+	Scsi_Disk *scsi_disk;
+=09
+	midx =3D MAJOR_TO_MIDX(MAJOR(inode->i_rdev));
+	didx =3D MINOR_TO_DIDX(MINOR(inode->i_rdev));
=20
-	SCSI_LOG_HLQUEUE(1, printk("target=3D%d, max=3D%d\n", target, sd_template=
.dev_max));
+	SCSI_LOG_HLQUEUE(1, printk("target=3D%d\n", MDIDX_TO_DISKNO(midx, didx)));
=20
-	if (target >=3D sd_template.dev_max || !rscsi_disks[target].device)
+	if (midx =3D=3D SD_NO_MIDX)
+		return -ENXIO;
+	sd_major  =3D SD_MAJOR_PTR(midx);
+	scsi_disk =3D SD_DISK_PTR(sd_major, didx);
+	SDev =3D scsi_disk->device;
+=09
+	if (!SDev)
 		return -ENXIO;	/* No such device */
=20
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
 	 */
-	if (!scsi_block_when_processing_errors(rscsi_disks[target].device)) {
+	if (!scsi_block_when_processing_errors(SDev)) {
 		return -ENXIO;
 	}
 	/*
-	 * Make sure that only one process can do a check_change_disk at one time.
-	 * This is also used to lock out further access when the partition table
-	 * is being re-read.
-	 */
-
-	while (rscsi_disks[target].device->busy) {
-		barrier();
-		cpu_relax();
-	}
-	/*
 	 * The following code can sleep.
 	 * Module unloading must be prevented
 	 */
-	SDev =3D rscsi_disks[target].device;
 	if (SDev->host->hostt->module)
 		__MOD_INC_USE_COUNT(SDev->host->hostt->module);
 	if (sd_template.module)
 		__MOD_INC_USE_COUNT(sd_template.module);
 	SDev->access_count++;
+	/*
+	 * Make sure that only one process can do a check_change_disk at one time.
+	 * This is also used to lock out further access when the partition table
+	 * is being re-read.
+	 */
+
+	while (SDev->busy) {
+		barrier();
+		cpu_relax();
+	}
=20
-	if (rscsi_disks[target].device->removable) {
+	if (SDev->removable) {
 		SDev->allow_revalidate =3D 1;
 		check_disk_change(inode->i_rdev);
 		SDev->allow_revalidate =3D 0;
@@ -514,7 +548,7 @@
 		/*
 		 * If the drive is empty, just let the open fail.
 		 */
-		if ((!rscsi_disks[target].ready) && !(filp->f_flags & O_NDELAY)) {
+		if ((!scsi_disk->ready) && !(filp->f_flags & O_NDELAY)) {
 			retval =3D -ENOMEDIUM;
 			goto error_out;
 		}
@@ -524,7 +558,7 @@
 		 * have the open fail if the user expects to be able to write
 		 * to the thing.
 		 */
-		if ((rscsi_disks[target].write_prot) && (filp->f_mode & 2)) {
+		if ((scsi_disk->write_prot) && (filp->f_mode & 2)) {
 			retval =3D -EROFS;
 			goto error_out;
 		}
@@ -542,7 +576,7 @@
 	 * See if we are requesting a non-existent partition.  Do this
 	 * after checking for disk change.
 	 */
-	if (sd_sizes[SD_PARTITION(inode->i_rdev)] =3D=3D 0) {
+	if (sd_major->sd_sizes[MINOR(inode->i_rdev)] =3D=3D 0) {
 		goto error_out;
 	}
=20
@@ -565,11 +599,20 @@
=20
 static int sd_release(struct inode *inode, struct file *file)
 {
-	int target;
-	Scsi_Device * SDev;
+	Scsi_Device *SDev;
+	int midx, didx;
+=09
+	midx =3D MAJOR_TO_MIDX(MAJOR(inode->i_rdev));
+	didx =3D MINOR_TO_DIDX(MINOR(inode->i_rdev));
=20
-	target =3D DEVICE_NR(inode->i_rdev);
-	SDev =3D rscsi_disks[target].device;
+	if (midx =3D=3D SD_NO_MIDX) {
+		printk (KERN_ERR "sd_release: dev %02x:%02x does not belong to sd!\n",=
=20
+			MAJOR(inode->i_rdev), MINOR(inode->i_rdev));
+		return -ENODEV;
+	}
+=09
+	SDev =3D SD_DISK_PTR(SD_MAJOR_PTR(midx), didx)->device;
+=09
 	if (!SDev)
 		return -ENODEV;
=20
@@ -598,22 +641,6 @@
 };
=20
 /*
- *    If we need more than one SCSI disk major (i.e. more than
- *      16 SCSI disks), we'll have to kmalloc() more gendisks later.
- */
-
-static struct gendisk sd_gendisk =3D
-{
-	major:		SCSI_DISK0_MAJOR,
-	major_name:	"sd",
-	minor_shift:	4,
-	max_p:		1 << 4,
-	fops:		&sd_fops,
-};
-
-#define SD_GENDISK(i)    sd_gendisks[(i) / SCSI_DISKS_PER_MAJOR]
-
-/*
  * rw_intr is the interrupt routine for the device driver.
  * It will be notified on the end of a SCSI read / write, and
  * will take one of several actions based on success or failure.
@@ -623,14 +650,18 @@
 {
 	int result =3D SCpnt->result;
 #if CONFIG_SCSI_LOGGING
-	char nbuff[6];
+	char nbuff[10];
 #endif
 	int this_count =3D SCpnt->bufflen >> 9;
 	int good_sectors =3D (result =3D=3D 0 ? this_count : 0);
 	int block_sectors =3D 1;
 	long error_sector;
+	int midx, didx;
+=09
+	midx =3D MAJOR_TO_MIDX(MAJOR(SCpnt->request.rq_dev));
+	didx =3D MINOR_TO_DIDX(MINOR(SCpnt->request.rq_dev));
=20
-	SCSI_LOG_HLCOMPLETE(1, sd_devname(DEVICE_NR(SCpnt->request.rq_dev), nbuff=
));
+	SCSI_LOG_HLCOMPLETE(1, sd_devname(SCpnt->request.rq_dev, nbuff));
=20
 	SCSI_LOG_HLCOMPLETE(1, printk("%s : rw_intr(%d, %x [%x %x])\n", nbuff,
 				      SCpnt->host->host_no,
@@ -677,9 +708,10 @@
 			default:
 				break;
 			}
-			error_sector -=3D sd_gendisks[SD_MAJOR_IDX(
-				SCpnt->request.rq_dev)].part[MINOR(
-				SCpnt->request.rq_dev)].start_sect;
+			/* find offset into partition */
+			error_sector -=3D SD_MAJOR_PTR(midx)
+				->sd_gendisk.part[MINOR(SCpnt->request.rq_dev)]
+				.start_sect;
 			error_sector &=3D ~(block_sectors - 1);
 			good_sectors =3D error_sector - SCpnt->request.sector;
 			if (good_sectors < 0 || good_sectors >=3D this_count)
@@ -726,19 +758,26 @@
=20
 static int check_scsidisk_media_change(kdev_t full_dev)
 {
-	int retval;
-	int target;
-	int flag =3D 0;
-	Scsi_Device * SDev;
-
-	target =3D DEVICE_NR(full_dev);
-	SDev =3D rscsi_disks[target].device;
+	int retval =3D 0;
+	int midx, didx;
+	SD_Major *sd_major;
+	Scsi_Disk *scsi_disk;
+=09
+	midx =3D MAJOR_TO_MIDX(MAJOR(full_dev));
+	didx =3D MINOR_TO_DIDX(MINOR(full_dev));
+=09
+	if (midx =3D=3D SD_NO_MIDX) {
+		printk("SCSI disk request error: invalid major.\n");
+		return 0;
+	}
+	sd_major  =3D SD_MAJOR_PTR(midx);
+	scsi_disk =3D SD_DISK_PTR(sd_major, didx);
=20
-	if (target >=3D sd_template.dev_max || !SDev) {
+	if (!scsi_disk->device) {
 		printk("SCSI disk request error: invalid device.\n");
 		return 0;
 	}
-	if (!SDev->removable)
+	if (!scsi_disk->device->removable)
 		return 0;
=20
 	/*
@@ -747,9 +786,9 @@
 	 * can deal with it then.  It is only because of unrecoverable errors
 	 * that we would ever take a device offline in the first place.
 	 */
-	if (SDev->online =3D=3D FALSE) {
-		rscsi_disks[target].ready =3D 0;
-		SDev->changed =3D 1;
+	if (scsi_disk->device->online =3D=3D FALSE) {
+		scsi_disk->ready =3D 0;
+		scsi_disk->device->changed =3D 1;
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	}
@@ -761,8 +800,8 @@
 	 * as this will spin up the drive.
 	 */
 	retval =3D -ENODEV;
-	if (scsi_block_when_processing_errors(SDev))
-		retval =3D scsi_ioctl(SDev, SCSI_IOCTL_START_UNIT, NULL);
+	if (scsi_block_when_processing_errors(scsi_disk->device))
+		retval =3D scsi_ioctl(scsi_disk->device, SCSI_IOCTL_START_UNIT, NULL);
=20
 	if (retval) {		/* Unable to test, unit probably not ready.
 				 * This usually means there is no disc in the
@@ -770,8 +809,8 @@
 				 * it out later once the drive is available
 				 * again.  */
=20
-		rscsi_disks[target].ready =3D 0;
-		SDev->changed =3D 1;
+		scsi_disk->ready =3D 0;
+		scsi_disk->device->changed =3D 1;
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	}
@@ -781,35 +820,43 @@
 	 * struct and tested at open !  Daniel Roche ( dan@lectra.fr )
 	 */
=20
-	rscsi_disks[target].ready =3D 1;	/* FLOPTICAL */
+	scsi_disk->ready =3D 1;	/* FLOPTICAL */
=20
-	retval =3D SDev->changed;
-	if (!flag)
-		SDev->changed =3D 0;
+	retval =3D scsi_disk->device->changed;
+	/* FIXME: The next statement was behind a if (!flag) conditional
+	 * with flag initialized to 0 and never changed ...  KG. */=20
+	scsi_disk->device->changed =3D 0;
 	return retval;
 }
=20
-static int sd_init_onedisk(int i)
+static int sd_init_onedisk(int midx, int didx)
 {
 	unsigned char cmd[10];
-	char nbuff[6];
+	char nbuff[8];
 	unsigned char *buffer;
 	unsigned long spintime_value =3D 0;
 	int the_result, retries, spintime;
-	int sector_size;
+	int sector_size, sz;
+	int part;
+	unsigned char cdb1;
 	Scsi_Request *SRpnt;
+	SD_Major *sd_major =3D SD_MAJOR_PTR(midx);
+	Scsi_Disk *scsi_disk =3D SD_DISK_PTR(sd_major, didx);
=20
 	/*
 	 * Get the name of the disk, in case we need to log it somewhere.
 	 */
-	sd_devname(i, nbuff);
+	sd_devname(MDIDX_TO_KDEV(midx,didx), nbuff);
=20
 	/*
 	 * If the device is offline, don't try and read capacity or any
 	 * of the other niceties.
 	 */
-	if (rscsi_disks[i].device->online =3D=3D FALSE)
-		return i;
+	if (scsi_disk->device->online =3D=3D FALSE)
+		return -1;
+
+	printk (KERN_DEBUG "sd_init_onedisk (%i,%i), %s %02x:%02x\n",
+		midx, didx, nbuff, MIDX_TO_MAJOR(midx), DIDX_TO_MINOR(didx));
=20
 	/*
 	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
@@ -817,19 +864,21 @@
 	 * just after a scsi bus reset.
 	 */
=20
-	SRpnt =3D scsi_allocate_request(rscsi_disks[i].device);
+	SRpnt =3D scsi_allocate_request(scsi_disk->device);
 	if (!SRpnt) {
 		printk(KERN_WARNING "(sd_init_onedisk:) Request allocation failure.\n");
-		return i;
+		return -1;
 	}
=20
-	buffer =3D (unsigned char *) scsi_malloc(512);
+	buffer =3D (unsigned char *) scsi_malloc(256);
 	if (!buffer) {
 		printk(KERN_WARNING "(sd_init_onedisk:) Memory allocation failure.\n");
 		scsi_release_request(SRpnt);
-		return i;
+		return -1;
 	}
=20
+	cdb1 =3D (scsi_disk->device->scsi_level <=3D SCSI_2) ?
+		((scsi_disk->device->lun << 5) & 0xe0) : 0;
 	spintime =3D 0;
=20
 	/* Spin up drives, as required.  Only do this at boot time */
@@ -839,8 +888,7 @@
=20
 		while (retries < 3) {
 			cmd[0] =3D TEST_UNIT_READY;
-			cmd[1] =3D (rscsi_disks[i].device->scsi_level <=3D SCSI_2) ?
-				 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
+			cmd[1] =3D cdb1;
 			memset((void *) &cmd[2], 0, 8);
 			SRpnt->sr_cmd_len =3D 0;
 			SRpnt->sr_sense_buffer[0] =3D 0;
@@ -848,7 +896,7 @@
 			SRpnt->sr_data_direction =3D SCSI_DATA_NONE;
=20
 			scsi_wait_req (SRpnt, (void *) cmd, (void *) buffer,
-				0/*512*/, SD_TIMEOUT, MAX_RETRIES);
+				       0/*512*/, SD_TIMEOUT, MAX_RETRIES);
=20
 			the_result =3D SRpnt->sr_result;
 			retries++;
@@ -866,24 +914,22 @@
 		    && ((driver_byte(the_result) & DRIVER_SENSE) !=3D 0)
 		    && SRpnt->sr_sense_buffer[2] =3D=3D UNIT_ATTENTION
 		    && SRpnt->sr_sense_buffer[12] =3D=3D 0x3A ) {
-			rscsi_disks[i].capacity =3D 0x1fffff;
+			scsi_disk->capacity =3D 0x1fffff;
 			sector_size =3D 512;
-			rscsi_disks[i].device->changed =3D 1;
-			rscsi_disks[i].ready =3D 0;
+			scsi_disk->device->changed =3D 1;
+			scsi_disk->ready =3D 0;
 			break;
 		}
=20
 		/* Look for non-removable devices that return NOT_READY.
 		 * Issue command to spin up drive for these cases. */
-		if (the_result && !rscsi_disks[i].device->removable &&
+		if (the_result && !scsi_disk->device->removable &&
 		    SRpnt->sr_sense_buffer[2] =3D=3D NOT_READY) {
 			unsigned long time1;
 			if (!spintime) {
 				printk("%s: Spinning up disk...", nbuff);
 				cmd[0] =3D START_STOP;
-				cmd[1] =3D (rscsi_disks[i].device->scsi_level <=3D SCSI_2) ?
-				 	 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
-				cmd[1] |=3D 1;	/* Return immediately */
+				cmd[1] =3D cdb1 | 1; /* Return immediately */
 				memset((void *) &cmd[2], 0, 8);
 				cmd[4] =3D 1;	/* Start spin cycle */
 				SRpnt->sr_cmd_len =3D 0;
@@ -915,8 +961,7 @@
 	retries =3D 3;
 	do {
 		cmd[0] =3D READ_CAPACITY;
-		cmd[1] =3D (rscsi_disks[i].device->scsi_level <=3D SCSI_2) ?
-			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
+		cmd[1] =3D cdb1;
 		memset((void *) &cmd[2], 0, 8);
 		memset((void *) buffer, 0, 8);
 		SRpnt->sr_cmd_len =3D 0;
@@ -925,7 +970,7 @@
=20
 		SRpnt->sr_data_direction =3D SCSI_DATA_READ;
 		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			    8, SD_TIMEOUT, MAX_RETRIES);
+			      8, SD_TIMEOUT, MAX_RETRIES);
=20
 		the_result =3D SRpnt->sr_result;
 		retries--;
@@ -963,28 +1008,28 @@
=20
 		printk("%s : block size assumed to be 512 bytes, disk size 1GB.  \n",
 		       nbuff);
-		rscsi_disks[i].capacity =3D 0x1fffff;
+		scsi_disk->capacity =3D 0x1fffff;
 		sector_size =3D 512;
=20
 		/* Set dirty bit for removable devices if not ready -
 		 * sometimes drives will not report this properly. */
-		if (rscsi_disks[i].device->removable &&
+		if (scsi_disk->device->removable &&
 		    SRpnt->sr_sense_buffer[2] =3D=3D NOT_READY)
-			rscsi_disks[i].device->changed =3D 1;
+			scsi_disk->device->changed =3D 1;
=20
 	} else {
 		/*
 		 * FLOPTICAL, if read_capa is ok, drive is assumed to be ready
 		 */
-		rscsi_disks[i].ready =3D 1;
+		scsi_disk->ready =3D 1;
=20
-		rscsi_disks[i].capacity =3D 1 + ((buffer[0] << 24) |
-					       (buffer[1] << 16) |
-					       (buffer[2] << 8) |
-					       buffer[3]);
+		scsi_disk->capacity =3D 1 + ((buffer[0] << 24) |
+					   (buffer[1] << 16) |
+					   (buffer[2] << 8) |
+					   buffer[3]);
=20
 		sector_size =3D (buffer[4] << 24) |
-		    (buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
+			(buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
=20
 		if (sector_size =3D=3D 0) {
 			sector_size =3D 512;
@@ -1004,58 +1049,52 @@
 			 * would be relatively trivial to set the thing up.
 			 * For this reason, we leave the thing in the table.
 			 */
-			rscsi_disks[i].capacity =3D 0;
+			scsi_disk->capacity =3D 0;
 		}
 		if (sector_size > 1024) {
-			int m;
-
 			/*
 			 * We must fix the sd_blocksizes and sd_hardsizes
 			 * to allow us to read the partition tables.
 			 * The disk reading code does not allow for reading
 			 * of partial sectors.
 			 */
-			for (m =3D i << 4; m < ((i + 1) << 4); m++) {
-				sd_blocksizes[m] =3D sector_size;
-			}
-		} {
-			/*
-			 * The msdos fs needs to know the hardware sector size
-			 * So I have created this table. See ll_rw_blk.c
-			 * Jacques Gelinas (Jacques@solucorp.qc.ca)
-			 */
-			int m;
-			int hard_sector =3D sector_size;
-			int sz =3D rscsi_disks[i].capacity * (hard_sector/256);
-
-			/* There are 16 minors allocated for each major device */
-			for (m =3D i << 4; m < ((i + 1) << 4); m++) {
-				sd_hardsizes[m] =3D hard_sector;
-			}
-
-			printk("SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
-			       nbuff, rscsi_disks[i].capacity,
-			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+			for (part =3D 0; part < SCSI_DISK_MAX_PART; ++part)
+				sd_major->sd_blocksizes[DIDX_TO_MINOR(didx) + part]
+					=3D sector_size;
 		}
+		/*
+		 * The msdos fs needs to know the hardware sector size
+		 * So I have created this table. See ll_rw_blk.c
+		 * Jacques Gelinas (Jacques@solucorp.qc.ca)
+		 */
+		sz =3D scsi_disk->capacity * (sector_size/256);
+		for (part =3D 0; part < SCSI_DISK_MAX_PART; ++part)
+			sd_major->sd_hardsizes[DIDX_TO_MINOR(didx) + part]
+				=3D sector_size;
+	=09
+		printk("SCSI device %s: "
+		       "%d %d-byte hdwr sectors (%d MB)\n",
+		       nbuff, scsi_disk->capacity,
+		       sector_size, (sz/2 - sz/1250 + 974)/1950);
+	=09
=20
 		/* Rescale capacity to 512-byte units */
 		if (sector_size =3D=3D 4096)
-			rscsi_disks[i].capacity <<=3D 3;
+			scsi_disk->capacity <<=3D 3;
 		if (sector_size =3D=3D 2048)
-			rscsi_disks[i].capacity <<=3D 2;
+			scsi_disk->capacity <<=3D 2;
 		if (sector_size =3D=3D 1024)
-			rscsi_disks[i].capacity <<=3D 1;
+			scsi_disk->capacity <<=3D 1;
 		if (sector_size =3D=3D 256)
-			rscsi_disks[i].capacity >>=3D 1;
+			scsi_disk->capacity >>=3D 1;
 	}
=20
=20
 	/*
 	 * Unless otherwise specified, this is not write protected.
 	 */
-	rscsi_disks[i].write_prot =3D 0;
-	if (rscsi_disks[i].device->removable && rscsi_disks[i].ready) {
+	scsi_disk->write_prot =3D 0;
+	if (scsi_disk->device->removable && scsi_disk->ready) {
 		/* FLOPTICAL */
=20
 		/*
@@ -1073,10 +1112,9 @@
=20
 		memset((void *) &cmd[0], 0, 8);
 		cmd[0] =3D MODE_SENSE;
-		cmd[1] =3D (rscsi_disks[i].device->scsi_level <=3D SCSI_2) ?
-			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
+		cmd[1] =3D cdb1;
 		cmd[2] =3D 0x3f;	/* Get all pages */
-		cmd[4] =3D 255;   /* Ask for 255 bytes, even tho we want just the first =
8 */
+		cmd[4] =3D 252;   /* Ask for 252 bytes, even tho we want just the first =
8 */
 		SRpnt->sr_cmd_len =3D 0;
 		SRpnt->sr_sense_buffer[0] =3D 0;
 		SRpnt->sr_sense_buffer[2] =3D 0;
@@ -1084,19 +1122,20 @@
 		/* same code as READCAPA !! */
 		SRpnt->sr_data_direction =3D SCSI_DATA_READ;
 		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			    512, SD_TIMEOUT, MAX_RETRIES);
+			      252, SD_TIMEOUT, MAX_RETRIES);
=20
 		the_result =3D SRpnt->sr_result;
=20
 		if (the_result) {
 			printk("%s: test WP failed, assume Write Enabled\n", nbuff);
 		} else {
-			rscsi_disks[i].write_prot =3D ((buffer[2] & 0x80) !=3D 0);
+			scsi_disk->write_prot =3D ((buffer[2] & 0x80) !=3D 0);
 			printk("%s: Write Protect is %s\n", nbuff,
-			       rscsi_disks[i].write_prot ? "on" : "off");
+			       scsi_disk->write_prot ? "on" : "off");
 		}
=20
 	}			/* check for write protect */
+
 	SRpnt->sr_device->ten =3D 1;
 	SRpnt->sr_device->remap =3D 1;
 	SRpnt->sr_device->sector_size =3D sector_size;
@@ -1104,193 +1143,81 @@
 	scsi_release_request(SRpnt);
 	SRpnt =3D NULL;
=20
-	scsi_free(buffer, 512);
-	return i;
+	scsi_free(buffer, 256);
+	return 0;
 }
=20
 /*
- * The sd_init() function looks at all SCSI drives present, determines
- * their size, and reads partition table entries for them.
+ * We are called on behalf scan_scsis() for every Device.
+ * First init(), then attach(Scsi_Device*), finally finish().
+ * It's inconvenient: In finish(), we don't know what device
+ * has been attached. So we iterate over all disk in
+ * sd_finish(). Sigh! KG.
  */
=20
 static int sd_registered;
=20
 static int sd_init()
 {
-	int i;
-
-	if (sd_template.dev_noticed =3D=3D 0)
+	int err =3D 0;
+	if (!sd_template.dev_noticed)
 		return 0;
-
-	if (!rscsi_disks)
-		sd_template.dev_max =3D sd_template.dev_noticed + SD_EXTRA_DEVS;
-
-	if (sd_template.dev_max > N_SD_MAJORS * SCSI_DISKS_PER_MAJOR)
-		sd_template.dev_max =3D N_SD_MAJORS * SCSI_DISKS_PER_MAJOR;
-
-	if (!sd_registered) {
-		for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
-				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
-				sd_template.dev_noticed =3D 0;
-				return 1;
-			}
-		}
+	sd_template.dev_max =3D MAX_SCSI_DYN_MAJORS * SCSI_DISKS_PER_MAJOR;
+	SD_LOCK_W;
+	printk(KERN_DEBUG "sd_init()\n");
+	if (!sd_majors) {
+		/* Register one sd_major at startup */
+		err =3D sd_alloc_major ();
+	}
+	SD_UNLOCK_W;
+	if (err =3D=3D SD_NO_MAJOR) {
+		sd_template.dev_noticed =3D 0;
+		return 1;
+	} else {
 		sd_registered++;
-	}
-	/* We do not support attaching loadable devices yet. */
-	if (rscsi_disks)
 		return 0;
-
-	rscsi_disks =3D kmalloc(sd_template.dev_max * sizeof(Scsi_Disk), GFP_ATOM=
IC);
-	if (!rscsi_disks)
-		goto cleanup_devfs;
-	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));
-
-	/* for every (necessary) major: */
-	sd_sizes =3D kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC=
);
-	if (!sd_sizes)
-		goto cleanup_disks;
-	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
-
-	sd_blocksizes =3D kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_A=
TOMIC);
-	if (!sd_blocksizes)
-		goto cleanup_sizes;
-=09
-	sd_hardsizes =3D kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_AT=
OMIC);
-	if (!sd_hardsizes)
-		goto cleanup_blocksizes;
-
-	sd_max_sectors =3D kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_=
ATOMIC);
-	if (!sd_max_sectors)
-		goto cleanup_max_sectors;
-
-	sd_varyio =3D kmalloc((sd_template.dev_max << 4), GFP_ATOMIC);
-	if (!sd_varyio)
-		goto cleanup_varyio;
-
-	memset(sd_varyio, 0, (sd_template.dev_max << 4));=20
-
-	for (i =3D 0; i < sd_template.dev_max << 4; i++) {
-		sd_blocksizes[i] =3D 1024;
-		sd_hardsizes[i] =3D 512;
-		/*
-		 * Allow lowlevel device drivers to generate 512k large scsi
-		 * commands if they know what they're doing and they ask for it
-		 * explicitly via the SHpnt->max_sectors API.
-		 */
-		sd_max_sectors[i] =3D MAX_SEGMENTS*8;
-	}
-
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		blksize_size[SD_MAJOR(i)] =3D sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR =
<< 4);
-		hardsect_size[SD_MAJOR(i)] =3D sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR =
<< 4);
-		max_sectors[SD_MAJOR(i)] =3D sd_max_sectors + i * (SCSI_DISKS_PER_MAJOR =
<< 4);
-	}
-
-	sd_gendisks =3D kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_AT=
OMIC);
-	if (!sd_gendisks)
-		goto cleanup_sd_gendisks;
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		sd_gendisks[i] =3D sd_gendisk;	/* memcpy */
-		sd_gendisks[i].de_arr =3D kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gen=
disks[i].de_arr,
-                                                 GFP_ATOMIC);
-		if (!sd_gendisks[i].de_arr)
-			goto cleanup_gendisks_de_arr;
-                memset (sd_gendisks[i].de_arr, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_a=
rr);
-		sd_gendisks[i].flags =3D kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gend=
isks[i].flags,
-                                                GFP_ATOMIC);
-		if (!sd_gendisks[i].flags)
-			goto cleanup_gendisks_flags;
-                memset (sd_gendisks[i].flags, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flag=
s);
-		sd_gendisks[i].major =3D SD_MAJOR(i);
-		sd_gendisks[i].major_name =3D "sd";
-		sd_gendisks[i].minor_shift =3D 4;
-		sd_gendisks[i].max_p =3D 1 << 4;
-		sd_gendisks[i].part =3D kmalloc((SCSI_DISKS_PER_MAJOR << 4) * sizeof(str=
uct hd_struct),
-						GFP_ATOMIC);
-		if (!sd_gendisks[i].part)
-			goto cleanup_gendisks_part;
-		memset(sd_gendisks[i].part, 0, (SCSI_DISKS_PER_MAJOR << 4) * sizeof(stru=
ct hd_struct));
-		sd_gendisks[i].sizes =3D sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
-		sd_gendisks[i].nr_real =3D 0;
-		sd_gendisks[i].real_devices =3D
-		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
-	}
-
-	return 0;
-
-cleanup_gendisks_part:
-	kfree(sd_gendisks[i].flags);
-cleanup_gendisks_flags:
-	kfree(sd_gendisks[i].de_arr);
-cleanup_gendisks_de_arr:
-	while (--i >=3D 0 ) {
-		kfree(sd_gendisks[i].de_arr);
-		kfree(sd_gendisks[i].flags);
-		kfree(sd_gendisks[i].part);
-	}
-	kfree(sd_gendisks);
-	sd_gendisks =3D NULL;
-cleanup_sd_gendisks:
-	kfree(sd_varyio);
-cleanup_varyio:
-	kfree(sd_max_sectors);
-cleanup_max_sectors:
-	kfree(sd_hardsizes);
-cleanup_blocksizes:
-	kfree(sd_blocksizes);
-cleanup_sizes:
-	kfree(sd_sizes);
-cleanup_disks:
-	kfree(rscsi_disks);
-	rscsi_disks =3D NULL;
-cleanup_devfs:
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 	}
-	sd_registered--;
-	sd_template.dev_noticed =3D 0;
-	return 1;
 }
=20
=20
 static void sd_finish()
 {
-	int i;
-
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		blk_dev[SD_MAJOR(i)].queue =3D sd_find_queue;
-		add_gendisk(&sd_gendisks[i]);
-	}
-
-	for (i =3D 0; i < sd_template.dev_max; ++i)
-		if (!rscsi_disks[i].capacity && rscsi_disks[i].device) {
-			sd_init_onedisk(i);
-			if (!rscsi_disks[i].has_part_table) {
-				sd_sizes[i << 4] =3D rscsi_disks[i].capacity;
-				register_disk(&SD_GENDISK(i), MKDEV_SD(i),
-						1<<4, &sd_fops,
-						rscsi_disks[i].capacity);
-				rscsi_disks[i].has_part_table =3D 1;
+	int midx, didx;
+	SD_Major  *sd_major;
+	Scsi_Disk *scsi_disk;
+	/* Everything moved to attach() */
+	printk (KERN_DEBUG "sd_finish()\n");
+
+	for (midx =3D 0; midx < sd_majors; ++midx) {
+		sd_major =3D SD_MAJOR_PTR(midx);
+		for (didx =3D 0; didx < SCSI_DISKS_PER_MAJOR; ++didx) {
+			scsi_disk =3D SD_DISK_PTR(sd_major, didx);
+			if (scsi_disk->device && !scsi_disk->capacity) {
+				if (sd_init_onedisk(midx, didx) =3D=3D -1) {
+					scsi_disk->attached =3D 0;
+					sd_major->sd_gendisk.nr_real--;
+					sd_template.nr_dev--;
+					scsi_disk->device->attached--;
+					//sd_next--;
+					continue;
+				}
+
+				if (!scsi_disk->has_part_table) {
+					sd_major->sd_sizes[DIDX_TO_MINOR(didx)] =3D scsi_disk->capacity;
+					register_disk(&sd_major->sd_gendisk, MDIDX_TO_KDEV(midx,didx),
+			      			      SCSI_DISK_MAX_PART, &sd_fops,
+			      			      scsi_disk->capacity);
+					scsi_disk->has_part_table =3D 1;
+				}
+		/* If our host adapter is capable of scatter-gather, then we increase
+		 * the read-ahead to 128 sectors (64k).  If not, we stay to a 8 sectors=
=20
+		 * (4k) default. We can only respect this on a per major basis.
+		 */
+				if (scsi_disk->device->host->sg_tablesize)
+					read_ahead[MIDX_TO_MAJOR(midx)] =3D 128;
 			}
 		}
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 60 blocks (120 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. We can only respect this with the
-	 * granularity of every 16 disks (one device major).
-	 */
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		read_ahead[SD_MAJOR(i)] =3D
-		    (rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device
-		     && rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device->host->sg_tablesize)
-		    ? 120	/* 120 sector read-ahead */
-		    : 4;	/* 4 sector read-ahead */
 	}
-
-	return;
 }
=20
 static int sd_detect(Scsi_Device * SDp)
@@ -1301,62 +1228,56 @@
 	return 1;
 }
=20
-#define SD_DISK_MAJOR(i)	SD_MAJOR((i) >> 4)
-
 static int sd_attach(Scsi_Device * SDp)
 {
-        unsigned int devnum;
-	Scsi_Disk *dpnt;
-	int i;
-	char nbuff[6];
+	SD_Major *sd_major;
+	Scsi_Disk *scsi_disk;
+	struct gendisk *gdp;
+=09
+	int midx, didx;
+	char nbuff[8];
=20
+	printk (KERN_DEBUG "sd_attach()\n");
 	if (SDp->type !=3D TYPE_DISK && SDp->type !=3D TYPE_MOD)
 		return 0;
=20
-	if (sd_template.nr_dev >=3D sd_template.dev_max || rscsi_disks =3D=3D NUL=
L) {
-		SDp->attached--;
-		return 1;
-	}
-	for (dpnt =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; i++, dpnt++)
-		if (!dpnt->device)
-			break;
-
-	if (i >=3D sd_template.dev_max) {
-		printk(KERN_WARNING "scsi_devices corrupt (sd),"
-		    " nr_dev %d dev_max %d\n",
-		    sd_template.nr_dev, sd_template.dev_max);
+	if (sd_find_free_slot (SDp, &midx, &didx)) {
 		SDp->attached--;
 		return 1;
 	}
-
-	rscsi_disks[i].device =3D SDp;
-	rscsi_disks[i].has_part_table =3D 0;
+=09
+	sd_major  =3D SD_MAJOR_PTR(midx);
+	scsi_disk =3D SD_DISK_PTR(sd_major, didx);
+	=09
+	scsi_disk->device =3D SDp;
+	scsi_disk->has_part_table =3D 0;
+	scsi_disk->attached =3D 1;
 	sd_template.nr_dev++;
-	SD_GENDISK(i).nr_real++;
-        devnum =3D i % SCSI_DISKS_PER_MAJOR;
-        SD_GENDISK(i).de_arr[devnum] =3D SDp->de;
+
+	gdp =3D &sd_major->sd_gendisk;
+	gdp->nr_real++;
+	gdp->de_arr[didx] =3D SDp->de;
+=09
         if (SDp->removable)
-		SD_GENDISK(i).flags[devnum] |=3D GENHD_FL_REMOVABLE;
-	sd_devname(i, nbuff);
+		gdp->flags[didx] |=3D GENHD_FL_REMOVABLE;
+	sd_devname(MDIDX_TO_KDEV(midx,didx), nbuff);
 	printk("Attached scsi %sdisk %s at scsi%d, channel %d, id %d, lun %d\n",
 	       SDp->removable ? "removable " : "",
 	       nbuff, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
=20
-	if (SDp->host->hostt->can_do_varyio) {
-		if (blkdev_varyio[SD_DISK_MAJOR(i)] =3D=3D NULL) {
-			blkdev_varyio[SD_DISK_MAJOR(i)] =3D=20
-				sd_varyio + ((i / SCSI_DISKS_PER_MAJOR) >> 8);
-		}
-		memset(blkdev_varyio[SD_DISK_MAJOR(i)] + (devnum << 4), 1, 16);
-	}
+	if (SDp->host->hostt->can_do_varyio)
+		memset(sd_major->sd_varyio + DIDX_TO_MINOR(didx), 1, SCSI_DISK_MAX_PART);
+=09
+	blk_dev[MIDX_TO_MAJOR(midx)].queue =3D sd_find_queue;
+=09
 	return 0;
 }
=20
-#define DEVICE_BUSY rscsi_disks[target].device->busy
-#define ALLOW_REVALIDATE rscsi_disks[target].device->allow_revalidate
-#define USAGE rscsi_disks[target].device->access_count
-#define CAPACITY rscsi_disks[target].capacity
-#define MAYBE_REINIT  sd_init_onedisk(target)
+#define DEVICE_BUSY scsi_disk->device->busy
+#define ALLOW_REVALIDATE scsi_disk->device->allow_revalidate
+#define USAGE scsi_disk->device->access_count
+#define CAPACITY scsi_disk->capacity
+#define MAYBE_REINIT  sd_init_onedisk(midx,didx)
=20
 /* This routine is called to flush all partitions and partition tables
  * for a changed scsi disk, and then re-read the new partition table.
@@ -1368,12 +1289,17 @@
 int revalidate_scsidisk(kdev_t dev, int maxusage)
 {
 	struct gendisk *sdgd;
-	int target;
-	int max_p;
-	int start;
-	int i;
-
-	target =3D DEVICE_NR(dev);
+	SD_Major *sd_major;
+	Scsi_Disk *scsi_disk;
+	int midx, didx;
+	int max_p, part;
+	int major, minor;
+
+	major =3D MAJOR(dev); minor =3D MINOR(dev);
+	midx =3D MAJOR_TO_MIDX(major);
+	sd_major =3D SD_MAJOR_PTR(midx);
+	didx =3D MINOR_TO_DIDX(minor);
+	scsi_disk =3D SD_DISK_PTR(sd_major, didx);
=20
 	if (DEVICE_BUSY || (ALLOW_REVALIDATE =3D=3D 0 && USAGE > maxusage)) {
 		printk("Device busy for revalidation (usage=3D%d)\n", USAGE);
@@ -1381,34 +1307,31 @@
 	}
 	DEVICE_BUSY =3D 1;
=20
-	sdgd =3D &SD_GENDISK(target);
-	max_p =3D sd_gendisk.max_p;
-	start =3D target << sd_gendisk.minor_shift;
-
-	for (i =3D max_p - 1; i >=3D 0; i--) {
-		int index =3D start + i;
-		invalidate_device(MKDEV_SD_PARTITION(index), 1);
-		sdgd->part[SD_MINOR_NUMBER(index)].start_sect =3D 0;
-		sdgd->part[SD_MINOR_NUMBER(index)].nr_sects =3D 0;
+	sdgd =3D &sd_major->sd_gendisk;
+	max_p =3D sdgd->max_p;
+	minor =3D DIDX_TO_MINOR(didx); /* equiv to: minor &=3D ~(SCSI_DISK_MAX_PA=
RT-1) */
+
+	for (part =3D max_p - 1; part >=3D 0; --part) {
+		invalidate_device(MKDEV(major, minor+part), 1);
+		sdgd->part[minor+part].start_sect =3D 0;
+		sdgd->part[minor+part].nr_sects =3D 0;
 		/*
 		 * Reset the blocksize for everything so that we can read
 		 * the partition table.  Technically we will determine the
 		 * correct block size when we revalidate, but we do this just
 		 * to make sure that everything remains consistent.
 		 */
-		sd_blocksizes[index] =3D 1024;
-		if (rscsi_disks[target].device->sector_size =3D=3D 2048)
-			sd_blocksizes[index] =3D 2048;
+		if (scsi_disk->device->sector_size =3D=3D 2048)
+			sd_major->sd_blocksizes[minor+part] =3D 2048;
 		else
-			sd_blocksizes[index] =3D 1024;
+			sd_major->sd_blocksizes[minor+part] =3D 1024;
 	}
=20
 #ifdef MAYBE_REINIT
 	MAYBE_REINIT;
 #endif
=20
-	grok_partitions(&SD_GENDISK(target), target % SCSI_DISKS_PER_MAJOR,
-			1<<4, CAPACITY);
+	grok_partitions(sdgd, didx, SCSI_DISK_MAX_PART, CAPACITY);
=20
 	DEVICE_BUSY =3D 0;
 	return 0;
@@ -1420,43 +1343,51 @@
 }
 static void sd_detach(Scsi_Device * SDp)
 {
-	Scsi_Disk *dpnt;
+	SD_Major *sd_major;
+	Scsi_Disk *scsi_disk;
+	int midx, didx;	/* major, disk */
 	struct gendisk *sdgd;
-	int i, j;
+	int part;
 	int max_p;
-	int start;
+	int major, minor;=20
=20
-	if (rscsi_disks =3D=3D NULL)
+	if (sd_majors =3D=3D 0)
 		return;
=20
-	for (dpnt =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; i++, dpnt++)
-		if (dpnt->device =3D=3D SDp) {
-
-			/* If we are disconnecting a disk driver, sync and invalidate
-			 * everything */
-			sdgd =3D &SD_GENDISK(i);
-			max_p =3D sd_gendisk.max_p;
-			start =3D i << sd_gendisk.minor_shift;
-
-			for (j =3D max_p - 1; j >=3D 0; j--) {
-				int index =3D start + j;
-				invalidate_device(MKDEV_SD_PARTITION(index), 1);
-				sdgd->part[SD_MINOR_NUMBER(index)].start_sect =3D 0;
-				sdgd->part[SD_MINOR_NUMBER(index)].nr_sects =3D 0;
-				sd_sizes[index] =3D 0;
+	for (midx =3D 0; midx < sd_majors; ++midx) {
+		sd_major =3D SD_MAJOR_PTR(midx);
+		for (didx =3D 0; didx < SCSI_DISKS_PER_MAJOR; ++didx) {
+			scsi_disk =3D SD_DISK_PTR(sd_major, didx);
+			if (scsi_disk->device =3D=3D SDp) {
+				/* If we are disconnecting a disk driver, sync and invalidate
+				 * everything */
+				sdgd  =3D &sd_major->sd_gendisk;
+				major =3D sdgd->major;
+				max_p =3D sdgd->max_p;
+				minor =3D DIDX_TO_MINOR(didx);
+			=09
+				for (part =3D max_p - 1; part >=3D 0; --part) {
+					invalidate_device(MKDEV(major,minor+part), 1);
+					sdgd->part[minor+part].start_sect =3D 0;
+					sdgd->part[minor+part].nr_sects =3D 0;
+					sd_major->sd_sizes[minor+part] =3D 0;
+				}
+				devfs_register_partitions (sdgd, minor+part, 1);
+
+				/* unregister_disk() */
+				scsi_disk->device =3D NULL;
+				scsi_disk->has_part_table =3D 0;
+				scsi_disk->capacity =3D 0;
+				scsi_disk->attached =3D 0;
+				SDp->attached--;
+				sd_template.dev_noticed--;
+				sd_template.nr_dev--;
+				sd_major->sd_gendisk.nr_real--;
+				memset(sd_major->sd_varyio + minor, 0, SCSI_DISK_MAX_PART);
+				return;
 			}
-                        devfs_register_partitions (sdgd,
-                                                   SD_MINOR_NUMBER (start)=
, 1);
-			/* unregister_disk() */
-			dpnt->has_part_table =3D 0;
-			dpnt->device =3D NULL;
-			dpnt->capacity =3D 0;
-			SDp->attached--;
-			sd_template.dev_noticed--;
-			sd_template.nr_dev--;
-			SD_GENDISK(i).nr_real--;
-			return;
 		}
+	}
 	return;
 }
=20
@@ -1468,35 +1399,10 @@
=20
 static void __exit exit_sd(void)
 {
-	int i;
-
 	scsi_unregister_module(MODULE_SCSI_DEV, &sd_template);
=20
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++)
-		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
-
 	sd_registered--;
-	if (rscsi_disks !=3D NULL) {
-		kfree(rscsi_disks);
-		kfree(sd_sizes);
-		kfree(sd_blocksizes);
-		kfree(sd_hardsizes);
-		kfree(sd_varyio);
-		for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-			kfree(sd_gendisks[i].de_arr);
-			kfree(sd_gendisks[i].flags);
-			kfree(sd_gendisks[i].part);
-		}
-	}
-	for (i =3D 0; i < N_USED_SD_MAJORS; i++) {
-		del_gendisk(&sd_gendisks[i]);
-		blksize_size[SD_MAJOR(i)] =3D NULL;
-		hardsect_size[SD_MAJOR(i)] =3D NULL;
-		read_ahead[SD_MAJOR(i)] =3D 0;
-	}
-	sd_template.dev_max =3D 0;
-	if (sd_gendisks !=3D NULL)    /* kfree tests for 0, but leave explicit */
-		kfree(sd_gendisks);
+	sd_deallocate_all ();
 }
=20
 module_init(init_sd);
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/sd.h linux-2.4.18.S18.scsimany=
/drivers/scsi/sd.h
--- linux-2.4.18.nohdstat/drivers/scsi/sd.h	Sun Jul 14 17:32:35 2002
+++ linux-2.4.18.S18.scsimany/drivers/scsi/sd.h	Fri Jul 26 02:42:27 2002
@@ -15,23 +15,13 @@
    $Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/sd.h,v 1.1 1992/07/24 0=
6:27:38 root Exp root $
  */
=20
-#ifndef _SCSI_H
 #include "scsi.h"
-#endif
-
-#ifndef _GENDISK_H
 #include <linux/genhd.h>
-#endif
=20
-typedef struct scsi_disk {
-	unsigned capacity;	/* size in blocks */
-	Scsi_Device *device;
-	unsigned char ready;	/* flag ready for FLOPTICAL */
-	unsigned char write_prot;	/* flag write_protect for rmvable dev */
-	unsigned char sector_bit_size;	/* sector_size =3D 2 to the  bit size powe=
r */
-	unsigned char sector_bit_shift;		/* power of 2 sectors per FS block */
-	unsigned has_part_table:1;	/* has partition table */
-} Scsi_Disk;
+#define SCSI_DISK_PART_BITS	4
+#define SCSI_DISK_MAX_PART	(1U<<SCSI_DISK_PART_BITS)
+#define SCSI_DISK_DISK_SHIFT	(MINORBITS-SCSI_DISK_PART_BITS)
+#define SCSI_DISKS_PER_MAJOR	(1U<<SCSI_DISK_DISK_SHIFT)
=20
 extern int revalidate_scsidisk(kdev_t dev, int maxusage);
=20
@@ -40,27 +30,18 @@
  */
 extern kdev_t sd_find_target(void *host, int tgt);
=20
-#define N_SD_MAJORS	8
-
-#define SD_MAJOR_MASK	(N_SD_MAJORS - 1)
+typedef struct scsi_disk {
+	Scsi_Device *device;
+	unsigned capacity;		/* size in blocks */
+	unsigned char sector_bit_size;	/* sector_size =3D 2 to the bit size power=
 */
+	unsigned char sector_bit_shift;	/* power of 2 sectors per FS block */
+	unsigned has_part_table:1;	/* has partition table */
+	unsigned ready:1;		/* flag ready for FLOPTICAL */
+	unsigned write_prot:1;		/* flag write_protect for rmvable dev */
+	unsigned attached:1;		/* has not been detached */
+} Scsi_Disk;
=20
+extern struct block_device_operations sd_fops;
+extern int sd_devname(kdev_t dev, char *buffer);
 #endif
=20
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * -----------------------------------------------------------------------=
----
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/sd_dynalloc.c linux-2.4.18.S18=
.scsimany/drivers/scsi/sd_dynalloc.c
--- linux-2.4.18.nohdstat/drivers/scsi/sd_dynalloc.c	Thu Jan  1 01:00:00 19=
70
+++ linux-2.4.18.S18.scsimany/drivers/scsi/sd_dynalloc.c	Fri Jul 26 03:24:5=
5 2002
@@ -0,0 +1,298 @@
+/* sd_dynalloc.c
+ * dynamic allocation of majors for SCSI disks
+ * (c) Kurt Garloff <garloff@suse.de>, 7/2002
+ * License: GNU GPL v2
+ */
+/* 2002-07-14: (sd_many-2)
+ *		Initial write.=20
+ *=20
+ * 2002-07-15: (sd_many-3)
+ *		Fixes=20
+ * 		Fix dynamic block major allocation to work with
+ * 		non-devfs systems.
+ *=20
+ * 2002-07-17: (sd_many-4)
+ *		Reversed major mapping array:=20
+ * 		We now map majors to an index in our ptr array.
+ * 		Fix /proc/partitions by calling sd_devname() via gendisk
+ *=20
+ * 	TODO: - Check locking issues.
+ *	      - More intelligent reuse of sd slots(?)
+ *	      - Remove debug printks
+ *=20
+ * 2002-07-25:  (sd_many-5)
+ * 	      - Added the officially assigned SCSI majors 9--15.
+ * 		(Thanks to Pete Zaitvec for telling!)
+ *            - Made maximum number of SCSI majors a config option
+ *	      - SysRq preference for all SCSI disk majors (Pete ...)
+ */
+
+
+#include "sd_dynalloc.h"
+#include <linux/spinlock.h>
+
+#define SD_REUSE_SLOTS 1
+#define SD_DYN_DEBUG 1
+
+# define SDD_PRINTK(ARGS...) printk(KERN_WARNING "sd: " ARGS)
+#ifdef SD_DYN_DEBUG
+# define SDD_DPRINTK(ARGS...) printk(KERN_DEBUG "sd: " ARGS)
+#else
+# define SDD_DPRINTK(ARGS...)
+#endif
+
+/* Locking:
+ * We protect the following variables by a spinlock:
+ * sd_majors, sd_per_major_ptrs, sd_major_to_midx, next_sd
+ * Actually, we try to only use the locks for writing.
+ * This should be possible, as we do build and fill
+ * structs before we link them into a list and we never
+ * remove any majors.
+ * So we only need to protect against two CPUs trying to
+ * change the structures.
+ */
+
+rwlock_t sd_dyn_lock =3D RW_LOCK_UNLOCKED;
+
+static int sd_majors;
+/* Index into the last sd_major struct for next free sd */
+static int sd_next =3D SCSI_DISKS_PER_MAJOR;=20
+
+/* Maps majors to indices into sd_major_ptrs */
+unsigned char sd_major_to_midx[MAJORS];
+/* List of pointers to SD_Major structs */
+struct sd_per_major *sd_major_ptrs[MAX_SCSI_DYN_MAJORS];
+
+int sd_midx_to_major (const int midx)
+{
+	if (midx < 0 || midx >=3D sd_majors)
+		return SD_NO_MAJOR;
+	return SD_MAJOR_PTR(midx)->sd_gendisk.major;
+}
+
+/* Fill in defaults (except 0) */
+static void sd_fill_defaults (SD_Major *sd_major)
+{
+	int i;
+	/* per part */
+	for (i =3D 0; i < MINORS; ++i) {
+		sd_major->sd_blocksizes[i]  =3D 1024;
+		sd_major->sd_max_sectors[i] =3D MAX_SEGMENTS*8;
+		sd_major->sd_hardsizes[i]   =3D 512;
+	}
+}
+
+/* Global per major arrays :-O need to be filled in */
+static void sd_set_major_arrays (SD_Major *sd_major)
+{
+	const int major =3D sd_major->sd_gendisk.major;
+	blksize_size[major]  =3D sd_major->sd_blocksizes;
+	hardsect_size[major] =3D sd_major->sd_hardsizes;
+	max_sectors[major]   =3D sd_major->sd_max_sectors;
+	blkdev_varyio[major] =3D sd_major->sd_varyio;
+	/* To be set to a higher value in attach() if HBA support s-g */
+	read_ahead[major]    =3D 8;
+}
+
+static void  sd_gendisk_defaults (struct gendisk *gdp)
+{
+	gdp->major_name  =3D "sd";
+	gdp->minor_shift =3D SCSI_DISK_PART_BITS; //?
+	gdp->max_p =3D SCSI_DISK_MAX_PART;
+	gdp->fops  =3D &sd_fops;
+	gdp->devname =3D sd_devname;
+}
+
+/* Fill in gendisk */
+static void sd_fill_in_gendisk (SD_Major *sd_major)
+{
+	struct gendisk * const gdp =3D &sd_major->sd_gendisk;
+	sd_gendisk_defaults (gdp);
+	gdp->de_arr =3D sd_major->de_arr;
+	gdp->flags  =3D sd_major->flags;
+	gdp->part   =3D sd_major->sd_hds;
+	gdp->sizes  =3D sd_major->sd_sizes;
+	gdp->nr_real=3D 0;
+	gdp->real_devices =3D (void*) sd_major->disks;
+}
+
+#ifndef CONFIG_DEVFS_FS
+#define FIRST_MAJOR 143=09
+static int sd_find_major (void)
+{
+	/* The get_blkfops() has the side-effect of triggering kmod=20
+	 * on blockdevs. This makes it safe not to accidently
+	 * take the major of sb. else. =20
+	 * We try to avoid conflicts by allocating
+	 * 8, 65--71, 128--135 ( 16, officially assigned to sd)
+	 * 144--254            (111, not yet assigned)
+	 *  72--127            ( 56, assigned to other devices)
+	 * 136--143            (  8, assigned to Mylex DAC960)
+	 *  12-- 64            ( 53, assigned to other devices)
+	 * Summary: 16 safe, 127 almost safe (poss. future confl.),
+	 * 	244 theoretical maximum, IOW 3904 disks.
+	 */
+	int maj =3D FIRST_MAJOR;
+	while (++maj < 255)	/* 255 is RESERVED */
+		if (!get_blkfops(maj))
+			return maj;
+	maj =3D SCSI_DISK7_MAJOR;	/* The search goes on */
+	while (++maj < SCSI_DISK10_MAJOR)
+		if (!get_blkfops(maj))
+			return maj;
+	maj =3D SCSI_DISK17_MAJOR;=20
+	while (++maj < FIRST_MAJOR)
+		if (!get_blkfops(maj))
+			return maj;
+	maj =3D 11;
+	while (++maj < SCSI_DISK1_MAJOR)
+		if (!get_blkfops(maj))
+			return maj;
+	return SD_NO_MAJOR;
+}
+#endif
+
+extern request_queue_t *sd_find_queue(kdev_t dev);
+/* We should already have the lock in write mode when entering */
+int sd_alloc_major (void)
+{
+	int major;
+	SD_Major *sd_major;
+=09
+	/* Initialize sd_major_to_midx array */
+	if (sd_majors =3D=3D 0)
+		memset (sd_major_to_midx, SD_NO_MIDX, MAJORS);
+=09
+	if (sd_majors >=3D MAX_SCSI_DYN_MAJORS)
+		return SD_NO_MAJOR;
+	if (!sd_majors)
+		major =3D SCSI_DISK0_MAJOR;
+	else if (sd_majors < 8)
+		major =3D SCSI_DISK1_MAJOR-1+sd_majors;
+	else if (sd_majors < 16)
+		major =3D SCSI_DISK10_MAJOR-8+sd_majors;
+	else {
+#ifdef CONFIG_DEVFS_FS
+		major =3D devfs_alloc_major(DEVFS_SPECIAL_BLK);
+#else
+		major =3D sd_find_major ();
+#endif
+		if (major =3D=3D SD_NO_MAJOR) {
+			SDD_PRINTK("alloc_major: could not get major\n");
+			return major;
+		}
+	}
+	/* Now perform memory allocations */
+	sd_major =3D kmalloc (sizeof (*sd_major), GFP_ATOMIC);
+	if (!sd_major) {
+		SDD_PRINTK("alloc_major: could not allocate sd_major structure\n");
+		goto dealloc_major;
+	}
+	memset (sd_major, 0, sizeof (*sd_major));
+=09
+	sd_major->sd_gendisk.major =3D major;
+=09
+	if (devfs_register_blkdev(major, "sd", &sd_fops)) {
+		SDD_PRINTK("alloc_major: could not register major %i\n",=20
+			   major);
+		goto dealloc_sd_major;
+	}
+
+	/* Now, nothing can fail ... except the programmer, of course */
+	sd_fill_defaults (sd_major);
+	sd_set_major_arrays (sd_major);
+	sd_fill_in_gendisk (sd_major);
+	blk_dev[major].queue =3D sd_find_queue;
+	sd_major_ptrs[sd_majors]   =3D sd_major;
+	sd_major_to_midx[major] =3D sd_majors++;
+	sd_next =3D 0;
+	/* FIXME: used to be done at finish time, should be OK here. KG. */
+	add_gendisk(&sd_major->sd_gendisk);
+	SDD_PRINTK("allocated major %i\n", major);
+	return major;
+
+    dealloc_sd_major:
+	kfree (sd_major);=09
+=09
+    dealloc_major:
+#ifdef CONFIG_DEVFS_FS=09
+	if (sd_majors >=3D 16)
+		devfs_dealloc_major(DEVFS_SPECIAL_BLK, major);
+#endif
+	return SD_NO_MAJOR;
+}
+=09
+/* Deallocate one major */
+void sd_dealloc_major (const int midx)
+{
+	SD_Major *sd_major =3D SD_MAJOR_PTR(midx);
+	const int major =3D MIDX_TO_MAJOR(midx);
+	del_gendisk(&sd_major->sd_gendisk);
+	devfs_unregister_blkdev(major, "sd");
+	sd_major_ptrs[midx] =3D NULL;
+	sd_major_to_midx[major] =3D SD_NO_MIDX;
+	read_ahead[major] =3D 0;
+	blksize_size[major] =3D NULL;
+	hardsect_size[major] =3D NULL;
+	max_sectors[major] =3D NULL;
+	blkdev_varyio[major] =3D NULL;
+	blk_dev[major].queue =3D NULL;
+#ifdef CONFIG_DEVFS_FS=09
+	if (midx >=3D 16)
+		devfs_dealloc_major(DEVFS_SPECIAL_BLK, major);
+#endif
+	kfree (sd_major);
+	SDD_PRINTK("deallocated major %i\n", major);
+}
+
+/* Deallocate all majors */
+void sd_deallocate_all (void)
+{
+	while (sd_majors--)=20
+		sd_dealloc_major (sd_majors);
+}
+
+/* Currently, sd_find_free_slot() does not use SDp.
+ * One could think of clever heuristics, that attaches a detached
+ * disk at the same slot again. KG. */
+
+/* Find a free slot to attach a SCSI disk */
+int sd_find_free_slot (Scsi_Device *SDp, int *midx, int *didx)
+{
+	SD_Major *sd_major;
+	Scsi_Disk *scsi_disk;
+	SDD_DPRINTK("find_free_slot ...");
+	SD_LOCK_W;
+#ifdef SD_REUSE_SLOTS
+	for (*midx =3D 0; *midx < sd_majors; ++*midx) {
+		sd_major =3D SD_MAJOR_PTR(*midx);
+		for (*didx =3D 0; *didx < SCSI_DISKS_PER_MAJOR; ++*didx) {
+			scsi_disk =3D SD_DISK_PTR(sd_major, *didx);
+			if (!scsi_disk->attached)=20
+				goto found;
+		}
+	}
+#else
+	if (sd_next < SCSI_DISKS_PER_MAJOR) {
+		*midx =3D sd_majors-1;
+		*didx =3D sd_next;
+		goto found;
+	}
+#endif
+	/* OK, we need to allocate a new major */
+	if (sd_alloc_major () =3D=3D -1) {
+		SD_UNLOCK_W;
+		return SD_NO_MAJOR;
+	}
+	*midx =3D sd_majors-1;
+	*didx =3D sd_next;	/* 0 */
+=09
+    found:
+	SDD_DPRINTK("... found %02x:%02x\n",=20
+		    MIDX_TO_MAJOR(*midx), DIDX_TO_MINOR(*didx));
+	sd_major  =3D SD_MAJOR_PTR(*midx);
+	scsi_disk =3D SD_DISK_PTR(sd_major, *didx);
+	++sd_next;
+	SD_UNLOCK_W;
+	return 0;
+}
diff -uNr linux-2.4.18.nohdstat/drivers/scsi/sd_dynalloc.h linux-2.4.18.S18=
.scsimany/drivers/scsi/sd_dynalloc.h
--- linux-2.4.18.nohdstat/drivers/scsi/sd_dynalloc.h	Thu Jan  1 01:00:00 19=
70
+++ linux-2.4.18.S18.scsimany/drivers/scsi/sd_dynalloc.h	Fri Jul 26 03:43:4=
3 2002
@@ -0,0 +1,79 @@
+/* sd_dynalloc.h=20
+ * dynamically allocated structures for the sd driver=20
+ * (c) Kurt Garloff <garloff@suse.de>, 7/2002
+ * License: GNU GPL v2
+ */
+
+#ifndef _SD_DYNALLOC_H
+#define _SD_DYNALLOC_H
+
+#include <linux/blk.h>
+#include "sd.h"
+
+/* Should default to the officially assigned 16 */
+#define MAX_SCSI_DYN_MAJORS CONFIG_SD_MAX_MAJORS
+#define MINORS (1U<<MINORBITS)
+#define MAJORS 256
+
+
+#define MIDX_TO_MAJOR(i)	(sd_midx_to_major(i))
+#define MAJOR_TO_MIDX(m)	(sd_majors? sd_major_to_midx[m]: SD_NO_MIDX)
+
+#define DIDX_TO_MINOR(di)	((di)<<SCSI_DISK_PART_BITS)
+#define MINOR_TO_DIDX(mn)	((mn)>>SCSI_DISK_PART_BITS)
+
+#define DISKNO_TO_MIDX(i)	((i)>>SCSI_DISK_DISK_SHIFT)
+#define DISKNO_TO_DIDX(i)	((i) & (SCSI_DISKS_PER_MAJOR-1))
+#define DISKNO_TO_MAJOR(i)	(MIDX_TO_MAJOR(DISKNO_TO_MIDX(i)))
+#define DISKNO_TO_MINOR(i)	(DIDX_TO_MINOR(DISKNO_TO_DIDX(i)))
+
+#define MDIDX_TO_DISKNO(mi,di)	(((mi)<<SCSI_DISK_DISK_SHIFT) + (di))
+#define MAJMIN_TO_DISKNO(mj,mn)	MDIDX_TO_DISKNO(MAJOR_TO_MIDX(mj),\
+					(mn)>>SCSI_DISK_PART_BITS)
+#define KDEV_TO_DISKNO(dev)	MAJMIN_TO_DISKNO(MAJOR(dev),MINOR(dev))
+
+#define MDIDX_TO_KDEV(mi,di)	(MKDEV(MIDX_TO_MAJOR(mi),DIDX_TO_MINOR(di)))
+
+
+#define SD_MAJOR_PTR(i)		(sd_major_ptrs[i])
+#define SD_DISK_PTR(sdm,i)	(&((sdm)->disks[i]))
+
+/* It would have made more sense to have per_partition structures,
+ * embedded into per_disk structures embedded into per_major
+ * structures. However, this would not have fit into the gendisk
+ * scheme. Therefore have these arrays in per_major struct */
+
+typedef struct sd_per_major {
+	int  sd_sizes[MINORS];		/* size of partitions */
+	int  sd_blocksizes[MINORS];	/* fs block size */
+	int  sd_hardsizes[MINORS];	/* hw block size */
+	int  sd_max_sectors[MINORS];	/* max request size in sectors */
+	char sd_varyio[MINORS];
+=09
+	Scsi_Disk disks[SCSI_DISKS_PER_MAJOR];
+	devfs_handle_t	de_arr[SCSI_DISKS_PER_MAJOR];
+	char flags[SCSI_DISKS_PER_MAJOR];
+	struct gendisk	 sd_gendisk;
+	struct hd_struct sd_hds[MINORS];
+} SD_Major;
+
+/* The dynamically allocated majors */
+extern int sd_majors;
+extern unsigned char sd_major_to_midx[MAJORS];
+extern struct sd_per_major *sd_major_ptrs[MAX_SCSI_DYN_MAJORS];
+
+#define SD_NO_MIDX 255
+#define SD_NO_MAJOR -1
+
+extern rwlock_t sd_dyn_lock;
+#define SD_LOCK_W write_lock(&sd_dyn_lock)
+#define SD_UNLOCK_W write_unlock(&sd_dyn_lock)
+
+int  sd_midx_to_major  (const int midex);
+int  sd_alloc_major    (void);
+void sd_dealloc_major  (const int idx);
+void sd_deallocate_all (void);
+int  sd_find_free_slot (Scsi_Device *SDp, int *midx, int *didx);
+
+
+#endif	/* _SD_DYNALLOC_H */
diff -uNr linux-2.4.18.nohdstat/fs/partitions/check.c linux-2.4.18.S18.scsi=
many/fs/partitions/check.c
--- linux-2.4.18.nohdstat/fs/partitions/check.c	Wed Jun 12 11:37:11 2002
+++ linux-2.4.18.S18.scsimany/fs/partitions/check.c	Wed Jul 17 14:52:16 2002
@@ -107,6 +107,16 @@
 			return buf + pos;
 	}
=20
+	/* The device driver can provide its own naming */
+	if (hd->devname) {
+		kdev_t dev =3D MKDEV(hd->major, minor);
+		*buf =3D 0;
+		if ((hd->devname)(dev, buf))=20
+			printk (KERN_ERR "disk_name():devname() failed!\n");
+		else
+			return buf;
+	}
+
 #ifdef CONFIG_ARCH_S390
 	if (genhd_dasd_name
 	    && genhd_dasd_name (buf, unit, part, hd) =3D=3D 0)
@@ -143,16 +153,9 @@
 			sprintf(buf, "%s%d", maj, unit);
 			return buf;
 	}
-	if (hd->major >=3D SCSI_DISK1_MAJOR && hd->major <=3D SCSI_DISK7_MAJOR) {
-		unit =3D unit + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;
-		if (unit+'a' > 'z') {
-			unit -=3D 26;
-			sprintf(buf, "sd%c%c", 'a' + unit / 26, 'a' + unit % 26);
-			if (part)
-				sprintf(buf + 4, "%d", part);
-			return buf;
-		}
-	}
+	=09
+	/* SCSI uses (*devname)() */
+
 	if (hd->major >=3D COMPAQ_SMART2_MAJOR && hd->major <=3D COMPAQ_SMART2_MA=
JOR+7) {
 		int ctlr =3D hd->major - COMPAQ_SMART2_MAJOR;
  		if (part =3D=3D 0)
diff -uNr linux-2.4.18.nohdstat/include/linux/blk.h linux-2.4.18.S18.scsima=
ny/include/linux/blk.h
--- linux-2.4.18.nohdstat/include/linux/blk.h	Wed Jul 17 13:17:39 2002
+++ linux-2.4.18.S18.scsimany/include/linux/blk.h	Fri Jul 26 02:33:11 2002
@@ -143,7 +143,10 @@
=20
 #define DEVICE_NAME "scsidisk"
 #define TIMEOUT_VALUE (2*HZ)
-#define DEVICE_NR(device) (((MAJOR(device) & SD_MAJOR_MASK) << (8 - 4)) + =
(MINOR(device) >> 4))
+/* The major calculation part duplicates SD_MAJOR_INDEX verbatim. */
+#define DEVICE_NR(device)	\
+    (( ( ((MAJOR(device) & 0x80) >> 4) + (MAJOR(device) & 7) ) << (8 - 4))=
 + \
+     (MINOR(device) >> 4))
=20
 /* Kludge to use the same number for both char and block major numbers */
 #elif  (MAJOR_NR =3D=3D MD_MAJOR) && defined(MD_DRIVER)
diff -uNr linux-2.4.18.nohdstat/include/linux/fs.h linux-2.4.18.S18.scsiman=
y/include/linux/fs.h
--- linux-2.4.18.nohdstat/include/linux/fs.h	Mon Jul 15 15:47:16 2002
+++ linux-2.4.18.S18.scsimany/include/linux/fs.h	Fri Jul 26 02:32:50 2002
@@ -1168,6 +1168,7 @@
 enum {BDEV_FILE, BDEV_SWAP, BDEV_FS, BDEV_RAW};
 extern int register_blkdev(unsigned int, const char *, struct block_device=
_operations *);
 extern int unregister_blkdev(unsigned int, const char *);
+extern const struct block_device_operations * get_blkfops(unsigned int maj=
or);
 extern struct block_device *bdget(dev_t);
 extern int bd_acquire(struct inode *inode);
 extern void bd_forget(struct inode *inode);
diff -uNr linux-2.4.18.nohdstat/include/linux/genhd.h linux-2.4.18.S18.scsi=
many/include/linux/genhd.h
--- linux-2.4.18.nohdstat/include/linux/genhd.h	Sun Jul 14 17:21:24 2002
+++ linux-2.4.18.S18.scsimany/include/linux/genhd.h	Fri Jul 26 02:32:50 2002
@@ -101,6 +101,7 @@
=20
 	devfs_handle_t *de_arr;         /* one per physical disc */
 	char *flags;                    /* one per physical disc */
+	int (*devname) (kdev_t dev, char *buffer);
 };
=20
 /* drivers/block/genhd.c */
diff -uNr linux-2.4.18.nohdstat/include/linux/major.h linux-2.4.18.S18.scsi=
many/include/linux/major.h
--- linux-2.4.18.nohdstat/include/linux/major.h	Wed Jun 12 11:37:13 2002
+++ linux-2.4.18.S18.scsimany/include/linux/major.h	Fri Jul 26 02:32:42 2002
@@ -111,16 +111,25 @@
=20
 #define COMPAQ_CISS_MAJOR 	104
 #define COMPAQ_CISS_MAJOR1	105
-#define COMPAQ_CISS_MAJOR2      106
-#define COMPAQ_CISS_MAJOR3      107
-#define COMPAQ_CISS_MAJOR4      108
-#define COMPAQ_CISS_MAJOR5      109
-#define COMPAQ_CISS_MAJOR6      110
-#define COMPAQ_CISS_MAJOR7      111
+#define COMPAQ_CISS_MAJOR2	106
+#define COMPAQ_CISS_MAJOR3	107
+#define COMPAQ_CISS_MAJOR4	108
+#define COMPAQ_CISS_MAJOR5	109
+#define COMPAQ_CISS_MAJOR6	110
+#define COMPAQ_CISS_MAJOR7	111
=20
 #define ATARAID_MAJOR		114
=20
-#define SCSI_CHANGER_MAJOR 86
+#define SCSI_CHANGER_MAJOR	86
+
+#define SCSI_DISK10_MAJOR	128
+#define SCSI_DISK11_MAJOR	129
+#define SCSI_DISK12_MAJOR	130
+#define SCSI_DISK13_MAJOR	131=20
+#define SCSI_DISK14_MAJOR	132
+#define SCSI_DISK15_MAJOR	133
+#define SCSI_DISK16_MAJOR	134
+#define SCSI_DISK17_MAJOR	135
=20
 #define DASD_MAJOR      94	/* Official assignations from Peter */
=20
@@ -173,7 +182,8 @@
  */
=20
 #define SCSI_DISK_MAJOR(M) ((M) =3D=3D SCSI_DISK0_MAJOR || \
-  ((M) >=3D SCSI_DISK1_MAJOR && (M) <=3D SCSI_DISK7_MAJOR))
+  ((M) >=3D SCSI_DISK1_MAJOR && (M) <=3D SCSI_DISK7_MAJOR) || \
+  ((M) >=3D SCSI_DISK10_MAJOR && (M) <=3D SCSI_DISK17_MAJOR))
  =20
 #define SCSI_BLK_MAJOR(M) \
   (SCSI_DISK_MAJOR(M)	\
diff -uNr linux-2.4.18.nohdstat/kernel/ksyms.c linux-2.4.18.S18.scsimany/ke=
rnel/ksyms.c
--- linux-2.4.18.nohdstat/kernel/ksyms.c	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.scsimany/kernel/ksyms.c	Tue Jul 16 13:25:07 2002
@@ -328,6 +328,7 @@
 EXPORT_SYMBOL(unregister_chrdev);
 EXPORT_SYMBOL(register_blkdev);
 EXPORT_SYMBOL(unregister_blkdev);
+EXPORT_SYMBOL(get_blkfops);
 EXPORT_SYMBOL(tty_register_driver);
 EXPORT_SYMBOL(tty_unregister_driver);
 EXPORT_SYMBOL(tty_std_termios);

--DXIF1lRUlMsbZ3S1--

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QW+bxmLh6hyYd04RAitqAJ9iVgk25xsx8lTo4mv5tjRNRqn3xwCglbqX
ppJzEWRROgJ5z1pOlRuS7zA=
=8SFF
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
