Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263494AbVHFUCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbVHFUCv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 16:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbVHFUCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 16:02:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263499AbVHFUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 16:02:38 -0400
Date: Sat, 6 Aug 2005 13:02:17 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: martinmaurer@gmx.at
Cc: Alan Stern <stern@rowland.harvard.edu>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Fw: Re: Elitegroup K7S5A + usb_storage problem
Message-Id: <20050806130217.1748f7be.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0508061137180.1168-100000@netrider.rowland.org>
References: <20050805151820.3f8f9e85.akpm@osdl.org>
	<Pine.LNX.4.44L0.0508061137180.1168-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Aug 2005 11:49:05 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:

> When asked what went wrong, the device says it didn't understand the 
> INQUIRY command.  This is a fatal error; if a device can't identify itself 
> there's no way for Linux to use it.
> 
> In short, your mp3stick is worthless.  Trade it in for one that works.

This is only true if usb-storage is used. The stick may work with ub.

Martin, please apply the attached patch and enable CONFIG_BLK_DEV_UB.
If you do not run a userland with udev, do this:

mknod /dev/uba b 180 0
mknod /dev/uba1 b 180 1

Let me know how it went.

-- Pete

diff -urp -X dontdiff linux-2.6.12/drivers/usb/storage/usb.c linux-2.6.12-lem/drivers/usb/storage/usb.c
--- linux-2.6.12/drivers/usb/storage/usb.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-lem/drivers/usb/storage/usb.c	2005-07-25 22:12:53.000000000 -0700
@@ -150,7 +150,9 @@ static struct usb_device_id storage_usb_
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
+#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
+#endif
 
 	/* Terminating entry */
 	{ }
@@ -224,8 +226,10 @@ static struct us_unusual_dev us_unusual_
 	  .useTransport = US_PR_BULK},
 	{ .useProtocol = US_SC_8070,
 	  .useTransport = US_PR_BULK},
+#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ .useProtocol = US_SC_SCSI,
 	  .useTransport = US_PR_BULK},
+#endif
 
 	/* Terminating entry */
 	{ NULL }
