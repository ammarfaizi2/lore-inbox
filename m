Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTHUICJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTHUICJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:02:09 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:51349 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262498AbTHUICD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:02:03 -0400
Date: Thu, 21 Aug 2003 10:01:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821080145.GA11263@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821015258.A3180@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:52:58AM +0200, Andries Brouwer wrote:

> > Synthesising an UP event after receiving a DOWN from the keyboard, and
> > nothing else for that key for > (repeat delay + a bit more) time looks
> > like a good plan to me, UNLESS there are keys which do report UP when
> > the key is released (as opposed to immediately after the DOWN), and
> > also don't repeat.
> 
> And there are keyboards with such keys.

Are there? Nevertheless the synthetic UP probably wouldn't hurt much,
because it will only happen some 270 ms after the press at which time
the user did probably already release the key, and if he did not, we
just ignore the real release event.

I have that logic running on my computer and so far it doesn't cause any
trouble.

> > Unrelated: I have some messages from my laptop, Toshiba Satellite 4070CDT:
> > 
> >   atkbd.c: Unknown key (set 2, scancode 0x94, in isa0060/serio0) pressed.
> >   atkbd.c: Unknown key (set 2, scancode 0xbf, in isa0060/serio0) pressed.
> >   atkbd.c: Unknown key (set 2, scancode 0xa1, in isa0060/serio0) pressed.
> 
> Do you know what keystrokes cause this?
> 
> It looks like this cannot come from i8042_unxlate_table[].
> Do you set i8042_direct?
> 
> Vojtech, this sounds like a bug in i8042.c:
> We do
> 	if (data > 0x7f) {
> 		index = (data & 0x7f);
> 		if (test_and_clear_bit(index, i8042_unxlate_seen)) {
> 			data = i8042_unxlate_table[data & 0x7f];
> 		}
> 	} else {
> 		data = i8042_unxlate_table[data];
> 	}
> 	serio_interrupt(&i8042_kbd_port, data, dfl, regs);
> 
> In other words, the keyboard sends something in translated Set 2,
> but we fake that it is untranslated, unless it was
> a key release and we didnt know that the key was down.
> Thus, atkbd.c gets a mixture of untranslated and translated codes.

It's not perfect, but it's the best what we can do if we don't want to
move translated mode support to atkbd, which I definitely don't.

The problem is that only data below 0x7f is translated, by a mostly 1:1
table (there are two exceptions, 0x83 and 0x84). Data above 0x80
inclusive is not translated.

So, if you get a 0x9f code, you need to decide whether it really was
0x9f coming from the wire, or if it was actually 0xf0 0x27 coming from
the wire.

The code has a slight problem with multiple key releases for a single
key without a press event inbetween (which is what the toshiba does, and
I've got another keyboard which does it, too). I already have a fix for
that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
