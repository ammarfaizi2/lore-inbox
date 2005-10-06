Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVJFVXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVJFVXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJFVXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:23:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:42421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751362AbVJFVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:23:13 -0400
Date: Thu, 6 Oct 2005 14:22:34 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20051006212234.GA6140@suse.de>
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net> <20051006000951.GA4411@suse.de> <200510060129.28066.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510060129.28066.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 01:29:27AM -0500, Dmitry Torokhov wrote:
> On Wednesday 05 October 2005 19:09, Greg KH wrote:
> > On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
> > > On Wednesday 28 September 2005 18:31, Greg KH wrote:
> > > > Alright, here's a patch that will add the ability to nest struct
> > > > class_device structures in sysfs.  This should give everyone the ability
> > > > to model what they need to in the class directory (input, video, etc.).
> > > 
> > > I still do not believe it is the solution we want:
> > > 
> > > 1. It does not allow installing separate hotplug handlers for devices
> > >    and their sub-devices. This will cause hotplug handlers to resort to
> > >    having some flags or otherwise detect the king of class device hotplug
> > >    hanlder is being called for and change behavior accordingly - YUCK!
> > 
> > Huh?  I don't understand your complaint here.  Why would we ever want to
> > have separate hotplug handlers for the same class?  If you do want that,
> > then create separate classes.
> >
> 
> Yes. I do want separate [sub]classes. I just want them grouped together
> under some <subsystem> name. And I want separate hotplug handlers because
> actions that are needed for these objects are different. When a new
> input_dev appears you want to match its capabilities with one or more
> input handlers and load appropriate handler module if it has not been
> loaded yet. When a new input interface device appears you want to create
> a new device node for it. The handlers should be diffrent if you want
> clean implementation, do you see?

Yes, now I understand.  You also need different release() functions,
which my current patch can not handle without some nasty hacks (for both
the hotplug and release stuff.)

Ugh, back to the drawing board...

> > > 2. It does not allow user/program to scan for devices of given subclass.
> > 
> > There is nothing called "subclass" anymore, so sure, you can't scan for
> > it :)
> >
> 
> I am pointing out what I think are deficiences in your design. I do not
> think saying "We won't have it at all so problem does not exists" is
> allowed. I do want to be able to easily get/enumerate devices of a logical
> subclass whether they are represented this way in sysfs or not.

Yes, sorry.  I now agree with you.

> > >    I understand that you want to tech udev about all existing handlers
> > >    and having hotplug events allows to filter out unneeded names but for
> > >    other programs I do not think we want to do that. Again, consider task
> > >    of wanting to know all input interfaces, ot all available partiotions
> > >    in a system. Do not say that the program has to know that there are hdX
> > >    and sdX and ubX and adopt every time new type of device comes along
> > >    since you would need to determine whether the name you see is an
> > >    ordinary attribute or attribute group or the subdevice you are interested
> > >    in. You can't really rely on presence of 'dev' attribute since subdevice
> > >    does not have to have it. A better way would be to do
> > >    "ls /sys/class/block/partitions/" or "ls /sys/class/input/interfaces"
> > >    and get all this information.
> > 
> > Yes, class devices can have a "dev" file, and be nested below another
> > class device, that's fine.  It's only a simple scan of sysfs to find
> > them, just like we do today for the block devices.  Again, I really
> > don't see the problem here.
> > 
> 
> Ok, so how do you scan for all instances of input interfaces under your
> proposal of you don't know their names? Remember you need to support
> special instances that do not have parent devices too.

I don't understand the problem here.  With my directory structure (which
is what I want to see everything looking like in the end anyway, and is
what Vojtech and Kay also agreed with when I talked with them last
week), how is it hard to scan for this?

> > > 3. It does not work well when you have an object that in your model is a
> > >    logical subdevice but does not have a parent (or has multiple parents).
> > >    Consider 'mice' multiplexor. Where would you put it? Together with
> > >    inputX? But it is not an input_dev, it should not be there.
> > 
> > Ok, the "mice" thing is a hack.  A big hack, but one that is needed.
> > Don't try to bring that one in...  Anyway, I can handle that one too,
> > see below.
> >
> 
> Still a hck as far as I can see ;(

Yeah, but we have to keep this hack, due to backward compatibility and
nasty X servers which can not handle mice disappearing and showing up
dynamically.

> > > 4. subdevice should have only one parent, your implementation allows to
> > >    link subdevice to a class device and a real device at the same time,
> > >    which IMHO is wrong. Only top-level class devices should be linked with
> > >    physical /sys/devices/ device. 
> > 
> > Why?  Why arbirtrary make that distinction?  See my example below for an
> > example of that symlink being in both class devices, and everything is
> > just fine.
> >
> 
> Because at the interface level all I care is what inputX device my mouse0
> is connected to and what capabilities it has. When I talk about mouse0
> I do not care that input_dev is actually connected to
> /sys/bus/serio/devices/serio1. If I want this info I will just travel
> dev->device->device->device chain and get this data. What you doing is just
> cluttering /sys with unneeded data.

Heh, it's only one extra symlink, which makes it much easier to find the
real device for the specific level in the class heirachy.  It also makes
it easier for libsysfs and udev to work this way, otherwise we have to
start special casing that device symlink, which will get very messy.

> > > I firmly believe that creating sub-classes (which solves hotplug issues)
> > > and linking sub-class devices to their parent via 'device' link, much like
> > > we link top-level class device to their physical parent devices (which
> > > solves 2, 3 and 4) is much cleanier way. It provides everything that your
> > > implementation does plus allows different views useful for other tasks
> > > besides udev.
> > 
> > I thought this way too.  Until I started to implement the sub-class
> > device code, and realized that I was just creating the same thing as the
> > existing class_device code.
> > 
> 
> See the patch below - it simply allows you to link class device to any
> valid kobject. No code duplication and together with bested classes
> it works nicely:
> 
> [dtor@core ~]$ tree -d /sys/class/input/devices/input2
> /sys/class/input/devices/input2
> |-- capabilities
> |-- device -> ../../../../devices/platform/i8042/serio0/serio2
> |-- id
> |-- interfaces:event2 -> ../../../../class/input/interfaces/event2
> |-- interfaces:mouse1 -> ../../../../class/input/interfaces/mouse1
> `-- interfaces:ts1 -> ../../../../class/input/interfaces/ts1

But this puts 2 extra levels for classes, "devices" and "interfaces".
I don't think that is necessary.

> > And yes, I realize that this is different from nesting classes, but I
> > _really_ do not think that is the proper solution for this at all.
> > 
> 
> Arguments please. I think I explained why I do not like your proposal but
> I have not heard why you think nesting classes is a bad idea.

Ok, sorry, I thought I said that before.  I don't like nexting "struct
class" because they should remain separate.  If you need different
classes for things, create different classes.  Nesting them is only
solving the "/sys/class/scsi-*" namespace "issue" (and I don't really
feel that is a real issue).

Also, nesting classes does not let us do things like what is needed to
move /sys/block/ under /sys/class.  I don't want to create something
that will only work right now for input, and then have to go off and
create something else for block devices (and possibly bluetooth and
video.)

> Driver core: allow linking class devices to any kobject
> 
> This will allow linking class devices not only to physical
> devices but also to other class devices.

You don't need this patch, you can create symlinks like this on your own
if you wish today to any kobject.  No, we need to keep that struct
device pointer in there, as "device" _must_ point to that, and not
something else, otherwise we _really_ break existing userspace programs.

Ok, let me think about the release() and hotplug() issues some more and
get back to you...

thanks,

greg k-h
