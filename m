Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161535AbWAMKM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161535AbWAMKM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWAMKM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:12:58 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:7115 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161535AbWAMKM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:12:57 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 13/13] USBATM: -EILSEQ workaround
Date: Fri, 13 Jan 2006 11:12:58 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r03xDpLvmYXzDkT"
Message-Id: <200601131112.59414.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_r03xDpLvmYXzDkT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Don't throttle on -EILSEQ urb status if requested by a minidriver.
It seems the ueagle modems are buggy, giving -EILSEQ when they
have no data to send.  The ueagle change will be sent separately
by the ueagle guys.  Patch by Matthieu Castet.

Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_r03xDpLvmYXzDkT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="13-EILSEQ"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="13-EILSEQ"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:27:55.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:28:29.000000000 +0100
@@ -270,7 +270,10 @@
 
 	spin_unlock_irqrestore(&channel->lock, flags);
 
-	if (unlikely(urb->status)) {
+	if (unlikely(urb->status) &&
+			(!(channel->usbatm->flags & UDSL_IGNORE_EILSEQ) ||
+			 urb->status != -EILSEQ ))
+	{
 		if (printk_ratelimit())
 			atm_warn(channel->usbatm, "%s: urb 0x%p failed (%d)!\n",
 				__func__, urb, urb->status);
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 09:25:43.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 09:28:29.000000000 +0100
@@ -88,6 +88,7 @@
 
 #define UDSL_SKIP_HEAVY_INIT	(1<<0)
 #define UDSL_USE_ISOC		(1<<1)
+#define UDSL_IGNORE_EILSEQ	(1<<2)
 
 
 /* mini driver */

--Boundary-00=_r03xDpLvmYXzDkT--
