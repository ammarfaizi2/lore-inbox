Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTIURHP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTIURHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:07:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6811 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262464AbTIURHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:07:12 -0400
Date: Sun, 21 Sep 2003 19:07:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921170710.GA20856@ucw.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz> <20030921164914.C11315@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921164914.C11315@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 04:49:14PM +0200, Andries Brouwer wrote:

> > > So, instead of requiring new ioctls and new loadkeys etc
> > > I would prefer to make NR_KEYS 256, if possible.
> > > So the question is: why did you require 512?
> > 
> > Excerpt from input.h:
> 
> > #define KEY_TEEN                0x19e
> > #define KEY_TWEN                0x19f
> > #define KEY_DEL_EOL             0x1c0
> > #define KEY_DEL_EOS             0x1c1
> > 
> > So far the last defined key is KEY_DEL_LINE, with a code of 0x1c3.
> > That's above 256. If there are other places that require less than 256,
> > well, then those will need to be fixed or we're heading for trouble.
> 
> Hmm. The kernel assumes today that keycodes have 8 bits:
> 
> In drivers/char/keyboard.c emulate_raw() tries to invent
> the codes that the keyboard probably sent and resulted in a given
> keycode. It starts out
> 	if (keycode > 255)
> 		return -1;

That's correct, because it can only emulate about 230 different
keycodes. Note that this is not 'invent what the keyboard sent', since
in many cases the keyboard did not send any keycodes (USB) or at least
not any AT-looking keycodes.

However XFree86 (and this hack is there ONLY because of XFree86) needs
AT-looking keycodes on most architectures.

If somebody could teach XFree86 to use at least the medium raw mode
here, we could get rid both of the emulate_raw() stuff and of the
limitation of what we can pass to XFree86.

Also, this causes trouble with the japanese keys in XFree86, since the
KEY_INTL* keys are in the e0 xx range because of the emulation.

> In drivers/input/keyboards/atkbd.c we have tables that convert
> scancodes to keycodes. The declaration is
> 	static unsigned char atkbd_set2_keycode[512];
> the unsigned char means that no keycodes larger than 255 can be returned.

We may need to change this to a u16, IF we'll ever need to load a
keycode above 256 for an AT keyboard. Keep in mind that AT keyboards are
not the whole world. So far all the keys on AT keyboards are within the
0..255 range. That's of course not true for other, more crazy keyboards.

> It really seems a pity to have to add new ioctls, and to have to release
> a new version of the kbd package, and to waste a lot of kernel space,
> while essentially nobody needs the resulting functionality.
 
We could do an audit of the key definitions, document which KEY_* symbol
means exactly what (and it'd be a good thing anyway), by that try to
remove duplicities and try to stuff everything in 0..255.

We'd lose te potential possibility to map keysyms to buttons, though
since that never was used, nobody would cry probably.

However, my experience tells me that whenever some range is tight, and
0..255 is in this case, we will very soon overflow as new weird devices
come into market.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
