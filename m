Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbTINJfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTINJfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:35:51 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:17374 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262204AbTINJft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:35:49 -0400
Date: Sun, 14 Sep 2003 11:35:46 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <Pine.GSO.4.44.0309141155480.22863-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.44.0309141117030.15181-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, Meelis Roos wrote:

> The update to atyfb to add LCD support breaks sparc64. I tried with
> -pre3, this broke (details below). Patched it with the updated
> atyfb_base thing but it didn't change anything.

Ok. The sparc code has not been modified; something weird is going on. (By
the way, the Sparc code could use some design improvement, as a special
exception, the Sparc does backcalculation and it is hacky implemented).

> Here is dmesg - the important bit is the bracketed current code value -
> bug in ksymoops probably. Note the invalid pixel width line before the
> oops. The pix_width in question comes from
> pix_width = crtc->gen_cntl & CRTC_PIX_WIDTH_MASK;

What is the default video mode on your sparc? Could the value that is
read be CRTC_PIX_WIDTH_4BPP or CRTC_PIX_WIDTH_16BPP? (Atyfb does only
support 8, 15, 24 and 32 bpp)

The code that calls aty_crtc_to_var has been changed a bit to accomodate
lcd mode calculations. It could be that it is called while the default
video mode on sparc is still active. This should not harm, since the
display is set to 640x480, 8bpp afterwards.

> So it seems it breaks on a division at the code 82704002.
>
> Search throught atyfb_init disassembly show it to be the second division
> of 3 in atyfb_init. This correnponds to the line
>
> T = 2 * Q * R / M;
>
> in atyfb_base.c, line 2668. M gets its value as
> M = pll_regs[2];
> a couple of lines above.

Ok, pll register 2 is PLL_REV_DIV (perhaps this code should use the
constants). It cannot be zero, otherwise the chip will malfunction.
So I think it must be because of a malfunction of aty_ld_pll.

> Here I get stuck - maybe pll_regs points to a wrong value...

Quite likely. I'm going to send you a few modifications, we'll see if they
do something.

Daniël

