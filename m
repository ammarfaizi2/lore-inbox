Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTIEP2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbTIEP2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:28:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34760 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262661AbTIEP2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:28:34 -0400
Date: Fri, 5 Sep 2003 08:23:20 -0700
From: Greg KH <greg@kroah.com>
To: Ingo Oeser <ioe@perch.kroah.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.22, USB visor module crashing on HotSync.
Message-ID: <20030905152320.GA16363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 01:30:22PM +0200, Ingo Oeser wrote:
> Hi Greg,
> 
> there seems to be a problem with the visor module and usb_serial.
> 
> Please look at __serial_close() and usb_disconnect() calling it
> in line 1406 vs. line 1408. I would suggest removing 1408 or
> folding it into __serial_close().
> 
> Formal Bug-Reporting follows:
> 
> [1.] One line summary of the problem:
> 
>       USB visor module and usb_serial crashing on HotSync in usb_disconnect
> 
> [2.] Full description of the problem/report:
> 
>       usb_disconnect calls __serial_close() which sets the tty = NULL
>       and afterwards trys to set tty->private_data = NULL
>       which will crash

Nice, someone else reported this yesterday for the ftdi_sio driver.

Can you test the patch below and let me know if this fixes it?

thanks,

greg k-h


--- a/drivers/usb/serial/usbserial.c	Sat Aug 30 23:27:18 2003
+++ b/drivers/usb/serial/usbserial.c	Thu Sep  4 13:48:45 2003
@@ -556,7 +556,10 @@
 		else
 			generic_close(port, filp);
 		port->open_count = 0;
-		port->tty = NULL;
+		if (port->tty) {
+			port->tty->driver_data = NULL;
+			port->tty = NULL;
+		}
 	}
 
 	if (port->serial->type->owner)
@@ -1401,12 +1404,9 @@
 		for (i = 0; i < serial->num_ports; ++i) {
 			port = &serial->port[i];
 			down (&port->sem);
-			if (port->tty != NULL) {
-				while (port->open_count > 0) {
+			if (port->tty != NULL)
+				while (port->open_count > 0)
 					__serial_close(port, NULL);
-				}
-				port->tty->driver_data = NULL;
-			}
 			up (&port->sem);
 		}
 
