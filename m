Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289737AbSAJW2t>; Thu, 10 Jan 2002 17:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289736AbSAJW2l>; Thu, 10 Jan 2002 17:28:41 -0500
Received: from daytona.gci.com ([205.140.80.57]:41483 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S289734AbSAJW2b>;
	Thu, 10 Jan 2002 17:28:31 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA315077C358B@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] ScanLogic USB-ATAPI Adapter, please apply
Date: Thu, 10 Jan 2002 13:28:12 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C19A26.16A96700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C19A26.16A96700
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Attched are updated patches for 2.4.18-pre3

Matt, please apply.

> Session Start (ICQ - 3749190:mantis): Wed Jan 09 08:20:42 2002
> *** NOTE: This user is offline.
> *** Your messages will be received when he/she logs into ICQ.
> HepCat: Dylan -- Did you get a chance to try that last patch?
> It looks like everybody's working -- you're the last person to report =
in!
> Session Close (mantis): Wed Jan 09 08:21:15 2002
> Session Start (ICQ - 3749190:mantis): Wed Jan 09 15:48:11 2002
> mantis: heya..... yeh i tried it and it works
> mantis: i can load my cdrw drive

on Wed Jan 9, 2002 at 2:01AM, Peter W=E4chtler wrote:=20
> The Transcend cardreader still works with the patch.=20
> So for me the patch does not hurt.

on Tue Jan 8, 2002 at 3:14PM, Rene Engelhard wrote:
> IT WORKS! Due to that I assume at Dylan that will also work.
> If Leifs and Peters dev also are working we did it...


diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/transport.c
linux/drivers/usb/storage/transport.c
--- linux-2.4.18-pre3/drivers/usb/storage/transport.c	Thu Jan 10 =
13:08:18
2002
+++ linux/drivers/usb/storage/transport.c	Thu Jan 10 13:13:36 2002
@@ -1157,7 +1157,7 @@
 		  le32_to_cpu(bcs.Signature), bcs.Tag,=20
 		  bcs.Residue, bcs.Status);
 	if (bcs.Signature !=3D cpu_to_le32(US_BULK_CS_SIGN) ||=20
-	    bcs.Tag !=3D bcb.Tag ||=20
+	    ((bcs.Tag !=3D bcb.Tag ) && (!(us->flags & US_FL_SL_IDE_BUG))) || =

 	    bcs.Status > US_BULK_STAT_PHASE || partial !=3D 13) {
 		US_DEBUGP("Bulk logical error\n");
 		return USB_STOR_TRANSPORT_ERROR;
diff -u --recursive =
linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.h
linux/drivers/usb/storage/unusual_devs.h
--- linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.h	Thu Jan 10
13:08:18 2002
+++ linux/drivers/usb/storage/unusual_devs.h	Thu Jan 10 13:13:36 2002
@@ -110,6 +110,28 @@
                "LS-120 Camera",
                US_SC_UFI, US_PR_CBI, NULL, 0),
=20
+/* Reported by Peter W=E4chtler <pwaechtler@loewe-komp.de> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
+		"ScanLogic",
+		"SL11R-IDE 0049SQFP-1.2 A002",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY ),
+
+/* Reported by Leif Sawyer <leif@gci.net> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0240, 0x0240,
+		"H45 ScanLogic",
+		"SL11R-IDE 9951SQFP-1.2 K004",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_SL_IDE_BUG ),
+
+/* Reported by Rene Engelhard <mail@rene-engelhard.de> and
+    Dylan Egan <crack_me@bigpond.com.au> */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0260, 0x0260,
+		"ScanLogic",
+		"SL11R-IDE unknown HW rev",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_SL_IDE_BUG ),
+
 /* Most of the following entries were developed with the help of
  * Shuttle/SCM directly.
  */
diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/usb.h
linux/drivers/usb/storage/usb.h
--- linux-2.4.18-pre3/drivers/usb/storage/usb.h	Thu Nov 22 10:49:34 =
2001
+++ linux/drivers/usb/storage/usb.h	Thu Jan 10 13:13:36 2002
@@ -101,6 +101,7 @@
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number =
given
*/
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets =
*/
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs =
fixing
*/
+#define US_FL_SL_IDE_BUG      0x00000100 /* ScanLogic usb-ide =
workaround */
=20
 #define USB_STOR_STRING_LEN 32
=20


------_=_NextPart_000_01C19A26.16A96700
Content-Type: application/octet-stream;
	name="usbat-2.4.18-pre3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="usbat-2.4.18-pre3.diff"

diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/transport.c =
linux/drivers/usb/storage/transport.c=0A=
--- linux-2.4.18-pre3/drivers/usb/storage/transport.c	Thu Jan 10 =
13:08:18 2002=0A=
+++ linux/drivers/usb/storage/transport.c	Thu Jan 10 13:13:36 2002=0A=
@@ -1157,7 +1157,7 @@=0A=
 		  le32_to_cpu(bcs.Signature), bcs.Tag, =0A=
 		  bcs.Residue, bcs.Status);=0A=
 	if (bcs.Signature !=3D cpu_to_le32(US_BULK_CS_SIGN) || =0A=
-	    bcs.Tag !=3D bcb.Tag || =0A=
+	    ((bcs.Tag !=3D bcb.Tag ) && (!(us->flags & US_FL_SL_IDE_BUG))) || =
=0A=
 	    bcs.Status > US_BULK_STAT_PHASE || partial !=3D 13) {=0A=
 		US_DEBUGP("Bulk logical error\n");=0A=
 		return USB_STOR_TRANSPORT_ERROR;=0A=
diff -u --recursive =
linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.h =
linux/drivers/usb/storage/unusual_devs.h=0A=
--- linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.h	Thu Jan 10 =
13:08:18 2002=0A=
+++ linux/drivers/usb/storage/unusual_devs.h	Thu Jan 10 13:13:36 =
2002=0A=
@@ -110,6 +110,28 @@=0A=
                "LS-120 Camera",=0A=
                US_SC_UFI, US_PR_CBI, NULL, 0),=0A=
 =0A=
+/* Reported by Peter W=E4chtler <pwaechtler@loewe-komp.de> */=0A=
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,=0A=
+		"ScanLogic",=0A=
+		"SL11R-IDE 0049SQFP-1.2 A002",=0A=
+		US_SC_SCSI, US_PR_BULK, NULL,=0A=
+		US_FL_FIX_INQUIRY ),=0A=
+=0A=
+/* Reported by Leif Sawyer <leif@gci.net> */=0A=
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0240, 0x0240,=0A=
+		"H45 ScanLogic",=0A=
+		"SL11R-IDE 9951SQFP-1.2 K004",=0A=
+		US_SC_SCSI, US_PR_BULK, NULL,=0A=
+		US_FL_FIX_INQUIRY | US_FL_SL_IDE_BUG ),=0A=
+=0A=
+/* Reported by Rene Engelhard <mail@rene-engelhard.de> and=0A=
+    Dylan Egan <crack_me@bigpond.com.au> */=0A=
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0260, 0x0260,=0A=
+		"ScanLogic",=0A=
+		"SL11R-IDE unknown HW rev",=0A=
+		US_SC_SCSI, US_PR_BULK, NULL,=0A=
+		US_FL_SL_IDE_BUG ),=0A=
+=0A=
 /* Most of the following entries were developed with the help of=0A=
  * Shuttle/SCM directly.=0A=
  */=0A=
diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/usb.h =
linux/drivers/usb/storage/usb.h=0A=
--- linux-2.4.18-pre3/drivers/usb/storage/usb.h	Thu Nov 22 10:49:34 =
2001=0A=
+++ linux/drivers/usb/storage/usb.h	Thu Jan 10 13:13:36 2002=0A=
@@ -101,6 +101,7 @@=0A=
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number =
given  */=0A=
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets =
*/=0A=
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs =
fixing */=0A=
+#define US_FL_SL_IDE_BUG      0x00000100 /* ScanLogic usb-ide =
workaround */=0A=
 =0A=
 #define USB_STOR_STRING_LEN 32=0A=
 =0A=

------_=_NextPart_000_01C19A26.16A96700--
