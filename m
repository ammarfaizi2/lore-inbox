Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUJLDDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUJLDDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUJLDDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:03:42 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:55949 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S269417AbUJLDDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:03:37 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 19:46:03 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
References: <1097455528.25489.9.camel@gaston> <200410110915.33331.david-b@pacbell.net> <1097533363.13795.22.camel@gaston>
In-Reply-To: <1097533363.13795.22.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410111946.03634.david-b@pacbell.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 3:22 pm, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-12 at 02:15, David Brownell wrote:
> 
> > In USB-land, we've been discussing "idle" as something orthogonal
> > to the PM states.  Not clear on all the details yet, but I'd vote against
> > anything that tries to make "driver doing nothing" a power state,
> > or doesn't have a way to idle drivers.
> 
> Well, having an "idle" system state that asks all drivers to go to
> "idle" state doesn't prevent local bus/driver management from having
> it's own dynamic idle state ...

Right ... if it were a CPU, one could say it's the difference between
a default "performance" governor or instead "ondemand".  But
it's an single device; so we can't currently say such things.

 
> "idle" as a system state is a kind of "light sleep" state where you come
> back up very quickly and makes a lot of sense for handheld devices.
> 
> "idle" as a device-state is what suspend-to-disk really wants :)

Some of those handheld devices want the analogue of an
"ondemand" governor applied to each device.  On a truly
idle system, that should end up looking like an "idle" system
state ... except that it wakes as needed!

 
> So you don't wnat the system state passed down to drivers but a policy
> instead ... We probably need more than that, like some additional flags
> along with a platform filter. For example, during a system suspend, a
> given piece of HW may end up beeing unclocked or powered off by the
> system, the driver will want to know that. The firmware may reboot the
> device on wakeup or not. The driver need to know that too.

Right; losing one clock may just save power, but losing another might
force a reset.  But most of that would be the driver's knowledge of how
the system was built ... more common with SOC systems than with PCs,
and a general PM core issue not a PCI-only one.

For PCI,  the drivers are often going to stick to the basics:  if it's really
in a D3hot, D2, or D1 state then it's still powered and didn't need to
lose any state.  Simple drivers might always do another reset.  More
complex ones (like a USB HCD!) will avoid that because of evil
consequences.


> But I agree that we can avoid passing down a system state if we define
> a "policy" state along with a few flags.
> 
> There is something else that we need to take into account. For system
> state, we want the driver to stay idle until woken up explicitely. But
> there are also more "dynamic" PM states that we may want to be triggered
> by the user via sysfs for which the driver will come back automatically
> when a request comes in from upstream (equivalent to disk idle sleep).

Yes, in fact what you talked about as a "system idle" state seems
like it might be a per-device version of your "dynamic device idle" state,
but with wakeup events globally disabled.  (And maybe also automatic
power state transitions disabled...)

Or I suppose "idle" could just be another kind of device policy
governor, along with "performance" and "ondemand".


> They are, but the choice of a device power state from a system power
> state can most of the time only be done ... by the device-driver itself,
> eventually with support from the platform. Only the device-driver knows
> what it's device really supports as far as states as concerned, what the
> driver supports waking the device from, etc... Though it needs
> informations and help from the platform as well, like knowing if the
> firmware will bring the device back up from power-on-reset (this is very
> important for video cards).

Sure, though PCI is standardized enough that many non-video drivers
can have very simple suspend/resume logic (as I sketched above).
The framework needs to handle those well, too!



> The problem, again, is that chosing the right state is a decision that
> can only be done by the driver, provided it knows information about the
> system state (or policy if you prefer, your policy thing is just a way
> to pass system states without calling them this way),

It's not "just" that.  Consider N devices that can each be made to use
one of three policies:  performance, ondemand, or idle.   Clearly
there are more than 3N potential system states!   Though I suppose
it all comes down to what a "state" is.  It'd certainly make sense to
make it easy to set all devices to use the same policy; also, to let
userspace manage the states of particular devices.


> and informations 
> from the platform about what will actually happen on this specific slot
> after the state is entered (and a lot of systems don't give a shit about
> PCI D states at this point, some machines will just power down all
> slots, or a random set of them, some will cut clocks off, some will do
> nothing, etc...) 

Well that sounds like no fun!  But it's not all that different from how
various non-PCI systems work either.

- Dave
