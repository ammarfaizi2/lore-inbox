Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVANCxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVANCxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVANCxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:53:44 -0500
Received: from ppp242-222.lns2.adl2.internode.on.net ([203.122.242.222]:61124
	"EHLO hank.shelbyville.oz") by vger.kernel.org with ESMTP
	id S261865AbVANCxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:53:38 -0500
Date: Fri, 14 Jan 2005 13:23:11 +1030
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Code to snatch a device from a generic driver
Message-ID: <20050114025310.GA6447@hank.shelbyville.oz>
References: <20050111024050.GA3255@hank.shelbyville.oz> <20050111193455.GE4623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111193455.GE4623@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ron <ron@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 11:34:56AM -0800, Greg KH wrote:
> No, try something like the following.  It creates a sysfs file that you
> can write to to unbind the device manually.

Thanks!  That's a potentially treacherous little toy to add to my
system, but it does work as advertised and it took me on a very nice
tour of appropriate internals.

> The binding a driver to a device manually is left as an exercise to the
> reader :)
> 
> Seriously, I'm working on adding this to the driver core so you don't
> have to do stuff like this in drivers.

Yes, I didn't seriously intend people should paste such goop into their
modules, right now I'm just digging my way through to the desired
functionality -- armed only with some rusty memories of 2.4, a broken
hacksaw blade, and grep ...  This should certainly be a core library
function of some form by the time we are through.

My next candidate is shown below.  Aside from the (relatively) minor
things commented there (and any that I still don't see), it seems to
have one major deficiency still, which I'll call 'warmplug' support,
(being somewhere between the increasingly ill-named hot and 'cold' plug
problems)

It will correctly snatch a device from a generic driver when the module
is loaded.  This covers 'first time users' installing the module into a
running kernel, and likewise subsequent hotplug operations when the module
is not installed at the time the device is plugged in.  But it fails
when both the generic module and the specialised module are already
loaded and the generic module was registered with the usbcore first.

In that case the generic module will ack the probe and the more
specialised module will never be queried about the device (and hence
have no opportunity to steal it).  The user must force a module reload
for the later module to get a chance to grab it.  In the case of the
wacom device, it appears to be able to lose this race from a cold boot
on a UP machine.  If the device is discovered during boot both modules
will be probed and installed but all modules fail to initialise it at
that time, since other required things are still cycling up.  Once
everyone is on the same page and the device is ready to be bound,
the modules are already loaded and so the problem above plays out.

Which I think takes us back to a more basic problem...  that I need
to register this intention to want a device more than some generic
driver does with the usb core itself -- so it can dispatch the probe
calls in a more ordered fashion from most specialised to most generic
candidates for a particular device, rather than just stopping with the
first driver that says it can handle it in some form.

I'm going to look at this more today.  All thoughts welcome.  Code below
is for vanilla 2.6.10 and still using the subsys.rwsem for now.

cheers,
Ron


/* Module side boilerplate
*/
static int __init cpad_init(void)
{
	int result = usb_register(&cpad_driver);
	if (result == 0) {
		info(DRIVER_DESC " " DRIVER_VERSION);
		repossess_devices(&cpad_driver, cpad_idtable);
	} else
		err("usb_register failed, error number: %d", result);

	return result;
}

/* Snatch all devices listed by @id from (hopefully) more generic drivers
   and bind them to @driver.  @id may be the same list passed to
   MODULE_DEVICE_TABLE, or a separate list subject to this more aggressive
   binding.
*/
static void repossess_devices(struct usb_driver *udrv,
                              struct usb_device_id *id)
{
	while (id->idVendor)
	{
		// XXX Not enough, we need to find ALL devices, not just the
		//     first of any particular model.  Messy to try and fix
		//     here in the module though, so don't yet.

		struct usb_device *udev = usb_find_device(id->idVendor,
							  id->idProduct);

		if (udev)
		{
			down_write(&udev->dev.bus->subsys.rwsem);
			usb_lock_device(udev);

			// see above
			struct usb_interface *interface = usb_ifnum_to_if(udev,0);

			if (interface->dev.driver &&
			    interface->dev.driver->owner != udrv->driver.owner)
			{
			    if (interface && usb_interface_claimed(interface))
				    device_release_driver(&interface->dev);

			    driver_probe_device(&udrv->driver, &interface->dev);
			}

			usb_unlock_device(udev);
			up_write(&udev->dev.bus->subsys.rwsem);

			usb_put_dev(udev);
		}
		++id;
	}
}


