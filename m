Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUHSPcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUHSPcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUHSPaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:30:03 -0400
Received: from ida.rowland.org ([192.131.102.52]:9476 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266498AbUHSPWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:22:09 -0400
Date: Thu, 19 Aug 2004 11:22:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rastislav Stanik <rs_kernel@yahoo.com>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: problem mounting vfat USB flash disk (usb mass storage) under
 2.6.8.1
Message-ID: <Pine.LNX.4.44L0.0408191115490.1057-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem you reported has also been reported by someone else; see

http://bugme.osdl.org/show_bug.cgi?id=3223

Briefly, this is a bug in your device, not in the kernel.  Until 2.6.8 the 
usb-storage driver ignored such bugs, but now it pays attention to them.
(The bug report you found (id 2092) was a completely different, unrelated 
problem.)

Below is an updated patch, providing a workaround that should work for 
your device.

Alan Stern


===== drivers/usb/storage/transport.c 1.145 vs edited =====
--- 1.145/drivers/usb/storage/transport.c	Tue Aug  3 10:17:59 2004
+++ edited/drivers/usb/storage/transport.c	Thu Aug 19 10:59:52 2004
@@ -1054,8 +1054,10 @@
 
 	/* try to compute the actual residue, based on how much data
 	 * was really transferred and what the device tells us */
-	residue = min(residue, transfer_length);
-	srb->resid = max(srb->resid, (int) residue);
+	if (!(us->flags & US_FL_IGNORE_RESIDUE)) {
+		residue = min(residue, transfer_length);
+		srb->resid = max(srb->resid, (int) residue);
+	}
 
 	/* based on the status code, we report good or bad */
 	switch (bcs->Status) {
===== drivers/usb/storage/unusual_devs.h 1.144 vs edited =====
--- 1.144/drivers/usb/storage/unusual_devs.h	Fri Aug  6 03:59:29 2004
+++ edited/drivers/usb/storage/unusual_devs.h	Thu Aug 19 11:13:20 2004
@@ -265,6 +265,13 @@
 		US_SC_8070, US_PR_BULK, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* Reported by Iacopo Spalletti <avvisi@spalletti.it> */
+UNUSUAL_DEV(  0x052b, 0x1807, 0x0100, 0x0100, 
+		"Tekom Technologies, Inc",
+		"300_CAMERA", 
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_IGNORE_RESIDUE ),
+
 /* This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0450, 
 		"Sony",
@@ -801,7 +808,14 @@
 		"Solid state disk",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
-		
+
+/* Reported by Rastislav Stanik <rs_kernel@yahoo.com> */
+UNUSUAL_DEV( 0x0ea0, 0x6828, 0x0110, 0x0110,
+		"USB",
+		"Flash Disk",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_IGNORE_RESIDUE ),
+
 /* Reported by Kevin Cernekee <kpc-usbdev@gelato.uiuc.edu>
  * Tested on hardware version 1.10.
  * Entry is needed only for the initializer function override.
===== drivers/usb/storage/usb.h 1.60 vs edited =====
--- 1.60/drivers/usb/storage/usb.h	Tue Jul 20 19:30:35 2004
+++ edited/drivers/usb/storage/usb.h	Thu Aug 19 10:59:52 2004
@@ -73,6 +73,7 @@
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets	    */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs faking   */
 #define US_FL_FIX_CAPACITY    0x00000080 /* READ CAPACITY response too big  */
+#define US_FL_IGNORE_RESIDUE  0x00000100 /* reported residue is wrong	    */
 
 /* Dynamic flag definitions: used in set_bit() etc. */
 #define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */

