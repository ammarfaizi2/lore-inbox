Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSFONnL>; Sat, 15 Jun 2002 09:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSFONnK>; Sat, 15 Jun 2002 09:43:10 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:22354 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S315374AbSFONnF>; Sat, 15 Jun 2002 09:43:05 -0400
Date: Sat, 15 Jun 2002 15:43:06 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: root=/dev/scsi/sdcXbXtXuXpX support
Message-ID: <20020615134306.GD11016@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: multipart/mixed; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

based on the /proc/scsi/map patch, one can add straightforward support
for the root=3D/dev/scsi/sdcXbXtXuXpX format. Note that the format is
identical to the one used by devfs, but devfs is not needed to achieve this
functionality id this patch is applied.=20

Together with the scsihosts=3D boot parameter, one can specify a partition
of a scsi disk based on the physical location.

Patch is against 2.4.19pre10.
Comments are welcome!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-map-boot1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.sdmany/drivers/scsi/scsi.c linux-2.4.18.S18.sdma=
ny2/drivers/scsi/scsi.c
--- linux-2.4.18.S18.sdmany/drivers/scsi/scsi.c	Fri Jun 14 12:49:15 2002
+++ linux-2.4.18.S18.sdmany2/drivers/scsi/scsi.c	Fri Jun 14 14:18:55 2002
@@ -1554,6 +1554,36 @@
     }
 }
=20
+int __init scsi_find_bdev(int h, int c, int i, int l, const char* tag,
+			  char* name, kdev_t *dev)
+{
+	Scsi_Device *scd;
+	struct Scsi_Host *HBA_ptr;
+	struct Scsi_Device_Template *sg_t =3D scsi_devicelist;
+	/* First look for right high-level driver */
+	while (sg_t &&=20
+	       (!sg_t->find_kdev || !sg_t->blk ||
+		!(sg_t->tag && !strcmp(sg_t->tag, tag))))
+		sg_t =3D sg_t->next;
+	if (!sg_t)
+		return 1;
+	/* Now find Scsi_Device and call high-level driver's find_kdev() */
+	for (HBA_ptr =3D scsi_hostlist; HBA_ptr; HBA_ptr =3D HBA_ptr->next) {
+		for (scd =3D HBA_ptr->host_queue; scd; scd =3D scd->next) {
+			if (scd->host->host_no =3D=3D h &&
+			    scd->channel =3D=3D c &&
+			    scd->id =3D=3D i &&
+			    scd->lun =3D=3D l) {
+				if (sg_t->find_kdev(scd, name, dev))
+					return 1;
+				else
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 #ifdef CONFIG_PROC_FS
 /*=20
  * Output the mapping of physical devices (contorller,channel.id,lun)
diff -uNr linux-2.4.18.S18.sdmany/init/do_mounts.c linux-2.4.18.S18.sdmany2=
/init/do_mounts.c
--- linux-2.4.18.S18.sdmany/init/do_mounts.c	Wed Jun 12 11:37:12 2002
+++ linux-2.4.18.S18.sdmany2/init/do_mounts.c	Fri Jun 14 15:53:45 2002
@@ -136,6 +136,19 @@
 	{ "sdn",     0x08d0 },
 	{ "sdo",     0x08e0 },
 	{ "sdp",     0x08f0 },
+	{ "sdq",     0x4100 },
+	{ "sdr",     0x4110 },
+	{ "sds",     0x4120 },
+	{ "sdt",     0x4130 },
+	{ "sdu",     0x4140 },
+	{ "sdv",     0x4150 },
+	{ "sdw",     0x4160 },
+	{ "sdx",     0x4170 },
+	{ "sdy",     0x4180 },
+	{ "sdz",     0x4190 },
+	/* more scsi devs could be added here, but /dev/sdaa would match=20
+	 * /dev/sda before, so it would need to be moved before sda.
+	 * Better use /dev/scsi/hXcXiXlXpX */
 	{ "ada",     0x1c00 },
 	{ "adb",     0x1c10 },
 	{ "adc",     0x1c20 },
@@ -147,6 +160,7 @@
 	{ "xdb",     0x0d40 },
 	{ "ram",     0x0100 },
 	{ "scd",     0x0b00 },
+	{ "sr",      0x0b00 },
 	{ "mcd",     0x1700 },
 	{ "cdu535",  0x1800 },
 	{ "sonycd",  0x1800 },
@@ -255,6 +269,64 @@
 	{ NULL, 0 }
 };
=20
+#if defined(CONFIG_SCSI) && !defined(CONFIG_DEVFS_FS)
+int scsi_find_bdev (int, int, int, int, const char*, char*, kdev_t*);
+/* Parse /dev/scsi/sdcXbXtXuXpX names. Makes only sense if scsi is
+ * compiled in. Otherwise the initrd stuff needs to take care ... */
+kdev_t __init scsiname_to_kdev_t(char* line)
+{
+	kdev_t dev =3D ROOT_DEV;
+	int h, c, i ,l;
+	char *tp =3D 0;
+	char nmbuf[16];
+
+	if (!strncmp (line, "sd", 2)) {
+		tp =3D "sd"; line +=3D 2;
+	}
+	else if (!strncmp (line, "sr", 2)) {
+		tp =3D "sr"; line +=3D 2;
+	}
+	else if (!strncmp (line, "scd", 3)) {
+		tp =3D "sr"; line +=3D 3;
+	}
+=09
+	if (strlen (line) < 8 || !tp)
+		goto out;
+=09
+	if (*line++ !=3D 'c')
+		goto out;
+	h =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 'b')
+		goto out;
+	c =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 't')
+		goto out;
+	i =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 'u')
+		goto out;
+	l =3D simple_strtoul(line, &line, 10);
+=09
+	if (!scsi_find_bdev (h, c, i, l, tp, nmbuf, &dev)) {
+		if (line && *line++ =3D=3D 'p') {
+			int p =3D simple_strtoul(line, &line, 10);
+			dev =3D MKDEV(MAJOR(dev),MINOR(dev)+p);
+			sprintf (nmbuf+strlen(nmbuf), "%i", p);
+			printk("found scsi root device %sc%ib%it%iu%ip%i: %s (%02x:%02x)\n",
+			       tp, h, c, i, l, p, nmbuf, MAJOR(dev), MINOR(dev));
+		} else
+			printk("found scsi root device %sc%ib%it%iu%i: %s (%02x:%02x)\n",
+			       tp, h, c, i, l, nmbuf, MAJOR(dev), MINOR(dev));
+		strcpy (root_device_name, nmbuf);
+	} else=20
+		printk("did not find scsi root device %sc%ib%it%iu%i\n",
+		       tp, h, c, i, l);
+
+ out:
+	return dev;
+=09
+}
+#endif
+
 kdev_t __init name_to_kdev_t(char *line)
 {
 	int base =3D 0;
@@ -732,6 +804,10 @@
 #else
 static void __init devfs_make_root(char *name)
 {
+# ifdef CONFIG_SCSI=09
+	if (!strncmp (name, "scsi/", 5))
+		ROOT_DEV =3D scsiname_to_kdev_t (name+5);
+# endif
 }
 #endif
=20

--47eKBCiAZYFK5l32--

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9C0RqxmLh6hyYd04RAl4pAJ92yrT526uP63eKJ1PlF6iDrBtjCgCg1xm6
xxGH8nzNW5w92wBHLCC7qOU=
=Epjk
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
