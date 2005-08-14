Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVHNS5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVHNS5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 14:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVHNS5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 14:57:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33498 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932566AbVHNS5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 14:57:04 -0400
Date: Sun, 14 Aug 2005 11:56:48 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: usb camera failing in 2.6.13-rc6
Message-Id: <20050814115648.4f12f1ec.zaitcev@redhat.com>
In-Reply-To: <200508141842.13209.kernel@kolivas.org>
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com>
	<20050814010047.4b5fd37e.zaitcev@redhat.com>
	<200508141842.13209.kernel@kolivas.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 18:42:12 +1000, Con Kolivas <kernel@kolivas.org> wrote:
> On Sun, 14 Aug 2005 18:00, Pete Zaitcev wrote:
> > On Sun, 14 Aug 2005 17:12:06 +1000, Con Kolivas <kernel@kolivas.org> wrote:

> Yes all those dmesgs etc were redone after it failed in rc6 as I needed it 
> working. Oh and all other usb devices - mouse, printer, scanner, keyboard are 
> working fine in rc6; it's just the camera.

This should be diffable. You caught this regression relatively early.
But I'm afraid you have to go through the divide-by-half excercise.

If I were a betting man, I'd bet on this:

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -579,7 +582,7 @@ static int proc_control(struct dev_state
 		if ((i > 0) && ctrl.wLength) {
 			if (usbfs_snoop) {
 				dev_info(&dev->dev, "control read: data ");
-				for (j = 0; j < ctrl.wLength; ++j)
+				for (j = 0; j < i; ++j)
 					printk ("%02x ", (unsigned char)(tbuf)[j]);
 				printk("\n");
 			}
@@ -784,16 +790,16 @@ static int proc_setconfig(struct dev_sta
  		for (i = 0; i < actconfig->desc.bNumInterfaces; ++i) {
  			if (usb_interface_claimed(actconfig->interface[i])) {
 				dev_warn (&ps->dev->dev,
-					"usbfs: interface %d claimed "
+					"usbfs: interface %d claimed by %s "
 					"while '%s' sets config #%d\n",
 					actconfig->interface[i]
 						->cur_altsetting
 						->desc.bInterfaceNumber,
+					actconfig->interface[i]
+						->dev.driver->name,
 					current->comm, u);
-#if 0	/* FIXME:  enable in 2.6.10 or so */
  				status = -EBUSY;
 				break;
-#endif
 			}
  		}
  	}

Remember that dmesg diff you sent? That's the one. If you strace
the digikamcameracl, it probably keels over after EBUSY.

-- Pete
