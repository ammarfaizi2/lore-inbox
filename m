Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSGZPpi>; Fri, 26 Jul 2002 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGZPpd>; Fri, 26 Jul 2002 11:45:33 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:46946 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317789AbSGZPoZ>; Fri, 26 Jul 2002 11:44:25 -0400
Date: Fri, 26 Jul 2002 17:47:34 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] sd_many done right (3/5)
Message-ID: <20020726154734.GF19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MFZs98Tklfu0WsCO
Content-Type: multipart/mixed; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

here comes patch 3/5 from a series of patches to support more than 128 (and
optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driv=
er
to dynamically allocate memory and register block majors as disks get
attached.

The patches are all available at
http://www.suse.de/~garloff/linux/scsi-many/

Patch 3 does use the infrastructure of patch 1 to allow specifying the
root filesystem as a kernel parameter using devfs syntax (e.g.
root=3D/dev/scsi/c2b0t9u0p5), but also working on non-devfs systems.
Together with the (already existing) scsihosts=3D parameter, this can=20
be quite useful if you have many SCSI disks with changing configurations.

This patch is against 2.4.19rc1. It depends on 1/3.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-boot-scsi-2419rc1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.scsirephl/drivers/scsi/scsi.c linux-2.4.18.S18.s=
csiboot/drivers/scsi/scsi.c
--- linux-2.4.18.S18.scsirephl/drivers/scsi/scsi.c	Thu Jun 20 18:06:16 2002
+++ linux-2.4.18.S18.scsiboot/drivers/scsi/scsi.c	Sat Jul 13 18:48:49 2002
@@ -1553,6 +1553,36 @@
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
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int le=
ngth)
 {
diff -uNr linux-2.4.18.S18.scsirephl/init/do_mounts.c linux-2.4.18.S18.scsi=
boot/init/do_mounts.c
--- linux-2.4.18.S18.scsirephl/init/do_mounts.c	Wed Jun 12 11:37:12 2002
+++ linux-2.4.18.S18.scsiboot/init/do_mounts.c	Sat Jul 13 18:51:18 2002
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
+	 * /dev/sda before, so it would need to be put before sda.
+	 * Better use /dev/scsi/sdcXbXtXuXpX */
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
@@ -255,6 +269,62 @@
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
+		return dev;
+=09
+	if (*line++ !=3D 'c')
+		return dev;
+	h =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 'b')
+		return dev;
+	c =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 't')
+		return dev;
+	i =3D simple_strtoul(line, &line, 10);
+	if (*line++ !=3D 'u')
+		return dev;
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
+	return dev;
+}
+#endif
+
 kdev_t __init name_to_kdev_t(char *line)
 {
 	int base =3D 0;
@@ -732,6 +802,10 @@
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

--CNfT9TXqV7nd4cfk--

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QW8WxmLh6hyYd04RAi5lAKCfEIklL/N3QtH9kfKBpC6TmbzXOgCguW2v
QSFvI9WsNnh9RyDapGPMWfY=
=hJqB
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
