Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJMUXz>; Sun, 13 Oct 2002 16:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJMUXz>; Sun, 13 Oct 2002 16:23:55 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:44050 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261698AbSJMUXy>;
	Sun, 13 Oct 2002 16:23:54 -0400
Date: Sun, 13 Oct 2002 13:25:04 -0700
From: Greg KH <greg@kroah.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] 2.5.42 partial fix for older pl2303
Message-ID: <20021013202504.GA23533@kroah.com>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net> <20021013011644.GA12720@kroah.com> <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 09:30:08PM -0700, Barry K. Nathan wrote:
> On Sat, Oct 12, 2002 at 06:16:44PM -0700, Greg KH wrote:
> [snip stuff regarding pl2303 on 2.4.20-pre]
> > Now, would you mind taking a look at 2.5, and fixing this there too? :)
> 
> Here's a half-successful attempt. With this patch, the device no longer
> appears twice, and it always works on the first open (at least, so I've
> observed up to this point). The open following a successful open usually
> fails (roughly speaking, it appears to play dead), and the open following
> a failed open usually (always?) succeeds.
> 
> So, on my PL-2303, it's not perfect but it's certainly livable.
> 
> This patch is based on the one I did for 2.4, and in fact, this code
> functions when it's plugged into 2.4.20-pre10 instead of 2.5.42. In that
> scenario, the opens work 100% of the time.
> 
> I'd be interested in suggestions or comments regarding this patch.
> Anyone who has a PL-2303 working under 2.5 might want to try this patch
> just to make sure it doesn't kill their working setup.

Nice, I've added this to my tree.  I also made the following patch, to
fix up the proper return value for the probe() call, and fix a memory
leak.

Let me know if this patch causes any problems for you.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Sun Oct 13 13:35:48 2002
+++ b/drivers/usb/serial/usb-serial.c	Sun Oct 13 13:35:48 2002
@@ -1249,7 +1249,6 @@
 	}
 
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
-#if 1
 	/* BEGIN HORRIBLE HACK FOR PL2303 */ 
 	/* this is needed due to the looney way its endpoints are set up */
 	if (((dev->descriptor.idVendor == PL2303_VENDOR_ID) &&
@@ -1280,11 +1279,11 @@
 		 */
 		if (num_bulk_in == 0 || num_bulk_out == 0) {
 			info("PL-2303 hack: descriptors matched but endpoints did not");
-			return NULL;
+			kfree (serial);
+			return -ENODEV;
 		}
 	}
 	/* END HORRIBLE HACK FOR PL2303 */
-#endif
 #endif
 
 	/* found all that we need */
