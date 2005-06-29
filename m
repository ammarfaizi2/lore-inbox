Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVF2Xur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVF2Xur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVF2XuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:50:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:8879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262753AbVF2Xsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:48:39 -0400
Date: Wed, 29 Jun 2005 16:47:55 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050629234755.GA19599@kroah.com>
References: <20050624051229.GA24621@kroah.com> <200506242322.57535.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506242322.57535.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:22:57PM -0500, Dmitry Torokhov wrote:
> On Friday 24 June 2005 00:12, Greg KH wrote:
> > Now that we have the internal infrastructure of the driver model
> > reworked so the locks aren't so global and imposing, it's possible to
> > bind and unbind drivers from devices from userspace with only a very
> > tiny ammount of code.
> > 
> > In reply to this email, are two patches, one that adds bind and one that
> > adds unbind functionality.  I've added these to my trees and should show
> > up in the next -mm releases.  Comments appreciated.
> > 
> > Oh, and yes, we still need a way to add new device ids to drivers from
> > sysfs, like PCI currently has.  I'll be working on that next.
> >
> 
> I think this is an overkill if you can do manual bind/unbind.

No, this is needed.  You can only bind a device to a driver that will
accept it.  As we can not add new device ids to all drivers yet (only
PCI supports that), this isn't as useful as it could be.  I'll be moving
that PCI code into the driver core, so that all busses that want to
support this (adding new device ids on the fly), can.

> > Even so, with these two patches, people should be able to do things that
> > they have been wanting to do for a while (like take over the what driver
> > to what device logic in userspace, as I know some distro installers
> > really want to do.)
> > 
> 
> I think bind/unbind should be bus's methods and attributes should be
> created only if bus supports such operations. Some buses either have
> or may need additional locking considerations and will not particularly
> like driver core getting in the middle of things.

Examples of such?  Yes, a bus that isn't really expecting this to
happen, as it has some odd locking logic in the
registering/unregistering of a new driver for it, might have issues.
But I'd say that this is the bus's fault, not the driver core's fault.

Becides, you can just have the bus fail such a bind/unbind attempt, if
you really want to do that.

Anyway, I've tested this with PCI and USB devices, and they both work
just fine, and those are the busses that the majority of people want
this functionality for.

> Btw, do we really need separate attributes for bind/unbind?

Overloading a single file would be messier.  The overhead for an
additional attribute per driver is quite small (I move the unbind
attribute to the driver, as it makes more sense there as Pat mentioned.)

thanks,

greg k-h
