Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUESW0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUESW0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUESW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:26:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:31112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264655AbUESWZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:25:49 -0400
Date: Wed, 19 May 2004 20:50:39 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
Message-ID: <20040519185039.GD5547@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1084229974.1763.512.camel@mulgrave> <20040511123441.GL4828@tpkurt.garloff.de> <1084282961.1886.8.camel@mulgrave> <20040517195241.GA4747@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <20040517195241.GA4747@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.5-10-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: multipart/mixed; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2004 at 09:52:42PM +0200, Kurt Garloff wrote:
> If wanted, I can rediff and resubmit.

Patches against 2.6.6 attached.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                        Director SUSE Labs

--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Description: scsi-log-unlikely.diff
Content-Disposition: attachment; filename=scsi-log-unlikely
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Optimization.

Tell the compiler that the SCSI LOG will not likely happen.

--- linux-2.6.5/drivers/scsi/scsi_logging.h.orig	2004-04-04 05:36:17.000000=
000 +0200
+++ linux-2.6.5/drivers/scsi/scsi_logging.h	2004-04-15 21:18:42.284491405 +=
0200
@@ -46,7 +46,7 @@ extern unsigned int scsi_logging_level;
=20
 #define SCSI_CHECK_LOGGING(SHIFT, BITS, LEVEL, CMD)		\
 {								\
-        if ((SCSI_LOG_LEVEL(SHIFT, BITS)) > (LEVEL))		\
+        if (unlikely((SCSI_LOG_LEVEL(SHIFT, BITS)) > (LEVEL)))	\
 		(CMD);						\
 }
 #else

--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Description: scsi-scan-deprecate-forcelun.diff
Content-Disposition: attachment; filename=scsi-scan-deprecate-forcelun
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Cleanup

Mark BLIST_FORCELUN as deprecated, as we don't want to collect a list
of perfectly working multi-LUN devices with BLIST_FORCELUN. Instead
document max_luns boot/module parameter.

diff -uNrp linux-2.6.5.scsi-orig/drivers/scsi/Kconfig linux-2.6.5.depr-forc=
elun/drivers/scsi/Kconfig
--- linux-2.6.5.scsi-orig/drivers/scsi/Kconfig	2004-04-21 14:17:50.00000000=
0 +0200
+++ linux-2.6.5.depr-forcelun/drivers/scsi/Kconfig	2004-04-21 14:23:23.0000=
00000 +0200
@@ -167,8 +167,8 @@ config SCSI_MULTI_LUN
 	  can say Y here to force the SCSI driver to probe for multiple LUNs.
 	  A SCSI device with multiple LUNs acts logically like multiple SCSI
 	  devices. The vast majority of SCSI devices have only one LUN, and
-	  so most people can say N here and should in fact do so, because it
-	  is safer.
+	  so most people can say N here. The max_luns boot/module parameter=20
+	  allows to override this setting.
=20
 config SCSI_REPORT_LUNS
 	bool "Build with SCSI REPORT LUNS support"
diff -uNrp linux-2.6.5.scsi-orig/include/scsi/scsi_devinfo.h linux-2.6.5.de=
pr-forcelun/include/scsi/scsi_devinfo.h
--- linux-2.6.5.scsi-orig/include/scsi/scsi_devinfo.h	2004-04-04 05:36:14.0=
00000000 +0200
+++ linux-2.6.5.depr-forcelun/include/scsi/scsi_devinfo.h	2004-04-21 14:24:=
40.000000000 +0200
@@ -4,7 +4,8 @@
  * Flags for SCSI devices that need special treatment
  */
 #define BLIST_NOLUN     	0x001	/* Only scan LUN 0 */
-#define BLIST_FORCELUN  	0x002	/* Known to have LUNs, force scanning */
+#define BLIST_FORCELUN  	0x002	/* Known to have LUNs, force scanning,
+					   deprecated: Use max_luns=3DN */
 #define BLIST_BORKEN    	0x004	/* Flag for broken handshaking */
 #define BLIST_KEY       	0x008	/* unlock by special command */
 #define BLIST_SINGLELUN 	0x010	/* Do not use LUNs in parallel */

--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Description: scsi-scan-blist-replun.diff
Content-Disposition: attachment; filename=scsi-scan-blist_replun
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Cleanup/Feature

Remove CONFIG_SCSI_REPORT_LUNS config option.
Instead provide BLIST_NOREPORTLUN that can be passed as default_dev_flags
(but also per device if needed).
Provide BLIST_REPORTLUN2 that allows trying to use REPORT_LUNS for SCSI-2
devices, if they are connected to a host adapter supporting more than 8 LUNs
(and thus avoiding the usual USB crap to render this feature useless when
used with default_dev_flags).

 drivers/scsi/Kconfig        |   11 -----------
 drivers/scsi/scsi_scan.c    |   19 +++++++++----------
 include/scsi/scsi_devinfo.h |    3 +++
 3 files changed, 12 insertions(+), 21 deletions(-)

diff -uNrp linux-2.6.5/drivers/scsi/Kconfig linux-2.6.5.scsi-replun/drivers=
/scsi/Kconfig
--- linux-2.6.5/drivers/scsi/Kconfig	2004-05-19 00:44:04.000000000 +0200
+++ linux-2.6.5.scsi-replun/drivers/scsi/Kconfig	2004-05-19 00:52:04.000000=
000 +0200
@@ -170,17 +170,6 @@ config SCSI_MULTI_LUN
 	  so most people can say N here. The max_luns boot/module parameter=20
 	  allows to override this setting.
=20
-config SCSI_REPORT_LUNS
-	bool "Build with SCSI REPORT LUNS support"
-	depends on SCSI
-	default y
-	help
-	  If you want support for SCSI REPORT LUNS, say Y here.
-	  The REPORT LUNS command is useful for devices (such as disk arrays)
-	  with large numbers of LUNs where the LUN values are not contiguous
-	  (sparse LUN).  REPORT LUNS scanning is done only for SCSI-3 devices.
-	  Most users can safely answer N here.
-
 config SCSI_CONSTANTS
 	bool "Verbose SCSI error reporting (kernel size +=3D12K)"
 	depends on SCSI
diff -uNrp linux-2.6.5/drivers/scsi/scsi_scan.c linux-2.6.5.scsi-replun/dri=
vers/scsi/scsi_scan.c
--- linux-2.6.5/drivers/scsi/scsi_scan.c	2004-05-19 00:44:04.000000000 +0200
+++ linux-2.6.5.scsi-replun/drivers/scsi/scsi_scan.c	2004-05-19 00:52:04.00=
0000000 +0200
@@ -80,7 +80,6 @@ module_param_named(max_luns, max_scsi_lu
 MODULE_PARM_DESC(max_luns,
 		 "last scsi LUN (should be between 1 and 2^32-1)");
=20
-#ifdef CONFIG_SCSI_REPORT_LUNS
 /*
  * max_scsi_report_luns: the maximum number of LUNS that will be
  * returned from the REPORT LUNS command. 8 times this value must
@@ -88,13 +87,12 @@ MODULE_PARM_DESC(max_luns,
  * in practice, the maximum number of LUNs suppored by any device
  * is about 16k.
  */
-static unsigned int max_scsi_report_luns =3D 128;
+static unsigned int max_scsi_report_luns =3D 511;
=20
 module_param_named(max_report_luns, max_scsi_report_luns, int, S_IRUGO|S_I=
WUSR);
 MODULE_PARM_DESC(max_report_luns,
 		 "REPORT LUNS maximum number of LUNS received (should be"
 		 " between 1 and 16384)");
-#endif
=20
 /**
  * scsi_unlock_floptical - unlock device via a special MODE SENSE command
@@ -863,7 +861,6 @@ static void scsi_sequential_lun_scan(str
 			return;
 }
=20
-#ifdef CONFIG_SCSI_REPORT_LUNS
 /**
  * scsilun_to_int: convert a scsi_lun to an int
  * @scsilun:	struct scsi_lun to be converted.
@@ -924,9 +921,14 @@ static int scsi_report_lun_scan(struct s
 	u8 *data;
=20
 	/*
-	 * Only support SCSI-3 and up devices.
-	 */
-	if (sdev->scsi_level < SCSI_3)
+	 * Only support SCSI-3 and up devices if BLIST_NOREPORTLUN is not set.
+	 * Also allow SCSI-2 if BLIST_REPORTLUN2 is set and host adapter does
+	 * support more than 8 LUNs.
+	 */
+	if ((bflags & BLIST_NOREPORTLUN) ||=20
+	     sdev->scsi_level < SCSI_2 ||
+	    (sdev->scsi_level < SCSI_3 &&=20
+	     (!(bflags & BLIST_REPORTLUN2) || sdev->host->max_lun <=3D 8)) )
 		return 1;
 	if (bflags & BLIST_NOLUN)
 		return 0;
@@ -1090,9 +1092,6 @@ static int scsi_report_lun_scan(struct s
 	printk(ALLOC_FAILURE_MSG, __FUNCTION__);
 	return 0;
 }
-#else
-# define scsi_report_lun_scan(sdev, blags, rescan)	(1)
-#endif	/* CONFIG_SCSI_REPORT_LUNS */
=20
 struct scsi_device *scsi_add_device(struct Scsi_Host *shost,
 				    uint channel, uint id, uint lun)
diff -uNrp linux-2.6.5/include/scsi/scsi_devinfo.h linux-2.6.5.scsi-replun/=
include/scsi/scsi_devinfo.h
--- linux-2.6.5/include/scsi/scsi_devinfo.h	2004-05-19 00:44:04.000000000 +=
0200
+++ linux-2.6.5.scsi-replun/include/scsi/scsi_devinfo.h	2004-05-19 00:53:01=
=2E000000000 +0200
@@ -21,4 +21,7 @@
 #define BLIST_MS_SKIP_PAGE_3F	0x4000	/* do not send ms page 0x3f */
 #define BLIST_USE_10_BYTE_MS	0x8000	/* use 10 byte ms before 6 byte ms */
 #define BLIST_MS_192_BYTES_FOR_3F	0x10000	/*  192 byte ms page 0x3f reques=
t */
+#define BLIST_REPORTLUN2	0x20000	/* try REPORT_LUNS even for SCSI-2 devs
+ 					   (if HBA supports more than 8 LUNs) */
+#define BLIST_NOREPORTLUN	0x40000	/* don't try REPORT_LUNS scan (SCSI-3 de=
vs) */
 #endif

--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Description: scsi-scan-inq-timeout.diff
Content-Disposition: attachment; filename=scsi-scan-inq-timeout
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Feature

Make the timeout for INQUIRY during SCSI scan adjustable via boot parameter.
Note that the second INQUIRY does use a shorter timeout, as the long timeout
is for recovery from the initial reset, not because existing devices would
take so long to answer INQUIRY. SPC3 says that INQUIRY should be available
right away, but real life is different unfortunately.

diff -uNrp linux-2.6.5.dontattachoffl/drivers/scsi/scsi_scan.c linux-2.6.5.=
inq_timeout/drivers/scsi/scsi_scan.c
--- linux-2.6.5.dontattachoffl/drivers/scsi/scsi_scan.c	2004-04-21 14:28:13=
=2E000000000 +0200
+++ linux-2.6.5.inq_timeout/drivers/scsi/scsi_scan.c	2004-04-21 14:32:04.00=
0000000 +0200
@@ -94,6 +94,13 @@ MODULE_PARM_DESC(max_report_luns,
 		 "REPORT LUNS maximum number of LUNS received (should be"
 		 " between 1 and 16384)");
=20
+static unsigned int scsi_inq_timeout =3D SCSI_TIMEOUT/HZ+3;
+
+module_param_named(inq_timeout, scsi_inq_timeout, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(inq_timeout,=20
+		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
+		 " Default is 5. Some non-compliant devices need more.");
+
 /**
  * scsi_unlock_floptical - unlock device via a special MODE SENSE command
  * @sreq:	used to send the command
@@ -344,7 +351,7 @@ static void scsi_probe_lun(struct scsi_r
=20
 	memset(inq_result, 0, 36);
 	scsi_wait_req(sreq, (void *) scsi_cmd, (void *) inq_result, 36,
-		      SCSI_TIMEOUT + 4 * HZ, 3);
+		      HZ/2 + HZ*scsi_inq_timeout, 3);
=20
 	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: 1st INQUIRY %s with"
 			" code 0x%x\n", sreq->sr_result ?
@@ -393,7 +400,7 @@ static void scsi_probe_lun(struct scsi_r
 		memset(inq_result, 0, possible_inq_resp_len);
 		scsi_wait_req(sreq, (void *) scsi_cmd,
 			      (void *) inq_result,
-			      possible_inq_resp_len, SCSI_TIMEOUT + 4 * HZ, 3);
+			      possible_inq_resp_len, (1+scsi_inq_timeout)*(HZ/2), 3);
 		SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: 2nd INQUIRY"
 				" %s with code 0x%x\n", sreq->sr_result ?
 				"failed" : "successful", sreq->sr_result));

--rqzD5py0kzyFAOWN--

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq6x/xmLh6hyYd04RAjL5AKDB2Ye4awnNbO9ssFlcHDHRvQOv9ACfUqTp
aXn51kT7BgS1hmJBfRKcigs=
=0BPV
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
