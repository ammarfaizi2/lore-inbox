Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUJVNnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUJVNnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUJVNnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:43:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16135 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269648AbUJVNng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:43:36 -0400
Date: Fri, 22 Oct 2004 15:43:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch] 2.6.9-mm1: usb/serial/console.c compile error
Message-ID: <20041022134305.GB2831@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following compile error seems to come from Linus' tree:


<--  snip  -->

...
  CC      drivers/usb/serial/bus.o
  CC      drivers/usb/serial/console.o
drivers/usb/serial/console.c: In function `usb_console_write':
drivers/usb/serial/console.c:221: warning: passing arg 3 of pointer to function makes integer from pointer without a cast
drivers/usb/serial/console.c:221: error: too many arguments to function
drivers/usb/serial/console.c:223: warning: passing arg 3 of `usb_serial_generic_write' makes integer from pointer without a cast
drivers/usb/serial/console.c:223: error: too many arguments to function `usb_serial_generic_write'
make[3]: *** [drivers/usb/serial/console.o] Error 1

<--  snip  -->


This was caused by the changed "write" in usb_serial_device_type.


Is the following patch correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/drivers/usb/serial/console.c.old	2004-10-22 15:12:36.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/usb/serial/console.c	2004-10-22 15:12:59.000000000 +0200
@@ -218,9 +218,9 @@
 
 	/* pass on to the driver specific version of this function if it is available */
 	if (serial->type->write)
-		retval = serial->type->write(port, 0, buf, count);
+		retval = serial->type->write(port, buf, count);
 	else
-		retval = usb_serial_generic_write(port, 0, buf, count);
+		retval = usb_serial_generic_write(port, buf, count);
 
 exit:
 	dbg("%s - return value (if we had one): %d", __FUNCTION__, retval);

