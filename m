Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTHTXxC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTHTXxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:53:02 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:8197 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262341AbTHTXw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:52:59 -0400
Date: Thu, 21 Aug 2003 01:52:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821015258.A3180@pclin040.win.tue.nl>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030820225812.GB24639@mail.jlokier.co.uk>; from jamie@shareable.org on Wed, Aug 20, 2003 at 11:58:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 11:58:12PM +0100, Jamie Lokier wrote:

> Synthesising an UP event after receiving a DOWN from the keyboard, and
> nothing else for that key for > (repeat delay + a bit more) time looks
> like a good plan to me, UNLESS there are keys which do report UP when
> the key is released (as opposed to immediately after the DOWN), and
> also don't repeat.

And there are keyboards with such keys.

> Unrelated: I have some messages from my laptop, Toshiba Satellite 4070CDT:
> 
>   atkbd.c: Unknown key (set 2, scancode 0x94, in isa0060/serio0) pressed.
>   atkbd.c: Unknown key (set 2, scancode 0xbf, in isa0060/serio0) pressed.
>   atkbd.c: Unknown key (set 2, scancode 0xa1, in isa0060/serio0) pressed.

Do you know what keystrokes cause this?

It looks like this cannot come from i8042_unxlate_table[].
Do you set i8042_direct?

Vojtech, this sounds like a bug in i8042.c:
We do
	if (data > 0x7f) {
		index = (data & 0x7f);
		if (test_and_clear_bit(index, i8042_unxlate_seen)) {
			data = i8042_unxlate_table[data & 0x7f];
		}
	} else {
		data = i8042_unxlate_table[data];
	}
	serio_interrupt(&i8042_kbd_port, data, dfl, regs);

In other words, the keyboard sends something in translated Set 2,
but we fake that it is untranslated, unless it was
a key release and we didnt know that the key was down.
Thus, atkbd.c gets a mixture of untranslated and translated codes.

Andries

