Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280435AbRJaT0h>; Wed, 31 Oct 2001 14:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRJaT02>; Wed, 31 Oct 2001 14:26:28 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:779 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280435AbRJaT0I>; Wed, 31 Oct 2001 14:26:08 -0500
Date: Wed, 31 Oct 2001 20:26:16 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Andreas Dilger <adilger@turbolabs.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <01103121070200.01262@nemo>
Message-ID: <Pine.LNX.4.30.0110312017460.29808-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I would say that the race is so rare that it should not be handled,
> > especially since it adds extra code in the timer interrupt.
>

The expensive code in the timer interupt will be executed every
497.1 days, so that's bearable.


> Race will be handled by readers of 64bit jiffy. There won't be many of them.
>
> > > +	/* We need to make sure jiffies_high does not change while
> > > +	 * reading jiffies and jiffies_high */
> > > +	do {
> > > +		jiffies_high_tmp = jiffies_high_shadow;
> > > +		barrier();
> > > +		jiffies_tmp = jiffies;
> > > +		barrier();
> > > +	} while (jiffies_high != jiffies_high_tmp);
> >
> > Maybe this could be condensed into a macro/inline, so that people don't
> > screw it up (and it looks cleaner).  Like get_jiffies64() or so, for
>
> Inline! Inline! Don't use macro unless you must!
>
> // extern or static? which is correct?
> // I see both types in kernel .h :-(
> extern inline u64 get_jiffies64() {
> 	unsigned long hi,lo;
> 	do {
> 		hi = jiffies_hi;
> 		barrier();
> 		lo = jiffies;
> 		barrier();
> 	} while (hi != jiffies_hi);
> 	return lo + (((u64)hi) << 32);
> }

should be
	return lo + (((u64)hi) << BITS_PER_LONG);
to not break 64 bit platforms.

Admittedly, I broke 64 bit myself by submitting a wrong version of my
patch. The condition
	if (jiffies != 0xffffffffUL) {
		jiffies++;
in do_timer needs to be
	if (jiffies != (unsigned long)-1) {
		jiffies++;


>
> And guys, why you don't comment on my hand-crafted asm version of
> union { u32 jiffies; u64 jiffies64; }; ? Is it flawed?
> --
> vda
>

I believe not, but it is platform-specific.

Tim

