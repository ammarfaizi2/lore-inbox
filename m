Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVHOVKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVHOVKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVHOVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:10:55 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:36506 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S964969AbVHOVKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:10:54 -0400
Date: Mon, 15 Aug 2005 23:10:43 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: James Simmons <jsimmons@infradead.org>, yhlu <yhlu.kernel@gmail.com>,
       <alex.kern@gmx.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <4789af9e050815133711481beb@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0508152246590.11750-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Op Mon, 15 Aug 2005, schreef Jim Ramsay:

> On 8/15/05, Daniël Mantione <daniel@deadlock.et.tudelft.nl> wrote:
> > I don't know what the purpose of this patch is but it copies the pre-LCD
> > version of the code in mach64_ct.c into the xlinit.c code of 2.6. This is
> > not the var_to_pll code. This code affects the display fifo and can
> > cause wrong image if incorrectly programmed, but has nothing to do with
> > initializing the chip.
>
> The purpose of this patch is to get the xlinit working for non-i386
> machines, such as the MIPS processor board I'm currently working with.
>  It works for me.  The problem is that for non-i386 machines,
> init_bios_setup is not called, so some values that the 2.6 code
> assumes should be initialized are not.
>
> In the 2.4 kernel I'm using as a reference with the 'xlinit' code
> built in, which works on my hardware, the var_to_pll code consists of
> 3 calls:
> - aty_valid_pll_ct
> - aty_dsp_gt
> - aty_calc_pll_ct
>
> Now, the 2.6 kernel's var_to_pll code is identical, except that it
> doesn't call aty_calc_pll_ct any more.  However, the differences don't
> stop there.  The 'aty_valid_pll_ct' call in the 2.6 kernel is much
> smaller than the 2.4 kernel - apparently it assumes that someone else
> will have initialized much of the pll struct.

Yes, aty_valid_pll_ct in the pre-LCD calculation consists of two parts:
 * Calculation of the post divider for the chip and memory clock.
 * Calculation of the post divider for the pixel clock.

The the calculation of the post divider for the chip and memory clock
is part of the chip initialisation, and not of the video mode setting. It
didn't hurt though. However, in the post-LCD code there is an option to
prevent the driver from reclocking your chip and there are separate chip
and memory clocks. Therefore the calculation of the memory post divider is
done in mach64_ct.c near line 358 and the chip clock near line 391. This
code is fully equivalent to the original.

The calculation of the post divider for the pixel clock is still in
aty_valid_pll_ct.

Now, the only thing that aty_calc_pll_ct did, was to convert a multiplier
(1x, 2x, 4x or 8x) to a number that should be programmed into a register
(0, 1, 2 or 3). I use a more elegant way in the post-LCD code, and that is
a simple array lookup in the postdividers array.

In other words, all code of aty_valid_pll_ct and aty_calc_pll_ct is still
there and there should be no need to use the 2.4 code.

aty_dsp_gt is totally rewritten as I described in my previous e-mail.

> So to work around this I took these from the 2.4 kernel, renamed them
> with 'init_' instead of 'aty_' and put them into xlinit.c, only if
> __i386__ isn't defined, and call them explicitly instead of wrapping
> them inside a function called 'var_to_pll'.
>
> > The pre-LCD code caused several problems for both i386 and
> > non-i386 laptops, and should not be reused. Also, Geert Uytterhoeven
> > has said that he developed the pre-LCD by trial and and not by
> > design. The post-LCD code is derived from the XFree86 driver, it is
> > supposed to work fine if X works.
>
> My patch won't affect non-i386 machines.  Notice the '#ifndef
> __i386__' around everything I changed.

It won't affect i386 machines because of that. It will affect PowerPC
hardware which use Mach64 chips a lot.

We did a fix (display fifo size) into the table of chips to make an
Apple Wallstreet laptop work. That change was correct, but it does have
the effect that it no longer works with the old code.

> This simply fixes the issue that the new 2.6 xlinit code assumes that
> you have a bios that will do *something* to your chip before handing
> control over to the kernel, which is not always the case.
>
> If you have a fix that is more correct, I'd be happy to test it for you!

Afaik the driver falls back to default values in the chip table if
init_bios_setup isn't called or succesfull. But then there might still be
a need for a replacement for init_bios_setup. If the chip table does not
contain the right values for your system you should write a replacement.
If necessary, explicitly detect your machine and use hardcoded values.

Daniël

