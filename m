Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVI2ABx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVI2ABx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVI2ABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:01:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751261AbVI2ABw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:01:52 -0400
Date: Wed, 28 Sep 2005 17:01:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com, rusty@rustcorp.com.au
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
Message-Id: <20050928170133.5406f8f4.zaitcev@redhat.com>
In-Reply-To: <20050928085159.GA11862@kroah.com>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	<20050928085159.GA11862@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 01:52:00 -0700, Greg KH <greg@kroah.com> wrote:

> Ok, fair enough, but it is nice at times to mix ub and usb-storage
> device controlled devices.

I mixed them just fine, as long as the protocol was different.
The difference now is how we can split devices with same protocol
by their IDs.

> >  - Devices can be marked for use by ub or usb-storage without rebuilding
> >    or rebooting.
> 
> How?  I missed this in the patch somewhere.

I do it with  rmmod ub, rmmod libusual, then changing the module
parameter to bias="usb-storage". Then either modprobe usb-storage or
replug the device. In Gentoo we could simply rebuild with
CONFIG_BLK_DEV_UB unset, but in Fedora this is more useful.

Ultimately I wanted to add some facility to add IDs, but it was
too tricky to be included into this first cut.

> >  - The scheme can be useful for sharing of devices between
> >    HID, Wacom, and Apitek, if we like how it works for the storage.
> 
> Fair enough, so we should rename it :)

I was going to have a very similar, but separate shared piece
called "libhideous", you know, because it's HIDeous. Then, maybe
factor out common parts... Maybe make it part of core, if we find it
useful. I'll ask Ping Cheng and Kristian Hoksberg about it. The flow
of requests to add another Wacom ID to the exclusion list is not very
strong recently.

> Just to verify that I read this code correct, is this how it all works?
> 
> 	- kernel finds usb device and calls out to hotplug with the
> 	  device id stuff.
> 	- hotplug scripts load libusual as that is where the mod info is
> 	  pointing to.
> 	- libusual's probe function gets called.
> 	- kernel thread is spawned and probe fails
> 	- module for "preferred" driver is loaded with a call to
> 	  request_module
> 	- requested module is loaded.
> 	- requested module's probe is called by core and device is bound
> 	  to it.
> 
> Did I get that correct?

Yes.

It is not the only mode of operation. You can modprobe modules by
hand, and also our installer can load them without hotplug.
In such case, dependancies cause libusual to be loaded ahead.

Another situation is when modules are built statically. I recommend
not to use libusual when building static kernel, and pre-select
usb-storage or ub, depending on application. There was company which
shipped static ub in arcage game machines. Libusual continues to work
but it's rather silly.

> If so, a few comments.
>   - This only covers the "which module to load" question.  Once the
>     module is loaded, it still always grabs the storage devices, even if
>     another module is loaded later on.  Isn't that still the same issue
>     we have today?  Can't we fix this too?

I am very sorry, I forgot a little piece of code in component driver's
probe() routines, like this:

@@ -2168,6 +2176,9 @@ static int ub_probe(struct usb_interface
 	int rc;
 	int i;
 
+	if (USB_US_TYPE(dev_id->driver_info) != USB_US_TYPE_UB)
+		return -ENXIO;
+
 	rc = -ENOMEM;
 	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
 		goto err_core;

I'll retest and resend a corrected patch.

>   - request_module() is icky.  I keep wanting to get rid of that
>     function, and really don't want to see any further users get added.
>     But that's just my feeling, if there's no other way to do this, I
>     don't mind.

Yes, yes, and yes. And also, it looks to me as if I am trying to do
something which "obviously" belongs to modprobe or other user mode
component. The trouble is, I am unable to find a different solution
which would not involve an alias pointing to an alias, and Rusty's
modprobe does not allow that. I could hack it up easily, but he
put in a comment, "that way lies madness". He probably knew what
he was doing.

-- Pete
