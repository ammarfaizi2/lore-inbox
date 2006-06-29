Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932933AbWF2VvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWF2VvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWF2VuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:50:21 -0400
Received: from mx.pathscale.com ([64.160.42.68]:39055 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932909AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 32 of 39] IB/ipath - support more models of InfiniPath hardware
X-Mercurial-Node: 8fbb5d71823abafe963a925afd41e339ddd4ebc3
Message-Id: <8fbb5d71823abafe963a.1151617283@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:23 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do a few more explicit checks for specific models, and now also
support the old PathScale serial number style, or new QLogic style.

This is backwards compatible with previous versions of software and
hardware.  That is, older software will see a plausible serial number
and correct GUID when used with a new board, while newer software will
correctly handle an older board.

Signed-off-by: Mike Albaugh <mike.albaugh@qlogic.com>
Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 21378f21e091 -r 8fbb5d71823a drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
@@ -476,7 +476,7 @@ struct ipath_sma_pkt
  * Data layout in I2C flash (for GUID, etc.)
  * All fields are little-endian binary unless otherwise stated
  */
-#define IPATH_FLASH_VERSION 1
+#define IPATH_FLASH_VERSION 2
 struct ipath_flash {
 	/* flash layout version (IPATH_FLASH_VERSION) */
 	__u8 if_fversion;
@@ -484,14 +484,14 @@ struct ipath_flash {
 	__u8 if_csum;
 	/*
 	 * valid length (in use, protected by if_csum), including
-	 * if_fversion and if_sum themselves)
+	 * if_fversion and if_csum themselves)
 	 */
 	__u8 if_length;
 	/* the GUID, in network order */
 	__u8 if_guid[8];
 	/* number of GUIDs to use, starting from if_guid */
 	__u8 if_numguid;
-	/* the board serial number, in ASCII */
+	/* the (last 10 characters of) board serial number, in ASCII */
 	char if_serial[12];
 	/* board mfg date (YYYYMMDD ASCII) */
 	char if_mfgdate[8];
@@ -503,8 +503,10 @@ struct ipath_flash {
 	__u8 if_powerhour[2];
 	/* ASCII free-form comment field */
 	char if_comment[32];
-	/* 78 bytes used, min flash size is 128 bytes */
-	__u8 if_future[50];
+	/* Backwards compatible prefix for longer QLogic Serial Numbers */
+	char if_sprefix[4];
+	/* 82 bytes used, min flash size is 128 bytes */
+	__u8 if_future[46];
 };
 
 /*
diff -r 21378f21e091 -r 8fbb5d71823a drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
@@ -602,8 +602,31 @@ void ipath_get_eeprom_info(struct ipath_
 		guid = *(__be64 *) ifp->if_guid;
 	dd->ipath_guid = guid;
 	dd->ipath_nguid = ifp->if_numguid;
-	memcpy(dd->ipath_serial, ifp->if_serial,
-	       sizeof(ifp->if_serial));
+	/*
+	 * Things are slightly complicated by the desire to transparently
+	 * support both the Pathscale 10-digit serial number and the QLogic
+	 * 13-character version.
+	 */
+	if ((ifp->if_fversion > 1) && ifp->if_sprefix[0]
+		&& ((u8 *)ifp->if_sprefix)[0] != 0xFF) {
+		/* This board has a Serial-prefix, which is stored
+		 * elsewhere for backward-compatibility.
+		 */
+		char *snp = dd->ipath_serial;
+		int len;
+		memcpy(snp, ifp->if_sprefix, sizeof ifp->if_sprefix);
+		snp[sizeof ifp->if_sprefix] = '\0';
+		len = strlen(snp);
+		snp += len;
+		len = (sizeof dd->ipath_serial) - len;
+		if (len > sizeof ifp->if_serial) {
+			len = sizeof ifp->if_serial; 
+		}
+		memcpy(snp, ifp->if_serial, len);
+	} else
+		memcpy(dd->ipath_serial, ifp->if_serial,
+		       sizeof ifp->if_serial);
+	
 	ipath_cdbg(VERBOSE, "Initted GUID to %llx from eeprom\n",
 		   (unsigned long long) be64_to_cpu(dd->ipath_guid));
 
diff -r 21378f21e091 -r 8fbb5d71823a drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
@@ -491,8 +491,11 @@ struct ipath_devdata {
 	u16 ipath_lid;
 	/* list of pkeys programmed; 0 if not set */
 	u16 ipath_pkeys[4];
-	/* ASCII serial number, from flash */
-	u8 ipath_serial[12];
+	/*
+	 * ASCII serial number, from flash, large enough for original
+	 * all digit strings, and longer QLogic serial number format
+	 */
+	u8 ipath_serial[16];
 	/* human readable board version */
 	u8 ipath_boardversion[80];
 	/* chip major rev, from ipath_revision */
diff -r 21378f21e091 -r 8fbb5d71823a drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Thu Jun 29 14:33:26 2006 -0700
@@ -533,7 +533,7 @@ static int ipath_pe_boardname(struct ipa
 	if (n)
 		snprintf(name, namelen, "%s", n);
 
-	if (dd->ipath_majrev != 4 || dd->ipath_minrev != 1) {
+	if (dd->ipath_majrev != 4 || !dd->ipath_minrev || dd->ipath_minrev>2) {
 		ipath_dev_err(dd, "Unsupported PE-800 revision %u.%u!\n",
 			      dd->ipath_majrev, dd->ipath_minrev);
 		ret = 1;
