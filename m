Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVDINje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDINje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVDINjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 09:39:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:25495 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261262AbVDINjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 09:39:22 -0400
Subject: Re: [2.4] "Fix" introduced in 2.4.27pre2 for bluetooth hci_usb
	race causes kernel hang
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas =?ISO-8859-1?Q?=D6gren?= <stric@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050408195632.GA17621@shaka.acc.umu.se>
References: <20050408195632.GA17621@shaka.acc.umu.se>
Content-Type: multipart/mixed; boundary="=-/Hbxu+bezTzViuhP479G"
Date: Sat, 09 Apr 2005 15:39:15 +0200
Message-Id: <1113053955.9783.57.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/Hbxu+bezTzViuhP479G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tomas,

> I have noticed a problem with a race condition fix introduced in
> 2.4.27-pre2 that causes the kernel to hang when disconnecting a
> Bluetooth USB dongle or doing 'hciconfig hci0 down'. No message is
> printed, the kernel just doesn't respond anymore.
> 
> Seen in Changelog:
> Marcel Holtmann:
>   o [Bluetooth] Fix race in RX complete routine of the USB drivers
> 
> Reversing the following patch to hci_usb_rx_complete() makes 2.4.27-pre2
> up until 2.4.30 happy and does not hang when removing the dongle
> anymore. (bfusb.c has the same patch applied)
> 
> 2.6.11.7 does not show the same problem, but has similar code to the
> "fixed" (that hangs) code in 2.4, so the real problem is probably
> somewhere else.

does the attached patch makes any difference?

Regards

Marcel


--=-/Hbxu+bezTzViuhP479G
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.23 vs edited =====
--- 1.23/drivers/bluetooth/hci_usb.c	2004-07-31 13:02:43 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2005-04-09 15:37:12 +02:00
@@ -398,12 +398,12 @@
 
 	BT_DBG("%s", hdev->name);
 
+	/* Synchronize with completion handlers */
 	write_lock_irqsave(&husb->completion_lock, flags);
-	
+	write_unlock_irqrestore(&husb->completion_lock, flags);
+
 	hci_usb_unlink_urbs(husb);
 	hci_usb_flush(hdev);
-
-	write_unlock_irqrestore(&husb->completion_lock, flags);
 
 	MOD_DEC_USE_COUNT;
 	return 0;

--=-/Hbxu+bezTzViuhP479G--

