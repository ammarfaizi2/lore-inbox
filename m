Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992543AbWJTHT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992543AbWJTHT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992544AbWJTHT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:19:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:44226 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S2992543AbWJTHT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:19:26 -0400
Subject: Re: [PATCH] Add device addition/removal notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20061020061618.GA9432@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	 <20061020032624.GA7620@kroah.com>
	 <1161318564.10524.131.camel@localhost.localdomain>
	 <20061020044454.GA8627@kroah.com>
	 <1161322979.10524.143.camel@localhost.localdomain>
	 <20061020061618.GA9432@kroah.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 17:19:07 +1000
Message-Id: <1161328747.10524.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well... people already use it and go check the bus types :)
> 
> That's wrong to do.

No, that's the only way to do anything.

> > Having a notifier queue per bus type is a bit harder though because bus
> > types are generally allocated statically and thus we would need to find
> > them all in the kernel to add a proper static initialisation for the
> > notifier queue... bus_register() is not a good spot to do it because
> > platform code might want to register for bus types before those bus
> > types have been registered (it's not always easy to find a place to
> > "hook" between a bus is registered and things get added to it).
> 
> Why would it be any different from what we have today with the
> usb_register_notify() function?  You could change that to be:
> 	bus_register_notify(struct bus_type *, struct notifier_block *);
> and then just pass in the proper bus type that you care about.
> 
> And yes, you will have to export those bus_type pointers, but that's ok,
> some of them already are there.

No, because some of them might be in modules.

> > In fact, the whole bus type thing is a mess :) We can't easily register
> > for bus types that are in modules. 
> 
> Like everything except PCI?  :)

Exactly.

> > For example, if I want to use the notifier to catch USB devices in order
> > to, for example, link them to firmware nodes, I'm lost if the USB
> > subsystem is modular ... unless I use a global notifier and strcmp the
> > bus type name in there.
> 
> Ick, I'd like to say that this is a pretty bad thing to do.  If you need
> that, then just statically link the bus into your code, or make your
> code a module and it will depend on the usb core.  I don't know...
> 
> Remember, we didn't add a type identifier to the struct device for a
> reason, comparing the string of the bus type is not a good idea (for
> USB, it will get you in trouble, because two different types of devices
> can be on that bus, who's to say other busses will not also have that
> issue?)
> 
> I think you need to re-evaluate exactly what you are needing to do
> here...

I want several things :)

 - For PCI, platform, of_platform, and maybe a couple others, I need the
DMA ops to go through a data structure attached to the device. For now,
I'm attaching it to firmware_data but I'll submit a way for archs to
actually add fields to the device instead for performances reason.

 - I want the ability to link devices in the system to their Open
Firmware node via the above same structure. I will have rules for
various bus types, to be able to do that. 

 - There are other users of that notifier, mostly embedded stuff using
platform or soc bus type for fixup-type tasks.

Now, it could be possible that the notifier that does the later for USB
would itself be a module that links on top of USB, in which case,
comparing the bus types remains possible.

Which means that in the end, your idea of doing 

bus_register_notify(struct bus_type *, struct notifier_block *);

Is workable, however, as I explained earlier, there is still a small
problem of how you initialize the notifier head in struct bus_type.
bus_register is not a good way because that would create a nasty
ordering requirement between code that attaches those notifiers and
whatever initcall registers the bus type. An option here might be to
have an "initialized" field that is statically set to 0 and have
bus_register_notify() test it and initialize the notifier head...

Ben.


