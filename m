Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUANOYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUANOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:24:54 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:36838 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266303AbUANOYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:24:48 -0500
Date: Wed, 14 Jan 2004 15:24:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040114142445.GA28377@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz> <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org> <20040112083647.GB2372@ucw.cz> <20040112135655.A980@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112135655.A980@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 01:56:55PM +0100, Andries Brouwer wrote:

> See http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.17
> 
> ---------------------------------------------------------------------
> ABNT (Associao Brasileira de Normas Tecnicas) and ABNT2 are Brazilian
> keyboard layout standards. The plain Brazilian keyboard has 103 keys. 
> The Brazilian ABNT keyboard has two unusual keys, with scancodes 73 (/?)
> and 7e (Keypad-.). The former is located to the left of the RShift
> (which key therefore is less wide than usually), the latter below the
> Keypad-Plus (reducing the Keypad-Plus to single height). 
> Under Linux, the corresponding key codes are 89 and 121, respectively.
> ---------------------------------------------------------------------
> 
> In the 2.4 source, see the array high_keys[]. It will map 73, 7d
> (seen on Japanese keyboards), 7e to keycodes 89, 124, 121.
> 
> The 2.6.1 kernel will first untranslate to 51, 6a, 6d and then map
> to 181, 182, 124, changing the keycode for all three.

I've delved into the pc_keyb.c from 2.4, and now I have found the final
piece of the puzzle. Thanks for the clues.

Up to now, I really didn't know there actually _were_ standard keycodes
for Japanese, Korean and Brazil keys in 2.4, as those are named like
"FOCUS_PF10" and similar there. That's why I didn't take them into
account when making a list of "Linux keycodes" in drivers/input.h.

Now I've found out that the list is:
		
			| Xlate	| 2.4	| 2.4	| 2.6	| 2.6
Name			| Set2	| Name	| code	| code	| conflict
------------------------------------------------------------
Brazil KP,		| 7e	| PF10	| 121	| 124	| F22
Brazil /?		| 73	| PF2	|  89	| 181	| F14
Jp Romanji		| 73	| PF2	|  89	| 181	| F14
Jp Hiragana/Katakana	| 70    | 	| 	| 182   |
Jp Yen			| 7d	| JAP86	| 124	| 183	| KPCOMMA
Jp Henkan		| 79	| PF5	|  92	| 184	| F17
Jp Muhenkan		| 7b	| PF7	|  94	| 185	| F19
Jp KP,			| 5c	| RGN4	| 127	| 186	| COMPOSE
Korean Hanguel/English	| f2	| 	| 	| 190	| 
Korean Hanja		| f1	|	|	| 191	|
Jp Katakana		| 78	| PF4	|  91	| 192	| F16
Jp Hiragana		| 77	| PF3	|  90	| 193	| F15
Jp Zenkaku/Hankaku	| 76	| 	| 	| 194	|
Euro (GB,Fr) 103rd	| 	|	|  43	|  84	| BACKSLASH

I am willing to change the 2.6 codes to match the 2.4 ones. This will
mean that the keys listed in "2.6 conflict" column will need to have
their keycodes changed. Since most of those are rarely used keys, this
shouldn't have too big impact on users.

A few problematic cases still remain:

1) Keys that don't have a 2.4 keycode. This is Korean keys and some
Japanese keys. I'd suggest assigning another of the "Fxx" keycodes to
them, so that they're close to each other.

2) JP PC9800 KP,. This one conflicts with COMPOSE (or windows-key on AT
keyboards). Since it conflicts in 2.4 as well, there is no way to make
it work sanely. I'd suggest not making it the same as on 2.4 and use
some Fxx keycode for it so that it is below 128. This will hurt PC9800
users, but the PC9800 is rare and more or less experimental ...

3) Euro 103rd. This one didn't exist on 2.4 at all, because Set2
keyboards can't generate it. Set3 keyboards, USB keyboards and ADB
keyboards can. So far 2.6 will generate keycode 84 for it, and
compatible set2 sequence in emulated raw mode. I think this is as far as
we can get with compatibility without throwing away the distinction
between the key and backslash. It'll still hurt french and british users
a bit, since they'll have to change their keymaps on console. In XFree86
things will work as expected.

COMMENTS?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
