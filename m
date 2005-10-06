Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVJFV7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJFV7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJFV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:59:52 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:54617 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751217AbVJFV7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lI99/hetjBkGAeqgB/FTUHHiJmHnHVNo1OcarCA/7LFvaLPqICoplrkCutB5kf8dQ0YLyMQ27Id/07QD1hKPJ9lGLe5nk1yGSWcLaNlcbj+FJAtNahEEtbWHaFTSPkcS3b2S+kWB3BuaJhmdO5yuuQf2Xk9XDK3sjvYGBFdW7Uw=
Message-ID: <d120d5000510061459m73f2302aq96325762cd5e58d2@mail.gmail.com>
Date: Thu, 6 Oct 2005 16:59:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <20051006212234.GA6140@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050928233114.GA27227@suse.de>
	 <200509300032.50408.dtor_core@ameritech.net>
	 <20051006000951.GA4411@suse.de>
	 <200510060129.28066.dtor_core@ameritech.net>
	 <20051006212234.GA6140@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Greg KH <gregkh@suse.de> wrote:
> On Thu, Oct 06, 2005 at 01:29:27AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 05 October 2005 19:09, Greg KH wrote:
> > > On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:

> > > >    I understand that you want to tech udev about all existing handlers
> > > >    and having hotplug events allows to filter out unneeded names but for
> > > >    other programs I do not think we want to do that. Again, consider task
> > > >    of wanting to know all input interfaces, ot all available partiotions
> > > >    in a system. Do not say that the program has to know that there are hdX
> > > >    and sdX and ubX and adopt every time new type of device comes along
> > > >    since you would need to determine whether the name you see is an
> > > >    ordinary attribute or attribute group or the subdevice you are interested
> > > >    in. You can't really rely on presence of 'dev' attribute since subdevice
> > > >    does not have to have it. A better way would be to do
> > > >    "ls /sys/class/block/partitions/" or "ls /sys/class/input/interfaces"
> > > >    and get all this information.
> > >
> > > Yes, class devices can have a "dev" file, and be nested below another
> > > class device, that's fine.  It's only a simple scan of sysfs to find
> > > them, just like we do today for the block devices.  Again, I really
> > > don't see the problem here.
> > >
> >
> > Ok, so how do you scan for all instances of input interfaces under your
> > proposal of you don't know their names? Remember you need to support
> > special instances that do not have parent devices too.
>
> I don't understand the problem here.  With my directory structure (which
> is what I want to see everything looking like in the end anyway, and is
> what Vojtech and Kay also agreed with when I talked with them last
> week), how is it hard to scan for this?
>

Because (please correct me if I am wrong) with your proposal you have
to know all possible names of your interfaces/block devices or use
some other tricks to identify them. The knowledge/tricks may work for
udev but I do not think it is maintainable and will require
maintaining close sync between udev and kernel.

To illustrate the above: imagine you have
/sys/class/input/input0/caps0 and /sys/class/input/input0/event0. How
do you know that 'caps0' is just some attribute group but 'event0' is
really an interface device? With my proposal you only need to know
name of the [sub]class to be able to enumerate all input interfaces.
If tomorrow I come out wuth 'blahdev' input handler you most likely
will not need to change anything in udev or its scripts/rules, you
will jsut get hotplug event for 'input' sybsystem,
'/sys/class/input/interfaces' class and 'blahX' device. And that's all
you really care.

> > > > 4. subdevice should have only one parent, your implementation allows to
> > > >    link subdevice to a class device and a real device at the same time,
> > > >    which IMHO is wrong. Only top-level class devices should be linked with
> > > >    physical /sys/devices/ device.
> > >
> > > Why?  Why arbirtrary make that distinction?  See my example below for an
> > > example of that symlink being in both class devices, and everything is
> > > just fine.
> > >
> >
> > Because at the interface level all I care is what inputX device my mouse0
> > is connected to and what capabilities it has. When I talk about mouse0
> > I do not care that input_dev is actually connected to
> > /sys/bus/serio/devices/serio1. If I want this info I will just travel
> > dev->device->device->device chain and get this data. What you doing is just
> > cluttering /sys with unneeded data.
>
> Heh, it's only one extra symlink, which makes it much easier to find the
> real device for the specific level in the class heirachy.  It also makes
> it easier for libsysfs and udev to work this way, otherwise we have to
> start special casing that device symlink, which will get very messy.

This is a layering violation as well. mouse0 does not know anything
about serioX. It does not work with serio abstraction, it works with
input_dev abstraction and therefore it's device should point to
corresponding inputX.

Why does udev care what physical device mouseX is connected to,
especially given that serioX numbers are not stable? If you are using
it for identification purposes you are much better off using 'phys'
attribute of corresponding inputX object.

>
> > > > I firmly believe that creating sub-classes (which solves hotplug issues)
> > > > and linking sub-class devices to their parent via 'device' link, much like
> > > > we link top-level class device to their physical parent devices (which
> > > > solves 2, 3 and 4) is much cleanier way. It provides everything that your
> > > > implementation does plus allows different views useful for other tasks
> > > > besides udev.
> > >
> > > I thought this way too.  Until I started to implement the sub-class
> > > device code, and realized that I was just creating the same thing as the
> > > existing class_device code.
> > >
> >
> > See the patch below - it simply allows you to link class device to any
> > valid kobject. No code duplication and together with bested classes
> > it works nicely:
> >
> > [dtor@core ~]$ tree -d /sys/class/input/devices/input2
> > /sys/class/input/devices/input2
> > |-- capabilities
> > |-- device -> ../../../../devices/platform/i8042/serio0/serio2
> > |-- id
> > |-- interfaces:event2 -> ../../../../class/input/interfaces/event2
> > |-- interfaces:mouse1 -> ../../../../class/input/interfaces/mouse1
> > `-- interfaces:ts1 -> ../../../../class/input/interfaces/ts1
>
> But this puts 2 extra levels for classes, "devices" and "interfaces".
> I don't think that is necessary.
>

This is what allows you to distinguish between input devices and input
interfaces. I agree it is not necessary if you want to keep flat
/sys/class structure and have /sys/class/input and
/sys/class/input_dev. But I am afraid this will eventually turn
/sys/class into a bug dumpster, similar to /proc. I would much rather
have it look like /sys/devices/... hierarchies.

> > > And yes, I realize that this is different from nesting classes, but I
> > > _really_ do not think that is the proper solution for this at all.
> > >
> >
> > Arguments please. I think I explained why I do not like your proposal but
> > I have not heard why you think nesting classes is a bad idea.
>
> Ok, sorry, I thought I said that before.  I don't like nexting "struct
> class" because they should remain separate.

I am still missing ".. they should remain separate because 1)... 2).. 3)..."

>  If you need different
> classes for things, create different classes.  Nesting them is only
> solving the "/sys/class/scsi-*" namespace "issue" (and I don't really
> feel that is a real issue).
>
> Also, nesting classes does not let us do things like what is needed to
> move /sys/block/ under /sys/class.  I don't want to create something
> that will only work right now for input, and then have to go off and
> create something else for block devices (and possibly bluetooth and
> video.)

Could you please elaborate on this one? I think my solution could be
useful with /sys/class/block/devices and
/sys/class/block/partitions...

>
> > Driver core: allow linking class devices to any kobject
> >
> > This will allow linking class devices not only to physical
> > devices but also to other class devices.
>
> You don't need this patch, you can create symlinks like this on your own
> if you wish today to any kobject.  No, we need to keep that struct
> device pointer in there, as "device" _must_ point to that, and not
> something else, otherwise we _really_ break existing userspace programs.
>

It is not "needed" needed, it is just for convenience, so if you want
to link 2 class devices driver core can do that for you too.

--
Dmitry
