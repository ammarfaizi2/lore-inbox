Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJMEYU>; Sun, 13 Oct 2002 00:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJMEYT>; Sun, 13 Oct 2002 00:24:19 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:18670 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261423AbSJMEYS>; Sun, 13 Oct 2002 00:24:18 -0400
Date: Sat, 12 Oct 2002 21:30:08 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] 2.5.42 partial fix for older pl2303
Message-ID: <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net> <20021013011644.GA12720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013011644.GA12720@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 06:16:44PM -0700, Greg KH wrote:
[snip stuff regarding pl2303 on 2.4.20-pre]
> Now, would you mind taking a look at 2.5, and fixing this there too? :)

Here's a half-successful attempt. With this patch, the device no longer
appears twice, and it always works on the first open (at least, so I've
observed up to this point). The open following a successful open usually
fails (roughly speaking, it appears to play dead), and the open following
a failed open usually (always?) succeeds.

So, on my PL-2303, it's not perfect but it's certainly livable.

This patch is based on the one I did for 2.4, and in fact, this code
functions when it's plugged into 2.4.20-pre10 instead of 2.5.42. In that
scenario, the opens work 100% of the time.

I'd be interested in suggestions or comments regarding this patch.
Anyone who has a PL-2303 working under 2.5 might want to try this patch
just to make sure it doesn't kill their working setup.

-Barry K. Nathan <barryn@pobox.com>

diff -ur linux-2.5.42/drivers/usb/serial/usb-serial.c linux-2.5.42-bkn1/drivers/usb/serial/usb-serial.c
--- linux-2.5.42/drivers/usb/serial/usb-serial.c	2002-10-12 20:13:30.000000000 -0700
+++ linux-2.5.42-bkn1/drivers/usb/serial/usb-serial.c	2002-10-12 20:22:02.000000000 -0700
@@ -1237,16 +1237,18 @@
 	}
 
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
-#if 0
+#if 1
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
+		//if (ifnum == 1) {
+		if (interface != &dev->actconfig->interface[0]) {
 			/* check out the endpoints of the other interface*/
-			interface = &dev->actconfig->interface[ifnum ^ 1];
+			//interface = &dev->actconfig->interface[ifnum ^ 1];
+			interface = &dev->actconfig->interface[0];
 			iface_desc = &interface->altsetting[0];
 			for (i = 0; i < iface_desc->bNumEndpoints; ++i) {
 				endpoint = &iface_desc->endpoint[i];
@@ -1259,6 +1261,15 @@
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
Only in linux-2.5.42-bkn1/drivers/usb/serial: usb-serial.c~
