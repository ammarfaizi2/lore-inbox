Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbSLLIgD>; Thu, 12 Dec 2002 03:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbSLLIgD>; Thu, 12 Dec 2002 03:36:03 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:9861 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267440AbSLLIgC>;
	Thu, 12 Dec 2002 03:36:02 -0500
Date: Thu, 12 Dec 2002 09:43:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021212094334.A1403@ucw.cz>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021210213444.GA451@elf.ucw.cz>; from pavel@ucw.cz on Tue, Dec 10, 2002 at 10:34:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 10:34:44PM +0100, Pavel Machek wrote:

> > > In article <m3d6ocjd81.fsf@Janik.cz> you wrote:
> > > > this patch add support for four functions key on DELL Latitude X200.
> > > 
> > > we need a more generic appoach to handle those key codes for various
> > > extensions. I think a pure software reconfiguration of the keymaps or a
> > > daemon trakcing the raw codes is fine. Perhaps we can make something like a
> > > hook into the kernel where all untrapped function keys are send to in raw
> > > format?
> > 
> > The PC only has so many possible keycodes (with E0 and E1 it's still
> > in the sub-300 range.)  It won't fit within 128, but I would really
> > like an algorithmic mapping from scancodes to keycodes so we don't
> > continue to have this problem.
> > 
> > For example, using a 16-bit keycode model:
> > 
> > 
> > 	Scancode		Keycode (binary)
> > 	mxxxxxxx	 	m0000000 0xxxxxxx
> > 	E0 mxxxxxxx		m0000000 1xxxxxxx
> > 	E1 mxxxxxxx yyyyyyyy	mxxxxxxx yyyyyyyy
> > 
> > m = make/break bit
> 
> Well, nothing prevents keyboard manufacturers from using 0xe2 as a
> prefix, too.

Except that it would pretty much confuse any existing OS. The only key
prefix is E0, because E1 is only used for a single key, and that's fake
right shift, which should be discarded anyway even before a keycode is
generated.

Anyway, we definitely don't want scancode dependent keycodes. Keycodes
should be the same for all types of keyboards (Be it PS/2, USB, or ADB),
so that you can have a single set of N keymaps (us, gb, french, czech,
whatever), and not N*M keymaps for different languages and keyboard
types.

This simplifies things both in the kernel (a bit), and userspace (a lot).

Now, speaking about a fixed scancode->something mapping, atkbd.c in 2.5
uses this encoding:

	   xxxxxxxx -> 0 xxxxxxxx	
	E0 xxxxxxxx -> 1 xxxxxxxx

Note that no make/break bit is used, as the keyboard is operated in 
"Set 2" of scancodes, where release is signalled by the F0 prefix, and
not by the highest bit. And since the keycode is passed on as an input
event, we don't need to encode make/break into the keycode on the output
either.

The real question is, when we have these 16-bit (or more bit) keycodes,
how do we export them to the userspace? In cooked mode, there is no
problem, we can extend the keymaps. But both medium raw and raw modes
are pretty much limited in the number of keys they can carry. See 2.5
keyboard.c for the current imperfect solution.

IMHO applications which now use raw mode should instead switch to using
the event devices in /dev/input ...

> I think there are really *weird* keyboards out there.

There are, but fortunately not that much weird.

-- 
Vojtech Pavlik
SuSE Labs
