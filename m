Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKALla>; Thu, 1 Nov 2001 06:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278782AbRKALlU>; Thu, 1 Nov 2001 06:41:20 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:6927 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S278714AbRKALlA>; Thu, 1 Nov 2001 06:41:00 -0500
Date: Thu, 1 Nov 2001 12:40:54 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: george anzinger <george@mvista.com>
cc: Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        J Sloan <jjs@lexus.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <3BE13035.30AC3E3D@mvista.com>
Message-ID: <Pine.LNX.4.30.0111011224440.1053-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, george anzinger wrote:

> Tim Schmielau wrote:
> > +
> > +#if BITS_PER_LONG < 48
> > +
> > +u64 get_jiffies64(void)
> > +{
> > +       static unsigned long jiffies_hi = 0;
> > +       static unsigned long jiffies_last = INITIAL_JIFFIES;
> > +       unsigned long jiffies_tmp;
> > +
> > +       jiffies_tmp = jiffies;   /* avoid races */
> > +       if (jiffies_tmp < jiffies_last)   /* We have a wrap */
> > +               jiffies_hi++;
> > +       jiffies_last = jiffies_tmp;
> > +
> > +       return (jiffies_tmp | ((u64)jiffies_hi) << BITS_PER_LONG);
>
> Doesn't this need to be protected on SMP machines?  What if two cpus
> call get_jiffies64() at the same time...  Seems like jiffies_hi could
> get bumped twice instead of once.
>
> George
>

Yes, it does, my race protection is bogus. Petr Vandrovec also pointed out
that. So we do need either to
 a) stuff jiffies_hi and jiffies_last into one atomic type
    (16 bits is enough for each) or
 b) use locking.
My next patch will use b), but I won't do it until I have resolved the
most annoying stability issues. I won't have time to do this before the
weekend, and don't want to bother the list too much either.

Maybe the lockups are just due to my setting of INITIAL_JIFFIES instead of
waiting 471 days. The time adjustment routines are good candidates for
this kind of mistakes. Any ideas anyone where else I might have forgotten
to introduce INITIAL_JIFFIES ?

Tim

