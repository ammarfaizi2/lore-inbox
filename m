Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285248AbRLFWJh>; Thu, 6 Dec 2001 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285249AbRLFWJ0>; Thu, 6 Dec 2001 17:09:26 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:44445 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S285248AbRLFWJU>;
	Thu, 6 Dec 2001 17:09:20 -0500
Date: Thu, 6 Dec 2001 17:09:19 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
In-Reply-To: <20011206104510.A32451@elektroni.ee.tut.fi>
Message-ID: <Pine.LNX.4.30.0112061657150.22686-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Petri Kaukasoina wrote:

> On Thu, Dec 06, 2001 at 12:41:36AM +0000, Alan Cox wrote:
> > We already have one. The Linux folks saw the problem much earlier than
> > windows people because our athlon optimised memory copies triggered it
> > reliably on many boards.
>
> The details were a bit different in that web page:
>
> Linux looks for chip with id 1106:0305 (KT133) and clears only bit 7 of
> register 55. The Windows driver checks for chips 1106:0305, 1106:3099,
> 1106:3102, 1106:3112, and clears three bits: bits 5-7 of that register. In
> addition, the web page tells that it's probably not right for 1106:3099
> (KT266) because there it should be register 95.
>
> Maybe this is not relevant: maybe all BIOSes for KT266 chipsets already set
> the right values and maybe KT133 boards with problems only have bit 7 set,
> not bits 5 and 6. (PCs here with KT133 already have all bits 5-7 zero in
> reg. 55 and PCs with KT266 have bits 5-7 both in reg. 55 and 95 zero.)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Here is the webpage:

This patch detects the 0305, 3099, 3102, and 3112 (KT133x, KT266x, VT8662,
and KLE133) *only*. On these chipsets, it will patch register 55 in the
Northbridge, which will supposedly switch off a Memory Write Queue timer.
In the KT133A datasheet, register 55 is "reserved". But - yikes! - in the
KT266, the documented MWQ register is register 95, not 55. Register 55
contains unrelated DDR timing adjustments and could actually be dangerous
to program. For this reason, I do not recommend installing this driver on
the KT266x chipsets until VIA examines this issue. For now, use WPCREDIT
and set bits 5, 6, and 7 to zero in register 95 instead."

----

Clearly, we need to modify the via workaround patches to take into account
the other via device id's (namely 3099, 3102, and 3112), and for each one
change the appropriate register.  Either register 55 or in the case of the
kt266x, register 95.  I am grepping through quirks.c right now and it
seems this would be the correct file to modify.. any other suggestions on
what file to modify?

I am going to play with this right now myself using user-space tools and
experiment to see if it solves my issues with my 33-node beowulf cluster
(all nodes use the kt266) being very unstable.

Read again: I seriously believe that I am a person who is afflicted by
this (or some other unknown) hardware bug as any linux kernel I try is
relatively unstable (approx 5% per day chance of crash -- 13% chance if we
turn on athlon optimizations)!  This means that in a few weeks, almost all
of our beowulf nodes go down if left unattended!  And I KNOW it's not due
to cpu temperature, wrong GCC version, or any other really obvious thing..

-Calin

