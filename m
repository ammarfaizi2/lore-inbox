Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319547AbSH3FYz>; Fri, 30 Aug 2002 01:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319554AbSH3FYy>; Fri, 30 Aug 2002 01:24:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59921 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319547AbSH3FYx>;
	Fri, 30 Aug 2002 01:24:53 -0400
Date: Thu, 29 Aug 2002 22:28:23 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 port PnP BIOS to the driver model RESEND #1
Message-ID: <20020830052823.GE6486@kroah.com>
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com> <3D6BF1E6.9010701@netscape.net> <20020828051406.GA26263@kroah.com> <3D6E85B1.4040708@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6E85B1.4040708@netscape.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 08:36:01PM +0000, Adam Belay wrote:
> 
> 
> greg@kroah.com wrote:
> 
> >
> >Hi,
> >
> >I don't have a box with a PnP BIOS (well, I don't think I do...), so
> >could you send the relevant portions of the driverfs tree, showing the
> >new devices that you add for this bus?
> >
> Just out of curiosity what architecture are you using, is it one that 
> doesn't support PnP BIOS?

i386, with PnP BIOS support turned off :)

I haven't tried enabling this before, what kind of devices does it
enable?

> Here they are:
> /driverfs/device/pnp
> /driverfs/device/pnp/01
> /driverfs/device/pnp/02
> /driverfs/device/pnp/03
> etc.
> /driverfs/bus/pnp
> /driverfs/bus/pnp/devices
> etc.
> /driverfs/bus/pnp/drivers
> etc.

But what are these devices?  Can you run 'tree' on this so as to
visualize the structure better?

> >Also a few minor comments on the patch:
> >   - pnpbios_bus_type should probably be made static, along with
> >     alloc_pnpbios_root().
> >
> alloc_pnpbios_root is now static.  I'm going to leave bus_type as it is 
> because I want it open to other files at least for now.

Why?  I don't think there's a need for any other code to need to point
to it.  If in the future it's needed, you can always export it :)

> >   - in pnpbios_bus_match(), don't you have to check the value of
> >     the call to match_device() to make sure you have a match?
> >     That would keep pnpbios_device_probe() from being called for
> >     every device like it looks your patch causes.
> >
> I did some serious restructuring here and in pnpbios_device_probe.  Also 
> I made it a bit more like the one used by pci.  Hopefully it's all right 
> now.

Wrong placement of your {} in the while statement :)
You also might want to not hard code the "7" in the memcmp, but use the
size of the smaller field there, incase things change in the future.

> >   - the pnpbios_device_probe() call should return a negative error
> >     number if the device does not match, or some error happens.
> >     Returning 1 does not mean success.  You also need to save off
> >     the device specific info somehow in your structure, so that
> >     the pnpbios_device_remove() can remove it.  Or am I just
> >     missing something here?
> >
> pnpbios_device_probe now returns a negative number on failure.  I'm 
> creating a more flexible pnpbios specific device data structure that can 
> be used instead of pci_dev in my next patch.  I should be able to clean 
> some of this up once I do that.  I'll take care of the device specific 
> info then.

But it still looks like you aren't saving off the needed information in
the dev.driver_data structure.  Or am I missing something?

thanks,

greg k-h
