Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJ2THy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTJ2THy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:07:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:45744 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261276AbTJ2THq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:07:46 -0500
Date: Wed, 29 Oct 2003 11:04:21 -0800
From: Greg KH <greg@kroah.com>
To: "Guo, Min" <min.guo@intel.com>
Cc: Steven Dake <sdake@mvista.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Mark Bellon <mbellon@mvista.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       cgl_discussion@osdl.org, "Ling, Xiaofeng" <xiaofeng.ling@intel.com>
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031029190421.GA4173@kroah.com>
References: <3ACA40606221794F80A5670F0AF15F840215DC2F@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840215DC2F@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 01:12:26PM +0800, Guo, Min wrote:
> Here I try to summary out some difference for uSDE and uDEV,any comments are welcome!
> In my opinion, competition is good and user can choose one they like because both of them
> are user-space applications with a little minor kernel changes,is that right?
> 
> 1.For the IDE/SCSI/PCI hotplug devices. 
>  uDEV:

What's with the wierd intercaps of the udev name?

> 	edit namedev.config manually to specify certain map,
> 	if slot change or device change, user can re-edit namedev.config

Then use something that will not change if you move the device.  Like a
serial number, or other unique identifier.  It's not udev's fault that
you used a non-flexible rule :)

Oh, and the file is called udev.config.

>  uSDE
> 	record the id or slot at the first time, when move device to new slot or change to a new same type device,
> 	automatically persist the name.
> 	user can also specify map manually.
> 
> 2.For non-hotplug device

What do you mean by this?  Memory devices?

>  uDEV:
> 	   not deal with it

See Robert Love's very simple script to populate stuff from sysfs.  It
can run from initscript just like SDE.  But in the end, udev will end up
in initramfs and we will not need to do this.

>  uSDE
> 	   scan at boot time and also perform policy method. so when moved or replaced devcie when the machine is
> down, the name can also be persisted.
> 
> 
> 3. for multipath device.
> uDEV
> 	    not support it.

Not true.  The CALLOUT rule handles this just fine.  I have a small
userspace program here from someone else that handles multipath devices
through the CALLOUT rule.

In fact I think this shows the flexibility of udev.  If you come up with
some new kind of device, or subsystem, or way of determining that you
want to name a device, udev can run _any_ program to do this.  No
rebuilding the code, or creating a shared library.  Small simple
programs all talking together in a universal manner.  Hm, where have I
heard that design decision before....

> uSDE
> 	    automatically detect mulitpath device and create md device. support hot add a new path and remove a path.
> 
> 4. ethernet
>  uDEV
> 	    not deal with it 

And this is on purpose.  Why would we, when there are so many other
programs out there that do deal with network devices.   Remember, not
all network connections are ethernet, which shows the limitation of SDE
in not handling all of them (ppp, ipsec, usb network devices, isdn, atm,
wireless, etc.)

>  nameif
> 	   name interface based on MAC, 
>  uSDE
> 	   can set map based on MAC, SLOT.
> 	   support both setting manually map and automatic processing
> 	   support hotplug, eg. when exchange two device, the name can also be exchanged automatically.
>   . 
> 5.devfs simulation
>   uDEV
> 	   No such function

Huh?  All it needs is a single config file to be created.  As the
current installed base of devfs users can probably all fit into my
basement with room to spare, and no one is coming up with such a file
for udev yet, I don't think this is a real need yet :)

But again, no rebuilding needed, if such a config file shows up, udev
will do this just fine.

>   uSDE
> 	    provide devfs simulation method.
> 
> >From the above comparsion, we can see uSDE really have some advantages.As far maintaince,
> I think that more codes don't mean lacking maintainability.

But it is at least one indicator, correct?

> Thanks
> Guo Min

In the interest of full disclosure, Min is one of the SDE authors, and I
am one of the udev authors.

Min, maybe you can answer why Intel has spent effort on this project
instead of offering to help udev, which has been public for a long time
now?

thanks,

greg k-h
