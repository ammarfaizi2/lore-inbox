Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVA2MLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVA2MLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 07:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVA2MLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 07:11:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46252 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262902AbVA2MLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 07:11:37 -0500
Date: Sat, 29 Jan 2005 13:11:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
In-Reply-To: <20050128105937.GA5963@ucw.cz>
Message-ID: <Pine.LNX.4.61.0501282031010.30794@scrub.home>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
 <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home>
 <20050128105937.GA5963@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2005, Vojtech Pavlik wrote:

> I'm very sorry about the locking, but the thing grew up in times of
> kernel 2.0, which didn't require any locking. There are a few possible
> races with device registration/unregistration, and it's on my list to
> fix that, however under normal operation there shouldn't be any need for
> locks, as there are no complex structures built that'd become
> inconsistent. 

I wouldn't say that there is no need for that, but that these events are 
rather rare, but it can happen. Unfortunately the lack of locking is all 
over the keyboard/vc/tty layer. It would have been nice if input had 
introduced some improvement here.
This seriously becomes a problem as soon we want to allow the user to 
dynamically attach/detach devices.

> > I tried to find a few times to find any discussion about the input
> > layer design, but I couldn't find anything.
> 
> You have to search in very old archives. There was quite a lot of it,
> and it was going off on a lot of tangents. In the end, I just wrote it.

How old and which archives?

> > - a single input device structure for all types: this structure is quite 
> > big, where most of its contents is irrelevant for most devices.
> 
> I actually think this is a big plus. 
> 
> Real word devices cannot be confined into predefined structures, as
> hardware develops, mice get more buttons, wheels, force feedback, 

That doesn't necessarilly mean we have to pack everything into a single 
structure. E.g. we present pci boards with multiple functions as multiple 
devices, the same can be done for input devices. More important is that 
kernel drivers only expect a certain class of devices, e.g. the keyboard 
driver only needs the keyboard related parts and would also allow us to 
add more keyboard specific callbacks instead of sending events.

> > Some of my favourites in the input layer:
> > - the keyboard sound/led handling: the keyboard driver basically fakes 
> > events for the device and input_event() is "clever" enough to also tell 
> > the device about it. This is quite an abuse of event system for general 
> > device/driver communication.
> 
> The intention here is that we have two types of events, input and
> output. Most events are input (REL, ABS, ...), while some travel the
> opposite direction. For simplicity, the interface is the same -
> input_event(), which then, based on the event type decides where to
> forward it - whether up or down the stream (or both, where other users
> of the device may be interested in the change).

This is rather a hint that the abstraction is wrong, e.g. why not send 
sound events to the pckbd _handler_? A device should just send input 
events and handlers handle them and with sysfs we should actually rename 
the latter to input_drivers (it's less confusing this way).

Some other problems I have with the current design:
- unified keyboard/mouse device: one rather annoying problem, which is 
neither solved by the input system or the linuxconsole patches, is that 
one can't use keyboards with different mappings (e.g. german and english 
is what I have here). I have a patch which makes the keymap data more 
dynamic and assigns it to keyboard device, which has the positive side 
effect that all keyboards don't have to send the same keycodes anymore 
(and we don't have to break all the keyboards anymore which don't use AT 
style keycodes).
I'm not convinced we need this unifying layer in the kernel. We need a 
keyboard driver in the kernel for the tty layer, but we have no kernel 
user for mouse or joystick events, so why not do some simple preprocessing 
and leave the rest to userspace?
- kbd raw mode: the emulation code should really go. I'm playing with the 
idea of merging input and serio infrastructure (or basically turning serio 
devices into (raw) input devices), the differences are not that big (at 
least the management part, the event path might still differ). This way 
the keyboard driver can ask the kbd device for the raw device and read 
the events directly.

> > - fine grained matching/filtering: I have no idea why the input layer has 
> > to do this down to the single event instead of just the event type.
> 
> I wonder what do you mean by this, the layer itself doesn't have any
> codepaths dependent directly on event code, just on the types.

E.g. also input_match_device.

> If you wonder why the input_event() function checks whether the event
> generated by a device really is possible for that device and ignores it
> if not, that's to make the drivers life easier by, in the example of a
> PS/2 mouse always reporting the state of the middle button, even when
> the PS/2 mouse is a 2-button mouse. The driver only needs to say that
> the middle button doesn't exist in the bitmap setup and the packet
> processing routine doesn't need to care about it.

I don't really see what's the point of this.
Such functionality is only needed by the minority of drivers, but 
increases setup complexity, bloats structures and adds unnecessary runtime 
test for everyone. Why not leave it to the few places where it actually 
might be needed? If it basically has only informal value, there are other 
ways to export this.

bye, Roman
