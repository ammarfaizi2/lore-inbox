Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135891AbRDTMf7>; Fri, 20 Apr 2001 08:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135890AbRDTMfu>; Fri, 20 Apr 2001 08:35:50 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:45250 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S135891AbRDTMff>; Fri, 20 Apr 2001 08:35:35 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pm-devel@lists.sourceforge.net>,
        <linux-power@phobos.fachschaften.tu-muenchen.de>
Subject: Re: PCI power management
Date: Fri, 20 Apr 2001 14:06:03 +0200
Message-Id: <20010420120603.28316@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10104191607280.7690-100000@nobelium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10104191607280.7690-100000@nobelium.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>All devices should handle having power removed from them. And, all of the
>drivers should as well, since that is the only way we're going to get
>power management out of legacy devices and other things on the board. This
>involves saving the current context on suspend, and reinitializing the
>device, and restoring the context as much as possible when we resume. It
>should behave almost identically to the boot-time init code.

Right. In fact, at the driver level, the power management involve
2 different things:

 - Handling context save & restore of the device state

 - Blocking of "user" (I mean user of the driver, that can be
   a kernel servicer) requests properly. In some case, this later
   thing can be done by returning errors provided that upper level
   drivers are read to handle them. For example, the IDE layer should
   probably just block the IO queues while the IDE susbsytem is powered
   off (not talking about disk sleep, but complete power off of the
   controller), while an USB host controller should probably return
   errors to URBs sent by drivers to a sleeping controller since those
   upper-level drivers should have been put to sleep before the host
   controller.
   That part is almost completely overlooked right now.

>>  - Some devices just can't be brought back to life from D3 state without
>> a PCI reset (ATI Rage M3 for example) and that require some arch specific
>> support (when it's possible at all).
>
>When a device comes out of D3[hot], the equivalent of a soft reset is
>performed. From D3[cold], PCI RST# is asserted, and the device must be
>completely reinitialized.

Some devices (bad bad HW designers ;) just can't do it themselves. The
Rage M3 requires the host to assert PCI RST#, and some motherboards
provide no documented facility for that (it might be possible with Apple
ASICs for example, it's just not documented).

Also, still in the case of the Rage M3, we just can't bring it out of
D3 for the same reason we can't bring the r128 in the AGP slot of a
Cube Mac out of PowerOff : The complete init sequence of those chips
is dependent on the chip revision, requires some informations about
undocumented registers that we don't have (at least that's my understanding
from talks with ATI) and so can basically only be done by a BIOS (or
OpenFirmware driver in my case), and we can't run that on wakeup (OF
is dead on macs once the kernel takes over). So we have to limit
ourselves to D2 mode on machines that don't remove power from the
slots (powerbooks, ibooks & imacs) and we can't do deep sleep at all
on machines that remove power from the slot (Cube, G4s, ...), at least
until we figure out the proper init sequence for those cards.

So the point here, as far as the kernel is concerned, is that drivers
should have a way to let the kenrel know the min/max power state they
support.

>It's not about what the device supports, it's about what the driver
>supports. STR and STD imply that all devices will lose power. The drivers
>are responsible for reinitializing the devices, regardless of what that
>may involve. 

Right. I'm typing too fast, but that's what I meant.

>Hmm. How about doing two walks of the device tree - the first calls a
>save_state() function for each device, which gives it the opportunity to
>allocate memory and save appropriate registers, etc. The second actually
>places the device in a low power state.  
>
>This could give the kernel the chance to disable swap, or for the action 
>to be cancelled before anything is actually put to sleep.

Yup. That's approximately what I do with the PPC-specific
"sleep notifiers" we are using. The only difference is that the real
save state is done on the "sleep now" (latest) request, not on the
"sleep request" (earlier) request. 

The basic idea here is that the first pass will do all of the memory
allocation (or whatever requires all system resources to be available,
that can be sending a special power management message to the device,
like enabling the remote wakup on USB, etc...). So this first pass
requires system services (all other drivers if you prefer, especially
the swap device) to be fully alive.

The second pass will do the actual IO blocking, state save, and eventually
enter device suspend mode for cases where it's controlled by the driver.

>>  - On SMP, we need some way to stop other CPUs in the scheduler
>> while running the last round of sleep (putting devices to sleep) at least
>> until all IO layers in Linux can properly handle blocking of IO queues
>> while the device sleeps.
>
>Ugh. SMP. Not yet.

Well, if all drivers properly handle blocking of IOs, the SMP issue will
be easy to handle. Having the other CPUs run is not a problem as long as
any IO triggered by processes on theose are properly blocked by sleeping
drivers. All is needed is a cross-CPU function call to force the other
CPU into an idle loop (or a idle/sleep loop on PPC) on the very last
step of entering suspend mode.

>>  - We need a generic (non-x86 APM or ACPI dependant) way of including
>> userland process that request it in the loop. Some userland process
>> that bang hardware directly (X, but not only X) need to be properly
>> suspended (and the kernel has to wait for ack from them before continuing
>> with devices sleep).
>
>Hmm. Like init?

Maybe. I have to study what init does a bit more closely. What I had
in mind was a kind of ioctl that would allocate a PM node in the kernel
tied to a given file descriptor. The PM thread would call it as part of
the normal chain of PM notifiers. This notifier would then signal (or
complete the ioctl or whatver) and block the PM thread (with a timeout
eventually) until the userland process ack the state change with
another ioctl, or the fd gets closed.

>Another sleep level is not acceptable when entering a system sleep state,
>except for S2, but I've never seen a system that supports that. Power will
>be cut to all devices, and there is no getting around it. If the driver
>can't support reinitializing the device, it should return an error and the
>sleep request be cancelled.

Why ? Some boards support various power levels. On PowerBooks, I know
precisely (well, almsost...) what a given motherboard will do when 
entering deep sleep. On embedded systems, you know exactly what you
are doing, and in some case, the sleep process is completely controlled
by the kernel, so you can do whatever you want.

For example, on Apple PowerBooks, iMacs and iBooks, the video chip
is put in "static" mode (unclocked). Additionally, the RageM3 in the
PowerBook and iBook can be put to D2 mode by the driver before that
(which is supposed to have the effect of properly shutting down the
LVDS transmitter).

>The PCI PM Capabilities can be read from a device's config space. The PCI
>PM Spec has register descriptions. There are also #defines for the fields
>in pci.h. So a driver can know exactly what is expected of it.

Well, that depends... some device lie in their config space. In some case,
the device _can_ do D3, but the driver can't revive it out of D3 (but can
revive it out of D2).

Again, this is a matter of arch policy and depends on what the motherboard
supports. All we should do on the driver side is advertise what state we
support getting the device from. Then, the arch specific code will do
whatever it can depending on what drivers says.

>I favor the idea of having a tree view of _all_ devices in the system, but
>that's another story, and something I discussed in a post to the
>linux-power list.

Hehe, right ;) we somewhat have the OF device tree on pmacs, but we don't
use it very much (mostly for initial retreival of interrupt routing, and
for probing of device cells inside Apple combo-ASIC).

>The PCI bus-child dependency and ordering should always be true, AFAIK.
>Some PCI functions may have another source of power, but should only be
>to support the generation of wake events when the device is in D3[cold] -
>it must maintain some of its capability state.

Well... you are optimistic about what HW engineers can invent... I think
the PM tree should, by default, be built with the same hierarchy as the
PCI tree. But the arch should have a way to re-arrange it. The simplest
way I see to do that is to have the generic PCI code "instert" the PM
nodes in the PM tree when probing devices using a function
(pci_add_pm_node() for example) that can be hooked by the arch. 

>Possibly a better term is bus-dependent? 

Right. That's why I prefer the notifier mecanism that allow you to
easily define additional messages while keeping an overall coherency
in the design.

>How is D3 not safe on all devices? You mean to tell me that I cannot turn
>my workstation off because it is not safe to cut power to some device?
>Every device supports that state. When placing the system in a sleep
>state, you have no choice. D0-D2 are not an option. It's the _driver_ that
>has problems and must be fixed if it can't recover from D3. 

Ever heard about bogus hardware ? Some devices require an external assert
of PCI RST# to get out of D3, and some motherboard can't provide it without
a complete reboot of the machine (which is _not_ what happen when putting
a powerbook to sleep, for example).

I'm not sure also that all ethernet controllers can do wake-on-lan in D3
mode. They might (unconfirmed) be able to do it in D1 or D2.

You are right on one point: in most case, it's the driver that has problems
recovering the device. Mostly because lack of documentation. That _does_
happen.

Let's do an mecanism flexible enough for drivers to tell what they can do
and for arch to then decide what to do.

>It is the responsibility of the PM layer to ensure that this doesn't
>happen. This is not the fault of the device or the driver, but must be
>disabled.

It's the responsibility of the motherboard-specific (arch) hooks in
the PM layer to know about that, yup.

>I don't understand why you would want to change the parent of a device. A
>device will always sit behind a bridge, logically if nothing else. It
>should adhere to the semantics to the bus on which it resides. This could
>just be fanciful idealism, but damn it, it makes sense.
>
>Though, I can see the need for a driver to have multiple nodes in the
>device tree. If it were a PCI card, it would have one that was a child of
>the root PCI bus. But it could also implement some logical ACPI object,
>such as a wake-enabled device, in which case another node would be a child
>of the root bus. Maybe.

My idea is not so much about changing the parent, but changing the ordering
at the same level of the tree... That could eventually be done with a
"priority" like field in the PM node. You always have to revive the
parent bridge first of course, as you can't access the device without it.

>What about considering just the USB root host or Firewire equivalent as
>nodes in the tree. When they are put to sleep, they handle walking the
>device scheme that lies behind them, much in the same manner that PCI does
>it now. This way, a bus-specific implementation could be achieved,
>depending on what is needed.

Well, that could be done that way too. I like the idea of the generic PM
notifier interface providing the tree structure, priority value, and
notifier funciton. Then, the messages passed to the notifier function can
be bus dependant. This would allow to add the ability to broadcase some
"system wide" messages as well that might or might not be handled by
some individual devices or define new messages if a given bus supports more
than one power state.

>There are a couple of things that I wanted to respond to. First, it is
>evident that a PM scheme must be implemented for the bridges. They support
>various power states, as well as have state that must be preserved across
>suspend. 

Right.

>A tree view of the all the devices in the system is needed to support
>proper ordering when suspending and resuming. At the moment, it's not
>necessary to modify anything to obtain, at least for PCI. PCI handles
>walking its own device tree, which is not a bad model for the rest of
>the buses present on the system.

Except that I beleive we need a way to handle ordering at a given level
of the tree because of possible dependencies introduced by the
motherboard. On macs, for example, the mac-io ASIC must be woken up
first as it provide clocks & reset signals to other devices and
handles the interface to the power management microcontroller.

>But, I also can see a benefit in a two-stage approach, where a call is
>made to save the state of each device, then another is called to put the
>device to sleep. In this case, a complete tree view almost seems
>necessary. Or at least like we would only have to implement the interface
>once, instead of n times.

Well, generalizing the notifier approach makes it easy to define new
messages. 

>p.s. Every device supports D3. It must. The drivers must be fixed to do so
>as well. It's absolutely necessary in order to support system sleep
>states.

Why ? My PowerBook is pretty happily sleeping with it's video controller
in D2 state and clock removed...

Ben.



