Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUJFDtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUJFDtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJFDtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:49:31 -0400
Received: from banach.math.auburn.edu ([131.204.45.3]:63371 "EHLO
	banach.math.auburn.edu") by vger.kernel.org with ESMTP
	id S266833AbUJFDtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:49:24 -0400
Date: Tue, 5 Oct 2004 22:06:58 -0500 (CDT)
From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH] to 2.6.9-rc2, supports USB Bulk devices using 32-byte CBW 
Message-ID: <Pine.LNX.4.58.0410052030230.12089@banach.math.auburn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch is to support SCSI Bulk-transport devices which
expect a 32-byte Command Block Wrapper, when the Bulk transport specs
require the length to be 31 bytes. Clearly, this non-conformity renders a
device totally inaccessible unless some accommodation is made for its
special needs. Nevertheless, all known devices with this particular
problem do otherwise honor the Bulk Transport specs and do otherwise use
the standard SCSI command set, so that only minor changes to existing code
will support them.  The changes proposed here incorporate the results of
extensive discussion on the usb-storage mailing list, as well as
correspondence with Matt Dharm and Pat LaVarre prior to that.

Why is the patch needed?

In particular, several digital cameras have been encountered which require
the 32-byte Command Block. These cameras do not respond to commands when
only 31 bytes are put in the Command Block Wrapper. An extra, tailing byte
is required (which is invariably 0x0). These cameras all report themselves
in /proc/bus/usb/devices as Class ff, Subclass 06, Protocol 50,
acknowledging by the ff entry that they are not quite standard. Attempts
in the past to support them have caused a great deal of trouble, as a
Google search for "DC2MEGA" will easily establish. One of these cameras,
the Praktica DC21, is even mentioned on the Linux Kernel mailing list,
2003/Jan/2389.html, as causing the first kernel oops for a 2.6 kernel. The
oops occurred when someone tried just to add an unusual_devs.h entry and
hook up the camera, without investigating what the actual the problem is.
Another such camera, the Argus DC-3500, is described as a (presumably
supported) mass-storage device on
<http://www.teaser.fr/~hfiguiere/linux/digicam.html>, the authoritative
list for current support status of known digital cameras. The entry is
inaccurate. But with this patch the Argus DC-3500 camera can indeed be
used as a mass-storage device.

What does the patch do?

Only a few small changes are sufficient to make these devices connect
through USB and to function normally:

The patch introduces a new flag US_FL_BULK32 (in
drivers/usb/storage/usb.h). The flag is then activated if a device is
connected, which has an entry in drivers/usb/storage/unusual_devs.h
containing US_FL_BULK32 in its flag field.  Two such new entries for
unusual_devs.h are given, which suffice to cover all currently-known
devices which require the flag.

Then, when and only when the US_FL_BULK32 flag is active, the standard
Bulk-only transport routines (in drivers/usb/storage/transport.c) will
implement a 32-byte Command Block Wrapper. And in order to be certain that
this is an unusual choice, the 32-byte variant is further marked as
"unlikely."

Has anyone actually tested this code?

Yes. And it did what it is supposed to do.

Developer's Certificate of Origin:

I certify that this contribution has been contributed in whole or in part
by me, and I have the right to submit it under the GPL, consistent with
the license of the Linux kernel.

Signed-off-by: Theodore Kilgore <kilgota@auburn.edu>

 (patch begins beneath dashed line)
--------------------------------------------------------------------------
diff -uprN -X dontdiff linux-2.6.9-rc2.orig/drivers/usb/storage/transport.c linux-2.6.9-rc2/drivers/usb/storage/transport.c
--- linux-2.6.9-rc2.orig/drivers/usb/storage/transport.c	2004-09-30 00:02:17.000000000 -0500
+++ linux-2.6.9-rc2/drivers/usb/storage/transport.c	2004-10-01 17:48:13.000000000 -0500
@@ -952,6 +952,13 @@ int usb_stor_Bulk_transport(struct scsi_
 	int result;
 	int fake_sense = 0;
 	unsigned int cswlen;
+	unsigned int cbwlen = US_BULK_CB_WRAP_LEN;
+
+	/* Take care of BULK32 devices; set extra byte to 0 */
+	if ( unlikely(us->flags & US_FL_BULK32)) {
+		cbwlen = 32;
+		us->iobuf[31] = 0;
+	}

 	/* set up the command wrapper */
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
@@ -974,7 +981,7 @@ int usb_stor_Bulk_transport(struct scsi_
 			(bcb->Lun >> 4), (bcb->Lun & 0x0F),
 			bcb->Length);
 	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
-				bcb, US_BULK_CB_WRAP_LEN, NULL);
+				bcb, cbwlen, NULL);
 	US_DEBUGP("Bulk command transfer result=%d\n", result);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
diff -uprN -X dontdiff linux-2.6.9-rc2.orig/drivers/usb/storage/unusual_devs.h linux-2.6.9-rc2/drivers/usb/storage/unusual_devs.h
--- linux-2.6.9-rc2.orig/drivers/usb/storage/unusual_devs.h	2004-09-30 00:02:17.000000000 -0500
+++ linux-2.6.9-rc2/drivers/usb/storage/unusual_devs.h	2004-10-05 20:45:01.000000000 -0500
@@ -248,6 +248,17 @@ UNUSUAL_DEV(  0x04e6, 0x0101, 0x0200, 0x
 		"CD-RW Device",
 		US_SC_8020, US_PR_CB, NULL, 0),

+/* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
+ * Device uses standards-violating 32-byte Bulk Command Block Wrappers and
+ * reports itself as "Proprietary SCSI Bulk." Cf. device entry 0x084d:0x0011.
+ */
+
+UNUSUAL_DEV(  0x04fc, 0x80c2, 0x0000, 0x9999,
+		"Kobian Mercury",
+		"Binocam DCB-132",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_BULK32),
+
 /* Reported by Bob Sass <rls@vectordb.com> -- only rev 1.33 tested */
 UNUSUAL_DEV(  0x050d, 0x0115, 0x0133, 0x0133,
 		"Belkin",
@@ -684,6 +695,19 @@ UNUSUAL_DEV( 0x0839, 0x000a, 0x0001, 0x0
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY),

+/* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
+ * Flag will support Bulk devices which use a standards-violating 32-byte
+ * Command Block Wrapper. Here, the "DC2MEGA" cameras (several brands) with
+ * Grandtech GT892x chip, which request "Proprietary SCSI Bulk" support.
+ */
+
+UNUSUAL_DEV(  0x084d, 0x0011, 0x0000, 0x9999,
+		"Grandtech",
+		"DC2MEGA",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_BULK32),
+
+
 /* Aiptek PocketCAM 3Mega
  * Nicolas DUPEUX <nicolas@dupeux.net>
  */
diff -uprN -X dontdiff linux-2.6.9-rc2.orig/drivers/usb/storage/usb.h linux-2.6.9-rc2/drivers/usb/storage/usb.h
--- linux-2.6.9-rc2.orig/drivers/usb/storage/usb.h	2004-09-30 00:02:17.000000000 -0500
+++ linux-2.6.9-rc2/drivers/usb/storage/usb.h	2004-09-29 18:46:19.000000000 -0500
@@ -73,6 +73,7 @@ struct us_unusual_dev {
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets	    */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs faking   */
 #define US_FL_FIX_CAPACITY    0x00000080 /* READ CAPACITY response too big  */
+#define US_FL_BULK32          0x00000200 /* Uses 32-byte CBW length         */

 /* Dynamic flag definitions: used in set_bit() etc. */
 #define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
