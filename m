Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUE2PUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUE2PUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUE2PUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:20:40 -0400
Received: from main.gmane.org ([80.91.224.249]:16313 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264295AbUE2PUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:20:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sat, 29 May 2004 17:12:31 +0200
Message-ID: <MPG.1b22c626ab9fcdc79896a5@news.gmane.org>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-39-142.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sat, May 29, 2004 at 03:14:42PM +0200, Giuseppe Bilotta wrote:
> 
> > The answer could be to the raw mode emulation of the current 
> > aux and kbd modules. The best thing would be to let the raw 
> > codes just bleed through the layers, together with the 
> > translated ones, and then letting the input event choose which 
> > one to pass on to the application depending on whether the 
> > application requested raw access or not. I don't know if this 
> > would work with AUX, but it would be the best solution for the 
> > keyboard driver.
> 
> With AUX it's indeed tough, since you cannot share the port for the
> simple reason that you don't just listen, but also talk to the mouse.
> This has led to lots of problems in the past, and the invention of
> repeater mode in GPM.
> 
> With keyboard, it's doable, if the application would keep using IOCTLs
> to set the LEDs. But I don't see the point of doing that. Actually, I
> have a few point why NOT to do it:
> 
> 1) USB keyboards don't have scancodes per se. And if you take HUT codes
> as scancodes, they'd be completely different and wouldn't work with any
> application. Thus there is nothing to pass on in that case.

How do USB keyboards cope with X on 2.4.x kernels? If they 
weren't usable, then it's ok to have this fake emulated raw 
mode for them, since it brings them from useless to usable. It 
doesn't *break* anything.

> 2) Application has no bussiness knowing the raw scancodes. It should be
> interested in keycodes if anything. The scancode emulation is there just
> for backward compatibility, and I hope one day I'll be able to remove
> it.

Backward compatibility, or support for the functionality not 
yet supported by the current model at the current development 
level. For example (see other post), a standard set of keycodes 
for multimedia keys on multimedia keyboards, with as much a 
widespread support for such things as X currently provides.

Please note that *when* we'll have kernel-level support and a 
kernel-level standard for these funky keyboards, it would be a 
breeze to create an inet(linux) keysym definition file, 
therefore nihiling the need for 'proper' raw access.

The problem is 'what should we do in the mean time?'

> 3) If I'd add the raw scancode passing through the input system, nobody
> would fix X and friends to stop using rawmode. Ever.

What is the *user* expected to do as we wait for things to be 
fixed? Stick to 2.4.x or hand-patching the raw mode emulation 
table and recompiling are the only sane options to keep full 
functionality *at the moment*. Which is not really that nice a 
set of options, if you ask me. Especially considering the, uhm, 
speed with which X and friends are fixed.

I do agree with you that it should be entirely up to the kernel 
to provide this kind of HAL. But since

1. the kernel still doesn't fully provide it anyway (see 
multimedia keys)
2. the applications still don't comply with it

When the kernel will provide a complete enough HAL, we can 
start talking about 'not needing a real raw mode'. *In the mean 
time*, real raw mode *is* needed.

> > Considering that in case of multiple keyboards one *should* 
> > have multiple raw emulation tables (one for each keyboard), I 
> > really think that it would be more troubles than anything to 
> > keep and maintain this 'raw emulation' method, which is why I 
> > suggest a 'bleed through' of raw codes, to be passed on when 
> > application request them.
> 
> Why would you want to have several different rawmodes bleed to
> userspace? They'd be mixed together at the console, and would just be a
> complete mess.

Ok, at this point I think I have more than abundantly answer 
the question :). I don't 'want' them. In fact, this is 
precisely the reason why I said the new input system is a good 
thing. But I *do* think that *until* its support for hardware 
completely supported by the old system is as complete as it 
used to be, and *until* its use is widespread enough in 
userspace, we *do* need real raw mode.

And differently from you, I do not think that *forcing* people 
to change to the new system by not providing any form of 
transition capability *is* the way to go. Especially when the 
biggest (complaining) userbase relies on projects which are 
known to be slow in the uptake (like X for example). It just 
pisses people off, and keeps them from using the new system, or 
increase their stress level if they must use it. Especially 
when the new system breaks things that worked smoothly before. 
Moderately expert users will just patch what is needed and move 
on, but what about all the others?

> > WRT this, would it be possible to create a GPM driver for the 
> > event interface?
> 
> Yes. Even better, it exists. And I though it's been integrated into GPM
> as well, but I might be wrong on this one.

Good I'll look into this.

> > This way, once kernel support for all the GPM-
> > supported mice is complete, we would have the three-layered:
> > 
> > kernel | gpm | app
> 
> No, this isn't needed.
> 
> > stream, which IIRC should work even with X, since X can read 
> > the gpm socket ...
> 
> Because it's easily possible to create a driver for X that will read the
> event interface, too, for _both_ keyboard and mouse.
> 
> It's then
> 
> kernel ---- gpm
>        `--- X -- app

Any chances of conflict? (No, because the kernel handles the 
stuff?)

> > BTW, what degree of support do we have for non-Synaptics 
> > touchpads, in particular ALPS?
>  
> ALPS support is in my patch queue, but there are some problems with it
> (like that ALPS touchpads cannot be autodetected).

Well, module options for type specification will probably be 
needed anyway for the keyboards, *when* we'll have a standard 
for multimedia keys, so I guess it's good to get used to having 
to specify models as module options ;)




One last thing: although here and there I might have come 
through somewhat fiercely, please understand that I'm not angry 
or pissed off or anything, it's just that I get carried on when 
talking. I really think the new method has great potential, and 
that when it'll be complete it'll be much better than the old 
one, but I really do think that something to smooth the 
transition should be provided while it gets completed.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

