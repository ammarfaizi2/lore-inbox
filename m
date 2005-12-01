Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbVLATAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbVLATAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbVLATAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:00:06 -0500
Received: from digitalimplant.org ([64.62.235.95]:5073 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751690AbVLATAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:00:05 -0500
Date: Thu, 1 Dec 2005 10:59:54 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Kay Sievers <kay.sievers@vrfy.org>
cc: dtor_core@ameritech.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       "" <airlied@linux.ie>, "" <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
In-Reply-To: <20051014084554.GA19445@vrfy.org>
Message-ID: <Pine.LNX.4.50.0512011040300.27848-100000@monsoon.he.net>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org>
 <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
 <20051014084554.GA19445@vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Uhh, sorry about the very long delay in responding to this. I was off
the continent and unemployed at the time. Both of those problems are
solved now. :) ]


On Fri, 14 Oct 2005, Kay Sievers wrote:

> On Thu, Oct 13, 2005 at 04:35:25PM -0500, Dmitry Torokhov wrote:
> > On 10/13/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > >
> > > The nesting classes implement a fraction of a device hierarchy in
> > > /sys/class. It moves arbitrary relation information into the class
> > > directory, where nothing else than device classification belongs.
> > > What is the rationale behind sticking device trees into class?
> > >
> > > Instead of that, I propose a unification of "/sys/devices-devices"
> > > and "class-devices". The differentiation of both does not make sense
> > > in a wold where we can't really tell if a device is hardware or virtual.
> > >
> > > We should model _all_ devices with its actual realationship in
> > > /sys/devices and /sys/class should only be a pinter to the actual
> > > devices in that place. Device like "mice", which have no parent, would
> > > sit at the top level of /sys/devices. All devices in /sys/class are
> > > only symlinks and never devices by itself.
> > > That way userspace can read all device relation at _one_ place in a sane
> > > way, and we keep the clean class interface to have easy access to all
> > > devices of a specific group.
> > > It gives us the right abstraction and is future proof, cause
> > > the class interface will not change when the relation between devices
> > > changes. The destinction between classes and buses would no longer be
> > > needed, and as we see in the "input" case never made sense anyway.
> > >
> > > /sys/class/block would look exactly like /sys/block today. The only
> > > difference is that there are symlinks to follow instead of class devices
> > > on its own. With every device creation we will get the whole dependency
> > > path of the device in the DEVPATH and a "classsification symlink" in
> > > /sys/class. The input devices are all clearly modeled in its hierarchy,
> > > in /sys/devices but we also get clean class interfaces:
> > >
> >
> > Kay eased my task by enumerating all issues I have with Greg's
> > approach. Not all the world is udev and not all class devices have
> > "/dev" represetation so haveing one program being able to understand
> > new sysfs hierarchy is not enough IHMO.
> >
> > However I do not think that "moving" class devices into /sys/devices
> > hierarchy is the right solution either because one physical device
> > could easily end up belonging to several classes.
>
> Sure, than that physical (while that distinction is silly by itself)
> will just have several child devices. Look at the mouse0 and event0 in
> the ascii drawing.
>
> > I recenty got an
> > e-mail from Adam Belay (whom I am pulling into the discussion)
> > regarding his desire to rearrange net/wireless representation. I think
> > it would be quite natural to have /sys/class/net/interfaces and
> > /sys/class/net/wireless /sys/class/net/irda, and /sys/class/net/wired
> > subclasses where "interfaces" would enumerate _all_ network interfaces
> > in the system, and the rest would show only devices of their class.
>
> That solution would keep a better device separation, sure. But it
> is completely incompatible with everything we ever had in sysfs and
> nobody wants to rewrite _all_ userspace programs.
>
> It invents artificial subclass names below a "master" class, which
> is absolutely not needed.
>
> It creates the magic "interfaces" directory, which is confusing, cause
> it classifies devices by itself.
>
> It doesn't represent any relationship and hierarchy of devices and
> adding a forest of magic symlinks and "device" pointers is a very
> bad design. The proposed "inter-class" symlinks make it even harder
> to understand sysfs as it already is.
>
> The biggest problem with current sysfs is that the driver hacker has to
> decide if the device is "hardware" or "virtual" which in a lot of
> cases just can't tell and this distiction doesn't make any sense today.

Could you provide an example of this? The driver model is currently
designed to handle two basic types of objects:

- Physical objects (mapping to struct device) that are discovered by a bus
  driver's probing/scanning routines.

- Logical objects (mapping to struct class_device) that are created when a
  driver binds to a device and registers with the device class that the
  driver belongs to.

Most of that should happen behind the scenes in the bus and class code
respectively.

> All the more complex subsystems use "virtual buses" and an unconnected
> bunch of class-devices to model its sysfs represention, which is just
> to work around a major design flaw in sysfs!

I wouldn't call this a design flaw. This was just willingness in the
implementors of those subsystems to overload the current design features,
and unwillingness to add new infrastructure that better represented what
they wanted to do. Don't blame the driver model for this; it was more a
lack of time and/or understanding of what needed to be done.

Note this is exactly why /sys/block exists, and even why kobjects were
created - someone wanted to export things that weren't currently
represented, so they overloaded the existing structures, and did so in a
fairly nasty way.

> We really should get _one_ device tree with its natural hierarchy, get
> rid of the stupid "device"-link, the PHYSDEVPATH and the unconnected
> class devices. Every device should just carry its dependency tree in
> it _own_ devpath!
>
> I'm very sure, we want a unified tree in /sys/devices, regardless of the type
> of device, to represent the global hierarchy wich is exactly what you want to
> know from a device tree!
> That way we stack "virtual" _and_ "physical" in a sane manner and at the same
> time get very clean class interfaces. We would stop to mix up "hierarchy" and
> "classes" all over the tree.

For what purpose? To make udev easier to program? Or, to make it easier to
determine what attributes are located where? Or, to determine what devices
map to what class devices? (Really, I'm curious).

Recall tht sysfs is designed to export kernel objects in a natural
manner. What we have now is mostly natural. There are some artificial bits
to it (the most agregious are things like usb-serial), but the distinction
between physical devices and class devices and their relationships with
drivers and the buses that they're on is clearly spelled out.

So what if there is a forest of symlinks?

If you want a unified representation of every thing (objects and
attrributes) that represent a single piece of hardware (i.e. in a compact,
single screen full of text), then that should be done in userspace, IMHO.
:)

Thanks,


	Pat
