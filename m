Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUKJAgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUKJAgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUKJAgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:36:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:32480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261791AbUKJAgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:36:07 -0500
Date: Tue, 9 Nov 2004 16:33:23 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041110003323.GA8672@kroah.com>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000411091536115ac91b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 06:36:52PM -0500, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Tue, 9 Nov 2004 14:37:29 -0800, Greg KH <greg@kroah.com> wrote:
> > Ok, everone's been back and forth about the whole bind/unbind stuff
> > lately, so let's just do this a step at a time.
> > 
> > How about the following patch.  It adds a "unbind" file to any device
> > that is bound to a driver.  Writing any value to that file disconnects
> > the device from the driver associated with it.
> > 
> > It's small, simple, and it works.
> > 
> > It also can cause bad things to happen if you aren't careful about what
> > type of device you are unbinding (some i2c chip devices don't really
> > unbind from the driver fully, but that's an i2c issue, and I'm working
> > on it.)
> > 
> > Also, unbinding a device from a driver can cause the children devices to
> > disappear, depending on the type of driver that is bound to the device.
> 
> With the present implementation it is pretty much impossible to do
> since unbind grabs bus's rwsem. That means that any driver attempting
> to remove children will deadlock. Driver core is not aware of evry bus's
> topology issues that's why you need a bus method to do proper locking
> and children removal.

Ok, in looking some more at this, you are right.

So, how to solve this.  I don't want a bus callback for bind, unbind,
re-bind, bind-every-other-day-depending-on-the-phase-of-the-moon, and so
on.  I really think we can do this with the current callbacks that we
have today.

All we have to do is rework that rwsem lock.  It's been staring at us
since the beginning of the driver core work, and we knew it would have
to be fixed eventually.  So might as well do it now.

Unfortunatly it seems everyone likes to grab that lock, so it's not
going to be a simple thing to fix (in their defense, we encouraged
people to grab the lock, so it's our fault too.)

So, if we fix up the locking issues, then we can do the following, which
I know people have been wanting to do:
	- add new devices from within a probe() callback.
	- remove other devices from within a probe() callback.
	- remove other devices from the remove() callback.
	- unbind devices from the driver core.

and other good stuff.

So, off to rework this mess...

thanks,

greg k-h
