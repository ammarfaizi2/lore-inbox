Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992520AbWJTGg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992520AbWJTGg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992521AbWJTGgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:36:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:22181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992520AbWJTGgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:36:24 -0400
Date: Thu, 19 Oct 2006 23:16:18 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] Add device addition/removal notifier
Message-ID: <20061020061618.GA9432@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain> <20061020032624.GA7620@kroah.com> <1161318564.10524.131.camel@localhost.localdomain> <20061020044454.GA8627@kroah.com> <1161322979.10524.143.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161322979.10524.143.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 03:42:59PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Ok, as long as you all agree that this does change the behavior, it's
> > fine with me :)
> 
> I should probably split the patch in two: One that does that behaviour
> change (I already have an Acked-by: Len Brown for that one even :) and
> one adding that notifier.

That would be a good idea.

> > Ok, then perhaps you just want a bus specific callback for the devices
> > on that bus?  That would be much simpler and keep you from having to do
> > that mess with the different tests of bus type.
> >
> > Actually, that's the only thing that really makes sense here, now that I
> > think about it, the platform_notify doesn't really make any sense...
> 
> Well... people already use it and go check the bus types :)

That's wrong to do.

> Having a notifier queue per bus type is a bit harder though because bus
> types are generally allocated statically and thus we would need to find
> them all in the kernel to add a proper static initialisation for the
> notifier queue... bus_register() is not a good spot to do it because
> platform code might want to register for bus types before those bus
> types have been registered (it's not always easy to find a place to
> "hook" between a bus is registered and things get added to it).

Why would it be any different from what we have today with the
usb_register_notify() function?  You could change that to be:
	bus_register_notify(struct bus_type *, struct notifier_block *);
and then just pass in the proper bus type that you care about.

And yes, you will have to export those bus_type pointers, but that's ok,
some of them already are there.

> In fact, the whole bus type thing is a mess :) We can't easily register
> for bus types that are in modules. 

Like everything except PCI?  :)

> For example, if I want to use the notifier to catch USB devices in order
> to, for example, link them to firmware nodes, I'm lost if the USB
> subsystem is modular ... unless I use a global notifier and strcmp the
> bus type name in there.

Ick, I'd like to say that this is a pretty bad thing to do.  If you need
that, then just statically link the bus into your code, or make your
code a module and it will depend on the usb core.  I don't know...

Remember, we didn't add a type identifier to the struct device for a
reason, comparing the string of the bus type is not a good idea (for
USB, it will get you in trouble, because two different types of devices
can be on that bus, who's to say other busses will not also have that
issue?)

I think you need to re-evaluate exactly what you are needing to do
here...

thanks,

greg k-h
