Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTGBGYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTGBGYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:24:51 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:993 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264766AbTGBGYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:24:49 -0400
Date: Wed, 2 Jul 2003 09:39:12 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
To: "Andreas U. Trottmann" <andreas.trottmann@werft22.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard.c fix in 2.4.21 breaks my (buggy?) keyboard
In-Reply-To: <20030701223800.GA13973@kreator.toc.aart.ch>
Message-ID: <Pine.LNX.4.53.0307020935380.9206@hosting.rdsbv.ro>
References: <20030701223800.GA13973@kreator.toc.aart.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have this problem with left shift key.
X 4.2.0, 2.4.21, epox motherboard, several keyboards.
But this happen from 6 to 6 hours. And seems to last 10-20 seconds.


> Hello linux-kernel,
>
> patch-2.4.21 contains the following patch to keyboard.c:
>
> diff -urN linux-2.4.20/drivers/char/keyboard.c linux-2.4.21/drivers/char/keyboard.c
> --- linux-2.4.20/drivers/char/keyboard.c        2002-08-02 17:39:43.000000000 -0700
> +++ linux-2.4.21/drivers/char/keyboard.c        2003-06-13 07:51:33.000000000 -0700
> @@ -213,7 +215,17 @@
>         }
>         kbd = kbd_table + fg_console;
>         if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
> -               put_queue(scancode | up_flag);
> +               /*
> +                *      The following is a workaround for hardware
> +                *      which sometimes send the key release event twice
> +                */
> +               unsigned char next_scancode = scancode|up_flag;
> +               if (up_flag && next_scancode==prev_scancode) {
> +                       /* unexpected 2nd release event */
> +               } else {
> +                       prev_scancode=next_scancode;
> +                       put_queue(next_scancode);
> +               }
>                 /* we do not return yet, because we want to maintain
>                    the key_down array, so that we have the correct
>                    values when finishing RAW mode or when changing VT's */
>
>
> But apparently, there is not only hardware that sends the key release
> event twice, but also hardware that sends the key press event twice
> in certain circumstances.
>
> I've got a keyboard ("Unikey model KWD-205"), which, for the left
> control key (and apparently only for this key) sends the key down
> event twice, followed by two key up events. For certain applications
> using VC_RAW (most important XFree86), this means that the ctrl
> key gets "stuck" once it's been pressed.
>
>
> I don't know an "appropriate" fix to this problem. Obviously, the
> patch got inserted in 2.4.21 because it fixes broken keyboards
> owned by many people. As I didn't find any reports about my
> problem with google, it seems that keyboards like my one are
> quite rare. One possible solution would be to ignore any events
> where next_scancode==prev_scancode, regardless of up_flag - but
> this breaks autorepeat, which then would maybe need to be
> emulated.
>
> Another possible fix would be to only ignore multiple identical
> "up" events for non-modifier keys, but this would require
> keyboard.c to have a list of key symbols of keys like "control",
> "shift" etc.
>
>
> So, are there other people having the same problem? Is it worth
> to find a "good" fix for the linux kernel, or should I just
> remove this patch by hand every time I compile a new kernel,
> until my keyboard dies and I get a non-broken one? ;-)
>
> --
> Andreas Trottmann
> Ideen Werft22 GmbH
> Tel    +41 (0)56 210 91 37
> Fax    +41 (0)56 210 91 34
> Mobile +41 (0)79 229 88 55
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
