Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSG3HeN>; Tue, 30 Jul 2002 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSG3HeN>; Tue, 30 Jul 2002 03:34:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:14232 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315198AbSG3HeM>;
	Tue, 30 Jul 2002 03:34:12 -0400
Date: Tue, 30 Jul 2002 09:37:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nathan Conrad <conrad@bungled.net>
Cc: linuxconsole-dev <linuxconsole-dev@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Customization of input drivers
Message-ID: <20020730093712.B3027@ucw.cz>
References: <20020729021110.GA25161@bungled.net> <20020730021731.GA26488@bungled.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730021731.GA26488@bungled.net>; from conrad@bungled.net on Mon, Jul 29, 2002 at 10:17:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 10:17:31PM -0400, Nathan Conrad wrote:

> Thanks for your reply. I accidently deleted your message after reading
> it.
> 
> I believe that the following would not be kernel bloat. Currently, the
> kernel does have keyboard remapping abilities (although I do not know
> the implementation details). Keyboard mapping _needs_ to be done at
> the kernel level because of the console layer. I need to be able to
> type with the dvorak layout soon after init is loaded. I do not want
> to run something like X in order to get a text console. If this
> remapping was done inside of input.c or evdev.c, this would kill two
> birds with one stone: keyboard re-mapping and mouse event re-mapping.

Well, no again. Keyboard remapping is done in keyboard.c (and not in the
input core) for a very good reason - the input core maps the
hardware-dependent scancodes to linux input event keycodes, which are
the same on every platform. Thus you can have the same keymap loaded
into keyboard.c to use the dvorak layout on a Sun, PC, Amiga, Mac, etc.

> Mouse mapping is not strictly needed here. It is just a nice side
> effect of moving mapping into input.c

But if you do it in userspace, you can also do all the nice gesture
stuff and sliders at the edge of touchpads and ... which you wouldn't be
able to do in the kernel generically enough and still pass the bloat
measure.

> Perhaps two mappings would be necessary: one for the scan codes->linux
> keycodes (which would be in the keyboard's driver) and another for
> linux codes->input events.
> 
> > I like for the left button sends a BTN_MIDDLE event while the touchpad
> > sends BTN_TOUCH. Is there a map somewhere that can change these button
> > mappings at runtime? Looking at mousdev.c, the BTN_TOUCH, BTN_LEFT,
> > and BTN_0 all send a mouse-0 event to the mouse device.... I would
> > like for my driver to be able to send a BTN_LEFT event when I click
> > the left button and have that converted somewhere into a mouse-1 event.
> 
> The touchpad itself reports when there has been a touch click or a
> drag. In order for this configuration to be done in userspace, there
> are two options:
> 
> 1) report the finger movements and use some complex, time-critical
> algorithm to determine if the user wants the touch to be translated
> into holding the mouse button down or if the user wants a click and
> then to move the mouse or a double click.

Actually time is not critical anymore with input drivers, because we
report precise timestamps to the userspace.

> 2) Let the hareware handle it, and add some new event such as BTN_TOUCH_DRAG.
> 
> I am not sure as to if kernel configuration or the second choice above
> would be the best.

I quite like option #2. I'd call it BTN_DRAG probably only. 

> > Another configuration flag that I would like to export to userspace is
> > if the user wants to be able to use the touchpad to click, and if so,
> > also be able to use a drag-lock. Many people that I know hate these
> > options....
> 
> > The ABS_* events seem to be directed towards toucdscreens and drawing
> > tablets. Is it the right thing to do to convert to REL_ events in
> > psmouse.c?
> 
> Now that I think about it, this point seems moot. The psmouse driver
> is the only place where it would have mattered. It is a hack and
> should die. 
> 
> On a side note, I like being able to mix multiple mouse devices. This
> should be done in gpm, etc.... What is supposed to happen when a
> device is hot-plugged? Will the hotplug daemon have to restart gpm
> (and supply the correct arguments) when a device is removed or added?

The hotplug agent (not a daemon, it's executed again on each hotplug
event) will do anything you want. Namely it can send a SIGUSR to gpm, or
connect to the X socket and explain the existence of a new device via
the XFree86-Misc extension.

> On the same Sony laptop, a key sometimes gets stuck down. It is almost
> always the shift key. The enter key started repeating right after I
> typed 'sudo halt'. My guess is that the key-release event is
> getting lost somewhere and the autorepeat (now done in software and
> not the keyboard that knows the correct state) is doing its job too
> well. Could you give me some pointers in debugging this? This happens
> in X and in the console.

There may be a bug in the autorepeat code. I think there is a small race
window which can cause the autorepeat continue even after the key is
released if the autorepeat timer code is running at the time the key is
being released.

I'll try to fix it today and if it still has problems on your machine
after that, we'll debug it there.

> Is there a mailing list somewhere to which I should be sending this
> message?

Cc:ed. Btw, linux-kernel could be interested, too.

-- 
Vojtech Pavlik
SuSE Labs
