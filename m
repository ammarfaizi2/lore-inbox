Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317788AbSGZPoJ>; Fri, 26 Jul 2002 11:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317786AbSGZPnb>; Fri, 26 Jul 2002 11:43:31 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:46178 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317779AbSGZPnT>; Fri, 26 Jul 2002 11:43:19 -0400
Date: Fri, 26 Jul 2002 17:46:22 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] sd_many done right (2/5)
Message-ID: <20020726154622.GE19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: multipart/mixed; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here comes patch 2/5 from a series of patches to support more than 128 (and
optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driv=
er
to dynamically allocate memory and register block majors as disks get
attached.

The patches are all available at
http://www.suse.de/~garloff/linux/scsi-many/

This patch (2/5) makes the /proc/scsi/scsi extensions realized in patch 1/5
switchable at run time by echoing "scsi report-devs X" to /proc/scsi/scsi.
(X=3D1 enables, 0 disables). It defaults to off to avoid any trouble with
applications parsing /proc/scsi/scsi. Though I don't know any due to the=20
limited usefulness of /proc/scsi/scsi without these extensions.

Patch is against 2.4.19rc1. Patch depends on patch 1/5.
Marcelo, these patches are meant for inclusion into 2.4.20pre.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-switch-repdev-2419rc1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.scsiboot/drivers/scsi/scsi.c linux-2.4.18.S18.sc=
siswitch/drivers/scsi/scsi.c
--- linux-2.4.18.S18.scsiboot/drivers/scsi/scsi.c	Sat Jul 13 18:48:49 2002
+++ linux-2.4.18.S18.scsiswitch/drivers/scsi/scsi.c	Tue Jul 16 01:24:00 2002
@@ -126,6 +126,9 @@
  */
 unsigned int scsi_logging_level;
=20
+/* Flag for extended /proc/scsi/scsi format */
+int scsi_rep_hldev;
+
 const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] =3D
 {
 	"Direct-Access    ",
@@ -1665,6 +1668,18 @@
 		goto out;
=20
 	/*
+	 * Usage: echo "scsi report-devs X" > /proc/scsi/scsi
+	 * to enable (X!=3D0) or disable (X=3D0) the extended /proc/scsi/scsi for=
mat
+	 */
+	if (!strncmp("report-devs", buffer + 5, 11)) {
+		p =3D buffer + 17;
+
+		switch (*p) {
+		    case '0': scsi_rep_hldev =3D 0; goto out;
+		    default:  scsi_rep_hldev =3D 1; goto out;
+		}
+	}
+	/*
 	 * Usage: echo "scsi dump #N" > /proc/scsi/scsi
 	 * to dump status of all scsi commands.  The number is used to specify th=
e level
 	 * of detail in the dump.
diff -uNr linux-2.4.18.S18.scsiboot/drivers/scsi/scsi_proc.c linux-2.4.18.S=
18.scsiswitch/drivers/scsi/scsi_proc.c
--- linux-2.4.18.S18.scsiboot/drivers/scsi/scsi_proc.c	Thu Jun 20 18:08:40 =
2002
+++ linux-2.4.18.S18.scsiswitch/drivers/scsi/scsi_proc.c	Sat Jul 13 19:17:3=
5 2002
@@ -256,6 +256,9 @@
 	return (cmdIndex);
 }
=20
+/* Flag for extended /proc/scsi/scsi format */
+extern int scsi_rep_hldev;
+
 void proc_print_scsidevice(Scsi_Device * scd, char *buffer, int *size, int=
 len)
 {
=20
@@ -301,6 +304,11 @@
 	else
 		y +=3D sprintf(buffer + len + y, "\n");
 =09
+	if (!scsi_rep_hldev) {
+		*size =3D y;
+		return;
+	}
+	   =20
 	/* Report high level devices attached */
 	y +=3D sprintf (buffer + len + y, "  Attached drivers:");
=20

--AH+kv8CCoFf6qPuz--

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QW7OxmLh6hyYd04RAv0jAJ0UxJbIw+TLDAM5gcHZTjew4ZVNHACcCyv2
dUpojJwzrE3RnTQn2urp86M=
=wJ70
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
