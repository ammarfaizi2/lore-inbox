Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUJLEC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUJLEC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUJLEC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:02:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:453 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269435AbUJLECp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:02:45 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <200410111946.03634.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <200410110915.33331.david-b@pacbell.net> <1097533363.13795.22.camel@gaston>
	 <200410111946.03634.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097553724.7778.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 14:02:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right ... if it were a CPU, one could say it's the difference between
> a default "performance" governor or instead "ondemand".  But
> it's an single device; so we can't currently say such things.

Yes. And we need partial tree suspend for that.

> > "idle" as a system state is a kind of "light sleep" state where you come
> > back up very quickly and makes a lot of sense for handheld devices.
> > 
> > "idle" as a device-state is what suspend-to-disk really wants :)
> 
> Some of those handheld devices want the analogue of an
> "ondemand" governor applied to each device.  On a truly
> idle system, that should end up looking like an "idle" system
> state ... except that it wakes as needed!

Yup.

> Right; losing one clock may just save power, but losing another might
> force a reset.  But most of that would be the driver's knowledge of how
> the system was built ... more common with SOC systems than with PCs,
> and a general PM core issue not a PCI-only one.
> 
> For PCI,  the drivers are often going to stick to the basics:  if it's really
> in a D3hot, D2, or D1 state then it's still powered and didn't need to
> lose any state.  Simple drivers might always do another reset.  More
> complex ones (like a USB HCD!) will avoid that because of evil
> consequences.

Well... the typical problem is video cards and most of them are PCI.
Depending on what your system & firmware does, you want to use D2
(usually called "APM" mode by card vendors) or D3 (which end up beeing
cold most of the time as the system will remove power). Then it depends
if the firmware will wake the card for you or not. In some cases, the
driver must refuse suspend if it can't do it. For example, on PowerMacs,
I have these cases:

 - Some laptops get the chip unclocked when suspending to RAM. We do D2
state in the ATI drivers, we have the code for that with most mobility
chips and that's what we had working for a while

 - Recent laptops and desktops power off the chip. Paulus managed to use
a tool I wrote to spy the MacOS driver and we got the re-init sequence
for some of these (currently 2 models) but not all. So the driver must
make the decision here of interrupting the sleep process if it can't
wake the chip.

 - A bunch of x86 laptops will have the chip powered off, but the BIOS
will re-POST it for you. (Ok, here we may have a problem identifying if
a given BIOS will do it or not ...)

So the driver decision of what state to enter into and how to wakeup
depends on critierias some beeing platform specific infos on what
happens with a given slot...

> Yes, in fact what you talked about as a "system idle" state seems
> like it might be a per-device version of your "dynamic device idle" state,
> but with wakeup events globally disabled.  (And maybe also automatic
> power state transitions disabled...)

Or globally enabled ... that is the high level "monitoring" stuff
detects nothing happened anywhere for some time and broadcasts a system
"idle" state to all devices. But it has the same wakeup semantics as a
sleep state, that is a keyboard (or pencil) hit will trigger a wakeup,
difference is wakeup there is very fast.

> Or I suppose "idle" could just be another kind of device policy
> governor, along with "performance" and "ondemand".

Well, we have three different informations if you think about it:

 - device state (the state the HW is put into)
 - the driver state (the state the driver is)
 - the 'stickyness" of those state (do we send back a wakeup
   even globally to the system ? does the driver just wakes up
   itself automatically if a request comes from above ?)

Though the later can be just flags, along with, eventually, some of my
platform thingies, those can be flags.

An example of the difference between device state and driver state: a
system "idle" state want devices to be put into some sort of D1 state,
that is power managed with very fast wakeup. On another hand,
suspend-to-disk don't care about devices beeing put in any power state
at all, but the driver must be "frozen" in a consistent state (not
process requests etc...) so we get a consistent image.
In the first case, it makes even sense to keep the driver operating
while the device is D1, the driver would then just wake the device on an
incoming request (provided this is allowed by the policy). In the later
case, the driver state is the only thing that matters.

The "will lose power" flag could be useful for USB too when you think
about it. Some controllers will need a disconnect (some don't do PCI PM
for example, or we can decide that in suspend-to-disk without S4 BIOS
support, we always disconnect everybody). That doesn't preclude the USB
driver from wanting to act before suspend. For example, an externally
powered mass storage may want to issue a spin-down command.

> > They are, but the choice of a device power state from a system power
> > state can most of the time only be done ... by the device-driver itself,
> > eventually with support from the platform. Only the device-driver knows
> > what it's device really supports as far as states as concerned, what the
> > driver supports waking the device from, etc... Though it needs
> > informations and help from the platform as well, like knowing if the
> > firmware will bring the device back up from power-on-reset (this is very
> > important for video cards).
> 
> Sure, though PCI is standardized enough that many non-video drivers
> can have very simple suspend/resume logic (as I sketched above).
> The framework needs to handle those well, too!

Agreed. That's why I was thinking about a "helper" that would convert
the passed-in struct into a PCI D state (with the help eventually of
the platform, that is the helper beeing platform-overridable) and would
give the suggested D state. 

> It's not "just" that.  Consider N devices that can each be made to use
> one of three policies:  performance, ondemand, or idle.   Clearly
> there are more than 3N potential system states!   Though I suppose
> it all comes down to what a "state" is.  It'd certainly make sense to
> make it easy to set all devices to use the same policy; also, to let
> userspace manage the states of particular devices.

Yup, with the exception that it becomes hell when those devices are
anywhere on the VM path... which makes userspace policy unuseable for
system suspend.

> > and informations 
> > from the platform about what will actually happen on this specific slot
> > after the state is entered (and a lot of systems don't give a shit about
> > PCI D states at this point, some machines will just power down all
> > slots, or a random set of them, some will cut clocks off, some will do
> > nothing, etc...) 
> 
> Well that sounds like no fun!  But it's not all that different from how
> various non-PCI systems work either.

Yup.

Ben.


