Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317783AbSGZPnT>; Fri, 26 Jul 2002 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317781AbSGZPnN>; Fri, 26 Jul 2002 11:43:13 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:44386 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317779AbSGZPmn>; Fri, 26 Jul 2002 11:42:43 -0400
Date: Fri, 26 Jul 2002 17:45:33 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] sd_many done right (1/5)
Message-ID: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: multipart/mixed; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here comes patch 1/5 from a series of patches to support more than 128 (and
optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driv=
er
to dynamically allocate memory and register block majors as disks get
attached.

The patches are all available at
http://www.suse.de/~garloff/linux/scsi-many/

This patch (1/5) does implement some infrastructure that is useful: We
extend the format of /proc/scsi/scsi to report the attached high-level
drivers.=20
This can be used by userspace applications to dynamically create device
nodes or to talk to the corresponding sg device (which otherwise is non-
trivial to find out!) and inquire extra information such as serial number
or WWID.

Here's a sample.
Host: scsi5 Channel: 00 Id: 04 Lun: 00
  Vendor: Linux    Model: scsi_debug       Rev: 0003
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Attached drivers: sdr(b:41:10) sg18(c:15:12)
     =20
Patch is against 2.4.19rc1.
Marcelo, these patches are meant for inclusion into 2.4.20pre.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-rep-hldevs-2419rc1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/hosts.h linux-2.4.18.S18.scsi=
rephl/drivers/scsi/hosts.h
--- linux-2.4.18.S18.fixed/drivers/scsi/hosts.h	Wed Jun 12 11:37:09 2002
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/hosts.h	Wed Jun 12 11:53:54 2002
@@ -530,6 +530,7 @@
     void (*detach)(Scsi_Device *);
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code.=20
                                            Selects command for blkdevs */
+    int (*find_kdev)(Scsi_Device *, char*, kdev_t*);  /* find back dev. */
 };
=20
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/osst.c linux-2.4.18.S18.scsir=
ephl/drivers/scsi/osst.c
--- linux-2.4.18.S18.fixed/drivers/scsi/osst.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/osst.c	Wed Jun 12 11:39:47 2002
@@ -156,6 +156,7 @@
 static int osst_attach(Scsi_Device *);
 static int osst_detect(Scsi_Device *);
 static void osst_detach(Scsi_Device *);
+static int osst_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 struct Scsi_Device_Template osst_template =3D
 {
@@ -166,7 +167,8 @@
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
-       detach:		osst_detach
+       detach:		osst_detach,
+       find_kdev:	osst_find_kdev,
 };
=20
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsig=
ned int cmd_in,unsigned long arg);
@@ -5417,6 +5419,24 @@
 	return 0;
 }
=20
+static int osst_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	OS_Scsi_Tape *ostp;
+=09
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && osst_supports(sdp)) {
+		for (ostp =3D os_scsi_tapes[i =3D 0]; i < osst_template.dev_max;
+		     ostp =3D os_scsi_tapes[++i]) {
+			if (ostp && ostp->device =3D=3D sdp) {
+				sprintf (nm, "osst%i", i);
+				*dev =3D MKDEV(OSST_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int osst_attach(Scsi_Device * SDp)
 {
 	OS_Scsi_Tape * tpnt;
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/scsi_proc.c linux-2.4.18.S18.=
scsirephl/drivers/scsi/scsi_proc.c
--- linux-2.4.18.S18.fixed/drivers/scsi/scsi_proc.c	Thu Jun 28 02:10:55 2001
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/scsi_proc.c	Thu Jun 20 18:08:40=
 2002
@@ -261,6 +261,10 @@
=20
 	int x, y =3D *size;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
+	char nm[16];
+	kdev_t kdev;
+	int att =3D scd->attached;
+	struct Scsi_Device_Template *sd_t =3D scsi_devicelist;
=20
 	y =3D sprintf(buffer + len,
 	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
@@ -296,7 +300,24 @@
 		y +=3D sprintf(buffer + len + y, " CCS\n");
 	else
 		y +=3D sprintf(buffer + len + y, "\n");
+=09
+	/* Report high level devices attached */
+	y +=3D sprintf (buffer + len + y, "  Attached drivers:");
=20
+	while (att && sd_t) {
+		if (sd_t->find_kdev) {
+			if (!(sd_t->find_kdev(scd, nm, &kdev))) {
+				y +=3D sprintf(buffer + len + y,
+					     " %s(%c:%02x:%02x)",
+					     nm, (sd_t->blk? 'b': 'c'),
+					     MAJOR(kdev), MINOR(kdev));
+				--att;
+			}
+		}
+		sd_t =3D sd_t->next;
+	}
+
+	y +=3D sprintf(buffer + len + y, "\n");
 	*size =3D y;
 	return;
 }
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sd.c linux-2.4.18.S18.scsirep=
hl/drivers/scsi/sd.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sd.c	Wed Jun 12 11:37:13 2002
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/sd.c	Wed Jun 12 11:39:47 2002
@@ -109,6 +109,7 @@
 static int sd_detect(Scsi_Device *);
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
+static int sd_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template sd_template =3D {
 	name:"disk",
@@ -127,6 +128,7 @@
 	attach:sd_attach,
 	detach:sd_detach,
 	init_command:sd_init_command,
+	find_kdev:sd_find_kdev,
 };
=20
=20
@@ -281,6 +283,23 @@
 	}
 }
=20
+static int sd_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_Disk *dp;=20
+	int i;
+=09
+	if (sdp && (sdp->type =3D=3D TYPE_DISK || sdp->type =3D=3D TYPE_MOD)) {
+		for (dp =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; ++i, ++dp) {
+			if (dp->device =3D=3D sdp) {
+				sd_devname(i, nm);
+				*dev =3D MKDEV_SD(i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static request_queue_t *sd_find_queue(kdev_t dev)
 {
 	Scsi_Disk *dpnt;
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sg.c linux-2.4.18.S18.scsirep=
hl/drivers/scsi/sg.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sg.c	Wed Jun 12 11:37:04 2002
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/sg.c	Wed Jun 12 15:27:55 2002
@@ -115,6 +115,7 @@
 static void sg_finish(void);
 static int sg_detect(Scsi_Device *);
 static void sg_detach(Scsi_Device *);
+static int sg_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 static Scsi_Request * dummy_cmdp;	/* only used for sizeof */
=20
@@ -123,6 +124,7 @@
=20
 static struct Scsi_Device_Template sg_template =3D
 {
+      name:"generic",
       tag:"sg",
       scsi_type:0xff,
       major:SCSI_GENERIC_MAJOR,
@@ -130,7 +132,8 @@
       init:sg_init,
       finish:sg_finish,
       attach:sg_attach,
-      detach:sg_detach
+      detach:sg_detach,
+      find_kdev:sg_find_kdev
 };
=20
=20
@@ -2696,6 +2699,36 @@
 }
=20
 #ifdef CONFIG_PROC_FS
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    unsigned long iflags;
+    int err =3D 1;=20
+
+    if (sdp && sg_dev_arr) {
+	int k;
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	for (k =3D 0; k < sg_template.dev_max; ++k) {
+	    if (sg_dev_arr[k] && sg_dev_arr[k]->device =3D=3D sdp) {
+		sprintf (nm, "sg%i", k);
+	        *dev =3D sg_dev_arr[k]->i_rdev;
+		err =3D 0;
+		break;
+	    }
+	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+    }
+    return err;
+}
+#else
+/* Not needed without procfs support */
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    *nm =3D 0; *kdev =3D MKDEV(255,255);
+    return 1;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
=20
 static struct proc_dir_entry * sg_proc_sgp =3D NULL;
=20
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sr.c linux-2.4.18.S18.scsirep=
hl/drivers/scsi/sr.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sr.c	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/sr.c	Wed Jun 12 11:39:47 2002
@@ -69,6 +69,8 @@
=20
 static int sr_init_command(Scsi_Cmnd *);
=20
+static int sr_find_kdev(Scsi_Device*, char*, kdev_t*);
+
 static struct Scsi_Device_Template sr_template =3D
 {
 	name:"cdrom",
@@ -81,7 +83,8 @@
 	finish:sr_finish,
 	attach:sr_attach,
 	detach:sr_detach,
-	init_command:sr_init_command
+	init_command:sr_init_command,
+	find_kdev:sr_find_kdev,
 };
=20
 Scsi_CD *scsi_CDs;
@@ -586,6 +589,22 @@
 	return 0;
 }
=20
+static int sr_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_CD *srp;
+	int i;
+=09
+	if (sdp && (sdp->type =3D=3D TYPE_ROM || sdp->type =3D=3D TYPE_WORM)) {
+		for (srp =3D scsi_CDs, i =3D 0; i < sr_template.dev_max; ++i, ++srp) {
+			if (srp->device =3D=3D sdp) {
+				sprintf(nm, "sr%i", i);
+				*dev =3D MKDEV(SCSI_CDROM_MAJOR,i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
=20
 void get_sectorsize(int i)
 {
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/st.c linux-2.4.18.S18.scsirep=
hl/drivers/scsi/st.c
--- linux-2.4.18.S18.fixed/drivers/scsi/st.c	Mon Feb 25 20:38:04 2002
+++ linux-2.4.18.S18.scsirephl/drivers/scsi/st.c	Wed Jun 12 11:39:47 2002
@@ -164,6 +164,7 @@
 static int st_attach(Scsi_Device *);
 static int st_detect(Scsi_Device *);
 static void st_detach(Scsi_Device *);
+static int st_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template st_template =3D
 {
@@ -174,7 +175,8 @@
 	detect:st_detect,=20
 	init:st_init,
 	attach:st_attach,=20
-	detach:st_detach
+	detach:st_detach,
+	find_kdev:st_find_kdev,
 };
=20
 static int st_compression(Scsi_Tape *, int);
@@ -3827,6 +3829,23 @@
 	return 1;
 }
=20
+static int st_find_kdev(Scsi_Device * sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	Scsi_Tape *stp;
+=09
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && !st_incompatible(sdp)) {
+		for (stp =3D scsi_tapes[0], i =3D 0; i < st_template.dev_max; stp=3Dscsi=
_tapes[++i]) {
+			if (stp && stp->device =3D=3D sdp) {
+				sprintf(nm, "st%i", i);
+				*dev =3D MKDEV (SCSI_TAPE_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int st_registered =3D 0;
=20
 /* Driver initialization (not __init because may be called later) */

--NklN7DEeGtkPCoo3--

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QW6cxmLh6hyYd04RAvCaAKCNyyjeYN1DxNMifn/wB8spo6sRjgCeP7RN
bXJ01BdzuGVfY91AeqFBK+g=
=j0yu
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
