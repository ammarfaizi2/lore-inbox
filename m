Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSBEUAn>; Tue, 5 Feb 2002 15:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289779AbSBEUAg>; Tue, 5 Feb 2002 15:00:36 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:49732 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S289775AbSBEUAO>; Tue, 5 Feb 2002 15:00:14 -0500
Date: Tue, 5 Feb 2002 21:00:11 +0100
From: Kurt Garloff <garloff@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Dave Jones <davej@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: [PATCH] Support large LUNs with SCSI2
Message-ID: <20020205210011.F14047@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Dave Jones <davej@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m972NQjnE83KvVa/
Content-Type: multipart/mixed; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo, Dave,

a change in Linux SCSI scanning code broke support for large LUNs on=20
EMC Symmetrix storage arrays.

The change was easy to identify, thanks to Doug Gilbert compiling a list of
recent SCSI changes. (THANKS, Doug!)
2.4.13:
  - [...]
  - don't probe luns > 7 for target <=3D SCSI_2

The new code is correct, AFAICT, so the EMC Symmetrix needs a special case.

I created a new BLIST_ flag for this, BLIST_LARGELUN.

When this flag is set, a device reporting as SCSI-2 will be treated as
SCSI-3 for the scanning code, which (at this moment) means that LUNs larger
than 7 are supported and the LUN bits in byte 2 of the CDB are not used for
the LUN addressing any more. (It's up to the host adapter that supports LUNs
> 7 to make sure the addressing is done appropriately.)

The patch has been tested and makes the high LUNs of the Symmetrix reappear.
No other devices are affected. (Though probably more of the SPARESLUN
devices are affected by the same problem and should be added this flag.)

Being at it, I also took time to finally document the BLIST_ flags in this
file, in order to make it more usable. Some comments were not at the right
position any more before.

Patch is against 2.4.18-pre8. Please apply.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-largelun-2418p8.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18-pre8/drivers/scsi/scsi_scan.c linux-2.4.18-pre8-larg=
elun/drivers/scsi/scsi_scan.c
--- linux-2.4.18-pre8/drivers/scsi/scsi_scan.c	Tue Feb  5 20:46:42 2002
+++ linux-2.4.18-pre8-largelun/drivers/scsi/scsi_scan.c	Tue Feb  5 20:48:35=
 2002
@@ -23,21 +23,20 @@
 #include <linux/kmod.h>
 #endif
=20
-/* The following devices are known not to tolerate a lun !=3D 0 scan for
- * one reason or another.  Some will respond to all luns, others will
- * lock up.
+/*=20
+ * Flags for irregular SCSI devices that need special treatment=20
  */
-
-#define BLIST_NOLUN     	0x001
-#define BLIST_FORCELUN  	0x002
-#define BLIST_BORKEN    	0x004
-#define BLIST_KEY       	0x008
-#define BLIST_SINGLELUN 	0x010
-#define BLIST_NOTQ		0x020
-#define BLIST_SPARSELUN 	0x040
-#define BLIST_MAX5LUN		0x080
-#define BLIST_ISDISK    	0x100
-#define BLIST_ISROM     	0x200
+#define BLIST_NOLUN     	0x001	/* Don't scan for LUNs */
+#define BLIST_FORCELUN  	0x002	/* Known to have LUNs, force sanning */
+#define BLIST_BORKEN    	0x004	/* Flag for broken handshaking */
+#define BLIST_KEY       	0x008	/* Needs to be unlocked by special command =
*/
+#define BLIST_SINGLELUN 	0x010	/* LUNs should better not be used in parall=
el */
+#define BLIST_NOTQ		0x020	/* Buggy Tagged Command Queuing */
+#define BLIST_SPARSELUN 	0x040	/* Non consecutive LUN numbering */
+#define BLIST_MAX5LUN		0x080	/* Avoid LUNS >=3D 5 */
+#define BLIST_ISDISK    	0x100	/* Treat as (removable) disk */
+#define BLIST_ISROM     	0x200	/* Treat as (removable) CD-ROM */
+#define BLIST_LARGELUN		0x400	/* LUNs larger than 7 despite reporting as S=
CSI 2 */
=20
 static void print_inquiry(unsigned char *data);
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
@@ -62,6 +61,10 @@
  */
 static struct dev_info device_list[] =3D
 {
+/* The following devices are known not to tolerate a lun !=3D 0 scan for
+ * one reason or another.  Some will respond to all luns, others will
+ * lock up.
+ */
 	{"Aashima", "IMAGERY 2400SP", "1.03", BLIST_NOLUN},	/* Locks up if polled=
 for lun !=3D 0 */
 	{"CHINON", "CD-ROM CDS-431", "H42", BLIST_NOLUN},	/* Locks up if polled f=
or lun !=3D 0 */
 	{"CHINON", "CD-ROM CDS-535", "Q14", BLIST_NOLUN},	/* Locks up if polled f=
or lun !=3D 0 */
@@ -75,7 +78,6 @@
 	{"MAXTOR", "XT-4170S", "B5A", BLIST_NOLUN},		/* Locks-up sometimes when L=
UN>0 polled. */
 	{"MAXTOR", "XT-8760S", "B7B", BLIST_NOLUN},		/* guess what? */
 	{"MEDIAVIS", "RENO CD-ROMX2A", "2.03", BLIST_NOLUN},	/*Responds to all lu=
n */
-	{"MICROP", "4110", "*", BLIST_NOTQ},			/* Buggy Tagged Queuing */
 	{"NEC", "CD-ROM DRIVE:841", "1.0", BLIST_NOLUN},	/* Locks-up when LUN>0 p=
olled. */
 	{"PHILIPS", "PCA80SC", "V4-2", BLIST_NOLUN},		/* Responds to all lun */
 	{"RODIME", "RO3000S", "2.33", BLIST_NOLUN},		/* Locks up if polled for lu=
n !=3D 0 */
@@ -126,6 +128,7 @@
 	{"INSITE", "Floptical   F*8I", "*", BLIST_KEY},
 	{"INSITE", "I325VM", "*", BLIST_KEY},
 	{"LASOUND","CDX7405","3.10", BLIST_MAX5LUN | BLIST_SINGLELUN},
+	{"MICROP", "4110", "*", BLIST_NOTQ},			/* Buggy Tagged Queuing */
 	{"NRC", "MBR-7", "*", BLIST_FORCELUN | BLIST_SINGLELUN},
 	{"NRC", "MBR-7.4", "*", BLIST_FORCELUN | BLIST_SINGLELUN},
 	{"REGAL", "CDC-4X", "*", BLIST_MAX5LUN | BLIST_SINGLELUN},
@@ -152,7 +155,7 @@
 	{"DELL", "PV660F   PSEUDO",   "*", BLIST_SPARSELUN},
 	{"DELL", "PSEUDO DEVICE .",   "*", BLIST_SPARSELUN}, // Dell PV 530F
 	{"DELL", "PV530F",    "*", BLIST_SPARSELUN}, // Dell PV 530F
-	{"EMC", "SYMMETRIX", "*", BLIST_SPARSELUN},
+	{"EMC", "SYMMETRIX", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"CMD", "CRA-7280", "*", BLIST_SPARSELUN},   // CMD RAID Controller
 	{"CNSI", "G7324", "*", BLIST_SPARSELUN},     // Chaparral G7324 RAID
 	{"CNSi", "G8324", "*", BLIST_SPARSELUN},     // Chaparral G8324 RAID
@@ -434,8 +437,13 @@
 								       scsi_result)
 						    && !sparse_lun)
 							break;	/* break means don't probe further for luns!=3D0 */
-						if (SDpnt && (0 =3D=3D lun))
-							lun0_sl =3D SDpnt->scsi_level;
+						if (SDpnt && (0 =3D=3D lun)) {
+							int bflags =3D get_device_flags (scsi_result);
+							if (bflags & BLIST_LARGELUN)
+								lun0_sl =3D SCSI_3; /* treat as SCSI 3 */
+							else
+								lun0_sl =3D SDpnt->scsi_level;
+						}
 					}	/* for lun ends */
 				}	/* if this_id !=3D id ends */
 			}	/* for dev ends */

--GV0iVqYguTV4Q9ER--

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8YDnLxmLh6hyYd04RAiI3AKCha00h/8CC9TMEgCQEzpszBPee0wCfeoOy
9HvJcwb+ru7uswzqLmCmxBM=
=wJnf
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
