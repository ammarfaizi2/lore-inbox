Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJMAhB>; Sat, 12 Oct 2002 20:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSJMAhB>; Sat, 12 Oct 2002 20:37:01 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:18670 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261386AbSJMAhA>; Sat, 12 Oct 2002 20:37:00 -0400
Date: Sat, 12 Oct 2002 17:42:49 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: marcelo@conectiva.com.br, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20-pre10: make PL-2303 hack work again
Message-ID: <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch allows the PL-2303 hack to work again. It applies
to and has been tested with 2.4.20-pre10. Testing included using an ISDN
"modem" connected to the PL-2303 to do some web browsing and some
downloads (including a gzipped Linux 2.5.42 tarball).

The patch resurrects a sanity check (or so it appears to me) which was
removed in 2.4.20-pre2. However, the new version of the check is
contained within the PL-2303 hack #ifdef's, and it no longer relies on
variables like interrupt_pipe which have been removed from the USB
serial code.

Given that 2.4.19 works with my PL-2303 and 2.4 is supposed to be a
"stable" series, I'd appreciate if this patch (or another which fixes my
problem) could be merged. If this patch needs improvements first, please
let me know.

-Barry K. Nathan <barryn@pobox.com>

diff -ru linux-2.4.20-pre10/drivers/usb/serial/usbserial.c linux-2.4.20-pre10-bkn4/drivers/usb/serial/usbserial.c
--- linux-2.4.20-pre10/drivers/usb/serial/usbserial.c	2002-09-26 02:23:00.000000000 -0700
+++ linux-2.4.20-pre10-bkn4/drivers/usb/serial/usbserial.c	2002-10-12 17:21:00.000000000 -0700
@@ -1182,11 +1182,11 @@
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
 	/* BEGIN HORRIBLE HACK FOR PL2303 */ 
 	/* this is needed due to the looney way its endpoints are set up */
-	if (ifnum == 1) {
-		if (((dev->descriptor.idVendor == PL2303_VENDOR_ID) &&
-		     (dev->descriptor.idProduct == PL2303_PRODUCT_ID)) ||
-		    ((dev->descriptor.idVendor == ATEN_VENDOR_ID) &&
-		     (dev->descriptor.idProduct == ATEN_PRODUCT_ID))) {
+	if (((dev->descriptor.idVendor == PL2303_VENDOR_ID) &&
+	     (dev->descriptor.idProduct == PL2303_PRODUCT_ID)) ||
+	    ((dev->descriptor.idVendor == ATEN_VENDOR_ID) &&
+	     (dev->descriptor.idProduct == ATEN_PRODUCT_ID))) {
+		if (ifnum == 1) {
 			/* check out the endpoints of the other interface*/
 			interface = &dev->actconfig->interface[ifnum ^ 1];
 			iface_desc = &interface->altsetting[0];
@@ -1201,6 +1201,15 @@
 				}
 			}
 		}
+
+		/* Now make sure the PL-2303 is configured correctly.
+		 * If not, give up now and hope this hack will work
+		 * properly during a later invocation of usb_serial_probe
+		 */
+		if (num_bulk_in == 0 || num_bulk_out == 0) {
+			info("PL-2303 hack: descriptors matched but endpoints did not");
+			return NULL;
+		}
 	}
 	/* END HORRIBLE HACK FOR PL2303 */
 #endif
Only in linux-2.4.20-pre10-bkn4/drivers/usb/serial: usbserial.c~
