Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUKPHHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUKPHHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKPHHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:07:18 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:37287 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261930AbUKPHG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:06:27 -0500
Date: Tue, 16 Nov 2004 02:04:13 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Tejun Heo <tj@home-tj.org>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116070413.GJ29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
	Tejun Heo <tj@home-tj.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20041109223729.GB7416@kroah.com> <200411092249.44561.dtor_core@ameritech.net> <20041116061315.GG29574@neo.rr.com> <200411160137.57402.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411160137.57402.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:37:57AM -0500, Dmitry Torokhov wrote:
> On Tuesday 16 November 2004 01:13 am, Adam Belay wrote: 
> > An Alternative Solution
> > =======================
> > 
> > Why not have a file named "bind".  We can write the name of the driver we want
> > bound to the device.  When we want to unbind the driver we could do something
> > like this:
> > 
> > # echo "" > bind
> > or
> > # echo 0 > bind
> > 
> > At least then we only have the link and the "bind" file to worry about.  I've
> > also been considering more inventive solutions (like deleting the symlink will
> > cause the driver to unbind). But it could get complex very quickly.  Really, 
> > we need to discuss this more.
> >
> 
> I'd like having one node as well. Right now serio bus uses "drvctl" and supports

Great!  I'm glad we agree.

> the following operations:
>  - "none" to unbind;
>  - "rescan" to unbind if bound and then find appropriate driver;
>  - "reconnect" to reinitialize hardware without inbinding (so exesting input
>    devices will be kept intact)
>  - <driver name> to unbind if bound and try to bind.
> 
> There was also ide of changing commands to form "CMD [DRIVER] [ARGS...]:
> "detach", "rescan", "reconnect", "attach <driver_name>"
> 

These additional features bring up another issue that we may want the driver
model to handle.  Basically, I think we should allow devices to be started and
stopped.

So it would look something like this:

struct device_driver {
	char			* name;
	struct bus_type		* bus;

	struct semaphore	unload_sem;
	struct kobject		kobj;
	struct list_head	devices;

	int	(*probe)	(struct device * dev);
	int	(*start)	(struct device * dev); <-----
	int	(*stop)		(struct device * dev); <-----
	int 	(*remove)	(struct device * dev);
	void	(*shutdown)	(struct device * dev);
	int	(*suspend)	(struct device * dev, u32 state, u32 level);
	int	(*resume)	(struct device * dev, u32 level);
};

"*probe"
- determine if this driver is able to handle this device
- if so create data structures that can store information about the device
- bind the device to the driver and display additional config attributes.

At this point userspace can set up the configuration of this specific binding
instance.  The configuration options would primarily be things that cannot be
modified while the device is in use.  It can be loaded from a cache so that it
is consistent between reboots, hotplugs etc.  This would sort of replace
module parameters.

Now that the user has specific his or her config preferences we can go to
"*start"

"*start"
- parse resource information
- fill in device/driver data structures with information
- prepare the device to actually be used

>From this point the device would be completely usable.

Then at a later time, when the device...
- is no longer needed
- resources need to be rebalanced
- the user wants to remove the device in the near future

"*stop"
- safely stop the upper class layer
- free resources, and reset device specific data

And we're ready for the next step. (which may even include another *start)

This would easily allow for things like "reconnect", which would simply be a
"*stop" follow by a "*start".

Comments?


> My bind mode patch is somewhat independent of "drvctl" as it just adds a new
> attribute - "bind_mode" to all devices and drivers. It can be either "auto"
> or "manual" and device/drivers that are set as manual mode will be ignored
> by driver core and will only be bound when user explicitely asks to do that.
> This is useful when you want "penalize" one driver over another, like
> psmouse/serio_raw.

That's actually a really interesting idea.  In some cases we may not want the
kernel automatically binding drivers.  A question would be should this feature
be disabled on a per device basis or globally?  If it's globally then should
it occur after init is done.  And if that's the case, couldn't we free the
device ID tables and handle everything from userspace.  I'm sure there are
some problems with this but I figured I'd mention it as well.

Thanks,
Adam
