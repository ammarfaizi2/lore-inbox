Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSCYTMb>; Mon, 25 Mar 2002 14:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312510AbSCYTMT>; Mon, 25 Mar 2002 14:12:19 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48398 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312505AbSCYTMJ>;
	Mon, 25 Mar 2002 14:12:09 -0500
Date: Mon, 25 Mar 2002 11:11:27 -0800
From: Greg KH <greg@kroah.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325191127.GC29011@kroah.com>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com> <20020324142545.GC20703@ufies.org> <20020325180133.GB28629@kroah.com> <20020325181956.GE1853@ufies.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 25 Feb 2002 16:24:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 01:19:56PM -0500, christophe barbé wrote:
> 
> Ok I understand that but hotplug has no way to influence the way the
> device is treated by the driver. The only way I can see is via the /proc
> interface, but at least it is not possible with this driver.

Not true.  The link I pointed to changes the way the "ethX" names are
assigned to the device based on MAC addresses.  So that's just one way
to influence the way a device is treated by a driver.

> 
> > > The problem here is not to give the same interface to a given NIC. The
> > > problem is to give the same options to a given NIC. But a solution can
> > > simply be to set the option from hotplug using the proc interface. The
> > > 3c59x doesn't support that for wol but that can be changed.
> > 
> > Understood.
> 
> So do you agree that something is missing here ?

Yes I do.  See below for more.

> > > > And why is there a limitation of only 8 devices?  Why not do what all
> > > > USB drivers do, and just create the structure that you need to use at
> > > > probe() time, and destroy it at remove() time?
> > > 
> > > This is an implementation issue which is not really important. It comes
> > > from Donald Becker. Your dynamic structure doesn't solve the problem
> > > 'which options for which cards', does it ? 
> > 
> > No, but it solves the problem, "only 8 devices max", and "what to do
> > when a card is removed and then plugged back in."  Both seems like good
> > things to fix in the driver :)
> 
> I have not checked the module loading code but is it possible to define
> for an option a vector with an undefined size ? Or do you consider that
> all devices use the same option ? (the vortex driver is only limited to
> 8 cards for the options passed by modutils)

Ok, in looking more at the 3c59x driver's module parameters, I see your
main problem.  You are relying on module wide options to effect
different cards in a system.  And these different cards could need
different options, right?

If so, yes this is a problem as you have outlined.  Might I suggest a
driverfs entry for the device?  That way every point in the device tree
could have those options be unique for the different device?  This could
also be done like you said above, with a /proc entry (but we are moving
away from /proc entries, remember? :)

Then when /sbin/hotplug is run when your network device is brought up,
it could find the driverfs entry for your device and initialize it with
the proper options (full_duplex, hw_checksums, etc.)

> Could you point me to a specific usb driver ?

In the drivers/usb directory, the following are network drivers:
	CDCEther.c
	catc.c
	kaweth.c
	pegasus.c
	usbnet.c

> How is solved the "what to do when a card is removed and then plugged
> back in." problem ? By keeping the entry for further use ? 

No, all of the information is deleted when a device is removed.  When a
device is inserted again, a structure is created again.  They do not
remember information about the device across removals.

Hope this helps,

greg k-h
