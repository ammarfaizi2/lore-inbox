Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVCVSn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVCVSn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCVSn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:43:27 -0500
Received: from mail0.lsil.com ([147.145.40.20]:37320 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261631AbVCVSlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:41:07 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01AEB0A8@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
Subject: [PATCH] - Fusion-MPT much faster as module
Date: Tue, 22 Mar 2005 11:40:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C52F0E.ADC8E900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C52F0E.ADC8E900
Content-Type: text/plain;
	charset="iso-8859-1"

Here is a patch for mpt fusion drivers, which
fix's issue of poor performance when driver compiled
built-in to the kernel.

Thanks to Chen, Kenneth W.

History on this:
Between the 3.01.16 and 3.01.18, we introduced new method
to passing command line options to the driver.  Some of the
command line options are used for fine tuning dv(domain
validation) in the driver.  By accident, these command line options were
wrapped around #ifdef MODULE in the 3.01.18 version of the driver.
What this meant is when the driver is compiled built-in the kernel,
the optimal settings for dv were ignored, thus poor performance.  

There was actually a fix for this when I submitted SAS drivers
to the mailing list back in November, however the SAS drivers was
rejected, and later on I overlooked submitting a single patch to 
solve this.

Please apply this patch against the 3.01.19 version of the mpt driver
in http://linux-scsi.bkbits.net:8080/scsi-misc-2.6

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>





------_=_NextPart_000_01C52F0E.ADC8E900
Content-Type: application/octet-stream;
	name="mptlinux-3.01.20"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.01.20"

diff -uarN drivers/message/fusion-3.01.19/mptbase.h =
drivers/message/fusion/mptbase.h=0A=
--- drivers/message/fusion-3.01.19/mptbase.h	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptbase.h	2005-03-22 10:44:24.000000000 =
-0700=0A=
@@ -83,8 +83,8 @@=0A=
 #define COPYRIGHT	"Copyright (c) 1999-2004 " MODULEAUTHOR=0A=
 #endif=0A=
 =0A=
-#define MPT_LINUX_VERSION_COMMON	"3.01.19"=0A=
-#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.01.19"=0A=
+#define MPT_LINUX_VERSION_COMMON	"3.01.20"=0A=
+#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.01.20"=0A=
 #define WHAT_MAGIC_STRING		"@" "(" "#" ")"=0A=
 =0A=
 #define show_mptmod_ver(s,ver)  \=0A=
diff -uarN drivers/message/fusion-3.01.19/mptscsih.c =
drivers/message/fusion/mptscsih.c=0A=
--- drivers/message/fusion-3.01.19/mptscsih.c	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptscsih.c	2005-03-22 10:51:55.000000000 =
-0700=0A=
@@ -96,23 +96,26 @@=0A=
 MODULE_DESCRIPTION(my_NAME);=0A=
 MODULE_LICENSE("GPL");=0A=
 =0A=
-#ifdef MODULE=0A=
-static int dv =3D MPTSCSIH_DOMAIN_VALIDATION;=0A=
-module_param(dv, int, 0);=0A=
-MODULE_PARM_DESC(dv, "DV Algorithm: enhanced =3D 1, basic =3D 0 =
(default=3DMPTSCSIH_DOMAIN_VALIDATION=3D1)");=0A=
-=0A=
-static int width =3D MPTSCSIH_MAX_WIDTH;=0A=
-module_param(width, int, 0);=0A=
-MODULE_PARM_DESC(width, "Max Bus Width: wide =3D 1, narrow =3D 0 =
(default=3DMPTSCSIH_MAX_WIDTH=3D1)");=0A=
-=0A=
-static ushort factor =3D MPTSCSIH_MIN_SYNC;=0A=
-module_param(factor, ushort, 0);=0A=
-MODULE_PARM_DESC(factor, "Min Sync Factor: =
(default=3DMPTSCSIH_MIN_SYNC=3D0x08)");=0A=
-=0A=
-static int saf_te =3D MPTSCSIH_SAF_TE;=0A=
-module_param(saf_te, int, 0);=0A=
-MODULE_PARM_DESC(saf_te, "Force enabling SEP Processor: =
(default=3DMPTSCSIH_SAF_TE=3D0)");=0A=
-#endif=0A=
+/* Command line args */=0A=
+static int mpt_dv =3D MPTSCSIH_DOMAIN_VALIDATION;=0A=
+MODULE_PARM(mpt_dv, "i");=0A=
+MODULE_PARM_DESC(mpt_dv, " DV Algorithm: enhanced=3D1, basic=3D0 =
(default=3DMPTSCSIH_DOMAIN_VALIDATION=3D1)");=0A=
+=0A=
+static int mpt_width =3D MPTSCSIH_MAX_WIDTH;=0A=
+MODULE_PARM(mpt_width, "i");=0A=
+MODULE_PARM_DESC(mpt_width, " Max Bus Width: wide=3D1, narrow=3D0 =
(default=3DMPTSCSIH_MAX_WIDTH=3D1)");=0A=
+=0A=
+static int mpt_factor =3D MPTSCSIH_MIN_SYNC;=0A=
+MODULE_PARM(mpt_factor, "h");=0A=
+MODULE_PARM_DESC(mpt_factor, " Min Sync Factor =
(default=3DMPTSCSIH_MIN_SYNC=3D0x08)");=0A=
+=0A=
+static int mpt_saf_te =3D MPTSCSIH_SAF_TE;=0A=
+MODULE_PARM(mpt_saf_te, "i");=0A=
+MODULE_PARM_DESC(mpt_saf_te, " Force enabling SEP Processor: =
enable=3D1  (default=3DMPTSCSIH_SAF_TE=3D0)");=0A=
+=0A=
+static int mpt_pq_filter =3D 0;=0A=
+MODULE_PARM(mpt_pq_filter, "i");=0A=
+MODULE_PARM_DESC(mpt_pq_filter, " Enable peripheral qualifier filter: =
enable=3D1  (default=3D0)");=0A=
 =0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 =0A=
@@ -253,7 +256,6 @@=0A=
 =0A=
 /* Driver command line structure=0A=
  */=0A=
-static struct mptscsih_driver_setup driver_setup;=0A=
 static struct scsi_host_template driver_template;=0A=
 =0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
@@ -1224,29 +1226,23 @@=0A=
 		/* Update with the driver setup=0A=
 		 * values.=0A=
 		 */=0A=
-		if (ioc->spi_data.maxBusWidth >=0A=
-		  driver_setup.max_width) {=0A=
-			ioc->spi_data.maxBusWidth =3D=0A=
-			  driver_setup.max_width;=0A=
-		}=0A=
-=0A=
-		if (ioc->spi_data.minSyncFactor <=0A=
-		  driver_setup.min_sync_factor) {=0A=
-			ioc->spi_data.minSyncFactor =3D=0A=
-			  driver_setup.min_sync_factor;=0A=
-		}=0A=
+		if (ioc->spi_data.maxBusWidth > mpt_width)=0A=
+			ioc->spi_data.maxBusWidth =3D mpt_width;=0A=
+		if (ioc->spi_data.minSyncFactor < mpt_factor)=0A=
+			ioc->spi_data.minSyncFactor =3D mpt_factor;=0A=
 =0A=
 		if (ioc->spi_data.minSyncFactor =3D=3D MPT_ASYNC) {=0A=
 			ioc->spi_data.maxSyncOffset =3D 0;=0A=
 		}=0A=
 =0A=
-		ioc->spi_data.Saf_Te =3D driver_setup.saf_te;=0A=
+		ioc->spi_data.Saf_Te =3D mpt_saf_te;=0A=
 =0A=
 		hd->negoNvram =3D 0;=0A=
 #ifndef MPTSCSIH_ENABLE_DOMAIN_VALIDATION=0A=
 		hd->negoNvram =3D MPT_SCSICFG_USE_NVRAM;=0A=
 #endif=0A=
 		ioc->spi_data.forceDv =3D 0;=0A=
+		ioc->spi_data.noQas =3D 0;=0A=
 		for (ii=3D0; ii < MPT_MAX_SCSI_DEVICES; ii++) {=0A=
 			ioc->spi_data.dvStatus[ii] =3D=0A=
 			  MPT_SCSICFG_NEGOTIATE;=0A=
@@ -1256,12 +1252,12 @@=0A=
 			ioc->spi_data.dvStatus[ii] |=3D=0A=
 			  MPT_SCSICFG_DV_NOT_DONE;=0A=
 =0A=
-		ddvprintk((MYIOC_s_INFO_FMT=0A=
+		dinitprintk((MYIOC_s_INFO_FMT=0A=
 			"dv %x width %x factor %x saf_te %x\n",=0A=
-			ioc->name, driver_setup.dv,=0A=
-			driver_setup.max_width,=0A=
-			driver_setup.min_sync_factor,=0A=
-			driver_setup.saf_te));=0A=
+			ioc->name, mpt_dv,=0A=
+			mpt_width,=0A=
+			mpt_factor,=0A=
+			mpt_saf_te));=0A=
 	}=0A=
 =0A=
 	mpt_scsi_hosts++;=0A=
@@ -1477,18 +1473,6 @@=0A=
 		  ": Registered for IOC reset notifications\n"));=0A=
 	}=0A=
 =0A=
-#ifdef MODULE=0A=
-	dinitprintk((KERN_INFO MYNAM=0A=
-		": Command Line Args: dv=3D%d max_width=3D%d "=0A=
-		"factor=3D0x%x saf_te=3D%d\n",=0A=
-		dv, width, factor, saf_te));=0A=
-=0A=
-	driver_setup.dv =3D (dv) ? 1 : 0;=0A=
-	driver_setup.max_width =3D (width) ? 1 : 0;=0A=
-	driver_setup.min_sync_factor =3D factor;=0A=
-	driver_setup.saf_te =3D (saf_te) ? 1 : 0;;=0A=
-#endif=0A=
-=0A=
 	if(mpt_device_driver_register(&mptscsih_driver,=0A=
 	  MPTSCSIH_DRIVER) !=3D 0 ) {=0A=
 		dprintk((KERN_INFO MYNAM=0A=
@@ -3165,6 +3149,18 @@=0A=
 	dinitprintk((MYIOC_s_INFO_FMT "initTarget bus=3D%d id=3D%d lun=3D%d =
hd=3D%p\n",=0A=
 			hd->ioc->name, bus_id, target_id, lun, hd));=0A=
 =0A=
+	/*=0A=
+	 * If the peripheral qualifier filter is enabled then if the target =
reports a 0x1=0A=
+	 * (i.e. The targer is capable of supporting the specified peripheral =
device type=0A=
+	 * on this logical unit; however, the physical device is not =
currently connected=0A=
+	 * to this logical unit) it will be converted to a 0x3 (i.e. The =
target is not =0A=
+	 * capable of supporting a physical device on this logical unit). =
This is to work=0A=
+	 * around a bug in th emid-layer in some distributions in which the =
mid-layer will=0A=
+	 * continue to try to communicate to the LUN and evntually create a =
dummy LUN.=0A=
+	*/=0A=
+	if (mpt_pq_filter && dlen && (data[0] & 0xE0))=0A=
+		data[0] |=3D 0x40;=0A=
+	=0A=
 	/* Is LUN supported? If so, upper 2 bits will be 0=0A=
 	* in first byte of inquiry data.=0A=
 	*/=0A=
@@ -5161,7 +5157,7 @@=0A=
 	}=0A=
 	ddvprintk((MYIOC_s_NOTE_FMT "DV: Basic test on id=3D%d completed =
OK.\n", ioc->name, id));=0A=
 =0A=
-	if (driver_setup.dv =3D=3D 0)=0A=
+	if (mpt_dv =3D=3D 0)=0A=
 		goto target_done;=0A=
 =0A=
 	inq0 =3D (*pbuf1) & 0x1F;=0A=
diff -uarN drivers/message/fusion-3.01.19/mptscsih.h =
drivers/message/fusion/mptscsih.h=0A=
--- drivers/message/fusion-3.01.19/mptscsih.h	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptscsih.h	2005-03-22 10:50:14.000000000 =
-0700=0A=
@@ -91,12 +91,4 @@=0A=
 #define MPTSCSIH_MIN_SYNC               0x08=0A=
 #define MPTSCSIH_SAF_TE                 0=0A=
 =0A=
-struct mptscsih_driver_setup=0A=
-{=0A=
-        u8      dv;=0A=
-        u8      max_width;=0A=
-        u8      min_sync_factor;=0A=
-        u8      saf_te;=0A=
-};=0A=
-=0A=
 #endif=0A=

------_=_NextPart_000_01C52F0E.ADC8E900--
