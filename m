Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWCNXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWCNXIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWCNXIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:08:52 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:48830 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750739AbWCNXIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:08:52 -0500
Message-ID: <17431.19680.579155.54647@wombat.chubb.wattle.id.au>
Date: Wed, 15 Mar 2006 10:08:16 +1100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="glIxaG3R16"
Content-Transfer-Encoding: 7bit
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Daniel Drake <dsd@gentoo.org>
Cc: Greg KH <gregkh@suse.de>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org, autophile@starband.net, stern@rowland.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: HP CDRW CD4E hasn't worked since 2.6.11
In-Reply-To: <44174DA0.5020105@gentoo.org>
References: <17430.14259.90181.849542@berry.ken.nicta.com.au>
	<20060314221958.GD12257@suse.de>
	<44174DA0.5020105@gentoo.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--glIxaG3R16
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

>>>>> "Daniel" == Daniel Drake <dsd@gentoo.org> writes:

Daniel> Greg KH wrote:
>> On Tue, Mar 14, 2006 at 02:25:39PM +1100, Peter Chubb wrote:
>>> Hi Greg, The changes to the usb/storage/shuttle_usbat.c to
>>> accomodate flash drives appears to have broken CD R/W support.
>>> 
>>> Sorry it took me so long to report this; I don't use this
>>> particular device very often.
>>> 
>>> Compiling with verbose debug shows that the IDENTIFY_PACKET_DEVICE
>>> command is failing, so the device is mis-identified as a flash
>>> drive.
>>> 
>>> I went to the start of the Git history in Linus's tree; 2.6.12
>>> also fails.

Daniel> I think it may have worked for you on-and-off in the middle of
Daniel> those changes. It's been a nightmare trying to get both device
Daniel> types identified correctly.

>>> I tried to force the detection, to see if I could get past that
>>> point, but there are still problems -- see the attached logs --
>>> the device is recognised as a scsi disk not cdrom.

Daniel> Can you detail your changes? I'm not convinced by this,
Daniel> because I have been careful not to change any HP8200-specific
Daniel> code (except the detection), and also, I don't think it is
Daniel> possible for the device to appear as a disk if the HP8200
Daniel> codepath is being followed.


Patch appended.


--glIxaG3R16
Content-Type: text/plain
Content-Disposition: inline;
	filename="shuttle"
Content-Transfer-Encoding: 7bit

 drivers/usb/storage/shuttle_usbat.c |   86 +++++-------------------------------
 drivers/usb/storage/shuttle_usbat.h |    3 -
 drivers/usb/storage/unusual_devs.h  |    8 +--
 3 files changed, 18 insertions(+), 79 deletions(-)

Index: linux-2.6/drivers/usb/storage/shuttle_usbat.c
===================================================================
--- linux-2.6.orig/drivers/usb/storage/shuttle_usbat.c	2006-03-14 11:40:06.000000000 +1100
+++ linux-2.6/drivers/usb/storage/shuttle_usbat.c	2006-03-14 14:16:30.000000000 +1100
@@ -837,68 +837,23 @@
 }
 
 /*
- * Determine whether we are controlling a flash-based reader/writer,
- * or a HP8200-based CD drive.
- * Sets transport functions as appropriate.
- */
-static int usbat_identify_device(struct us_data *us,
-				 struct usbat_info *info)
-{
-	int rc;
-	unsigned char status;
-
-	if (!us || !info)
-		return USB_STOR_TRANSPORT_ERROR;
-
-	rc = usbat_device_reset(us);
-	if (rc != USB_STOR_TRANSPORT_GOOD)
-		return rc;
-	msleep(500);
-
-	/*
-	 * In attempt to distinguish between HP CDRW's and Flash readers, we now
-	 * execute the IDENTIFY PACKET DEVICE command. On ATA devices (i.e. flash
-	 * readers), this command should fail with error. On ATAPI devices (i.e.
-	 * CDROM drives), it should succeed.
-	 */
-	rc = usbat_write(us, USBAT_ATA, USBAT_ATA_CMD, 0xA1);
- 	if (rc != USB_STOR_XFER_GOOD)
- 		return USB_STOR_TRANSPORT_ERROR;
-
-	rc = usbat_get_status(us, &status);
- 	if (rc != USB_STOR_XFER_GOOD)
- 		return USB_STOR_TRANSPORT_ERROR;
-
-	/* Check for error bit, or if the command 'fell through' */
-	if (status == 0xA1 || !(status & 0x01)) {
-		/* Device is HP 8200 */
-		US_DEBUGP("usbat_identify_device: Detected HP8200 CDRW\n");
-		info->devicetype = USBAT_DEV_HP8200;
-	} else {
-		/* Device is a CompactFlash reader/writer */
-		US_DEBUGP("usbat_identify_device: Detected Flash reader/writer\n");
-		info->devicetype = USBAT_DEV_FLASH;
-	}
-
-	return USB_STOR_TRANSPORT_GOOD;
-}
-
-/*
  * Set the transport function based on the device type
  */
 static int usbat_set_transport(struct us_data *us,
-			       struct usbat_info *info)
+			       struct usbat_info *info,
+			       int devicetype)
 {
-	int rc;
-
 	if (!info->devicetype) {
-		rc = usbat_identify_device(us, info);
-		if (rc != USB_STOR_TRANSPORT_GOOD) {
-			US_DEBUGP("usbat_set_transport: Could not identify device\n");
-			return 1;
-		}
+		int rc = usbat_device_reset(us);
+		if (rc)
+			return rc;
+		msleep(500);
+		info->devicetype = devicetype;
 	}
 
+	if (!info->devicetype)
+		return USB_STOR_TRANSPORT_ERROR;
+
 	if (usbat_get_device_type(us) == USBAT_DEV_HP8200)
 		us->transport = usbat_hp8200e_transport;
 	else if (usbat_get_device_type(us) == USBAT_DEV_FLASH)
@@ -1310,7 +1265,7 @@
 /*
  * Initialize the USBAT processor and the storage device
  */
-int init_usbat(struct us_data *us)
+static int init_usbat(struct us_data *us, int devicetype)
 {
 	int rc;
 	struct usbat_info *info;
@@ -1393,7 +1348,7 @@
 	US_DEBUGP("INIT 9\n");
 
 	/* At this point, we need to detect which device we are using */
-	if (usbat_set_transport(us, info))
+	if (usbat_set_transport(us, info, devicetype))
 		return USB_STOR_TRANSPORT_ERROR;
 
 	US_DEBUGP("INIT 10\n");
@@ -1696,6 +1651,17 @@
 	return USB_STOR_TRANSPORT_FAILED;
 }
 
+int init_usbat_cd(struct us_data *us)
+{
+	return init_usbat(us, USBAT_DEV_HP8200);
+}
+
+
+int init_usbat_flash(struct us_data *us)
+{
+	return init_usbat(us, USBAT_DEV_FLASH);
+}
+
 /*
  * Default transport function. Attempts to detect which transport function
  * should be called, makes it the new default, and calls it.
@@ -1709,9 +1675,8 @@
 {
 	struct usbat_info *info = (struct usbat_info*) (us->extra);
 
-	if (usbat_set_transport(us, info))
+	if (usbat_set_transport(us, info, 0))
 		return USB_STOR_TRANSPORT_ERROR;
 
 	return us->transport(srb, us);	
 }
-
Index: linux-2.6/drivers/usb/storage/shuttle_usbat.h
===================================================================
--- linux-2.6.orig/drivers/usb/storage/shuttle_usbat.h	2006-03-14 11:40:06.000000000 +1100
+++ linux-2.6/drivers/usb/storage/shuttle_usbat.h	2006-03-14 12:53:25.000000000 +1100
@@ -106,7 +106,8 @@
 #define USBAT_FEAT_ET2	0x01
 
 extern int usbat_transport(struct scsi_cmnd *srb, struct us_data *us);
-extern int init_usbat(struct us_data *us);
+extern int init_usbat_cd(struct us_data *us);
+extern int init_usbat_flash(struct us_data *us);
 
 struct usbat_info {
 	int devicetype;
Index: linux-2.6/drivers/usb/storage/unusual_devs.h
===================================================================
--- linux-2.6.orig/drivers/usb/storage/unusual_devs.h	2006-03-14 11:40:06.000000000 +1100
+++ linux-2.6/drivers/usb/storage/unusual_devs.h	2006-03-14 12:56:49.000000000 +1100
@@ -71,12 +71,12 @@
 UNUSUAL_DEV(  0x03f0, 0x0207, 0x0001, 0x0001, 
 		"HP",
 		"CD-Writer+ 8200e",
-		US_SC_8070, US_PR_USBAT, init_usbat, 0),
+		US_SC_8070, US_PR_USBAT, init_usbat_cd, 0),
 
 UNUSUAL_DEV(  0x03f0, 0x0307, 0x0001, 0x0001, 
 		"HP",
 		"CD-Writer+ CD-4e",
-		US_SC_8070, US_PR_USBAT, init_usbat, 0),
+		US_SC_8070, US_PR_USBAT, init_usbat_cd, 0),
 #endif
 
 /* Reported by Sebastian Kapfer <sebastian_kapfer@gmx.net>
@@ -380,7 +380,7 @@
 UNUSUAL_DEV(  0x04e6, 0x1010, 0x0000, 0x9999,
 		"Shuttle/SCM",
 		"USBAT-02",
-		US_SC_SCSI, US_PR_USBAT, init_usbat,
+		US_SC_SCSI, US_PR_USBAT, init_usbat_flash,
 		US_FL_SINGLE_LUN),
 #endif
 
@@ -770,7 +770,7 @@
 UNUSUAL_DEV(  0x0781, 0x0005, 0x0005, 0x0005,
 		"Sandisk",
 		"ImageMate SDDR-05b",
-		US_SC_SCSI, US_PR_USBAT, init_usbat,
+		US_SC_SCSI, US_PR_USBAT, init_usbat_flash,
 		US_FL_SINGLE_LUN ),
 #endif
 

--glIxaG3R16
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit



-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia

--glIxaG3R16--
