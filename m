Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSFZILH>; Wed, 26 Jun 2002 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSFZILG>; Wed, 26 Jun 2002 04:11:06 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:49966 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316390AbSFZILC>; Wed, 26 Jun 2002 04:11:02 -0400
Date: Wed, 26 Jun 2002 10:11:02 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: [PATCH] root=/dev/scsi/sdcXbXtXuXpX
Message-ID: <20020626081102.GA32133@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

if you accept the /proc/scsi/scsi extension (listing attached high-level
drivers) that caused a lot of discussions because we're heading for a very
general solution, I'd like to offer a second patch as well, which uses the
infrastructure to allow=20
root=3D/dev/scsi/sdCXbXtXuXpX=20
parameter. This currently works already if you enable devfs, but may also be
needed in setups where devfs can not used.
Patch is against 2.5.24-dj1 again.
The patch depends on the /proc/scsi/scsi extensions or /proc/scsi/map.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-map-boot2.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.5.24-dj1-scsirephl/drivers/scsi/scsi.c linux-2.5.24-dj1-s=
csiboot/drivers/scsi/scsi.c
--- linux-2.5.24-dj1-scsirephl/drivers/scsi/scsi.c	Wed Jun 19 04:11:55 2002
+++ linux-2.5.24-dj1-scsiboot/drivers/scsi/scsi.c	Tue Jun 25 11:59:45 2002
@@ -1544,6 +1544,39 @@
     }
 }
=20
+int __init scsi_find_bdev(int h, int c, int i, int l, const char* tag,
+			  char* name, dev_t *dev)
+{
+	Scsi_Device *scd;
+	struct Scsi_Host *HBA_ptr;
+	struct Scsi_Device_Template *sg_t =3D scsi_devicelist;
+	kdev_t kdev;
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
+				if (sg_t->find_kdev(scd, name, &kdev))
+					return 1;
+				else {
+					*dev =3D kdev_t_to_nr(kdev);
+					return 0;
+				}
+			}
+		}
+	}
+	return 1;
+}
+
 #ifdef CONFIG_PROC_FS
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int le=
ngth)
 {
diff -uNr linux-2.5.24-dj1-scsirephl/init/do_mounts.c linux-2.5.24-dj1-scsi=
boot/init/do_mounts.c
--- linux-2.5.24-dj1-scsirephl/init/do_mounts.c	Fri Jun 21 07:51:53 2002
+++ linux-2.5.24-dj1-scsiboot/init/do_mounts.c	Tue Jun 25 12:00:20 2002
@@ -128,6 +128,19 @@
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
+	 * Better use /dev/scsi/sdcXbXtXuXpX */
 	{ "ada",     0x1c00 },
 	{ "adb",     0x1c10 },
 	{ "adc",     0x1c20 },
@@ -139,6 +152,7 @@
 	{ "xdb",     0x0d40 },
 	{ "ram",     0x0100 },
 	{ "scd",     0x0b00 },
+	{ "sr",      0x0b00 },
 	{ "mcd",     0x1700 },
 	{ "cdu535",  0x1800 },
 	{ "sonycd",  0x1800 },
@@ -231,6 +245,64 @@
 	{ NULL, 0 }
 };
=20
+#if defined(CONFIG_SCSI) && !defined(CONFIG_DEVFS_FS)
+int scsi_find_bdev (int, int, int, int, const char*, char*, dev_t*);
+/* Parse /dev/scsi/sdcXbXtXuXpX names. Makes only sense if scsi is
+ * compiled in. Otherwise the initrd stuff needs to take care ... */
+dev_t __init scsiname_to_dev_t(char* line)
+{
+	dev_t dev =3D ROOT_DEV;
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
@@ -710,6 +782,10 @@
 #else
 static void __init devfs_make_root(char *name)
 {
+# ifdef CONFIG_SCSI=09
+	if (!strncmp (name, "scsi/", 5))
+		ROOT_DEV =3D scsiname_to_dev_t (name+5);
+# endif
 }
 #endif
=20

--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9GXcWxmLh6hyYd04RAtoAAKCcaZDx2V01ljlSyx7oLa6Tq0+z+wCfaxsB
CUL73/fBIILJTJoBEIeFMgA=
=9Mx1
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
