Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUEBUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUEBUxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUEBUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 16:53:10 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:7839 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263229AbUEBUxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 16:53:06 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Date: Sun, 2 May 2004 22:53:03 +0200
User-Agent: KMail/1.5.4
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net> <200404301810.56271.baldrick@free.fr> <20040430224111.GB14643@kroah.com>
In-Reply-To: <20040430224111.GB14643@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405022253.03011.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Greg, I'm not sure when these problems started showing up, maybe they
> > have been in 2.6.6- for a while.  One patch that may be worth having in
> > 2.6.6 by the way is the one for device_disconnect in devio.c that changes
> > destroy_all_async to destroy_async_on_interface.  It's clearly correct
> > and does do some good!
>
> Care to point out which one this was?  I'm swimming in a sea of patches
> right now :)

I rediffed it against Linus's current tree.  The extern -> static change is to make sure
we avoid the problem reported by R. J. Wysocki for -rc3-mm1: unknown symbol
destroy_all_async.

--- linux-2.5/drivers/usb/core/devio.c.orig	2004-05-02 23:22:34.000000000 +0200
+++ linux-2.5/drivers/usb/core/devio.c	2004-05-02 23:40:40.000000000 +0200
@@ -315,7 +315,7 @@
 	destroy_async(ps, &hitlist);
 }
 
-extern __inline__ void destroy_all_async(struct dev_state *ps)
+static inline void destroy_all_async(struct dev_state *ps)
 {
 	        destroy_async(ps, &ps->async_pending);
 }
@@ -335,6 +335,7 @@
 static void driver_disconnect(struct usb_interface *intf)
 {
 	struct dev_state *ps = usb_get_intfdata (intf);
+	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
 
 	if (!ps)
 		return;
@@ -345,11 +346,16 @@
 
 	/* prevent new I/O requests */
 	ps->dev = 0;
-	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
+
+	if (likely(ifnum < 8*sizeof(ps->ifclaimed)))
+		clear_bit(ifnum, &ps->ifclaimed);
+	else
+		warn("interface number %u out of range", ifnum);
+
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
-	destroy_all_async (ps);
+	destroy_async_on_interface (ps, ifnum);
 }
 
 struct usb_driver usbdevfs_driver = {
