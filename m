Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262171AbSIZEX2>; Thu, 26 Sep 2002 00:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSIZEX1>; Thu, 26 Sep 2002 00:23:27 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:51465 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262171AbSIZEXX>;
	Thu, 26 Sep 2002 00:23:23 -0400
Date: Wed, 25 Sep 2002 21:27:15 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and usb
Message-ID: <20020926042715.GB1790@kroah.com>
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net> <20020926002554.GB518@kroah.com> <3D92749F.9050504@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92749F.9050504@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 07:44:47PM -0700, David Brownell wrote:
> 
> >I also found the unload USB module problem.  The driver core was calling
> >hotplug after the device was already removed.  Made it a bit difficult
> >to be able to describe the device that way :)
> 
> On the other hand, since there's no internal "this is an ex-device"
> state, that's also insurance that nothing could use "usbfs" to try
> to re-activate the device.  I seem to recall oopses going away by
> reporting the hotplug "remove" events after the usbfs path could
> no longer be used.  Not that I ever liked that consequence, but
> a fix adding such a "zombie" state would have taken a bit of time.

Yes, Pat and I have talked a lot about the need for a driver "state".  I
think the current goal was to see how far we can get without needing it.
I was certainly cursing the lack of it today when trying to debug this
problem, but in the end, having it would have only masked over the
real problem that was there.

So personally, I keep going back and forth on if it is really necessary
or not to have.  Right now, the USB drivers and developers are very used
to the fact that when the device disappears from the system, they can
not access it anymore, and that this needs to be constantly checked.  I
think that as time goes on, and more subsystems become "hot-pluggable"
either this paranoia will have to spread to the other subsystems, or we
will have to create the notion of a device "state" to make things
easier on everyone.

> The real "module unload problem" has a lot to do with not having any
> way to track how many devices a module is bound to ... that aren't
> necessarily opened at the moment.  (Does Rusty's patch set touch
> any of that?)

As far as I know, it doesn't, but I'm not sure.

> Without having a way to answer that question, today's un-helpful
> "driver is in active use" refcount would encourage rmmodding drivers
> that users will expect to still be available.  Plug in two devices,
> look at one, decide to use the other, unplug the first ... and just
> because you hadn't yet opened the second device, its driver module
> vanishes.  As you start to use it ... huge frustration quotient! :)

Well, that's a driver unload issue, which I think everyone agrees on the
fact that it's not ok to do automatic driver unload when a device is
removed, because of this very problem.

thanks,

greg k-h
