Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVAKDDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVAKDDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAKC7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:59:20 -0500
Received: from ppp242-222.lns2.adl2.internode.on.net ([203.122.242.222]:22724
	"EHLO hank.shelbyville.oz") by vger.kernel.org with ESMTP
	id S262560AbVAKClO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:41:14 -0500
Date: Tue, 11 Jan 2005 13:10:50 +1030
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: RFC: Code to snatch a device from a generic driver
Message-ID: <20050111024050.GA3255@hank.shelbyville.oz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Ron <ron@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We're presently working on enabling the cpad[1] and wacom kernel
modules to retrieve their particular devices from a more generic
driver that may have already claimed them, without resorting to
patching other drivers as we see with the quirks in usbhid.
In 2.6 we can no longer even pull the 'add below hid' stunt
that got us by from userspace in 2.4 [2] -- however the new driver
core model as I understand it seems like it should be able to
handle this very nicely from within the module itself.

The following code (derived from a patch sent to me by Jan
Steinhoff) seems to do the job, but is surely not correct yet.

The cpad really is a one off device at present, so it can get
by with something like this at this stage, but the wacom driver
will need to iterate over its id table if it is to do it the
same way.  And if I haven't totally botched the locking below[3]
that means it will need to collect the locks of all the devices
it finds before it registers with they usb core -- if there is
more than one such device attached to the system.

Which seems to me like a sure recipe for occasional deadlock,
unless there is a guarantee I'm missing here somewhere.

I believe that Greg KH has a pretty good handle on this, and
possibly this is the issue he is aiming to fix still, but I
think there are surely other people who need to do this too
so I'm posting here now, because the following doesn't crash
under the testing I've given it so far, so only more eyeballs
or more testing is going to tell me what else may be wrong
with it, and tell us what still needs to be mended in the
kernel proper.

Comments from anyone with an interest in this would be
greatly appreciated.  Please cc, it's been many years since
my inbox could cope with vger.

thanks,
Ron


static int __init cpad_init(void)
{
	struct usb_device *udev = usb_find_device(USB_VENDOR_ID_SYNAPTICS,
	                                          USB_DEVICE_ID_CPAD);
	if (udev) {
		down( &udev->serialize );
		down_write( &udev->dev.bus->subsys.rwsem );

		struct usb_interface *interface = usb_ifnum_to_if(udev, 0);

		if (interface && usb_interface_claimed(interface))
		{
			info("releasing cPad from generic driver '%s'.",
			     interface->dev.driver->name);
			usb_driver_release_interface(
			       to_usb_driver(interface->dev.driver),interface);
		}

		up_write( &udev->dev.bus->subsys.rwsem );
		usb_put_dev(udev);
	}

	int result = usb_register(&cpad_driver);

	if (udev)
		up( &udev->serialize );

	if (result == 0) {
		cpad_procfs_init();
		info(DRIVER_DESC " " DRIVER_VERSION);
	}
	else
		err("usb_register failed. Error number %d", result);

	return result;
}


[1] The cPad is an lcd backed touchpad from synaptics,
    the module is not in the mainline kernel yet, we were
    too late for 2.4 and slow to get onboard 2.6 ...
    (we being the authors, none of us are associated with
    synaptics)
[2] without some nasty acrobatics
[3] which is quite possible, I'm still very green to kernel 2.6

