Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSI0EhU>; Fri, 27 Sep 2002 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSI0EhU>; Fri, 27 Sep 2002 00:37:20 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:17164 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261625AbSI0EhT>;
	Fri, 27 Sep 2002 00:37:19 -0400
Date: Thu, 26 Sep 2002 21:41:05 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: mdharm-usb@one-eyed-alien.net, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: devicefs requests
Message-ID: <20020927044104.GA8728@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1E8C5@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E8C5@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 11:13:37AM -0500, Matt_Domsch@Dell.com wrote:
> 
> What I'm picturing is something like this (feedback welcome!):

<nice picture snipped>

Yes, I think this is a nice goal, and that driverfs is the right way to
do this.  But you might want to walk the bus lists of the different
devices a bit differently.  Here's a small example of how to walk all of
the USB devices in a system, and see if they match a specific vendor_id
and product_id:


static int match_device (struct usb_device *dev)
{
	int retval = -ENODEV;
	int child;

	dbg ("looking at vendor %d, product %d\n",
	dev->descriptor.idVendor,
	dev->descriptor.idProduct);

	/* see if this device matches */
	if ((dev->descriptor.idVendor == vendor_id) &&
	    (dev->descriptor.idProduct == product_id)) {
		dbg ("found the device!\n");
		retval = 0;
		goto exit;
	}

	/* look through all of the children of this device */
	for (child = 0; child < dev->maxchild; ++child) {
		if (dev->children[child]) {
			retval = match_device (dev->children[child]);
			if (retval == 0)
				goto exit;
		}
	}
exit:
	return retval;
}

static int find_usb_device (void)
{
	struct list_head *buslist;
	struct usb_bus *bus;
	int retval = -ENODEV;

	down (&usb_bus_list_lock);
	for (buslist = usb_bus_list.next;
		buslist != &usb_bus_list; 
		buslist = buslist->next) {
		bus = container_of (buslist, struct usb_bus, bus_list);
		retval = match_device(bus->root_hub);
		if (retval == 0)
			goto exit;
		}
exit:
	up (&usb_bus_list_lock);
	return retval;
}

I think usb_bus_list_lock and usb_bus_list needs to be exported for
these functions to work outside of the USB core, but if you need them,
I'd don't have a problem with exporting them.

Doing something like this might be easier than trying to get the driver
core to let you walk all of its devices.  But Pat could answer that
better than I could.

Good luck,

greg k-h
