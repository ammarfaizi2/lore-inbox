Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSLTEuM>; Thu, 19 Dec 2002 23:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbSLTEuM>; Thu, 19 Dec 2002 23:50:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265982AbSLTEuL>;
	Thu, 19 Dec 2002 23:50:11 -0500
Date: Thu, 19 Dec 2002 22:29:39 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
In-Reply-To: <200212192244.OAA06433@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0212192147590.914-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	A philosophical musing is not substitute for identifying real
> technical advantages or disadvantages, but thanks for the response.

Ouch. 

> 	If my proposed changes shrink kernel memory footprint, improve
> code maintainability, allow multiple drivers per device (e.g., scsi
> generic and scsi disk), users will be better off with those advantages
> than being lost in a doctrine for which they've lost track of the benefits.

You're trying to pinch pennies with the footprint you're talking about. 
The extra structure definition costs nothing, and the code to interface 
those objects with the other driver model objects is trivial. 

Plus, you'd be overloading the object to behave differently depending on
how it was referenced, causing more code. That certainly wouldn't improve
code maintainability.

A device belongs to exactly one bus type and exactly one class type. This 
is easy to express. If you combine the objects, you either reference each 
instance explicitly, kinda like they are now, or you represent it in some 
list, which will complicate the existing code immensely. 

What problem would that solve? How would that allow you to bind multiple 
drivers to a device? Why would you want to do that anyway? 

To support scsi-generic? I've talked with SCSI people before about this. 
It's bad to treat it as a driver, because it causes the core to special 
case these wacky instances where you have an extension of the bus driver 
apply to each device registered with it. I've gotten verbal confirmation 
that scsi-generic will change in this regard, and I've offered to provide 
hooks to make this easier to express. 

For the record, both USB and PCI do similar things. USB creates procfs
entries, and can create device nodes. IIRC, USB makes an explicit call to
the function that does this. PCI makes an explicit call to create procfs 
entries for each PCI device. They could all be implemented as 'drivers' 
but it doesn't make sense to overload the objects to do it this way. 

> >They're not the same, though. They may be similar, but they are 
> >fundamentally different. 
> 
> 	There are also differences between USB and PCI, but that
> doesn't mean that the part that is handled by drivers/base has to be
> different.  The question is whether having separate implementations
> for a set of differences make the code smaller, faster, more
> functional, or delivers other real benefits that tip the trade-off.

Why? Why try to micro-optimize the core now? You'll gain much more by 
converting bus and class drivers to use the driver model objects, and 
reducing the replication in the dusty corners of the kernel. 

> 	Perhaps it would help you to understand the impetus that made
> me think about this.  I want to have a mechanism for race-free module
> unloading without a new lowest level locking primitive (i.e., just by
> using rw_semaphore).  To make its use transparent for most cases, I
> want add a field to struct device_driver and add a couple of lines to
> {,un}register_driver, and I see that if I have to duplicate this
> effort if I want the same thing for, say, converting filesystems to
> use the generic driver interface.  I don't see that duplication buying
> any real improvement in speed, kernel footprint, source code size,
> etc.  In other words, having two separate interfaces makes it harder
> to write other facilities that are potentially generic to
> driver/target rendezvous.

Fine. That would be nice. You definitely have good intentions, but there 
is much more work to be done, that is far less glamorous, that I am 
concerned with. 

> >Consolidation is possible, but I would not recommend doing it by merging
> >the structures. Look for other ways to create common objects that the two
> >can share.
> 
> 	I'm thinking about this.  I just wonder if there would be any
> remaining fields that would not be common. 

Even if there are not, they have different purposes, and different 
semantics for dealing with them. Please do not play God on them, they are 
there for specific purposes. 

> >Especially during the continuing evolution
> >of the model. At least for now, and for probably a very long time, I will 
> >not consider patches to consolidate the two object types.
> 
> 	Linux will be better if we decide things by weighing technical
> benefits rather than by attempts at diktat.  I recommend you keep an
> open mind about it.

I like to think I do have an open mind. I listen to what everyone says,
good or bad, and save it all. Well, most. I am definitely not the one to
have a closed mind, since I know for a fact most of the people that rant
and rave have much more experience with this stuff than I do. 

I may not respond to everything, and it may appear I ignore things, but
it's only because I am weighing and contemplating them, and their
responses. I may not know the low-level details about many things, but
I've spent enough of the last two years comparing and analyzing the
behavior of drivers to mean it when I say I will not consider patches of 
that type. :)

	-pat

