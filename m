Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277900AbRJISq3>; Tue, 9 Oct 2001 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277901AbRJISqU>; Tue, 9 Oct 2001 14:46:20 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:26296 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S277900AbRJISqN>; Tue, 9 Oct 2001 14:46:13 -0400
Date: Tue, 9 Oct 2001 20:45:52 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: [Emu10k1-devel] Re: Emu10k1 driver update
In-Reply-To: <Pine.LNX.4.33.0110091055170.911-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110092019470.3012-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Linus Torvalds wrote:

Actually there is no locking implemented for the ac97 codec mixer.
It never seemed worth it, even if there are potential races in the code.
To have two applications accessing the mixer at the same time is a _very_
rare condition and the worse that can happen is to set a wrong volume
value. Anyway, I will give it another look and try to come up with a fix.


The locking that we care about (mgr->lock) is for the dsp microcode, where
we don't want to have it changing under us. Writing to the wrong
dsp register can have some interesting effects.

Rui Sousa

>
> On Tue, 9 Oct 2001, Rui Sousa wrote:
> >
> > Attached a patch for the emu10k1 kernel driver against 2.4.11pre6.
>
> Applied. However..
>
> > Changes:
> > Mixer improvements.
> > Fixed a dead lock in emu10k1_volxxx_irqhandler.
>
> The locking still looks _very_ suspicious. The code seems to lock at all
> the wrong places, leaving a lot of accesses completely outside any
> locking. In particular, look at how the code in emu10k1_set_oss_vol()
> (which was apparently the one involved in the irqhandler lockup) now does
> not protect the mixer_state thing in _any_ way.
>
> In general it is a bug to leave locking to the low-level routines, in this
> case to "emu10k1_set_volume_gpr()". I realize that somebody went "Ugh, we
> should try to make the locking regions as small as possible", but the fact
> is, locks that are _too_ small are no better than no locks at all.
>
> It may be that there is some good reason for why the mixer_state thing
> doesn't need a lock - I only gave the patch a quick see-though, but if so
> maybe a single line comment migth be appropriate.
>
> 		Linus
>
>
> _______________________________________________
> Emu10k1-devel mailing list
> Emu10k1-devel@opensource.creative.com
> http://opensource.creative.com/mailman/listinfo/emu10k1-devel
>

