Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRIBHE6>; Sun, 2 Sep 2001 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271588AbRIBHEv>; Sun, 2 Sep 2001 03:04:51 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:15118
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S271586AbRIBHEm>; Sun, 2 Sep 2001 03:04:42 -0400
Date: Sun, 2 Sep 2001 00:04:58 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
        Kernel Developer List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        USB Storage List <usb-storage@one-eyed-alien.net>
Subject: PATCH: usb-storage: 3 of 3
Message-ID: <20010902000458.I4415@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Kernel Developer List <linux-kernel@vger.redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	USB Storage List <usb-storage@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+Z5jE7Arku/2GrR
Content-Type: multipart/mixed; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch to usb-storage.  Linus, please apply.

This patch does the following:
(o) Keeps CVS versions in the kernel in sync with mine (the min() changes
    forced this one).
(o) A one-line fix to the (experimental) sddr-09 driver.
(o) Switch much of transport.c to use the new struct completion.  This
    shows a slight performance gain (less CPU used) and eliminates some bug
    reports.  I don't know what was wrong with the old code, but this new
    code is clearly correct and works better, anyway.
(o) Adds a few unusual device entries, removes a bogus entry, and fixes a
    comment in the same file.

Matt Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.patch"
Content-Transfer-Encoding: quoted-printable

diff -u -X ../dontdiff drivers/usb/storage.old/scsiglue.c drivers/usb/stora=
ge/scsiglue.c
--- drivers/usb/storage.old/scsiglue.c	Sun Aug 12 13:54:53 2001
+++ drivers/usb/storage/scsiglue.c	Sat Sep  1 21:29:27 2001
@@ -1,7 +1,7 @@
 /* Driver for USB Mass Storage compliant devices
  * SCSI layer glue code
  *
- * $Id: scsiglue.c,v 1.21 2001/07/29 23:41:52 mdharm Exp $
+ * $Id: scsiglue.c,v 1.22 2001/09/02 04:29:27 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
diff -u -X ../dontdiff drivers/usb/storage.old/sddr09.c drivers/usb/storage=
/sddr09.c
--- drivers/usb/storage.old/sddr09.c	Sun Jul 29 21:11:50 2001
+++ drivers/usb/storage/sddr09.c	Sat Sep  1 23:07:20 2001
@@ -1,6 +1,6 @@
 /* Driver for SanDisk SDDR-09 SmartMedia reader
  *
- * $Id: sddr09.c,v 1.18 2001/06/11 02:54:25 mdharm Exp $
+ * $Id: sddr09.c,v 1.19 2001/09/02 06:07:20 mdharm Exp $
  *
  * SDDR09 driver v0.1:
  *
@@ -693,7 +693,7 @@
 	// scatterlist block i*64/128k =3D i*(2^6)*(2^-17) =3D i*(2^-11)
=20
 	for (i=3D0; i<numblocks; i++) {
-		ptr =3D sg[i>>11].address+(i<<6);
+		ptr =3D sg[i>>11].address+((i&0x7ff)<<6);
 		if (ptr[0]!=3D0xFF || ptr[1]!=3D0xFF || ptr[2]!=3D0xFF ||
 		    ptr[3]!=3D0xFF || ptr[4]!=3D0xFF || ptr[5]!=3D0xFF) {
 			US_DEBUGP("PBA %04X has no logical mapping: reserved area =3D "
diff -u -X ../dontdiff drivers/usb/storage.old/transport.c drivers/usb/stor=
age/transport.c
--- drivers/usb/storage.old/transport.c	Sun Jul 29 21:11:50 2001
+++ drivers/usb/storage/transport.c	Sat Aug 18 01:37:46 2001
@@ -1,6 +1,6 @@
 /* Driver for USB Mass Storage compliant devices
  *
- * $Id: transport.c,v 1.39 2001/03/10 16:46:28 zagor Exp $
+ * $Id: transport.c,v 1.40 2001/08/18 08:37:46 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
@@ -371,10 +371,9 @@
  */
 static void usb_stor_blocking_completion(urb_t *urb)
 {
-	wait_queue_head_t *wqh_ptr =3D (wait_queue_head_t *)urb->context;
+	struct completion *urb_done_ptr =3D (struct completion *)urb->context;
=20
-	if (waitqueue_active(wqh_ptr))
-		wake_up(wqh_ptr);
+	complete(urb_done_ptr);
 }
=20
 /* This is our function to emulate usb_control_msg() but give us enough
@@ -384,8 +383,7 @@
 			 u8 request, u8 requesttype, u16 value, u16 index,=20
 			 void *data, u16 size)
 {
-	wait_queue_head_t wqh;
-	wait_queue_t wait;
+	struct completion urb_done;
 	int status;
 	devrequest *dr;
=20
@@ -402,9 +400,7 @@
 	dr->length =3D cpu_to_le16(size);
=20
 	/* set up data structures for the wakeup system */
-	init_waitqueue_head(&wqh); =09
-	init_waitqueue_entry(&wait, current); =09
-	add_wait_queue(&wqh, &wait);
+	init_completion(&urb_done);
=20
 	/* lock the URB */
 	down(&(us->current_urb_sem));
@@ -412,33 +408,25 @@
 	/* fill the URB */
 	FILL_CONTROL_URB(us->current_urb, us->pusb_dev, pipe,=20
 			 (unsigned char*) dr, data, size,=20
-			 usb_stor_blocking_completion, &wqh);
+			 usb_stor_blocking_completion, &urb_done);
 	us->current_urb->actual_length =3D 0;
 	us->current_urb->error_count =3D 0;
 	us->current_urb->transfer_flags =3D USB_ASYNC_UNLINK;
=20
 	/* submit the URB */
-	set_current_state(TASK_UNINTERRUPTIBLE);
 	status =3D usb_submit_urb(us->current_urb);
 	if (status) {
 		/* something went wrong */
 		up(&(us->current_urb_sem));
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&wqh, &wait);
 		kfree(dr);
 		return status;
 	}
=20
 	/* wait for the completion of the URB */
 	up(&(us->current_urb_sem));
-	while (us->current_urb->status =3D=3D -EINPROGRESS)
-		schedule();
+	wait_for_completion(&urb_done);
 	down(&(us->current_urb_sem));
=20
-	/* we either timed out or got woken up -- clean up either way */
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&wqh, &wait);
-
 	/* return the actual length of the data transferred if no error*/
 	status =3D us->current_urb->status;
 	if (status >=3D 0)
@@ -456,45 +444,34 @@
 int usb_stor_bulk_msg(struct us_data *us, void *data, int pipe,
 		      unsigned int len, unsigned int *act_len)
 {
-	wait_queue_head_t wqh;
-	wait_queue_t wait;
+	struct completion urb_done;
 	int status;
=20
 	/* set up data structures for the wakeup system */
-	init_waitqueue_head(&wqh); =09
-	init_waitqueue_entry(&wait, current); =09
-	add_wait_queue(&wqh, &wait);
+	init_completion(&urb_done);
=20
 	/* lock the URB */
 	down(&(us->current_urb_sem));
=20
 	/* fill the URB */
 	FILL_BULK_URB(us->current_urb, us->pusb_dev, pipe, data, len,
-		      usb_stor_blocking_completion, &wqh);
+		      usb_stor_blocking_completion, &urb_done);
 	us->current_urb->actual_length =3D 0;
 	us->current_urb->error_count =3D 0;
 	us->current_urb->transfer_flags =3D USB_ASYNC_UNLINK;
=20
 	/* submit the URB */
-	set_current_state(TASK_UNINTERRUPTIBLE);
 	status =3D usb_submit_urb(us->current_urb);
 	if (status) {
 		/* something went wrong */
 		up(&(us->current_urb_sem));
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&wqh, &wait);
 		return status;
 	}
=20
 	/* wait for the completion of the URB */
 	up(&(us->current_urb_sem));
-	while (us->current_urb->status =3D=3D -EINPROGRESS)
-		schedule();
+	wait_for_completion(&urb_done);
 	down(&(us->current_urb_sem));
-
-	/* we either timed out or got woken up -- clean up either way */
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&wqh, &wait);
=20
 	/* return the actual length of the data transferred */
 	*act_len =3D us->current_urb->actual_length;
diff -u -X ../dontdiff drivers/usb/storage.old/unusual_devs.h drivers/usb/s=
torage/unusual_devs.h
--- drivers/usb/storage.old/unusual_devs.h	Sat Sep  1 21:25:09 2001
+++ drivers/usb/storage/unusual_devs.h	Sat Sep  1 22:31:11 2001
@@ -1,7 +1,7 @@
 /* Driver for USB Mass Storage compliant devices
  * Ununsual Devices File
  *
- * $Id: unusual_devs.h,v 1.16 2001/07/30 00:27:59 mdharm Exp $
+ * $Id: unusual_devs.h,v 1.20 2001/09/02 05:12:57 mdharm Exp $
  *
  * Current development and maintenance by:
  *   (c) 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
@@ -68,6 +68,19 @@
 		US_FL_START_STOP ),
 #endif
=20
+/* Made with the help of Edd Dumbill <edd@usefulinc.com> */
+UNUSUAL_DEV(  0x0451, 0x5409, 0x0001, 0x0001,
+		"Frontier Labs",
+		"Nex II Digital",
+		US_SC_SCSI, US_PR_BULK, NULL, US_FL_START_STOP),
+
+/* Reported by Paul Stewart <stewart@wetlogic.net>
+ * This entry is needed because the device reports Sub=3Dff */
+UNUSUAL_DEV(  0x04a4, 0x0004, 0x0001, 0x0001,
+		"Hitachi",
+		"DVD-CAM DZ-MV100A Camcorder",
+		US_SC_SCSI, US_PR_CB, NULL, US_FL_SINGLE_LUN),
+
 UNUSUAL_DEV(  0x04cb, 0x0100, 0x0000, 0x2210,
 		"Fujifilm",
 		"FinePix 1400Zoom",
@@ -155,13 +168,20 @@
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
=20
+/* Reported by win@geeks.nl */
+UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100,=20
+		"Sony",
+		"Memorystick NW-MS7",
+		US_SC_UFI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP ),
+
 UNUSUAL_DEV(  0x054c, 0x002d, 0x0100, 0x0100,=20
 		"Sony",
 		"Memorystick MSAC-US1",
 		US_SC_UFI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP ),
=20
-/* Submitted by Klaus Mueller <k.mueller@intership.de> */
+/* Submitted by Klaus Mueller <k.mueller@intershop.de> */
 UNUSUAL_DEV(  0x054c, 0x002e, 0x0106, 0x0310,=20
 		"Sony",
 		"Handycam",
@@ -195,12 +215,6 @@
 UNUSUAL_DEV(  0x05ab, 0x0031, 0x0100, 0x0110,
                 "In-System",
                 "USB/IDE Bridge (ATA/ATAPI)",
-                US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-                0 ),
-
-UNUSUAL_DEV(  0x05ab, 0x0060, 0x0100, 0x0110,
-                "In-System",
-                "USB 2.0/IDE Bridge (ATA/ATAPI)",
                 US_SC_ISD200, US_PR_BULK, isd200_Initialization,
                 0 ),
=20

--M9kwpIYUMbI/2cCx--

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE7kdoaz64nssGU+ykRAv+UAJjL8exhHjSCAgfkL+m2mJubglajAJ0bcyCX
MRdDX9hh8dR3kcmHJjaazA==
=PFMm
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
