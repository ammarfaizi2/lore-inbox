Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKFD2n>; Mon, 5 Nov 2001 22:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281446AbRKFD2e>; Mon, 5 Nov 2001 22:28:34 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:38149
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S277738AbRKFD2U>; Mon, 5 Nov 2001 22:28:20 -0500
Date: Mon, 5 Nov 2001 19:28:04 -0800
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
        Kernel Developer List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: USB Storage List <usb-storage@one-eyed-alien.net>
Subject: PATCH: usb-storage: bugfixes for Freecom driver
Message-ID: <20011105192804.A22349@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	Kernel Developer List <linux-kernel@vger.redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	USB Storage List <usb-storage@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch to the usb-storage driver.  Linus and Alan, please
apply.  The patch is against 2.4.14.

Sorry for not sending this patch in time for 2.4.14, but it needed more
testing than time allowed.

This patch resolves the problems with detecting and initializing devices
behind a Freecom USB/ATA bridge, as well as problems with transfer length
calculations which were affecting CD-ROM users.  The algorithm implemented
for initialization is the one recommended by Freecom based on their
experience with a wide variety of devices -- it's sub-optimal in many
cases, but you often can't identify those cases until much later.

As a side note, this is a great example of why the scsi command structure
needs a request_tranferlen as well as the existing request_bufflen fields.
It would be much easier all around if the various drivers told the
low-level controllers how much data to expect to move, in addition to the
total buffer allocation (which is always as big or larger).

I'm still working on a patch to resolve the one last issue with this
driver, where the driver fails if a command takes longer than 20 seconds to
execute.  The bug is in the code that's supposed to recover from a device
timeout (the bridge has a 20 sec internal timeout), but it doesn't work
right.  I'm working with Freecom on this, and should have a patch soon.

Matthew Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch20011105
Content-Transfer-Encoding: quoted-printable

Only in linux-2.4.14/drivers/usb/storage: CVS
diff -u linux-2.4.14/drivers/usb/storage.old/freecom.c linux-2.4.14/drivers=
/usb/storage/freecom.c
--- linux-2.4.14/drivers/usb/storage.old/freecom.c	Sun Jul 29 21:11:50 2001
+++ linux-2.4.14/drivers/usb/storage/freecom.c	Sun Nov  4 05:01:17 2001
@@ -1,6 +1,6 @@
 /* Driver for Freecom USB/IDE adaptor
  *
- * $Id: freecom.c,v 1.15 2001/06/27 23:50:28 mdharm Exp $
+ * $Id: freecom.c,v 1.18 2001/11/04 13:01:17 mdharm Exp $
  *
  * Freecom v0.1:
  *
@@ -132,6 +132,12 @@
 		sg =3D (struct scatterlist *) srb->request_buffer;
 		for (i =3D 0; i < srb->use_sg; i++) {
=20
+			US_DEBUGP("transfer_amount: %d and total_transferred: %d\n", transfer_a=
mount, total_transferred);
+
+			/* End this if we're done */
+			if (transfer_amount =3D=3D total_transferred)
+				break;
+
 			/* transfer the lesser of the next buffer or the
 			 * remaining data */
 			if (transfer_amount - total_transferred >=3D=20
@@ -139,10 +145,12 @@
 				result =3D usb_stor_transfer_partial(us,
 						sg[i].address, sg[i].length);
 				total_transferred +=3D sg[i].length;
-			} else
+			} else {
 				result =3D usb_stor_transfer_partial(us,
 						sg[i].address,
 						transfer_amount - total_transferred);
+				total_transferred +=3D transfer_amount - total_transferred;
+			}
=20
 			/* if we get an error, end the loop here */
 			if (result)
@@ -158,7 +166,7 @@
 	srb->result =3D result;
 }
=20
-
+#if 0
 /* Write a value to an ide register. */
 static int
 freecom_ide_write (struct us_data *us, int reg, int value)
@@ -255,6 +263,7 @@
=20
         return USB_STOR_TRANSPORT_GOOD;
 }
+#endif
=20
 static int
 freecom_readdata (Scsi_Cmnd *srb, struct us_data *us,
@@ -470,13 +479,15 @@
         US_DEBUGP("Device indicates that it has %d bytes available\n",
                         le16_to_cpu (fst->Count));
=20
-        /* Find the length we desire to read.  It is the lesser of the SCSI
-         * layer's requested length, and the length the device claims to
-         * have available. */
+        /* Find the length we desire to read. */
         length =3D usb_stor_transfer_length (srb);
         US_DEBUGP("SCSI requested %d\n", length);
-        if (length > le16_to_cpu (fst->Count))
-                length =3D le16_to_cpu (fst->Count);
+
+	/* verify that this amount is legal */
+	if (length > srb->request_bufflen) {
+		length =3D srb->request_bufflen;
+		US_DEBUGP("Truncating request to match buffer length: %d\n", length);
+	}
=20
         /* What we do now depends on what direction the data is supposed to
          * move in. */
@@ -522,7 +533,6 @@
                 if (result !=3D USB_STOR_TRANSPORT_GOOD)
                         return result;
=20
-#if 1
                 US_DEBUGP("FCM: Waiting for status\n");
                 result =3D usb_stor_bulk_msg (us, fst, ipipe,
                                 FCM_PACKET_LENGTH, &partial);
@@ -540,7 +550,7 @@
                         US_DEBUGP("Drive seems still hungry\n");
                         return USB_STOR_TRANSPORT_FAILED;
                 }
-#endif
+
                 US_DEBUGP("Transfer happy\n");
                 break;
=20
@@ -570,8 +580,7 @@
 int
 freecom_init (struct us_data *us)
 {
-        int result, value;
-        int counter;
+        int result;
 	char buffer[33];
=20
         /* Allocate a buffer for us.  The upper usb transport code will
@@ -591,42 +600,29 @@
 	buffer[32] =3D '\0';
 	US_DEBUGP("String returned from FC init is: %s\n", buffer);
=20
-        result =3D freecom_ide_write (us, 0x06, 0xA0);
-        if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                return result;
-        result =3D freecom_ide_write (us, 0x01, 0x00);
-        if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                return result;
-
-        counter =3D 50;
-        do {
-                result =3D freecom_ide_read (us, 0x07, &value);
-                if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                        return result;
-                if (counter-- < 0) {
-                        US_DEBUGP("Timeout in freecom");
-                        return USB_STOR_TRANSPORT_ERROR;
-                }
-        } while ((value & 0x80) !=3D 0);
+	/* Special thanks to the people at Freecom for providing me with
+	 * this "magic sequence", which they use in their Windows and MacOS
+	 * drivers to make sure that all the attached perhiperals are
+	 * properly reset.
+	 */
=20
-        result =3D freecom_ide_write (us, 0x07, 0x08);
-        if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                return result;
-
-        counter =3D 50;
-        do {
-                result =3D freecom_ide_read (us, 0x07, &value);
-                if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                        return result;
-                if (counter-- < 0) {
-                        US_DEBUGP("Timeout in freecom");
-                        return USB_STOR_TRANSPORT_ERROR;
-                }
-        } while ((value & 0x80) !=3D 0);
+	/* send reset */
+	result =3D usb_control_msg(us->pusb_dev,
+			usb_sndctrlpipe(us->pusb_dev, 0),
+			0x4d, 0x40, 0x24d8, 0x0, NULL, 0x0, 3*HZ);
+	US_DEBUGP("result from activate reset is %d\n", result);
+
+	/* wait 250ms */
+	mdelay(250);
+
+	/* clear reset */
+	result =3D usb_control_msg(us->pusb_dev,
+			usb_sndctrlpipe(us->pusb_dev, 0),
+			0x4d, 0x40, 0x24f8, 0x0, NULL, 0x0, 3*HZ);
+	US_DEBUGP("result from clear reset is %d\n", result);
=20
-        result =3D freecom_ide_write (us, 0x08, 0x08);
-        if (result !=3D USB_STOR_TRANSPORT_GOOD)
-                return result;
+	/* wait 3 seconds */
+	mdelay(3 * 1000);
=20
         return USB_STOR_TRANSPORT_GOOD;
 }
diff -u linux-2.4.14/drivers/usb/storage.old/scsiglue.c linux-2.4.14/driver=
s/usb/storage/scsiglue.c
--- linux-2.4.14/drivers/usb/storage.old/scsiglue.c	Tue Sep 18 14:10:43 2001
+++ linux-2.4.14/drivers/usb/storage/scsiglue.c	Mon Oct 15 00:02:32 2001
@@ -1,7 +1,7 @@
 /* Driver for USB Mass Storage compliant devices
  * SCSI layer glue code
  *
- * $Id: scsiglue.c,v 1.22 2001/09/02 04:29:27 mdharm Exp $
+ * $Id: scsiglue.c,v 1.23 2001/10/15 07:02:32 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
diff -u linux-2.4.14/drivers/usb/storage.old/sddr09.c linux-2.4.14/drivers/=
usb/storage/sddr09.c
--- linux-2.4.14/drivers/usb/storage.old/sddr09.c	Sun Nov  4 09:31:57 2001
+++ linux-2.4.14/drivers/usb/storage/sddr09.c	Mon Nov  5 19:18:36 2001
@@ -1,6 +1,6 @@
 /* Driver for SanDisk SDDR-09 SmartMedia reader
  *
- * $Id: sddr09.c,v 1.19 2001/09/02 06:07:20 mdharm Exp $
+ * $Id: sddr09.c,v 1.21 2001/11/06 03:18:36 mdharm Exp $
  *
  * SDDR09 driver v0.1:
  *
diff -u linux-2.4.14/drivers/usb/storage.old/transport.c linux-2.4.14/drive=
rs/usb/storage/transport.c
--- linux-2.4.14/drivers/usb/storage.old/transport.c	Fri Sep 14 14:04:07 20=
01
+++ linux-2.4.14/drivers/usb/storage/transport.c	Mon Oct 15 00:02:32 2001
@@ -1,6 +1,6 @@
 /* Driver for USB Mass Storage compliant devices
  *
- * $Id: transport.c,v 1.40 2001/08/18 08:37:46 mdharm Exp $
+ * $Id: transport.c,v 1.41 2001/10/15 07:02:32 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
diff -u linux-2.4.14/drivers/usb/storage.old/usb.c linux-2.4.14/drivers/usb=
/storage/usb.c
--- linux-2.4.14/drivers/usb/storage.old/usb.c	Fri Sep 14 14:04:07 2001
+++ linux-2.4.14/drivers/usb/storage/usb.c	Mon Oct 15 00:02:33 2001
@@ -1,6 +1,6 @@
 /* Driver for USB Mass Storage compliant devices
  *
- * $Id: usb.c,v 1.67 2001/07/29 23:41:52 mdharm Exp $
+ * $Id: usb.c,v 1.68 2001/10/15 07:02:33 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)

--cNdxnHkX5QqsyA0e--

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE751jEz64nssGU+ykRAiQDAJ4hb2Lwplraukcs0GVL31axVVcKvACgs6uZ
Ij+QaxJLZ5qV1nq1yTrzH1g=
=bSG2
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
