Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946727AbWKJQLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946727AbWKJQLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946730AbWKJQLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:11:15 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:26510 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1946727AbWKJQLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:11:14 -0500
Date: Fri, 10 Nov 2006 11:11:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI core: always store >= 36 bytes of INQUIRY data
Message-ID: <Pine.LNX.4.44L0.0611101104360.2314-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as810c) copies a minimum of 36 bytes of INQUIRY data,
even if the device claims that not all of them are valid.  Often badly
behaved devices put plausible data in the Vendor, Product, and Revision
strings but set the Additional Length byte to a small value.  Using
potentially valid data is certainly better than allocating a short
buffer and then reading beyond the end of it, which is what we do now.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 9 Nov 2006, Andrew Morton wrote:

> So Alan, I think Greg is out of town somewhere.  If you have a final patch
> you'd like merged, please send her over.

This is the final version submitted to James Bottomley on Oct. 31.  
Apparently he hasn't applied it yet, and there hasn't been any word back 
on whether he intends to.

Alan Stern


Index: usb-2.6/drivers/scsi/scsi_scan.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_scan.c
+++ usb-2.6/drivers/scsi/scsi_scan.c
@@ -631,12 +631,22 @@ static int scsi_add_lun(struct scsi_devi
 	 * scanning run at their own risk, or supply a user level program
 	 * that can correctly scan.
 	 */
-	sdev->inquiry = kmalloc(sdev->inquiry_len, GFP_ATOMIC);
-	if (sdev->inquiry == NULL) {
+
+	/*
+	 * Copy at least 36 bytes of INQUIRY data, so that we don't
+	 * dereference unallocated memory when accessing the Vendor,
+	 * Product, and Revision strings.  Badly behaved devices may set
+	 * the INQUIRY Additional Length byte to a small value, indicating
+	 * these strings are invalid, but often they contain plausible data
+	 * nonetheless.  It doesn't matter if the device sent < 36 bytes
+	 * total, since scsi_probe_lun() initializes inq_result with 0s.
+	 */
+	sdev->inquiry = kmemdup(inq_result,
+				max_t(size_t, sdev->inquiry_len, 36),
+				GFP_ATOMIC);
+	if (sdev->inquiry == NULL)
 		return SCSI_SCAN_NO_RESPONSE;
-	}
 
-	memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
 	sdev->vendor = (char *) (sdev->inquiry + 8);
 	sdev->model = (char *) (sdev->inquiry + 16);
 	sdev->rev = (char *) (sdev->inquiry + 32);

