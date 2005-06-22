Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFVP7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFVP7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVFVP5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:57:47 -0400
Received: from gw.alcove.fr ([81.80.245.157]:44479 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261569AbVFVPza convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:55:30 -0400
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created
	when probe fails
From: Stelian Pop <stelian@popies.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 22 Jun 2005 17:53:28 +0200
Message-Id: <1119455608.4651.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 11:41 -0400, Alan Stern a écrit :

> This is a curious aspect of the driver model core.  Should failure of a 
> driver to bind be considered serious enough to cause device_add to fail?
> The current answer is Yes unless the driver's probe routine returns 
> -ENODEV or -ENXIO, in which case the failure is not considered serious.

Indeed. I've also tracked my problem down to the hid core which returns
-EIO when it fails to drive an unknown HID device, instead of a more
logical -ENODEV (this is not a failure to init a known device, but
rather the impossibility to init an unknown device).

The patch below solves the problem for me:

Index: linux-2.6-trunk.git/drivers/usb/input/hid-core.c
===================================================================
--- linux-2.6-trunk.git.orig/drivers/usb/input/hid-core.c	2005-06-22
10:33:23.000000000 +0200
+++ linux-2.6-trunk.git/drivers/usb/input/hid-core.c	2005-06-22
17:43:10.000000000 +0200
@@ -1784,7 +1784,7 @@
 	if (!hid->claimed) {
 		printk ("HID device not claimed by input or hiddev\n");
 		hid_disconnect(intf);
-		return -EIO;
+		return -ENODEV;
 	}
 
 	printk(KERN_INFO);


> IMO this is a perverse way of doing things.  The existence of a device has 
> nothing to do with what driver is bound to it.  Either the device exists 
> or it doesn't -- and if it exists, failure to bind a driver shouldn't 
> prevent adding the device into sysfs.  Right now, however, it does.

I agree, presence in /sys/devices shouldn't be related to the existence
or success/failure of a driver. The link between /sys/class
towards /sys/devices is already saying this.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

