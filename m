Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDNPAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUDNPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:00:47 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:58497 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261378AbUDNPAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:00:45 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 17:00:43 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404141530.54093.oliver@neukum.org>
In-Reply-To: <200404141530.54093.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141700.43087.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 15:30, Oliver Neukum wrote:
> Am Mittwoch, 14. April 2004 12:45 schrieb Duncan Sands:
> > The remaining three patches contain miscellaneous fixes to usbfs.
> > This one fixes up the disconnect callback to only shoot down urbs
> > on the disconnected interface, and not on all interfaces.  It also adds
> > a sanity check (this check is pointless because the interface could
> > never have been claimed in the first place if it failed, but I feel
> > better having it there).
>
> Well, I don't. If you care about it, add a WARN_ON().
> Checking without consequences is bad.

Hi Oliver, how about this instead?

--- gregkh-2.6/drivers/usb/core/devio.c.orig	2004-04-14 16:02:44.000000000 +0200
+++ gregkh-2.6/drivers/usb/core/devio.c	2004-04-14 16:57:15.000000000 +0200
@@ -335,6 +341,7 @@
 static void driver_disconnect(struct usb_interface *intf)
 {
 	struct dev_state *ps = usb_get_intfdata (intf);
+	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
 
 	if (!ps)
 		return;
@@ -343,13 +350,15 @@
 	 * all pending I/O requests; 2.6 does that.
 	 */
 
-	/* prevent new I/O requests */
-	ps->dev = 0;
-	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
+	if (ifnum < 8*sizeof(ps->ifclaimed))
+		clear_bit(ifnum, &ps->ifclaimed);
+	else
+		warn("interface number %u out of range", ifnum);
+
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
-	destroy_all_async (ps);
+	destroy_async_on_interface(ps, ifnum);
 }
 
 struct usb_driver usbdevfs_driver = {
