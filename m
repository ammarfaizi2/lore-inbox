Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTIBFjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTIBFjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:39:11 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:8921 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263515AbTIBFjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:39:07 -0400
Date: Tue, 2 Sep 2003 07:39:03 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030902053903.GD25927@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030901160125.GL22127@charite.de> <20030902021603.A1167@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902021603.A1167@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer <aebr@win.tue.nl>:

> > * Chris Heath <chris@heathens.co.nz>:
> > > > Aug 27 18:53:41 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > > > Aug 27 19:15:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> > > > Aug 27 19:42:50 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > > > Aug 28 10:14:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > > > 
> > > > Basically, CTRL was stuck. Even when I switched to X11.
> > > 
> > > Well, this completely baffles me.  I thought X11 maintains its own
> > > keydown array.
> 
> It can do that only when it gets uncontaminated data.
> 
> > I applied your patch, and alas:
> > 
> > Sep  1 16:12:19 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> > Sep  1 16:12:19 hummus2 kernel: i8042 history: ae 9d e0 48 e0 c8 e0 38 56 d6 e0 b8 e0 b8 39 b9
> 
> I don't know why you say "alas". I read (two key releases, then)
> press UpArrow, release UpArrow, RAlt, some key, release some key, release RAlt,
> funny: again release RAlt, press space bar, release space bar.

This must a known bug of this particular keyboard.

> So, nothing "Unknown" about this 0xb9 key - it is the spacebar release.
> 
> But i8042.c will do an unxlate when it thinks the key is down, so it
> did not think so. But we saw the key down a moment ago. Apparently
> the line
> 
> 	set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
> 
> did not set i8042_unxlate_seen for data = 0x39. And it is clear why:
> The sequence e0 b8 e0 b8 is a repetition, the second e0 sets i8042_last_e0,
> but after the second b8 we bail out without clearing i8042_last_e0 again.
> *BUG*.
> 
> Conclusion: in the skipped double release case we must clear i8042_last_e0.
> 
> Andries
> 
> Vojtech: Note: 1 line should be added in i8042.c:i8042_interrupt().
> [A stopgap - in fact all this i8042_unxlate_seen stuff should be ripped out.]
> 
> --- serio/i8042.c~      Sat Aug  9 22:16:42 2003
> +++ serio/i8042.c       Tue Sep  2 03:09:12 2003
> @@ -410,6 +410,7 @@
>                         /* work around hardware that doubles key releases */
>                         if (index == i8042_last_release) {
>                                 dbg("i8042 skipped double release (%d)\n", index);
> +                               i8042_last_e0 = 0;
>                                 continue;
>                         }
>                         if (index == 0xaa || index == 0xb6)

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
