Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbUAMUsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUAMUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:48:51 -0500
Received: from colino.net ([62.212.100.143]:57340 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S265153AbUAMUrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:47:01 -0500
Date: Tue, 13 Jan 2004 21:46:13 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Re: cdc-acm problems
Message-Id: <20040113214613.07998ff6.colin@colino.net>
In-Reply-To: <20040113130529.03f5dbac.colin@colino.net>
References: <20040113130529.03f5dbac.colin@colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__13_Jan_2004_21_46_13_+0100_W1.8w7h12)fM?=.B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__13_Jan_2004_21_46_13_+0100_W1.8w7h12)fM?=.B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> I have problems with cdc-acm killing ohci. I tried to narrow down the problem, 
> but didn't get far. 
> Basically `killall -HUP pppd` gives (in dmesg):
> 
> drivers/usb/class/cdc-acm.c: acm_ctrl_irq - urb shutting down with status: -2
> ohci_hcd 0001:01:1b.1: OHCI Unrecoverable Error, disabled
> ohci_hcd 0001:01:1b.1: HC died; cleaning up
> usb 4-1: USB disconnect, address 2
> bus usb: remove device 4-1:1.0
> bus usb: remove device 4-1:1.1
> bus usb: remove device 4-1

After having looked some more hours, it looks like acm_tty_close() unlinks 
urbs too soon or something like that... The attached patch fixes it for me 
(I don't think it's really clean, but it may help ?)

-- 
Colin

--Multipart_Tue__13_Jan_2004_21_46_13_+0100_W1.8w7h12)fM?=.B
Content-Type: text/plain;
 name="cdc-acm.diff"
Content-Disposition: attachment;
 filename="cdc-acm.diff"
Content-Transfer-Encoding: 7bit

Index: drivers/usb/class/cdc-acm.c
===================================================================
RCS file: /home/cvsroot/linuxppc/drivers/usb/class/cdc-acm.c,v
retrieving revision 1.1.1.1
diff -u -u -r1.1.1.1 cdc-acm.c
--- drivers/usb/class/cdc-acm.c	8 Jan 2004 11:25:51 -0000	1.1.1.1
+++ drivers/usb/class/cdc-acm.c	13 Jan 2004 20:40:39 -0000
@@ -157,6 +157,7 @@
 	unsigned int minor;				/* acm minor number */
 	unsigned char throttle;				/* throttled by tty layer */
 	unsigned char clocal;				/* termios CLOCAL */
+	unsigned int finish_remove;			/* finish removing */
 };
 
 static struct usb_driver acm_driver;
@@ -214,8 +215,16 @@
 		goto exit;
 	}
 
-	if (!ACM_READY(acm))
+	if (!ACM_READY(acm)) {
+		if (acm->finish_remove) {
+			dbg("unlinking urbs");
+			usb_unlink_urb(acm->ctrlurb);
+			usb_unlink_urb(acm->writeurb);
+			usb_unlink_urb(acm->readurb);
+			return;			
+		}
 		goto exit;
+	}
 
 	switch (dr->bRequest) {
 
@@ -382,9 +391,7 @@
 	if (!--acm->used) {
 		if (acm->dev) {
 			acm_set_control(acm, acm->ctrlout = 0);
-			usb_unlink_urb(acm->ctrlurb);
-			usb_unlink_urb(acm->writeurb);
-			usb_unlink_urb(acm->readurb);
+			acm->finish_remove = 1;
 		} else {
 			tty_unregister_device(acm_tty_driver, acm->minor);
 			acm_table[acm->minor] = NULL;

--Multipart_Tue__13_Jan_2004_21_46_13_+0100_W1.8w7h12)fM?=.B--
