Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUDWSER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUDWSER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUDWSER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:04:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:19089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264893AbUDWSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:04:14 -0400
Date: Fri, 23 Apr 2004 11:03:42 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz
Cc: Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423180342.GA14533@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <1082723147.1843.14.camel@merlin> <200404230802.42293.dtor_core@ameritech.net> <20040423153111.GB12126@kroah.com> <20040423171953.GB13835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423171953.GB13835@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 10:19:53AM -0700, Greg KH wrote:
> On Fri, Apr 23, 2004 at 08:31:11AM -0700, Greg KH wrote:
> > 
> > No, we need to oops, as that's a real bug.  Can you post the whole oops
> > that was generated with this usb problem?  I can't seem to duplicate
> > this here.
> 
> Nevermind I dug up a device here that causes this problem.  I'll track
> it down...

Ok, here's a patch that fixes it for me.  I was waiting for a good
reason to finally get rid of this fake usb_interface structure, and now
I have it :)

Let me know if it solves the problem for you too and then I'll send it
off to Linus.

Any objections Vojtech?

thanks,

greg k-h


# USB: fix up fake usb_interface structure in hiddev
#
# This fixes a oops in the current kernel tree.

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Fri Apr 23 11:00:23 2004
+++ b/drivers/usb/input/hiddev.c	Fri Apr 23 11:00:23 2004
@@ -53,7 +53,6 @@
 	wait_queue_head_t wait;
 	struct hid_device *hid;
 	struct hiddev_list *list;
-	struct usb_interface intf;
 };
 
 struct hiddev_list {
@@ -234,7 +233,7 @@
 static struct usb_class_driver hiddev_class;
 static void hiddev_cleanup(struct hiddev *hiddev)
 {
-	usb_deregister_dev(&hiddev->intf, &hiddev_class);
+	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
 	hiddev_table[hiddev->minor] = NULL;
 	kfree(hiddev);
 }
@@ -775,7 +774,7 @@
 		return -1;
 	memset(hiddev, 0, sizeof(struct hiddev));
 
- 	retval = usb_register_dev(&hiddev->intf, &hiddev_class);
+ 	retval = usb_register_dev(hid->intf, &hiddev_class);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		kfree(hiddev);
@@ -784,13 +783,13 @@
 
 	init_waitqueue_head(&hiddev->wait);
 
- 	hiddev->minor = hiddev->intf.minor;
- 	hiddev_table[hiddev->intf.minor - HIDDEV_MINOR_BASE] = hiddev;
+ 	hiddev->minor = hid->intf->minor;
+ 	hiddev_table[hid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
 
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
- 	hid->minor = hiddev->intf.minor;
+ 	hid->minor = hid->intf->minor;
 	hid->hiddev = hiddev;
 
 	return 0;
