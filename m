Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWEVWF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWEVWF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWEVWF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:05:26 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:30361 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751224AbWEVWF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:05:26 -0400
Date: Tue, 23 May 2006 00:04:59 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Greg KH <gregkh@suse.de>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Re: usb-serial ipaq kernel problem
Message-ID: <20060522220459.GA1910@fks.be>
References: <20060522143043.GA6408@fks.be> <20060522214403.GA7044@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522214403.GA7044@suse.de>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-104.72,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL -1.01,
	BAYES_05 -0.41, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 02:44:03PM -0700, Greg KH wrote:
> On Mon, May 22, 2006 at 04:30:48PM +0200, Frank Gevaerts wrote:
> > Hi, 
> > 
> > We are having problems with the usb-serial ipaq driver in 2.6.16 (debian
> > backports 2.6.16-1-686, but also reproducible with self-compiled
> > kernel.org kernel)
> > 
> > Sometimes, we get the following on disconnect:
> 
> <snip>
> 
> Can you duplicate this on 2.6.17-rc4?  A number of tty changes went into
> that release that should have fixed this issue.

I'll try it in the morning. In the meantime, we found some other
problems in ipaq.c : apparently pocketpc accepts usb enumeration long
before it accepts usb-serial commands (sometimes 50 or more seconds),
which makes ipaq_open fail. When it fails, the read urb is not killed,
while the associated structures are freed, which gives a panic when
the urb completes. The following patch solves that :
Since changing this, I also have not seen the original problem anymore,
but I will do some more testing tomorrow.

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

--- linux-2.6.16/drivers/usb/serial/ipaq.c      2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.ipaq/drivers/usb/serial/ipaq.c 2006-05-23 00:00:33.000000000 +0200
@@ -59,7 +59,7 @@
 #include "usb-serial.h"
 #include "ipaq.h"
 
-#define KP_RETRIES     100
+#define KP_RETRIES     1000
 
 /*
  * Version Information
@@ -652,12 +652,6 @@
                      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
                      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
                      ipaq_read_bulk_callback, port);
-       result = usb_submit_urb(port->read_urb, GFP_KERNEL);
-       if (result) {
-               err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
-               goto error;
-       }
-
        /*
         * Send out control message observed in win98 sniffs. Not sure what
         * it does, but from empirical observations, it seems that the device
@@ -671,8 +665,15 @@
                                usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
                                0x1, 0, NULL, 0, 100);
                if (result == 0) {
+                       result = usb_submit_urb(port->read_urb, GFP_KERNEL);
+                       if (result) {
+                               err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
+                               goto error;
+                       }
+
                        return 0;
                }
+                msleep(100);
        }
        err("%s - failed doing control urb, error %d", __FUNCTION__, result);
        goto error;

> 
> thanks,
> 
> greg k-h
> 

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
