Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRJRQew>; Thu, 18 Oct 2001 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRJRQed>; Thu, 18 Oct 2001 12:34:33 -0400
Received: from marty.infinity.powertie.org ([63.105.29.14]:62213 "HELO
	marty.infinity.powertie.org") by vger.kernel.org with SMTP
	id <S277782AbRJRQe1>; Thu, 18 Oct 2001 12:34:27 -0400
Date: Thu, 18 Oct 2001 09:19:24 -0700 (PDT)
From: Patrick Mochel <mochelp@infinity.powertie.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011018121318.17949@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there. 

> I would add to the generic structure device, a "uuid" string field.
> This field would contain a "munged" unique identifier composed of
> the bus type followed which whatever bus-specific unique ID is
> provided by the driver. If the driver don't provide one, it defaults
> to a copy of the busID.
> 
> What I have in mind here is to have a common place to look for the
> best possible unique identification for a device. Typical example are
> ieee1394 hard disks which do have a unique ID, and so can be properly
> tracked between insertion removal.

Hmm. So, this would be a device ID, much like the Vendor/Device ID pair in
PCI space? Does this need to happen at the top layer, or can it work at
the bus layer?

> Also, I'd like to see a simple ability for the arch code to add
> entries to the exposed device filesystem nodes. The main reason for
> this is that on machines like PPC with OpenFirmware or Sun with
> OpenBoot, it makes a lot of sense (and is very useful for bootloader
> configuration among others) to be able to know the firmware "path"
> corresponding to a given device. On PPC, the generic PCI code can
> do the convertion between an Open Firmware device node an a PCI
> device in the kernel, but doing so from userland is a lot more
> tricky. The device filesystem is a very good way to fix that problem
> once for all.

That shouldn't be too hard. ACPI wants to do something like that as well -
they will be able to ascertain information about some devices that we
otherwise wouldn't know, and will want to export that to userspace. 

The idea was to make a call to platform_notify() on each device
registration, so the platform/firmware/arch could do things liike that.

> However, there is another important point about power management I
> discovered the "hard way", which is memory allocation vs. turning
> off of swapping devices (that is the swap device itself or any device
> on which you may have mmap'ed files).
> 
> For "transcient" power management (that is dynamically putting a
> subsystem to sleep when idle until it gets a new request), there
> is no real problem provided that the driver can do the wakeup without
> allocating memory.
> 
> For system power sleep, where you actually shut down everything,
> the problem happens when you start shutting down those "swap" devices.
> Once done, you may be in a situation where another device, to be shut
> down or to wake up properly, need to allocate memory (see for example
> USB devices that need to allocate urb's). This may cause requests
> to swap_out which will block indefinitely if trying to swap out
> pages to an already sleeping device.
> 
> I "work around" this in the PowerBook sleep code in a bit dumb way
> which work in 99% of the case but is probably broken as well if you
> are really near oom. Basically, instead of calling only the "suspend"
> callbacks of devices, I have an additional "suspend requested"
> one that is sent to every driver using my specific PM scheme _before_
> starting the real round of "suspend" callbacks. Drivers that need 
> a significant amount of backup memory (like some framebuffers) will
> do the necessary allocations from this early callback.

I think this can be solved in the suspend transition that I desribed:

- save_state
- suspend
- resume
- restore_state

The save_state() call is the notification that the device will be
suspended. It is in here that the driver allocates memory to save
state. But, no devices are actually put to sleep until the enter tree has
been walked to save state. 

Then, we make a rule that says "Thou shall not allocate memory in
suspend() or resume()" and let them be damned if they do. 

> Another issue with suspend and resume is with interrupt sharing and
> some bad devices that unconditionally assert their interrupt line
> when put to any PM state. On the contrary, some drivers, in order
> to properly block any new request in it's queues and wait for any
> pending one to complete, may need to operate with interrupt still
> running. I discussed that a bit with Alan, and it seem that we really
> need 2 rounds of "suspend" callbacks in this case (at least for
> system suspend), one with interrupts still enabled, one with interrupts
> disabled.

I remember that discussion, and I think the above transition should fix
that as well - have save_state() and restore_state() operate with
interrupts enabled, while suspend() and resume() execute with interrupts
disabled.

> Finally, I have another need for which I'm not sure how to react
> with either the current scheme or the new scheme. On "desktop"
> Apple systems (at least all the recent G4 ones), the PCI bus will
> be effectively powered down during system sleep. That means that
> we must (at least that's what both MacOS and MacOS X do) prevent
> the complete system sleep when at least one PCI slot contains a
> card for which the driver can't properly restore the state after
> a complete shutdown. This frequently happens, for example, with
> video cards that rely on some initial chip & pll configuration
> to be done by the firmware. We may be able to fallback to some 
> kind of "light suspend" where we suspend any device we can but
> not the motherboard, but that mean that the "main" PM code has
> to know about the problem and need some way to know if a given
> node in the device tree can or cannot be revived from a given
> power state (in this case, we might consider beeing powered down
> as equivalent to D3 state). My current solution is to not allow
> system sleep at all on those desktop machines.

Yes, I remember these discussions as well. Oh, and what a nightmare that
is. The bus layer needs to have logic to know what power state to enter
based on the power state of all its children; a PCI bridge cannot enter a
state lower than the lowest state of all its children. The PM layer should
then take this into account and react appropriately.

Ideally, we want some way to reinit all devices. Most should be possible,
with one glaring exception: video. In order to reinit video, we need:

- a framebuffer driver that knows the innards of all the cards it supports

or 

- make something else do it, like X.

The latter seems most plausible, since it knows about most cards. And, for
initialisation, at least on x86, it can run the BIOS routines. 

Of course, that does nothing for you on PPC, but I am hoping something
similar can be accomplished. Can X run the OFW routines in the video ROM?

	-pat

