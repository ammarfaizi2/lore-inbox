Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVG3AxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVG3AxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVG3AvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:51:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:6064 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262758AbVG2TSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:18:54 -0400
Date: Fri, 29 Jul 2005 12:18:28 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ddstreet@ieee.org
Subject: [patch 28/29] USB: fix in usb_calc_bus_time
Message-ID: <20050729191828.GD5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-usb_calc_bus_time.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Streetman <ddstreet@ieee.org>

This patch does the same swap, i.e. use the ISO macro if (isoc).  
Additionally, it fixes the return value - the usb_calc_bus_time function 
returns the time in nanoseconds (I didn't notice that before) while the 
HS_USECS and HS_USECS_ISO are microseconds.  This fixes the function to 
return nanoseconds always, and adjusts ehci-q.c (the only high-speed 
caller of the function) to wrap the call in NS_TO_US().

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/core/hcd.c    |    4 ++--
 drivers/usb/core/hcd.h    |    8 +++++---
 drivers/usb/host/ehci-q.c |    4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/hcd.c	2005-07-29 11:30:03.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/hcd.c	2005-07-29 11:36:34.000000000 -0700
@@ -939,9 +939,9 @@
 	case USB_SPEED_HIGH:	/* ISOC or INTR */
 		// FIXME adjust for input vs output
 		if (isoc)
-			tmp = HS_USECS (bytecount);
+			tmp = HS_NSECS_ISO (bytecount);
 		else
-			tmp = HS_USECS_ISO (bytecount);
+			tmp = HS_NSECS (bytecount);
 		return tmp;
 	default:
 		pr_debug ("%s: bogus device speed!\n", usbcore_name);
--- gregkh-2.6.orig/drivers/usb/core/hcd.h	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/hcd.h	2005-07-29 11:36:34.000000000 -0700
@@ -334,17 +334,19 @@
 extern int usb_check_bandwidth (struct usb_device *dev, struct urb *urb);
 
 /*
- * Ceiling microseconds (typical) for that many bytes at high speed
+ * Ceiling [nano/micro]seconds (typical) for that many bytes at high speed
  * ISO is a bit less, no ACK ... from USB 2.0 spec, 5.11.3 (and needed
  * to preallocate bandwidth)
  */
 #define USB2_HOST_DELAY	5	/* nsec, guess */
-#define HS_USECS(bytes) NS_TO_US ( ((55 * 8 * 2083)/1000) \
+#define HS_NSECS(bytes) ( ((55 * 8 * 2083)/1000) \
 	+ ((2083UL * (3167 + BitTime (bytes)))/1000) \
 	+ USB2_HOST_DELAY)
-#define HS_USECS_ISO(bytes) NS_TO_US ( ((38 * 8 * 2083)/1000) \
+#define HS_NSECS_ISO(bytes) ( ((38 * 8 * 2083)/1000) \
 	+ ((2083UL * (3167 + BitTime (bytes)))/1000) \
 	+ USB2_HOST_DELAY)
+#define HS_USECS(bytes) NS_TO_US (HS_NSECS(bytes))
+#define HS_USECS_ISO(bytes) NS_TO_US (HS_NSECS_ISO(bytes))
 
 extern long usb_calc_bus_time (int speed, int is_input,
 			int isoc, int bytecount);
--- gregkh-2.6.orig/drivers/usb/host/ehci-q.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ehci-q.c	2005-07-29 11:36:34.000000000 -0700
@@ -657,8 +657,8 @@
 	 * For control/bulk requests, the HC or TT handles these.
 	 */
 	if (type == PIPE_INTERRUPT) {
-		qh->usecs = usb_calc_bus_time (USB_SPEED_HIGH, is_input, 0,
-				hb_mult (maxp) * max_packet (maxp));
+		qh->usecs = NS_TO_US (usb_calc_bus_time (USB_SPEED_HIGH, is_input, 0,
+				hb_mult (maxp) * max_packet (maxp)));
 		qh->start = NO_FRAME;
 
 		if (urb->dev->speed == USB_SPEED_HIGH) {

--
