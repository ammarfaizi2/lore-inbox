Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVAHHlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVAHHlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVAHHgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:36:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:42117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261859AbVAHFsP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:15 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163264681@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <11051632641468@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.6, 2004/12/15 14:26:09-08:00, mdharm-usb@one-eyed-alien.net

[PATCH] USB Storage: support 'bulk32' devices

This patch implements support for what we call "bulk32" devices.  These are
devices that use the BBB transport mechanism with the slight modification
that the CBW is padded to 32 bytes (instead of the standard 31 bytes).

Signed-off-by: Theodore Kilgore <kilgota@banach.math.auburn.edu>
Signed-off-by: Phil Dibowitz <phil@ipom.com>
Signed-off-by: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/storage/transport.c    |    9 ++++++++-
 drivers/usb/storage/unusual_devs.h |   24 ++++++++++++++++++++++++
 drivers/usb/storage/usb.h          |    1 +
 3 files changed, 33 insertions(+), 1 deletion(-)


diff -Nru a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
--- a/drivers/usb/storage/transport.c	2005-01-07 15:50:46 -08:00
+++ b/drivers/usb/storage/transport.c	2005-01-07 15:50:46 -08:00
@@ -954,6 +954,13 @@
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
@@ -976,7 +983,7 @@
 			(bcb->Lun >> 4), (bcb->Lun & 0x0F), 
 			bcb->Length);
 	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
-				bcb, US_BULK_CB_WRAP_LEN, NULL);
+				bcb, cbwlen, NULL);
 	US_DEBUGP("Bulk command transfer result=%d\n", result);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:46 -08:00
+++ b/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:46 -08:00
@@ -249,6 +249,17 @@
 		"CD-RW Device",
 		US_SC_8020, US_PR_CB, NULL, 0),
 
+/* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
+ * Device uses standards-violating 32-byte Bulk Command Block Wrappers and
+ * reports itself as "Proprietary SCSI Bulk." Cf. device entry 0x084d:0x0011.
+ */
+
+UNUSUAL_DEV(  0x04fc, 0x80c2, 0x0100, 0x0100,
+		"Kobian Mercury",
+		"Binocam DCB-132",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_BULK32),
+
 /* Reported by Bob Sass <rls@vectordb.com> -- only rev 1.33 tested */
 UNUSUAL_DEV(  0x050d, 0x0115, 0x0133, 0x0133,
 		"Belkin",
@@ -714,6 +725,19 @@
 		"Digimax 410",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY),
+
+/* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
+ * Flag will support Bulk devices which use a standards-violating 32-byte
+ * Command Block Wrapper. Here, the "DC2MEGA" cameras (several brands) with
+ * Grandtech GT892x chip, which request "Proprietary SCSI Bulk" support.
+ */
+
+UNUSUAL_DEV(  0x084d, 0x0011, 0x0110, 0x0110,
+		"Grandtech",
+		"DC2MEGA",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_BULK32),
+
 
 /* Aiptek PocketCAM 3Mega
  * Nicolas DUPEUX <nicolas@dupeux.net> 
diff -Nru a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
--- a/drivers/usb/storage/usb.h	2005-01-07 15:50:46 -08:00
+++ b/drivers/usb/storage/usb.h	2005-01-07 15:50:46 -08:00
@@ -74,6 +74,7 @@
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs faking   */
 #define US_FL_FIX_CAPACITY    0x00000080 /* READ CAPACITY response too big  */
 #define US_FL_IGNORE_RESIDUE  0x00000100 /* reported residue is wrong	    */
+#define US_FL_BULK32          0x00000200 /* Uses 32-byte CBW length         */
 
 /* Dynamic flag definitions: used in set_bit() etc. */
 #define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */

