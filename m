Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWG2KgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWG2KgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWG2KgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:36:25 -0400
Received: from styx.suse.cz ([82.119.242.94]:32187 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1422734AbWG2KgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:36:24 -0400
Date: Sat, 29 Jul 2006 12:36:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: Generic battery interface
Message-ID: <20060729103613.GB7438@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 01:48:34AM +0300, Shem Multinymous wrote:
> On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> >Not that much. The difference then remains only on a tickless system.
> 
> And even then, only when apps use excessive poll rates (way above
> 1Hz), in which case the apps are broken; and broken apps can eat power
> in ways much worse than msleep(10) on a tickless system.

Sure. What I want is an interface that encourages good apps.

> >I'm not proposing polling. I'm proposing that there be a way how to read
> >the immediate values, in addition to the event notifications.
> >
> >Yes, this means polling would be possible.
> 
> So your /dev proposal is equivalent, functionality-wise, to sysfs +
> attribute change uevent, right? The only question is if we do it
> through /dev+ioctls or /sysfs+fscanf.

Right. And I don't care much which of them will be the final
implementation.

The main difference that remains is that with /dev, all the immediate
data and the events come from the same source - the device file.

For /sys, you need to open multiple files, and re-read them either based
on information from yet another file or select()ing on them all. But
this may not be a huge problem.

> >> And then we have to maintain both a kernel side and a userspace side.
> >> And what do I, poor author of tp_smapi, do if I want to add a
> >> non-standard attribute? Tell people to patch and overwrite their
> >> disto's batstate binary too?
> >
> >How often do you plan to do that?
> 
> With tp_smapi, I did it about 10 times over half a year. And there's
> probably more to come.
> 
> >Anyway, the answer is yes, it's not a big deal to do.
> 
> Practically, it's much messier. As a developer/tester you have two
> components to juggle instead of one, and it's a mess when they get out
> of sync.

It's nicer not to have to worry about that, I agree.

> >As Dmitry pointed out, all the info (except for the events) is in sysfs,
> >too.
> 
> And as I pointed out in reply, matching up devices in /sys and /dev is
> extremely cumbersome (and prone to race conditions).

I think we're hitting a fundamental problem with sysfs/hotplug/udev
here. It was created to get fixed, non-changing names of devices in
/dev, so that they'd be easy to enter into configuration files.

Yet applications today want automatic discovery of devices and don't
want to rely on udev getting the names right. 

We should make our minds up, and decide whether we want the 'devices are
in /dev and applications just need to open the filename' or the 'an
application will find the device itself' approach.

This reminds me very much of the Joerg Schilling discussion (flamewar)
of enumerating CD-burners. Most people on the kernel mailing list just
wanted to enter the name of the device node on the cdrecord command
line. Yet Joerg insisted that the application should do the discovery.

Here we're doing exactly the same: Where simply specifying a rule in
udev, and a fixed name to the battery applet would have worked fine,
people are trying to design ways how to do the discovery from the
applet.

I still believe the first approach is the only one that is sane and
portable.

> >You need at least 50 Hz for reasonable game control, too. I remember
> >that analog joysticks sampled at 10 Hz were unusable.
> 
> If you rattle your ThinkPad this badly, latency in Neverball is going
> to be the least of your problems. :-)

HDAPS, as explained above, doesn't have huge latency impact. The reason
to have high update rates for input devices (mice nowadays run at 100 Hz
refresh usually, gaming mice up to 1 kHz), is to not introduce
additional delay to the user->computer->user closed control loop.

The less delay, the better stability of the control loop and the better
results in the game. The limiting factor is usually 3D rendering, but a
10 Hz joystick will still kill the experience by inducing a much larger
delay.

> The mainline hdaps driver does 20Hz, BTW.
> 
> >The input layer was designed for input devices that control applications
> >by actions of the user. The fuzz filtering was designed with that in
> >mind and is expected to be set once at boot either by an educated guess
> >of a kernel driver or by the system administrator. Because it's designed
> >for input devices, it has these properties:
> >
> >        * It ignores minor noise
> >        * It slowly reacts to continuous drift of the values
> >        * It reacts immediately to large changes
> >
> >This would be likely completely unsuitable for batteries and may be bad
> >for a drive parking daemon, too. If the daemon can't use it, it'll need
> >another interface.
> 
> There's a pattern here. Maybe what we need is a generic scheme for
> publishing continuous readouts, that will work for both hdaps and
> batteries (despite a X100 difference in typical time magnitudes).
> Doubtless there are other uses for such a scheme. We want it to
> support clients with different desired rates, data sources with
> different update frequencies, use minimum CPU and avoid unnecesary
> timer interrupts on tickless kernels.
> 
> Here's one approach: use a syscall (e.g., ioctl) saying "block until
> there's new data on this fd, or N milliseconds have passed, whichever
> is *later*".

Sort of a 'reverse select'. Interesting idea.

> This way each client declares the update rate it wants
> and can change it on the fly. The driver sees all the requests and can
> perform the minimum hardware quering -- for example, it won't query
> the hardware at all if no client has submitted a request with
> parameter N more than N milliseconds go. And there's no excessive work
> or interrupts. Some (simple) kernel code infrastructure is needed to
> help drivers manage the pending requests.
> 
> Extending this approach, we can have a call for "block until the
> readout has changed by M, or N milliseconds have passed, whichever is
> later". This may not reduce query rate for polling-based hardware, but
> will reduce the event rate.

> I suppose these calls should also have a (normal) timeout, for the
> usual reasons.
 

-- 
Vojtech Pavlik
Director SuSE Labs
