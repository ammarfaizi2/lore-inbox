Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUBHNHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 08:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUBHNHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 08:07:30 -0500
Received: from main.gmane.org ([80.91.224.249]:49292 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263596AbUBHNH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 08:07:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: USB 2.0 mass storage problem
Date: Sun, 08 Feb 2004 14:07:22 +0100
Message-ID: <yw1xfzdlu3cl.fsf@kth.se>
References: <yw1xr7x5u84v.fsf@kth.se> <200402081214.i18CEWe00689@mailgate01.ctimail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:T4pMISFi0+MTnprAjlr+dEMEQwc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

"Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk> writes:

>> This looks like the drive is using a buggy Genesys USB-to-IDE bridge.
>> Run lsusb and check.  There was a workaround kernel patch floating
>> around here about a month ago.
>
> Thank you for your help, 
> but could you please provide some more key words so that I can find those
> messages? Thanks.

It was one of the attached patches.  I don't remember which one.

-- 
Måns Rullgård
mru@kth.se


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=usb-storage.diff

===== scsiglue.c 1.62 vs edited =====
--- 1.62/drivers/usb/storage/scsiglue.c Fri Nov 14 04:15:20 2003
+++ edited/drivers/usb/storage/scsiglue.c	Tue Dec 16 10:56:12 2003
@@ -219,6 +219,21 @@
 	return result < 0 ? FAILED : SUCCESS;
 }
 
+/* Report a driver-initiated device reset to the SCSI layer.
+ * Calling this for a SCSI-initiated reset is unnecessary but harmless. */
+void usb_stor_report_device_reset(struct us_data *us)
+{
+	int i;
+
+	scsi_lock(us->host);
+	scsi_report_device_reset(us->host, 0, 0);
+	if (us->flags & US_FL_SCM_MULT_TARG) {
+		for (i = 1; i < 8; ++i)
+			scsi_report_device_reset(us->host, 0, i);
+	}
+	scsi_unlock(us->host);
+}
+
 /***********************************************************************
  * /proc/scsi/ functions
  ***********************************************************************/
===== scsiglue.h 1.7 vs edited =====
--- 1.7/drivers/usb/storage/scsiglue.h	Mon Jul 28 14:29:04 2003
+++ edited/drivers/usb/storage/scsiglue.h	Tue Dec 16 10:56:31 2003
@@ -44,6 +44,9 @@
 #include <linux/blkdev.h>
 #include "scsi.h"
 #include "hosts.h"
+#include "usb.h"
+
+extern void usb_stor_report_device_reset(struct us_data *us);
 
 extern unsigned char usb_stor_sense_notready[18];
 extern unsigned char usb_stor_sense_invalidCDB[18];
===== transport.c 1.113 vs edited =====
--- 1.113/drivers/usb/storage/transport.c	Fri Oct 24 11:05:36 2003
+++ edited/drivers/usb/storage/transport.c	Tue Dec 16 11:41:27 2003
@@ -929,6 +929,7 @@
 	unsigned int residue;
 	int result;
 	int fake_sense = 0;
+	unsigned int cswlen;
 
 	/* set up the command wrapper */
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
@@ -985,7 +986,17 @@
 	/* get CSW for device status */
 	US_DEBUGP("Attempting to get CSW...\n");
 	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-				bcs, US_BULK_CS_WRAP_LEN, NULL);
+				bcs, US_BULK_CS_WRAP_LEN, &cswlen);
+
+	/* Some broken devices add unnecessary zero-length packets to the
+	 * end of their data transfers.	 Such packets show up as 0-length
+	 * CSWs.  If we encounter such a thing, try to read the CSW again.
+	 */
+	if (result == USB_STOR_XFER_SHORT && cswlen == 0) {
+		US_DEBUGP("Received 0-length CSW; retrying...\n");
+		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
+				bcs, US_BULK_CS_WRAP_LEN, &cswlen);
+	}
 
 	/* did the attempt to read the CSW fail? */
 	if (result == USB_STOR_XFER_STALLED) {
@@ -1066,6 +1077,9 @@
 {
 	int result;
 	int result2;
+
+	/* Let the SCSI layer know we are doing a reset */
+	usb_stor_report_device_reset(us);
 
 	/* A 20-second timeout may seem rather long, but a LaCie
 	 *  StudioDrive USB2 device takes 16+ seconds to get going

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=usb-storage-csw.diff

--- 1.112/drivers/usb/storage/transport.c       Fri Sep 26 12:37:45 2003
+++ edited/drivers/usb/storage/transport.c      Mon Dec  1 14:06:19 2003
@@ -985,7 +985,7 @@
				bcs, US_BULK_CS_WRAP_LEN, NULL);
 
	/* did the attempt to read the CSW fail? */
-	if (result == USB_STOR_XFER_STALLED) {
+	if (result == USB_STOR_XFER_STALLED || result == USB_STOR_XFER_SHORT) {
 
		/* get the status again */
		US_DEBUGP("Attempting to get CSW (2nd try)...\n");

--=-=-=--

