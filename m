Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIRQtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTIRQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:49:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41875 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261670AbTIRQtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:49:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 18 Sep 2003 18:42:06 +0200 (MEST)
Message-Id: <UTC200309181642.h8IGg6G24616.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, john@81-2-122-30.bradfords.org.uk,
       john@grabjohn.com, linux-kernel@vger.kernel.org, ndiamond@wta.att.ne.jp
Subject: Re: 2.6.0-test5 vs. APM or keyboard driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > So far we have heard about precisely one keyboard in the world
    > where scancode mode 3 was useful. It is the Japanese keyboard
    > of John Bradford.
    > John: What ID does this keyboard report?

    Sorry I didn't get back to you earlier about this.

    It reports ab90.

Thanks!
That is the ID that is said to belong to "old Japanese 'G' keyboards".

    Using set3 in 2.6 works, but not without a few problems.

    Pressing any of the language keys reports nothing, but causes the next
    keystroke to be lost.

Yes, a phenomenon I discovered a few years ago.
Your language keys are muhenkan, zenkoho/henkan, hiragana
with scancodes 85, 86, 87 (untranslated Set 3).
A release produces f0 85, etc.

Now the translation operation turns this f0 into an OR of the first
following scancode byte that does not have the high bit set with 0x80.
That is reasonable in case of e0 escapes like e0 1d that are turned
into e0 9d. But it is unreasonable in a case like this. The effect
is that the following make code is turned into a break code, so that
no keystroke is seen.

Similar things happen with the Windows keys LWin, RWin, Menu.

This means that you do not want to use translated Set 3 - you need
untranslated Set 3. (Not that the kernel should untranslate - the
keyboard must not translate. Try the i8042_direct boot parameter.)

    Right alt and right control both generate keycode 100, and are both
    interpreted as alt.

RAlt: X(Set 2): e0 38, Set 2: e0 11, keycode2: 100, Set3: 39, keycode3: 100
RCtrl:X(Set 2): e0 1d, Set 2: e0 14, keycode2:  97, Set3: 58, keycode3: 100

This is a bug in the atkbd_set3_keycode[].
Of course one wants the keycodes to be independent of the current
scancode set. So, a diff for atkbd.c (line number might differ):
73c73
<       113,114, 40, 84, 26, 13, 87, 99,100, 54, 28, 27, 43, 84, 88, 70,
---
>       113,114, 40, 84, 26, 13, 87, 99, 97, 54, 28, 27, 43, 84, 88, 70,


    The Yen key reports keycode 86.  This is defined as less/greater in
    the Japanese keyboard map I used.

Yen,| on your keyboard gives Set 3: 13, and that is converted into
keycode 86. Normally keycode 86 is used for Set 2: 61, X(Set 2): 56
a non-US key.
Normally Yen gives X(Set 2): 7d, Set 2: 6a, keycode 183.

Not good, not bad. Adapt the keymap used.

    Backslash/underscore reports keycode 43, which the keymap defines as
    bracketright/braceright.

Backslash/underscore on your keyboard gives Set 3: 5c, and that is
converted into keycode 43. Normally keycode 43 is used for Set 2: 5d,
X(Set 2): 2b, Set 3: 5c, the \| key.

Not good, not bad. Adapt the keymap used.

    The actual bracketright/braceright key reports 84 on my keyboard,
    whereas backslash/underscore in the keymap is defined for keycode 89.

Bracketright/braceright on your keyboard gives Set 3: 53, and that is
converted into keycode 84. Normally keycode 84 is returned in Set 2
for Alt+SysRq, while it is returned in Set 3 for both 53 and 5d.
That sounds like another bug in the kernel Set 3 keymap.
Neither 53 nor 5d are standard Set 3 scancodes.
I have no suggestion for correction - we must ask Vojtech why he
put down 84 here. In the meantime, be careful not to activate the
magic sysrq accidentally.

    All of these problems should be easily fixable.  The lost keystoke one
    didn't happen last time I actually tested set3 in 2.5, (that was a
    long time ago, though, around 2.5.40).

Yes. That time you used untranslated Set 3, this time translated Set 3.

    I'll get some more useful debug information later, but my serial
    terminal is in need of repair at the moment :-(.

Well, this was very useful. One ID and two kernel bugs.

Andries


