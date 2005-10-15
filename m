Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVJOPI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVJOPI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJOPI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:08:58 -0400
Received: from soundwarez.org ([217.160.171.123]:49046 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751165AbVJOPI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:08:58 -0400
Date: Sat, 15 Oct 2005 17:08:55 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: dtor_core@ameritech.net
Cc: Greg KH <gregkh@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051015150855.GA7625@vrfy.org>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 12:02:30PM -0500, Dmitry Torokhov wrote:
> On 10/14/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > On Thu, Oct 13, 2005 at 04:35:25PM -0500, Dmitry Torokhov wrote:
> > > On 10/13/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > > >
> > > > The nesting classes implement a fraction of a device hierarchy in
> > > > /sys/class. It moves arbitrary relation information into the class
> > > > directory, where nothing else than device classification belongs.
> > > > What is the rationale behind sticking device trees into class?
> > > >
> > > > Instead of that, I propose a unification of "/sys/devices-devices"
> > > > and "class-devices". The differentiation of both does not make sense
> > > > in a wold where we can't really tell if a device is hardware or virtual.
> > > >
> > > > We should model _all_ devices with its actual realationship in
> > > > /sys/devices and /sys/class should only be a pinter to the actual
> > > > devices in that place. Device like "mice", which have no parent, would
> > > > sit at the top level of /sys/devices. All devices in /sys/class are
> > > > only symlinks and never devices by itself.
> > > > That way userspace can read all device relation at _one_ place in a sane
> > > > way, and we keep the clean class interface to have easy access to all
> > > > devices of a specific group.
> > > > It gives us the right abstraction and is future proof, cause
> > > > the class interface will not change when the relation between devices
> > > > changes. The destinction between classes and buses would no longer be
> > > > needed, and as we see in the "input" case never made sense anyway.
> > > >
> > > > /sys/class/block would look exactly like /sys/block today. The only
> > > > difference is that there are symlinks to follow instead of class devices
> > > > on its own. With every device creation we will get the whole dependency
> > > > path of the device in the DEVPATH and a "classsification symlink" in
> > > > /sys/class. The input devices are all clearly modeled in its hierarchy,
> > > > in /sys/devices but we also get clean class interfaces:
> > > >
> > >
> > > Kay eased my task by enumerating all issues I have with Greg's
> > > approach. Not all the world is udev and not all class devices have
> > > "/dev" represetation so haveing one program being able to understand
> > > new sysfs hierarchy is not enough IHMO.
> > >
> > > However I do not think that "moving" class devices into /sys/devices
> > > hierarchy is the right solution either because one physical device
> > > could easily end up belonging to several classes.
> >
> > Sure, than that physical (while that distinction is silly by itself)
> > will just have several child devices. Look at the mouse0 and event0 in
> > the ascii drawing.
> >
> > > I recenty got an
> > > e-mail from Adam Belay (whom I am pulling into the discussion)
> > > regarding his desire to rearrange net/wireless representation. I think
> > > it would be quite natural to have /sys/class/net/interfaces and
> > > /sys/class/net/wireless /sys/class/net/irda, and /sys/class/net/wired
> > > subclasses where "interfaces" would enumerate _all_ network interfaces
> > > in the system, and the rest would show only devices of their class.
> >
> > That solution would keep a better device separation, sure. But it
> > is completely incompatible with everything we ever had in sysfs and
> > nobody wants to rewrite _all_ userspace programs.
> >
> 
> Does anyone know how many of these we have?

A lot! From general distro specific system-management to subsystem specific
setup tools and tons of udev rules... There is definitely no chance to break
/sys/class in _all_ subsystems by introducing subdirectories.

> We are moving /sys/block
> to /sys/class so many of these will require upgrades anyway.

If needed, there can be a link from /sys/block to /sys/class/block and it
will look exactly like is is today.

> Could libsysfs hide some of the changes?

Not without hardcoding susbsystem-specific knowledge/translation into it, which
will not happen and will be definitely the wrong way to solve such a thing.
Only the block-move case could be easily covered by libsysfs as it is already
prepared to do this and "block" is a "class" from the first version of
libsysfs on.

> Btw, is your proposal with moving it all into /sys/device less drastic?

Definitely, cause it keeps all the curent api! The only difference is that class-devices
are reached by symlinks instead of real directories. The pathes to the devices are
the same!

> > It invents artificial subclass names below a "master" class, which
> > is absolutely not needed.
> >
> 
> I really do not see why you think that "ieee1394_node" and
> "ieee1394_transport" are natural names while "ieee1394/node" and
> "ieee1394/transport" are "artificial".

Well, all three classes are different kind of devices. All devices are at the
same level, which I absolutely like. You propose an artificial "hierarchy of
classes" or a "superclass", which will break everything and give us no advantage,
I think.

> > It creates the magic "interfaces" directory, which is confusing, cause
> > it classifies devices by itself.
> >
> 
> Why is "interfaces" is more magic than "wireless"? Is it just the name
> that is confusing? We could call it "netifs", "netdevs", "devices" -
> just pick a name you like better.

Cause "interfaces" is a classification by itself and this is wrong! If
you give one of your "subclass devices" an interface, let's say "input0"
will get a device node to talk to the low-level device, where do you
want to stick it then? You will move the device around to the
"interface" directory? That breaks the api!

Take a step back and look what a kernel interface is about. It is to
give userland a unified view to devices. The internal kernel structure
like "bus", "class", "bus_device", "class_device" are in no way interesting
for userspace. It's a kernel implementation detail.

All we want are DEVICES! And from devices we want:
  - a classification:    /sys/class/<name>
  - the properties:      attribute files to read values or to invoke actions
  - the dependency tree: /sys/devices/<device1>/<device2>
Any mix between any of the three things is completely wrong, makes it hard to
read and can never provide a stable device interface.

In HAL, which is the heaviest user of sysfs today, we need to reconstruct the
device tree by following the "device" symlink from sysfs to get a unified tree
and use the class name to classify the device properly.
In udevd I need to read PHYSDEVPATH to ensure the right event order. All that
is needed cause the _internal_ kernel structure is exported, which is "broken"
in the sense of a unified device interface.
Both proposals, the subclasses and also the stacked class-devices will render
it even more "broken" by mixing classification and device pathes.

> > It doesn't represent any relationship and hierarchy of devices and
> > adding a forest of magic symlinks and "device" pointers is a very
> > bad design. The proposed "inter-class" symlinks make it even harder
> > to understand sysfs as it already is.
> >
> > The biggest problem with current sysfs is that the driver hacker has to
> > decide if the device is "hardware" or "virtual" which in a lot of
> > cases just can't tell and this distiction doesn't make any sense today.
> >
> 
> Well, it is rather simple I think - if it works with hardware and
> needs power management then it's a physical device.

Forget power management and /sys/devices. The PM guys say, that they will need
their own tree for this. Anyway, sticking virtual devices in the tree, but keep
the hierarchy is not a reason not to be able to walk up the chain and change
device state (We already have a lot non-hardware devices in /sys/devices).
You will get the type of device by looking which class it belongs to.

The distinction between "virtual" and "physical" does not make any sense for
userspace! And it will get more complicated every year with every new
virtualization or abstract subsystem.

> If it just a
> kernel abstraction/API for group of similar objects then it is a class
> device. Physical device can only have one driver, class device can
> have several interfaces/views. So far we have input interfaces and
> SCSI generic interface.

That is a kernel implementation detail, we really don't care from
userspace. Rememer, sysfs is a _userspace_ interface!

> > All the more complex subsystems use "virtual buses" and an unconnected
> > bunch of class-devices to model its sysfs represention, which is just
> > to work around a major design flaw in sysfs!
> 
> Could you tell me which ones you consider virtual buses?

acpi-bus, serial-bus, scsi-target-bus, platform-bus, ... SUSE had an
input-bus, ... These all exist cause of the stupid "virtual" - "physical"
distinction. XEN has it's own xen-bus, and absolutely _no_ physical
hardware is involved...

> > We really should get _one_ device tree with its natural hierarchy, get
> > rid of the stupid "device"-link, the PHYSDEVPATH and the unconnected
> > class devices. Every device should just carry its dependency tree in
> > it _own_ devpath!
> >
> > I'm very sure, we want a unified tree in /sys/devices, regardless of the type
> > of device, to represent the global hierarchy wich is exactly what you want to
> > know from a device tree!
> > That way we stack "virtual" _and_ "physical" in a sane manner and at the same
> > time get very clean class interfaces. We would stop to mix up "hierarchy" and
> > "classes" all over the tree.
> >
> 
> Having hierarchy in the /sys/devices is nice and I think I agree with it.
> I don't think it will reslve any confusion for the coder WRT
> physical/virtual devices - after all I think you just need to change
> class_device kset from class's to devices and that will "move" the
> object into the new spot in /sys tree.

What we really need is to keep "hierarchy" and "classification"
separated. /sys/class is our usual interface to the kernel devices and
we don't want to stick hierarchy here. All hierarchy belongs into a
single place with all parent-less devices in the root. That way we can
move devices around in the hierarchy if we need to change kernel device
handling. But the most important reason: it will always keep the class
interface to the devices stable!

Think of sticking an "abstraction device" into a subsystem, like "input0" is,
only with a flat class interface you can do this without breaking the
users interface. (It already happened several times with scsi.)

> However having class hierarchy spelled out is also nice because it
> _does exist_. Right now we just encode it with common prefixes in the
> class names.

That is "grouping", it does not expose any hierarchy. And again, creating
tons of sysmlinks between class-devices like in your input proposal, is
wrong I think.

Thanks,
Kay
