Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUDNKqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUDNKqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:46:07 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:40165 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264038AbUDNKpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:45:39 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 12:45:37 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141245.37101.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining three patches contain miscellaneous fixes to usbfs.
This one fixes up the disconnect callback to only shoot down urbs
on the disconnected interface, and not on all interfaces.  It also adds
a sanity check (this check is pointless because the interface could
never have been claimed in the first place if it failed, but I feel better
having it there).

 devio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
@@ -341,6 +341,7 @@
 static void driver_disconnect(struct usb_interface *intf)
 {
 	struct dev_state *ps = usb_get_intfdata (intf);
+	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
 
 	if (!ps)
 		return;
@@ -349,11 +350,12 @@
 	 * all pending I/O requests; 2.6 does that.
 	 */
 
-	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
+	if (ifnum < 8*sizeof(ps->ifclaimed))
+		clear_bit(ifnum, &ps->ifclaimed);
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
-	destroy_all_async (ps);
+	destroy_async_on_interface(ps, ifnum);
 }
 
 struct usb_driver usbdevfs_driver = {
