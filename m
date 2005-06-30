Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVF3GQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVF3GQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVF3GQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:16:14 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:19074 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262871AbVF3GN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:13:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Date: Thu, 30 Jun 2005 01:13:53 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com> <200506242322.57535.dtor_core@ameritech.net> <20050629234755.GA19599@kroah.com>
In-Reply-To: <20050629234755.GA19599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506300113.54001.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 18:47, Greg KH wrote:
> On Fri, Jun 24, 2005 at 11:22:57PM -0500, Dmitry Torokhov wrote:
> > On Friday 24 June 2005 00:12, Greg KH wrote:
> > > Now that we have the internal infrastructure of the driver model
> > > reworked so the locks aren't so global and imposing, it's possible to
> > > bind and unbind drivers from devices from userspace with only a very
> > > tiny ammount of code.
> > > 
> > > In reply to this email, are two patches, one that adds bind and one that
> > > adds unbind functionality.  I've added these to my trees and should show
> > > up in the next -mm releases.  Comments appreciated.
> > > 
> > > Oh, and yes, we still need a way to add new device ids to drivers from
> > > sysfs, like PCI currently has.  I'll be working on that next.
> > >
> > 
> > I think this is an overkill if you can do manual bind/unbind.
> 
> No, this is needed.  You can only bind a device to a driver that will
> accept it.  As we can not add new device ids to all drivers yet (only
> PCI supports that), this isn't as useful as it could be.  I'll be moving
> that PCI code into the driver core, so that all busses that want to
> support this (adding new device ids on the fly), can.
> 

Yes, you are right, sorry.

> > > Even so, with these two patches, people should be able to do things that
> > > they have been wanting to do for a while (like take over the what driver
> > > to what device logic in userspace, as I know some distro installers
> > > really want to do.)
> > > 
> > 
> > I think bind/unbind should be bus's methods and attributes should be
> > created only if bus supports such operations. Some buses either have
> > or may need additional locking considerations and will not particularly
> > like driver core getting in the middle of things.
> 
> Examples of such?

serio, gameport. Everything is protected by a semaphore, partly for
historical reasons, partly because when adding children devices parent
devices need to be locked too...

> Yes, a bus that isn't really expecting this to 
> happen, as it has some odd locking logic in the
> registering/unregistering of a new driver for it, might have issues.
> But I'd say that this is the bus's fault, not the driver core's fault.
>

I don't think so. Up to now all driver core iteractions were under
individual bus code control. Now out of sudden you allow disconnecting
device from its driver from outside of bus control and you are saying
that's all right. Driver core is a framework; buses use driver core to
simplify their tasks but driver core does not really control their
operations. 
 
> Becides, you can just have the bus fail such a bind/unbind attempt, if
> you really want to do that.
>

How can you do it cleanly? probe and remove routined do not have any idea
how they were called.
 
> Anyway, I've tested this with PCI and USB devices, and they both work
> just fine, and those are the busses that the majority of people want
> this functionality for.

That is really sloppy. "It happens to work for 2 buses I care about so it
must be perfect"?

> 
> > Btw, do we really need separate attributes for bind/unbind?
> 
> Overloading a single file would be messier.  The overhead for an
> additional attribute per driver is quite small (I move the unbind
> attribute to the driver, as it makes more sense there as Pat mentioned.)
> 

Let me ask again - what if we need more operations similar to [un]bind,
such as rescan? They do not use a specific driver but work for device.
If you keep bind/unbind in driver and rescan/reconnect/etc in device
subdirectoty it will be rather messy. Please consider movin in the
opposite directtion - have bind and unbind attributes of device, not
driver.

Also, what about rolling bind_mode attribute into driver core as well?

-- 
Dmitry
