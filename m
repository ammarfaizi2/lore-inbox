Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUIVXHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUIVXHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIVXHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:07:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:28339 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268092AbUIVXH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:07:28 -0400
Date: Wed, 22 Sep 2004 16:06:50 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Message-ID: <20040922230650.GB14279@kroah.com>
References: <1095701390.2016.34.camel@mulgrave> <20040922230423.GA14279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922230423.GA14279@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 04:04:23PM -0700, Greg KH wrote:
> I'll post my usb core change after this, to show you how USB can
> be hooked up to it.

And here's the 3 line patch that I added to the usb core to hook up both
the usb and usb-serial drivers to support the modules symlinks.

I'll go mess with the pci core now, but as there is no "struct module *"
in the pci driver structure, it will take a bit of auditing to get them
all hooked up properly.

thanks,

greg k-h

------


USB: add support for symlink from usb and usb-serial driver to its module in sysfs

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2004-09-22 15:56:44 -07:00
+++ b/drivers/usb/core/usb.c	2004-09-22 15:56:44 -07:00
@@ -76,6 +76,7 @@
 }
 
 static struct device_driver usb_generic_driver = {
+	.owner = THIS_MODULE,
 	.name =	"usb",
 	.bus = &usb_bus_type,
 	.probe = generic_probe,
@@ -159,6 +160,7 @@
 	new_driver->driver.bus = &usb_bus_type;
 	new_driver->driver.probe = usb_probe_interface;
 	new_driver->driver.remove = usb_unbind_interface;
+	new_driver->driver.owner = new_driver->owner;
 
 	usb_lock_all_devices();
 	retval = driver_register(&new_driver->driver);
diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	2004-09-22 15:56:44 -07:00
+++ b/drivers/usb/serial/bus.c	2004-09-22 15:56:44 -07:00
@@ -120,6 +120,7 @@
 	device->driver.bus = &usb_serial_bus_type;
 	device->driver.probe = usb_serial_device_probe;
 	device->driver.remove = usb_serial_device_remove;
+	device->driver.owner = device->owner;
 
 	retval = driver_register(&device->driver);
 
