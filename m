Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVA2TKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVA2TKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVA2TIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:08:54 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:61646 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261531AbVA2TIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:09 -0500
Date: Sat, 29 Jan 2005 12:12:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050129111233.GA2268@ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128111005.GA9232@ucw.cz> <20050128215939.GF6010@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128215939.GF6010@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 10:59:39PM +0100, Andries Brouwer wrote:
> On Fri, Jan 28, 2005 at 12:10:05PM +0100, Vojtech Pavlik wrote:
> 
> > And, btw, raw mode in 2.6 is not badly broken. It works as it is
> > intended to. If you want the 2.4 behavior on x86, you just need to
> > specify "atkbd.softraw=0" on the kernel command line.
> 
> Thanks for pointing that out - I should have read patch-2.6.9 more
> carefully. I'll add that to the setkeycodes.8 man page.
> 
> Nevertheless I disagree a bit. "raw mode" is by definition the mode
> where scan codes are passed unmodified to user space.
> So before 2.6.9 this was just broken, and since 2.6.9 it is broken
> by default but there is a boot option to make it work.

The problem is that users wouldn't be happy if I passed USB usage codes
when they enable raw mode with an USB keyboard.

The expectation is that 'it will work'.

Because of that, the 'softraw=0' option _only_ works for AT and PS/2
keyboards, with any other keyboard type it has no effect.

> What is the reason that you do not make this the default?

To have all keyboard types behave the same, instead of having a single
exception, although I admit that the exception would be for the most
common case.

> The current default is really messy and confusing, especially
> when people have to map keys using setkeycodes.

The emulated rawmode is there mainly for X. If it weren't for X, I
wouldn't bother generating rawmode for keyboards other than PS/2, and
for PS/2 I'd have kept the true raw data there.

However, on 2.6, where you can have more than one keyboard, it'd be
better to use the EVIOCSKEYCODE ioctl on the event device instead of the
KDSKEYCODE ioctl on the console, as the later only changes the first
found keyboard.

Also, if setkeycodes used the event device, it'd get the raw scancodes
easily, as they're embedded in the event stream together with the
keycodes.

I'd hoped someone of the lineak/.../... multimedia key people will make
such an utility, but now I see that what one doesn't do himself, doesn't
happen. I will write it, possibly as a patch to setkeycodes.

> BTW, now that I read the corresponding code:
> 
>         if (atkbd_softrepeat)
>                 atkbd_softraw = 1;
> 
>         if (!atkbd_softrepeat) {
>                 atkbd->dev.rep[REP_DELAY] = 250;
>                 atkbd->dev.rep[REP_PERIOD] = 33;
>         } else atkbd_softraw = 1;
> 
> The "else" part is superfluous.

It indeed is. It's been removed, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
