Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWA3SEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWA3SEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWA3SEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:04:51 -0500
Received: from mx01.qsc.de ([213.148.129.14]:29115 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S964854AbWA3SEu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:04:50 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: [PATCH] Adaptec USBXchange and USB2Xchange support
Date: Mon, 30 Jan 2006 19:04:15 +0100
User-Agent: KMail/1.9
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Louis C. Kouvaris" <louisk@comcast.net>,
       "wilford smith" <wilford_smith_2@hotmail.com>
References: <200509132253.53960.rene@exactcode.de> <200601301422.40500.rene@exactcode.de> <200601301622.19998.oliver@neukum.org>
In-Reply-To: <200601301622.19998.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601301904.15207.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, finally - I got multi target (that is a SCSI device
	other than ID = 0 and more than than one) working with the USB2Xchange.
	But it needs two ugly changes in transport.c: The first one is only
	encoding the ID, no LUN: [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

finally - I got multi target (that is a SCSI device other than ID = 0 and more than than one) working
with the USB2Xchange. But it needs two ugly changes in transport.c:

The first one is only encoding the ID, no LUN:

--- ../linux-2.6.15/drivers/usb/storage/transport.c	2006-01-03 04:21:10.000000000 +0100
+++ drivers/usb/storage/transport.c	2006-01-30 18:49:25.172317000 +0100
@@ -983,7 +983,7 @@
 	bcb->Tag = ++us->tag;
 	bcb->Lun = srb->device->lun;
 	if (us->flags & US_FL_SCM_MULT_TARG)
-		bcb->Lun |= srb->device->id << 4;
+		bcb->Lun = srb->device->id;
 	bcb->Length = srb->cmd_len;
 
 	/* copy the command payload */

Would it be ok when special case that one only for the Adaptec device, for now?
Or define a whole new 2nd MULTI_TARG(2) quirk?

And furthermore the device does not respond to request other than the attached targets,
this might be needed:

@@ -1069,6 +1069,19 @@
 	US_DEBUGP("Bulk Status S 0x%x T 0x%x R %u Stat 0x%x\n",
 			le32_to_cpu(bcs->Signature), bcs->Tag, 
 			residue, bcs->Status);
+
+	if (bcs->Status > US_BULK_STAT_FAIL) {
+		/* Adaptec USB2XCHANGE */
+		if (us->pusb_dev->descriptor.idVendor == 0x03f3 &&
+		    us->pusb_dev->descriptor.idProduct == 0x2003) {
+
+			/* This device will send bcs->Status == 0x8a for unused targets and
+			   == 0x02 for SRB's that require SENSE. */
+			bcs->Status = US_BULK_STAT_OK;
+			fake_sense = 1;
+			US_DEBUGP("Patched Bulk status to %d.\n", bcs->Status);
+		}
+	}
 	if (bcs->Tag != us->tag || bcs->Status > US_BULK_STAT_PHASE) {
 		US_DEBUGP("Bulk logical error\n");
 		return USB_STOR_TRANSPORT_ERROR;

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
