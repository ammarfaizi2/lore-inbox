Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVAKThK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVAKThK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVAKThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:37:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30413 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262337AbVAKTgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:36:49 -0500
Date: Tue, 11 Jan 2005 11:34:56 -0800
From: Greg KH <greg@kroah.com>
To: Ron <ron@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Code to snatch a device from a generic driver
Message-ID: <20050111193455.GE4623@kroah.com>
References: <20050111024050.GA3255@hank.shelbyville.oz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111024050.GA3255@hank.shelbyville.oz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:10:50PM +1030, Ron wrote:
> 
> Hi,
> 
> We're presently working on enabling the cpad[1] and wacom kernel
> modules to retrieve their particular devices from a more generic
> driver that may have already claimed them, without resorting to
> patching other drivers as we see with the quirks in usbhid.
> In 2.6 we can no longer even pull the 'add below hid' stunt
> that got us by from userspace in 2.4 [2] -- however the new driver
> core model as I understand it seems like it should be able to
> handle this very nicely from within the module itself.
> 
> The following code (derived from a patch sent to me by Jan
> Steinhoff) seems to do the job, but is surely not correct yet.

No, try something like the following.  It creates a sysfs file that you
can write to to unbind the device manually.

The binding a driver to a device manually is left as an exercise to the
reader :)

Seriously, I'm working on adding this to the driver core so you don't
have to do stuff like this in drivers.

thanks,

greg k-h


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-01-11 09:35:48 -08:00
+++ b/drivers/base/bus.c	2005-01-11 09:35:48 -08:00
@@ -243,6 +243,17 @@
 	return ret;
 }
 
+/* manually detach a device from it's associated driver. */
+/* Any write will cause it to happen. */
+static ssize_t device_unbind(struct device *dev, const char *buf, size_t count)
+{
+	down_write(&dev->bus->subsys.rwsem);
+	device_release_driver(dev);
+	up_write(&dev->bus->subsys.rwsem);
+	return count;
+}
+static DEVICE_ATTR(unbind, S_IWUSR, NULL, device_unbind);
+
 /**
  *	device_bind_driver - bind a driver to one device.
  *	@dev:	device.
@@ -264,6 +275,7 @@
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+	device_create_file(dev, &dev_attr_unbind);
 }
 
 
@@ -389,6 +401,7 @@
 	if (drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
+		device_remove_file(dev, &dev_attr_unbind);
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)
