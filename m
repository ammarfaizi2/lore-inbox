Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVF3TbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVF3TbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVF3TaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:30:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:1422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262984AbVF3T3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:29:38 -0400
Date: Thu, 30 Jun 2005 09:01:50 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050630160150.GB6828@kroah.com>
References: <20050624051229.GA24621@kroah.com> <200506242322.57535.dtor_core@ameritech.net> <20050629234755.GA19599@kroah.com> <200506300113.54001.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300113.54001.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 01:13:53AM -0500, Dmitry Torokhov wrote:
> On Wednesday 29 June 2005 18:47, Greg KH wrote:
> > On Fri, Jun 24, 2005 at 11:22:57PM -0500, Dmitry Torokhov wrote:
> > > On Friday 24 June 2005 00:12, Greg KH wrote:
> > > > Even so, with these two patches, people should be able to do things that
> > > > they have been wanting to do for a while (like take over the what driver
> > > > to what device logic in userspace, as I know some distro installers
> > > > really want to do.)
> > > > 
> > > 
> > > I think bind/unbind should be bus's methods and attributes should be
> > > created only if bus supports such operations. Some buses either have
> > > or may need additional locking considerations and will not particularly
> > > like driver core getting in the middle of things.
> > 
> > Examples of such?
> 
> serio, gameport. Everything is protected by a semaphore, partly for
> historical reasons, partly because when adding children devices parent
> devices need to be locked too...

Why do parent devices need to be locked?  Reference counting in the
driver core should take care of everything properly, right?  Also, these
are not hotpluggable devices, so it should be a lot easier :)

> > Yes, a bus that isn't really expecting this to 
> > happen, as it has some odd locking logic in the
> > registering/unregistering of a new driver for it, might have issues.
> > But I'd say that this is the bus's fault, not the driver core's fault.
> >
> 
> I don't think so. Up to now all driver core iteractions were under
> individual bus code control. Now out of sudden you allow disconnecting
> device from its driver from outside of bus control and you are saying
> that's all right. Driver core is a framework; buses use driver core to
> simplify their tasks but driver core does not really control their
> operations. 

Well, yes and no.  I see the driver core driving a lot of interactions,
due to the probing and matching and disconnecting all coming from the
core, but I guess as they are usually initiated from the bus itself, I
can see how you feel this way also.  So ok, yes, this is a change, I
agree.  But it isn't one that should cause major issues.

> > Becides, you can just have the bus fail such a bind/unbind attempt, if
> > you really want to do that.
> >
> 
> How can you do it cleanly? probe and remove routined do not have any idea
> how they were called.

You can set a flag if those functions come from your own bus (due to
device/driver add/remove) and check that, but I agree, that's an ugly
hack...

> > Anyway, I've tested this with PCI and USB devices, and they both work
> > just fine, and those are the busses that the majority of people want
> > this functionality for.
> 
> That is really sloppy. "It happens to work for 2 buses I care about so it
> must be perfect"?

Heh, at least I tried 2 :)

No, I don't mean to be sloppy, I just tested what I had availble, like
almost everyone else.


> > > Btw, do we really need separate attributes for bind/unbind?
> > 
> > Overloading a single file would be messier.  The overhead for an
> > additional attribute per driver is quite small (I move the unbind
> > attribute to the driver, as it makes more sense there as Pat mentioned.)
> > 
> 
> Let me ask again - what if we need more operations similar to [un]bind,
> such as rescan?

"rescan"?  Like reprobe the bus address space?  That sounds like a bus
specific issue.  But if you like I could add a general bus callback for
that and an attribute for it.  I know pci could use that for some odd
cases (see the fakephp driver for an example of how to do rescan for pci
devices from a driver itself.)

> They do not use a specific driver but work for device.

Yes, and as such, rescan should be a bus attribute, not a driver or
device one.

> If you keep bind/unbind in driver and rescan/reconnect/etc in device
> subdirectoty it will be rather messy. Please consider movin in the
> opposite directtion - have bind and unbind attributes of device, not
> driver.

No, I put bind/unbind in the driver directory.  There is no additions to
the device directory.

> Also, what about rolling bind_mode attribute into driver core as well?

Um, I don't recall what you are referring to here.  Have a
pointer/patch?

thanks,

greg k-h
