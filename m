Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTH2Uoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTH2UoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:44:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:12167 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262228AbTH2Unq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:43:46 -0400
Date: Fri, 29 Aug 2003 13:43:59 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, Patrick Mochel <mochel@osdl.org>
Subject: [PATCH] Fix oopses with usb-serial devices (2.6.0-test4)
Message-ID: <20030829204359.GA2601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a small patch that fixes the oops that happens in the latest
2.6 kernels when you plug in a keyspan or whiteheat usb to serial
device.  Thanks to Ben for pointing out that there is a problem, and to
Pat for finding where the problem was (in my code, not his :)

I'll be sending it on to Linus next week, but here is is for those
people who want to use their devices again.

thanks,

greg k-h


# USB: fix oops in keyspan and whiteheat devices when plugged in.

diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Fri Aug 29 13:39:11 2003
+++ b/drivers/usb/serial/usb-serial.c	Fri Aug 29 13:39:11 2003
@@ -871,7 +871,8 @@
 
 	/* the ports are cleaned up and released in port_release() */
 	for (i = 0; i < serial->num_ports; ++i)
-		device_unregister(&serial->port[i]->dev);
+		if (serial->port[i]->dev.parent != NULL)
+			device_unregister(&serial->port[i]->dev);
 
 	/* If this is a "fake" port, we have to clean it up here, as it will
 	 * not get cleaned up in port_release() as it was never registered with
