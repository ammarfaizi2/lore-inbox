Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVA2TOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVA2TOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVA2TLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:11:49 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:65486 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261539AbVA2TIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:14 -0500
Date: Sat, 29 Jan 2005 15:04:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050129140427.GA13077@ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128105937.GA5963@ucw.cz> <Pine.LNX.4.61.0501282031010.30794@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501282031010.30794@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 01:11:08PM +0100, Roman Zippel wrote:

> > I'm very sorry about the locking, but the thing grew up in times of
> > kernel 2.0, which didn't require any locking. There are a few possible
> > races with device registration/unregistration, and it's on my list to
> > fix that, however under normal operation there shouldn't be any need for
> > locks, as there are no complex structures built that'd become
> > inconsistent. 
> 
> I wouldn't say that there is no need for that, but that these events are 
> rather rare, but it can happen.

Sorry, I meant to say that of course locking is needed for protecting
the device and handler lists, but that the event delivery path itself
is in my opinion safe, and that there is no need to eg. lock
input_event() against concurrent use by different callers.

> Unfortunately the lack of locking is all 
> over the keyboard/vc/tty layer. It would have been nice if input had 
> introduced some improvement here.
> This seriously becomes a problem as soon we want to allow the user to 
> dynamically attach/detach devices.

I agree, and I plan to fix the locking at least in input and keyboard.
How far it'll go into vc/tty I can't promise.`

> > > I tried to find a few times to find any discussion about the input
> > > layer design, but I couldn't find anything.
> > 
> > You have to search in very old archives. There was quite a lot of it,
> > and it was going off on a lot of tangents. In the end, I just wrote it.
> 
> How old and which archives?

1999 I think, some discussion was on L-K, the rest on
linux-input@atrey.karlin.mff.cuni.cz, which, unfortunately, doesn't have
a web-based archive.

> > > - a single input device structure for all types: this structure is quite 
> > > big, where most of its contents is irrelevant for most devices.
> > 
> > I actually think this is a big plus. 
> > 
> > Real word devices cannot be confined into predefined structures, as
> > hardware develops, mice get more buttons, wheels, force feedback, 
> 
> That doesn't necessarilly mean we have to pack everything into a single 
> structure. E.g. we present pci boards with multiple functions as multiple 
> devices, the same can be done for input devices. More important is that 
> kernel drivers only expect a certain class of devices, e.g. the keyboard 
> driver only needs the keyboard related parts and would also allow us to 
> add more keyboard specific callbacks instead of sending events.

The USB HID devices often are crossing the device type boundaries. A
keyboard with a few mouse buttons, for example. Yes, we could split it,
but I really doubt the gain.

The GGI people went the way of predefined device types ...

> > The intention here is that we have two types of events, input and
> > output. Most events are input (REL, ABS, ...), while some travel the
> > opposite direction. For simplicity, the interface is the same -
> > input_event(), which then, based on the event type decides where to
> > forward it - whether up or down the stream (or both, where other users
> > of the device may be interested in the change).
> 
> This is rather a hint that the abstraction is wrong, e.g. why not send 
> sound events to the pckbd _handler_? A device should just send input 
> events and handlers handle them and with sysfs we should actually rename 
> the latter to input_drivers (it's less confusing this way).

You imply that the atkbd module would register itself both as an input
device, and as an input handler? That's quite an interesting idea I
haven't thought about before.

But then all the handlers also have to register themselves as devices,
for generating the LED and Sound events. Probably we then could get rid
of the handlers altogether and have devices only, which would both send
and receive events.

It would work, but to me this looks even more confusing. 

> Some other problems I have with the current design:
> - unified keyboard/mouse device: one rather annoying problem, which is 
> neither solved by the input system or the linuxconsole patches, is that 
> one can't use keyboards with different mappings (e.g. german and english 
> is what I have here).

The unified mouse device was planned for backward compatibility only,
unfortunately it stuck, since for userspace that was the easiest way to
deal with hotplug.

The single keyboard similarly was the easiest way how to plug the input
into keyboard.c. James Simmons was working on the vc part of the code,
but it never made it there. It sort of lives in the linuxconsole
patches, but was never really finished either.

> I have a patch which makes the keymap data more 
> dynamic and assigns it to keyboard device,

Cool! How do you load the keymaps for the specific devices? How do you
assign the devices to vcs? Can a user have per-vc keymaps?

> which has the positive side effect that all keyboards don't have to
> send the same keycodes anymore (and we don't have to break all the
> keyboards anymore which don't use AT style keycodes).

Well, I think the fact that the input layer uses an unified set of
numbers for the keys really helps in a lot of places. One is that you
don't need (architectures * languages) of keymaps and only can define
language keymaps.

It's a sort of pnmtools approach. The X people tried to solve this with
xkb, and it got very complex. I believe the two stage thing is much
easier to work with.

> I'm not convinced we need this unifying layer in the kernel. We need a 
> keyboard driver in the kernel for the tty layer, but we have no kernel 
> user for mouse or joystick events, so why not do some simple preprocessing 
> and leave the rest to userspace?

We could do that. We could even pass raw HID reports to userspace like
BSDs do, and have the userspace decode the data in there.

We would need a lot of different interfaces for that, for each kind of a
device. I'm not sure we'd even save kernel code doing that.

Btw, aside from parsing the data layout and assigning proper codes to
the events, the kernel tries to do as little processing on the actual
data as possible.

> - kbd raw mode: the emulation code should really go. I'm playing with the 
> idea of merging input and serio infrastructure (or basically turning serio 
> devices into (raw) input devices), the differences are not that big (at 
> least the management part, the event path might still differ). This way 
> the keyboard driver can ask the kbd device for the raw device and read 
> the events directly.

Not all input devices are serio based. Only few are. In current 2.6, the
atkbd.c driver sends both MSC_RAW and MSC_SCAN events, representing the
raw data and scancodes for the keys. Keyboard.c can use that to do raw
mode instead of generating a fake one.

Similarly, hid-input.c can send MSC_SCAN events containing HID usage
codes - the scancodes for HID.

Other drivers can implement the same.

However, I'm sure that X won't be happy to receive anything but the
single rawmode it expects.

A question for you: What is raw mode good for? (I'd like the emulation
to go, and not be replaced by anything at all.)

> > > - fine grained matching/filtering: I have no idea why the input layer has 
> > > to do this down to the single event instead of just the event type.
> > 
> > I wonder what do you mean by this, the layer itself doesn't have any
> > codepaths dependent directly on event code, just on the types.
> 
> E.g. also input_match_device.

That's there for the handlers to be able to decide whether a device is
interesting for them. Since we don't have device type information (and
USB HID devices will necessarily not provide us with it, although often
they do), we can't simply assign handlers based on the device type.

> I don't really see what's the point of this.  Such functionality is
> only needed by the minority of drivers, but increases setup
> complexity, bloats structures and adds unnecessary runtime test for
> everyone. Why not leave it to the few places where it actually might
> be needed? If it basically has only informal value, there are other
> ways to export this.

The setup of the bitfields is there _primarily_ for userspace. In the
end, I'd like the only two handlers that will stay to be keyboard.c for
console and evdev.c for everything else.

Then the userspace will need to know what the device is, which features
it has, and how to handle it. We have mice, touchpads, touchpoints,
touchscreens, keyboards, tablets, joysticks, ... and each need special
care. Some touchpads have palm detection, other don't. Some mice don't
have three buttons, the middle button emulation is desired in that case.

All this information is stored in the bitmaps.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
