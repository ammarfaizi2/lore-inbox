Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSJ2TCc>; Tue, 29 Oct 2002 14:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSJ2TCc>; Tue, 29 Oct 2002 14:02:32 -0500
Received: from waste.org ([209.173.204.2]:24499 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262036AbSJ2TCY>;
	Tue, 29 Oct 2002 14:02:24 -0500
Date: Tue, 29 Oct 2002 13:08:31 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Entropy from disks
Message-ID: <20021029190831.GE28665@waste.org>
References: <20021029171011.GD28665@waste.org> <3DBECD3F.2080204@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBECD3F.2080204@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 01:02:39PM -0500, Chris Friesen wrote:
> Oliver Xymoron wrote:
> 
> I'm not an expert in this field, so bear with me if I make any blunders 
> obvious to one trained in information theory.
> 
> >The current Linux PRNG is playing fast and loose here, adding entropy
> >based on the resolution of the TSC, while the physical turbulence
> >processes that actually produce entropy are happening at a scale of
> >seconds. On a GHz processor, if it takes 4 microseconds to return a
> >disk result from on-disk cache, /dev/random will get a 12-bit credit.
> 
> In the paper the accuracy of measurement is 1ms.  Current hardware has 
> tsc precision of nanoseconds, or about 6 orders of magnitude more 
> accuracy.  Doesn't this mean that we can pump in many more bits into the 
>  algorithm and get out many more than the 100bits/min that the setup in 
> the paper acheives?

No, it doesn't scale quite like that. The autocorrelation property
says such bits are poorly distributed - the turbulence has an inherent
timescale at which things become hard to predict. Over short
timescales they become easier to predict. We can posit that we can
increase the measurement accuracy to a degree where we begin to see
some sort of underlying noise caused by Brownian motion and physical
processes of that sort, but then you'd have to sit down and model it
like this paper's done rather than just handwaving and saying 12 LSBs
of the TSC are real noise. 

But that's all irrelevant because the TSC resolution isn't really
improving our measurement accuracy anything like that much. Nothing
the processor can measure comes in faster than the FSB clock rate,
which is a fixed lock-step multiple of the processor clock, which is
generally a fixed lock-step multiple of a 33.3MHz crystal somewhere.
The disk's microcontrollers, if not taking a clock signal directly
from the motherboard, are likely in sympathetic synchrony with them,
and are even then likely divided down a bit. Framing requirements for
disk and bus protocols lower this further. 

> >My entropy patches had each entropy source (not just disks) allocate
> >its own state object, and declare its timing "granularity".
> 
> Is it that straightforward? In the paper they go through a number of 
> stages designed to remove correlated data.  From what I remember of the 
> linux prng disk-related stuff it is not that sophisticated.

No, it's not that straightforward. And no, the current code doesn't
even address cache effects. Hell, it doesn't even know about
solid-state devices. Note that SHA will do just as good a job of
removing correlation as an FFT, the problem is overestimating the
input entropy.

I think the prudent approach here is to punt and declare disks
untrusted, especially in light of the headless server attack model
where we intentionally leak entropy. It's still possible to use this
data for /dev/urandom (which my patches allow).

> >There's a further problem with disk timing samples that make them less
> >than useful in typical headless server use (ie where it matters): the
> >server does its best to reveal disk latency to clients, easily
> >measurable within the auto-correlating domain of disk turbulence.
> 
> If this is truly a concern, what about having a separate disk used for 
> nothing but generating randomness?

Doable, and probably best done with a userspace app feeding /dev/random.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
