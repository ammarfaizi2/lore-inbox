Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbUKDR51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbUKDR51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUKDRzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:55:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:64408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262331AbUKDRxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:53:35 -0500
Date: Thu, 4 Nov 2004 09:49:44 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       rusty@rustcorp.com.au, mochel@osdl.org
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
Message-ID: <20041104174944.GG16389@kroah.com>
References: <20041104074330.GG25567@home-tj.org> <20041104074628.GK25567@home-tj.org> <200411041205.32028.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041205.32028.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:05:31PM -0500, Dmitry Torokhov wrote:
> On Thursday 04 November 2004 02:46 am, Tejun Heo wrote:
> > ?ma_04_manual_attach.patch
> > 
> > ?This patch implements device interface nodes attach and detach.
> > Reading attach node shows the name of applicable drivers. ?Writing a
> > driver name attaches the device to the driver. ?Writing anything to
> > the write-only detach node detaches the driver from the currently
> > associated driver.
> > 
> ...
> > +/**
> > + *???detach - manually detaches the device from its associated driver.
> > + *
> > + *???This is a write-only node. ?When any value is written, it detaches
> > + *???the device from its associated driver.
> > + */
> > +static ssize_t detach_store(struct device * dev, const char * buf, size_t
> > n)
> > +{
> > +?????down_write(&dev->bus->subsys.rwsem);
> > +?????device_release_driver(dev);
> > +?????up_write(&dev->bus->subsys.rwsem);
> > +?????return n;
> > +}
> 
> This will not work for pretty much any bus but PCI because only PCI
> allows to detach a driver leaving children devices on the bus. The
> rest of buses remove children devices when disconnecting parent.

Yeah, I was glad you stepped in.  Both of you are trying to work on the
same problem, in different ways.  It would be great if you both could
work out a common method together.

> Also, there usually much more going on with regard to locking and
> other bus-specific actions besides taking bus's rwsem when binding
> devices. Serio bus will definitely get upset if you try to disconnect
> even a leaf device in the manner presented above and I think USB
> will get upset as well.

No, we can disconnect a driver from a device just fine for USB with no
problems (as long as it's not the hub driver from a hub device, we need
to never be able to disconnect those.)

thanks,

greg k-h
