Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVCXQGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVCXQGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVCXQGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:06:04 -0500
Received: from byterapers.com ([195.156.109.210]:31688 "EHLO byterapers.com")
	by vger.kernel.org with ESMTP id S262798AbVCXQFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:05:39 -0500
Date: Thu, 24 Mar 2005 18:05:14 +0200 (EET)
From: Jakemuksen spammiosote <jhroska@byterapers.com>
To: linux-kernel@vger.kernel.org
cc: dbrownell@users.sourceforge.net
Subject: [PATCH] usbnet.c, buf.overrun crash-bugfix, Kernel 2.6.12-rc1
Message-ID: <Pine.LNX.4.61.0503241722160.30661@byterapers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atleast versions 2.6.5 - 2.6.12-rc1 crash if an USB device using usbnet 
sends oversized packet. Such packets occur most likely with broken
device. Here's a patch that throws away such packet, to keep the machine
from crashing. Hopefully this doesn't leave memory unreleased. If it does, 
it's still better than crashing as such oversized packets are really rare.

Signed-off-by: Jarkko Hakala <jhroska@byterapers.com>

diff -Nur linux-2.6.12-rc1-orig/drivers/usb/net/usbnet.c 
linux-2.6.12-rc1/drivers/usb/net/usbnet.c
--- linux-2.6.12-rc1-orig/drivers/usb/net/usbnet.c      2005-03-18 
03:34:13.000000000 +0200
+++ linux-2.6.12-rc1/drivers/usb/net/usbnet.c   2005-03-24 
16:46:08.000000000 +0200
@@ -2795,9 +2795,20 @@
         struct usbnet           *dev = entry->dev;
         int                     urb_status = urb->status;

-       skb_put (skb, urb->actual_length);
-       entry->state = rx_done;
-       entry->urb = NULL;
+       if (unlikely((skb->tail + urb->actual_length) > skb->end)) {
+               entry->state = rx_cleanup;
+               dev->stats.rx_errors++;
+               dev->stats.rx_length_errors++;
+               entry->urb = NULL;
+               printk(KERN_ERR
+                      "USB RX packet too long, discarded. "
+                      "Your slave device most likely is broken\n");
+               /* lets hope upper level protocols will recover */
+       } else {
+               skb_put(skb, urb->actual_length);
+               entry->state = rx_done;
+               entry->urb = NULL;
+       }

         switch (urb_status) {
             // success

