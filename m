Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTLJVKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLJVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:10:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:12009 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264123AbTLJVJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:09:57 -0500
Date: Wed, 10 Dec 2003 13:08:54 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031210210854.GA8724@kroah.com>
References: <20031210153056.GA7087@kroah.com> <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org> <20031210204621.GA8566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210204621.GA8566@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 12:46:21PM -0800, Greg KH wrote:
> > Of course, if all you want to do is unload the module then it doesn't 
> > matter which host is which.  You just have to wait until they are all 
> > gone.
> 
> Exactly, and that will happen, if we wait on that
> class_device_unregister() call.  An example of how to do that can be
> seen in the i2c_del_adapter() function in drivers/i2c/i2c-core.c.

Ok, below is the patch.  I've only compile tested it, not run it yet.
Please let me know if it works for you or not.

thanks,

greg k-h


===== hcd.c 1.123 vs edited =====
--- 1.123/drivers/usb/core/hcd.c	Sun Dec  7 04:29:05 2003
+++ edited/hcd.c	Wed Dec 10 13:06:19 2003
@@ -588,6 +588,9 @@
 
 	if (bus->release)
 		bus->release(bus);
+	/* FIXME change this when the driver core gets the
+	 * class_device_unregister_wait() call */
+	complete(&bus->released);
 }
 
 static struct class usb_host_class = {
@@ -724,7 +727,11 @@
 
 	clear_bit (bus->busnum, busmap.busmap);
 
+	/* FIXME change this when the driver core gets the
+	 * class_device_unregister_wait() call */
+	init_completion(&bus->released);
 	class_device_unregister(&bus->class_dev);
+	wait_for_completion(&bus->released);
 }
 EXPORT_SYMBOL (usb_deregister_bus);
 
===== usb.h 1.164 vs edited =====
--- 1.164/include/linux/usb.h	Mon Oct  6 10:46:13 2003
+++ edited/usb.h	Wed Dec 10 13:07:27 2003
@@ -210,6 +210,8 @@
 
 	struct class_device class_dev;	/* class device for this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
+	/* FIXME, remove this when the driver core gets class_device_unregister_wait */
+	struct completion released;
 };
 #define	to_usb_bus(d) container_of(d, struct usb_bus, class_dev)
 
