Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266429AbUAIIY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUAIIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 03:24:29 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:49083 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266429AbUAIIYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 03:24:25 -0500
Date: Fri, 9 Jan 2004 09:24:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Broken keycodes in recent kernels
Message-ID: <20040109082415.GA6463@ucw.cz>
References: <UTC200401090008.i0908eb24625.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200401090008.i0908eb24625.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:08:40AM +0100, Andries.Brouwer@cwi.nl wrote:
> 
> Just received my tenth complaint this year about the fact
> that kbd and recent kernels disagree as to what the right
> keycodes are. Since I maintain kbd it follows that recent
> kernels are broken.
> 
> What is right?
> The old Linux convention is that for 1-88 keycode equals scancode.
> Above that things are a bit messy, mainly because the 128 scancodes
> xx and the 128 escaped scancodes e0 xx and the single combination
> e1 1d 45 are put into 127 keycodes, and that doesnt fit.
> 
> OK. So we want at least to preserve this 1-88 range, and may worry
> about the rest later. All common keys should keep their keycode.
> See also setkeycodes(8).
> 
> 2.6 does first an untranslate and then a map to keycode,
> so the fact that keycode equals (translated) scancode
> now becomes atkbd_set2_keycode[atkbd_unxlate_table[i]] == i
> for i=1,...,88.
> 
> Looking at 2.6.0 we see a single mistake: scancode 84 is
> translated incorrectly. And many Japanese complained.
> Looking at 2.6.1-rc1 we see two mistakes: also scancode 85
> is now mistranslated.
> 
> So, I think the change of 2.6.1-rc1 was not necessarily an
> improvement, but 2.6.0 needs a fix.
> 
> I can look at the details, but perhaps Vojtech wants to comment.

I won't argue that the 2.6.1-rc situation is correct, but I'll describe
it and the difference from 2.4:

1) Keycode 84.

On 2.4, keycode 84 is the SysRq keycode, since historically AT keyboards
do emit a different keycode for SysRq than form PrintScreen, although
they're on the same key.

On 2.6, there is only one keycode for PrintScreen, in an attempt to be a
bit saner, and that is 99. And here comes my mistake - since 84 was not
used anymore, I used it for the "103rd" European key.

The 103rd key usually produces either backslash-bar or hash-tilde, or
other national combo. I believe that 2.4 did emit keycode 43 for it,
since this keyboard is treated the same as backslash by AT Set 2
keyboards, in hardware. 

USB keyboards, and Set 3 keyboards, however differentiate between this
key and the real backslash, and since there also can be the real
backslash in addition to this key on the keyboard, it makes sense to
allocate a scancode to it.

Now my snafu was that I allocated a 2.4-used scancode to it, and one
that is mapped to SAK in 2.4 keymaps usually.

This bites French, British and probably Brazilian people, too.

I'm open to suggestions about how to fix it.

2) Keycode 85.

Scancode 85 (translated, set2) at the moment is not mapped to any
keycode. There are other scancodes that are not mapped at all, only
known scancodes are mapped, the rest should be changed by the user.

Keycode 85 is defined as F13 (in keymaps), and is mapped to scancode 93
(both in atkbd.c and keyboard.c), which is F13, according to Microsoft
documentation, which was used as reference, since that's what keyboard
manufacturers tend to follow nowadays.

3) Japanese and Korean keys.

2.6 has unified support for Japanese and Korean keys on both USB and
PS/2 keyboards. 

The keycodes are defined as:

KEY_INTL1  181  /* Romanji */
KEY_INTL2  182  /* Hiragana / Katakana */
KEY_INTL3  183  /* Yen */
KEY_INTL4  184  /* Henkan */
KEY_INTL5  185  /* Muhenkan */
KEY_INTL6  186  /* PC9800 KP , */
KEY_LANG1  190  /* Hanguel */
KEY_LANG2  191  /* Hanja */
KEY_LANG3  192  /* Katakana */
KEY_LANG4  193  /* Hiragana */
KEY_LANG5  194  /* Zenkaku / Hankaku */

These keycodes are translated back to the PS/2 scancodes in raw mode.

The problem here lies in that that all the keycodes are above 128, and
are different from what 2.4 used for these keys on an AT keyboard. 

We could go back to the 2.4 layout, where the keycodes are scattered
where there was space in the translated set2 scancode list, and not even
all fit there, but I think that way lies madness. The 2.6 layout is
based on the USB HUT definition.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
