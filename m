Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319409AbSH3DnQ>; Thu, 29 Aug 2002 23:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319419AbSH3DnQ>; Thu, 29 Aug 2002 23:43:16 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:46865 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319409AbSH3DnP>;
	Thu, 29 Aug 2002 23:43:15 -0400
Date: Thu, 29 Aug 2002 20:46:46 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] [RFC] USB driver conversion to "struct device_driver" for 2.5.32
Message-ID: <20020830034646.GA6486@kroah.com>
References: <20020822204457.GA7532@kroah.com> <20020829221339.GA5074@kroah.com> <3D6EB333.7050509@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6EB333.7050509@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the lkml readers, my original post (with patch) didn't seem to go
through to that list, it can be found at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103065990107372

On Thu, Aug 29, 2002 at 04:50:11PM -0700, David Brownell wrote:
> So to be sure I've got this right ... those modified driver
> entry points change things as follows:
> 
> >+	int (*probe) (struct usb_interface *intf,
> >+		      const struct usb_device_id *id);
> 
>  (a) the device (for urbs etc) is now implicit:
>        struct usb_device *dev = interface_to_usbdev (int):

Yes.

>  (b) the interface index should no longer matter

Yes.  But for those drivers that do care, they can get it with the new
usb_if_to_ifnum() function.  This will provide the _correct_ interface
number, the old interface only provided the index, which people seemed
to use as the ifnum.

>  (c) returns 0 (not void *) or -Errno (not null)

Yes.

>  (d) that void * handle is explicitly intf->dev.driver_data

Yes.  dev.driver_data should be wrapped by a function, like
pci_set_drvdata() and pci_get_drvdata() are for.

> >+	void (*disconnect) (struct usb_interface *intf);
> 
>   (a) and (d) above: same change

exactly.

> Makes me wonder about intf->private_data, which was the
> original version of intf->dev.driver_data.  Shouldn't that
> be removed too?

Yes it should.

> It's only used in the interface claiming calls (shouldn't they fit in
> with the driver model?) and usbfs just now.  Is that the usbfs work
> you mentioned?

Yes, that's the part that I am pretty sure is not working properly right
now, and is next on my list of things to clean up.

thanks,

greg k-h
