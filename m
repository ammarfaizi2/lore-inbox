Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJISCT>; Tue, 9 Oct 2001 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277878AbRJISCJ>; Tue, 9 Oct 2001 14:02:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63749 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273796AbRJISBz>; Tue, 9 Oct 2001 14:01:55 -0400
Date: Tue, 9 Oct 2001 11:01:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: Emu10k1 driver update
In-Reply-To: <Pine.LNX.4.33.0110092119230.12595-200000@sophia-sousar3.nice.mindpseed.com>
Message-ID: <Pine.LNX.4.33.0110091055170.911-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Oct 2001, Rui Sousa wrote:
>
> Attached a patch for the emu10k1 kernel driver against 2.4.11pre6.

Applied. However..

> Changes:
> Mixer improvements.
> Fixed a dead lock in emu10k1_volxxx_irqhandler.

The locking still looks _very_ suspicious. The code seems to lock at all
the wrong places, leaving a lot of accesses completely outside any
locking. In particular, look at how the code in emu10k1_set_oss_vol()
(which was apparently the one involved in the irqhandler lockup) now does
not protect the mixer_state thing in _any_ way.

In general it is a bug to leave locking to the low-level routines, in this
case to "emu10k1_set_volume_gpr()". I realize that somebody went "Ugh, we
should try to make the locking regions as small as possible", but the fact
is, locks that are _too_ small are no better than no locks at all.

It may be that there is some good reason for why the mixer_state thing
doesn't need a lock - I only gave the patch a quick see-though, but if so
maybe a single line comment migth be appropriate.

		Linus

