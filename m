Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTIRIAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTIRIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 04:00:38 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:40378 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S263011AbTIRIAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 04:00:36 -0400
Date: Thu, 18 Sep 2003 10:00:33 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <Pine.LNX.4.44.0309172325160.8954-100000@deadlock.et.tudelft.nl>
Message-ID: <Pine.LNX.4.44.0309180940460.17499-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003, Daniël Mantione wrote:

> So, to fix this we can look at the X driver, I must have made an error
> somewhere.

I found a problem, but it would mean that it was already broken before my
patch.

X does this test to check if a chip has 24 bit or a 32 bit precision display
fifo settings:

    if (pATI->Chip < ATI_CHIP_264VT4)
    {
        pATI->XCLKPageFaultDelay += 2;
        pATI->XCLKMaxRASDelay += 3;
        pATI->DisplayFIFODepth = 24;
    }

In atichip.h, ATI_CHIP_264LT is smaller than ATI_CHIP_264VT4, so according
to the X sources, the Mach64 LT has a fifo depth 24.

Now my code:

    if (M64_HAS(FIFO_24)) {
        info->fifo_size = 24;
        info->xclkpagefaultdelay += 2;
        info->xclkmaxrasdelay += 3;
    } else {
        info->fifo_size = 32;
    };

That looks ok. But look at the aty_chips table:

    { 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg,     230,  63,  63, M64F_GT |
    M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL |
    M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },

The Mach64 LT does not have the M64F_FIFO_24 flag set! That will result in
completely different values to be calculated and cause a distorted
display.

Greetings,

Daniël Mantione

