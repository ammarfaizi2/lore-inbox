Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278160AbRJRWGQ>; Thu, 18 Oct 2001 18:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278172AbRJRWGH>; Thu, 18 Oct 2001 18:06:07 -0400
Received: from smtprt13.wanadoo.fr ([193.252.19.223]:55747 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278160AbRJRWFt>; Thu, 18 Oct 2001 18:05:49 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 00:06:04 +0200
Message-Id: <20011018220604.23253@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hmm. So, this would be a device ID, much like the Vendor/Device ID pair in
>PCI space? Does this need to happen at the top layer, or can it work at
>the bus layer?

No, the idea is to have a unique identifier for a given device "instance".
A VendorID/DeviceID pair isn't unique as two PCI cards can perfectly have
the same one.

Some devices, and I think this is mandatory in the ieee1394 spec, provide
a per-device unique ID, similar to an ethernet address or a serial number.

The goal here is to provide in a common location for any kind of a device
the best approximation of a unique identifier a device can provide.

I beleive the "bus" driver would setup a "default" one for a given device
(like a munge of pci slot/vendorid/deviceId for a PCI device that doesn't
provide anything better), and let the device driver override that with
something with better "uniqueness" if available.

However, I didn't explain myself correctly when writing about appending
that id to a "bus type". It's not actually a bus type I was thinking
about, but a type related to the uuid itself to avoid name space
collisions between uuid's of different devices types. In the case of
ethernet hardware, the MAC address seems to be the best type of uuid
available, so it would be something like "ethaddr,xx:xx:xx:xx:xx:xx",
FireWire has a generic uuid allocation scheme as well, it could be
"ieee1394,xxxxxx...", etc...

The goal is to help userland, especially configuration tools, to
keep track or hardware. In the case of block devices like sbp2 disks,
it can help making sure that if a device is unplugged before beeing
properly unmounted, when plugged back, it can be identified as beeing
the same device.

>That shouldn't be too hard. ACPI wants to do something like that as well -
>they will be able to ascertain information about some devices that we
>otherwise wouldn't know, and will want to export that to userspace. 
>
>The idea was to make a call to platform_notify() on each device
>registration, so the platform/firmware/arch could do things liike that.

Ok, nice. maybe provide some room (for a pointer) in the device
structure to be used by the platform.

Thinking a bit more about it, why not simply calling the node's
father with a kind of child_notify() callback ? The default
behaviour would be to call the parent until it ends up at the
motherboard/arch level. That way, special bus types can add
bus-related informations to devices more easily.

>I think this can be solved in the suspend transition that I desribed:
>
>- save_state
>- suspend
>- resume
>- restore_state
>
>The save_state() call is the notification that the device will be
>suspended. It is in here that the driver allocates memory to save
>state. But, no devices are actually put to sleep until the enter tree has
>been walked to save state. 

Well, I remember when you first implemented this save state mecanism. I'm
not sure I like the save_state and restore_state semantics much. Since the
device can take additional requests after save_state (typically, it's a
block device and another driver is causing swap out from it's save_state
routine), then your state gets changed. You are not really saving the device
state at this point, you are allocating room to save state.

>Then, we make a rule that says "Thou shall not allocate memory in
>suspend() or resume()" and let them be damned if they do. 

Ok. That means that things like USB must make sure they pre-allocate
any USBs that may be needed. Sounds fine to me. 

>I remember that discussion, and I think the above transition should fix
>that as well - have save_state() and restore_state() operate with
>interrupts enabled, while suspend() and resume() execute with interrupts
>disabled.

I don't agree there. As I said, since the device can still take requests
after save_state, it can't really save its state nor block it's IO queues
if any. So that has to happen within suspend itself.

I've turned that problem in every possible directions ;) I think there's
really 3 required suspend steps, even if most drivers will only need to
really implement one or two.

>Yes, I remember these discussions as well. Oh, and what a nightmare that
>is. The bus layer needs to have logic to know what power state to enter
>based on the power state of all its children; a PCI bridge cannot enter a
>state lower than the lowest state of all its children. The PM layer should
>then take this into account and react appropriately.

Ok. So if I we implement a toplevel "motherboard" node that is father
of all PCI busses (and anything else), we can have the arch handle that.
If the loop of all it's device don't return D3 but something less, then
the motherboard won't be put to suspend. That's fine... for me ;) But
what if not beeing able to set a given PCI bus to D3 is not a real
issue ? (for example, the motherboard can be told not to shutdown that
specific PCI bus). Well, I beleive in this case, the motherboard can
have more intimate knowledge of it's children and which ones are
really "mandatory" for sleep or not.

>Ideally, we want some way to reinit all devices. Most should be possible,
>with one glaring exception: video. In order to reinit video, we need:

Are you sure we know how to reinit all sorts of SCSI cards our there
as well ?

>- a framebuffer driver that knows the innards of all the cards it supports
>
>or 
>
>- make something else do it, like X.
>
>The latter seems most plausible, since it knows about most cards. And, for
>initialisation, at least on x86, it can run the BIOS routines. 

Well, both may work. It's a matter of motherboard policy I beleive.
We might add a special case to the fbdev layer to be told by X "hey,
don't bother about sleep, I'll handle it", but X is only allowed to
touch hardware when frontmost, and this would require more linux-specific
cruft in X which would be difficult to get accepted.

I beleive the way to get back the video card will have to be dealt on
a per card basis anyway. If we have the infrastructure for drivers to
say "I can't deal with shutdown", it's enough for now. I'm looking
into some ways, on PPC, to re-run the card's firmware with a small
forth interpreter ;) (reminds you of ACPI ? heh ;) For now, it's
not an important issue as putting desktop machines to sleep is not
as important as putting laptops to sleep, and fortunately, so far,
Apple laptops don't power off the AGP slot during sleep (we use D2).


>Of course, that does nothing for you on PPC, but I am hoping something
>similar can be accomplished. Can X run the OFW routines in the video ROM?

It can't (well, it could probably run the BIOS of an x86 card), but
there might be other ways. Re-initing the card completely after figuring
out all registers values for a given model may be a working solution for
macs as they almost all use a limited range of ATI hardware. 
Emulating OF might be a solution as well. One last would be a wrapper
to run Apple MacOS drivers (which are in card's ROMs most of the time,
this is more or less already what Apple does with MacOS X).

Ben.



