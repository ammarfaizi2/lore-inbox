Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbSLSWlw>; Thu, 19 Dec 2002 17:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWlw>; Thu, 19 Dec 2002 17:41:52 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:20610 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267782AbSLSWi2>; Thu, 19 Dec 2002 17:38:28 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 19 Dec 2002 14:44:53 -0800
Message-Id: <200212192244.OAA06433@adam.yggdrasil.com>
To: mochel@osdl.org
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Adam Richter
>  = Patrick Mochel

>>       I'm thinking about trying to embed struct device_class into
>> struct bus_type or perhaps just eliminate the separate struct
>> bus_type.  The two structures are almost identical, especially
>> considering that device_class.devnum appears not to be used by
>> anything.
>
>Someone else tried to do this a while back, and my argument was the same 
>as this is going to be: they are very distinct objects that describe 
>different things. 

	A philosophical musing is not substitute for identifying real
technical advantages or disadvantages, but thanks for the response.

	If my proposed changes shrink kernel memory footprint, improve
code maintainability, allow multiple drivers per device (e.g., scsi
generic and scsi disk), users will be better off with those advantages
than being lost in a doctrine for which they've lost track of the benefits.

	Also, thanks for the pointer to the paper.  I've only skimmed
it at this point, but it at already has helped clarify your thinking
on struct subsystem for me.

>They're not the same, though. They may be similar, but they are 
>fundamentally different. 

	There are also differences between USB and PCI, but that
doesn't mean that the part that is handled by drivers/base has to be
different.  The question is whether having separate implementations
for a set of differences make the code smaller, faster, more
functional, or delivers other real benefits that tip the trade-off.

>A class is the flipside. It describes the function a device is designed 
>to perform, independent of its underlying transport.

	You see it as the "flipside" because you're used to seeing
only two levels of indirection (you also haven't shown a real benefit
to a different interface).  Let's look at your example:

>Consider audio devices. The only things I care about are /dev/mixer and
>/dev/dsp, which map to devices registered with the audio subsystem.
>Actually, what is registered are not devices. They are objects allocated 
>by the driver for my sound card that describe the device in the context of 
>the audio subsystem. This object is independent of the bus the device 
>resides on. Communication from userspace to the device passes through the 
>driver, which formats the class requests to bus and device-specific ones 
>to actaully talk to the physical device. Something like this:
>
>
> Me -> device node -> kernel intf -> audio subsys -> driver -> bus -> device

	Even in this example, there could be many gradations between
bus_type and device_class.  There can be hardware support for complex
sound synthesis and there can be software versions of that same
interface to support more ordinary sound cards.  Sound cards are a
good example of a type of device that can have separate but related
functions, so it may be handy to have device drivers that are written
to accomodate multiple drivers per device (although I would agree that
the _default_ policy should remain only one driver per device at this
point).  The audio hardware may also be located across multiple busses
(PCI --> USB --> USB audio) or may involve more software (PC speaker
driver).

	Perhaps it would help you to understand the impetus that made
me think about this.  I want to have a mechanism for race-free module
unloading without a new lowest level locking primitive (i.e., just by
using rw_semaphore).  To make its use transparent for most cases, I
want add a field to struct device_driver and add a couple of lines to
{,un}register_driver, and I see that if I have to duplicate this
effort if I want the same thing for, say, converting filesystems to
use the generic driver interface.  I don't see that duplication buying
any real improvement in speed, kernel footprint, source code size,
etc.  In other words, having two separate interfaces makes it harder
to write other facilities that are potentially generic to
driver/target rendezvous.

	Anyhow, if you don't convince me of the error of my ways, then
it's probably incumbent upon me to produce a patch before whining
further.

>Consolidation is possible, but I would not recommend doing it by merging
>the structures. Look for other ways to create common objects that the two
>can share.

	I'm thinking about this.  I just wonder if there would be any
remaining fields that would not be common. 

>The distinction between the object types is important,
>conceptually, if nothing else.

	If it is not important for any other reason, then it's just a
lost opportunity for code shrink and perhaps for potentially making
the facility generically useful in new ways.

>Especially during the continuing evolution
>of the model. At least for now, and for probably a very long time, I will 
>not consider patches to consolidate the two object types.

	Linux will be better if we decide things by weighing technical
benefits rather than by attempts at diktat.  I recommend you keep an
open mind about it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
