Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUE2Poa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUE2Poa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUE2Poa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:44:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:46724 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264305AbUE2PoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:44:24 -0400
Date: Sat, 29 May 2004 17:44:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529154443.GA15651@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b22c626ab9fcdc79896a5@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 05:12:31PM +0200, Giuseppe Bilotta wrote:

> > 1) USB keyboards don't have scancodes per se. And if you take HUT codes
> > as scancodes, they'd be completely different and wouldn't work with any
> > application. Thus there is nothing to pass on in that case.
> 
> How do USB keyboards cope with X on 2.4.x kernels? If they 
> weren't usable, then it's ok to have this fake emulated raw 
> mode for them, since it brings them from useless to usable. It 
> doesn't *break* anything.

They used emulated rawmode on 2.4.

> Backward compatibility, or support for the functionality not 
> yet supported by the current model at the current development 
> level. For example (see other post), a standard set of keycodes 
> for multimedia keys on multimedia keyboards, with as much a 
> widespread support for such things as X currently provides.
> 
> Please note that *when* we'll have kernel-level support and a 
> kernel-level standard for these funky keyboards, it would be a 
> breeze to create an inet(linux) keysym definition file, 
> therefore nihiling the need for 'proper' raw access.

The support is present in the kernel. You can use setkeycode to load that
table. Only X won't use it.

> > 3) If I'd add the raw scancode passing through the input system, nobody
> > would fix X and friends to stop using rawmode. Ever.
> 
> What is the *user* expected to do as we wait for things to be 
> fixed?

The emulated rawmode (which is needed for USB anyway) is supposed to
work well enough. It supports multimedia keys (and generates
Microsoft-compatible scancodes for most of them), and can be configured
to work with any keyboard using setkeycode.

> Stick to 2.4.x or hand-patching the raw mode emulation 
> table and recompiling are the only sane options to keep full 
> functionality *at the moment*.

No. The sane option at the moment (which isn't perfect, I admit), is to
use setkeycode to make the kernel understand the multimedia keys (you
can verify it does using evtest), and then to configure X to understand
the kernel-generated scancodes. That way you get full functionality
without any hacks.

> Which is not really that nice a 
> set of options, if you ask me. Especially considering the, uhm, 
> speed with which X and friends are fixed.

That's the main problem, actually. Were it a little bit less slow, we'd
have X using the event interface by now and all the discussion would be
moot.

> I do agree with you that it should be entirely up to the kernel 
> to provide this kind of HAL. But since
> 
> 1. the kernel still doesn't fully provide it anyway (see 
> multimedia keys)

It understands MS-compatible multimedia keys by default. For
incompatible scancode sets, you need to use setkeycode. Setkeycode
works.

> 2. the applications still don't comply with it

Unfortunately, yes.

> When the kernel will provide a complete enough HAL, we can 
> start talking about 'not needing a real raw mode'. *In the mean 
> time*, real raw mode *is* needed.

As Andries convinced me, it'll always be needed, if only for debugging
and setting up the translation tables easily (without checking the
kernel log).

I'll buy some food and start hacking at it today evening.

> Ok, at this point I think I have more than abundantly answer 
> the question :). I don't 'want' them. In fact, this is 
> precisely the reason why I said the new input system is a good 
> thing. But I *do* think that *until* its support for hardware 
> completely supported by the old system is as complete as it 
> used to be, and *until* its use is widespread enough in 
> userspace, we *do* need real raw mode.
> 
> And differently from you, I do not think that *forcing* people 
> to change to the new system by not providing any form of 
> transition capability *is* the way to go.

Note that I did provide a transition capability, although it isn't a
perfect one. If I didn't, there would be _no_ raw mode and X wouldn't
work at all, which might have been better. ;)

> Especially when the 
> biggest (complaining) userbase relies on projects which are 
> known to be slow in the uptake (like X for example). It just 
> pisses people off, and keeps them from using the new system, or 
> increase their stress level if they must use it. Especially 
> when the new system breaks things that worked smoothly before. 
> Moderately expert users will just patch what is needed and move 
> on, but what about all the others?
> 
> > > WRT this, would it be possible to create a GPM driver for the 
> > > event interface?
> > 
> > Yes. Even better, it exists. And I though it's been integrated into GPM
> > as well, but I might be wrong on this one.
> 
> Good I'll look into this.
> 
> > > This way, once kernel support for all the GPM-
> > > supported mice is complete, we would have the three-layered:
> > > 
> > > kernel | gpm | app
> > 
> > No, this isn't needed.
> > 
> > > stream, which IIRC should work even with X, since X can read 
> > > the gpm socket ...
> > 
> > Because it's easily possible to create a driver for X that will read the
> > event interface, too, for _both_ keyboard and mouse.
> > 
> > It's then
> > 
> > kernel ---- gpm
> >        `--- X -- app
> 
> Any chances of conflict? (No, because the kernel handles the 
> stuff?)

Exactly. The kernel interface is implemented so as to be used by any
number of processes simultaneously.

This is also valid for the emulated PS/2 mouse. Two opens don't hurt,
each process gets its own virtual mouse.

> Well, module options for type specification will probably be 
> needed anyway for the keyboards, *when* we'll have a standard 
> for multimedia keys, so I guess it's good to get used to having 
> to specify models as module options ;)

Module (or kernel cmdline) parameters are not a good way to go, because
they cannot be changed at runtime. For mouse models, sysfs will be used
(when I get to implementing sysfs support for serio and input layers),
and most keyboards don't need any special options, except for scrolling
keyboards - setkeycode is enough to teach the driver about the special
scancodes.

> One last thing: although here and there I might have come 
> through somewhat fiercely, please understand that I'm not angry 
> or pissed off or anything, it's just that I get carried on when 
> talking. I really think the new method has great potential, and 
> that when it'll be complete it'll be much better than the old 
> one, but I really do think that something to smooth the 
> transition should be provided while it gets completed.
 
Thanks. I hope we'll get there eventually.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
