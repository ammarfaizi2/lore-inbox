Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271786AbRHRF54>; Sat, 18 Aug 2001 01:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271787AbRHRF5m>; Sat, 18 Aug 2001 01:57:42 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:52380 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S271786AbRHRF5g>;
	Sat, 18 Aug 2001 01:57:36 -0400
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
From: Robert Love <rml@tech9.net>
To: stimits@idcomm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B7DA103.1B29FACE@idcomm.com>
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr>
	<212453020.997993720@[169.254.45.213]>  <3B7C2AED.F8882B5A@idcomm.com>
	<998009263.660.65.camel@phantasy>  <3B7DA103.1B29FACE@idcomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 18 Aug 2001 01:57:27 -0400
Message-Id: <998114267.2184.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 16:56:03 -0600, D. Stimits wrote:
> Robert Love wrote:
> > 
> > On 16 Aug 2001 14:19:57 -0600, D. Stimits wrote:
> > > It would be interesting if an option were possible for entropy pool via
> > > loopback traffic.
> > 
> > is that humor? :)
> 
> To a large degree, yes (but now that I think about it, not
> entirely...speculation is dangerous to one's sanity).
> 
> > 
> > it can certainly generate a large amount of entropy if you let it.
> > 
> > but the general mechanism for grabbing entropy from char/net devices is
> > measuring values from their interrupt timings.  this is done via a flag
> > value in request_irq.
> > 
> > loopback has no interrupts thus no request_irq
> 
> After hearing about all of the possible ways of sniffing keyboards, I
> have to wonder how hard it would be to create an irq sniffing device to
> aid monitoring (like the keyboard device, planted directly in the
> computer being monitored, though I suppose once you have the keystrokes
> it is a moot point). Then there are also all those wireless mice and
> keyboards, which could possibly broadcast useful information about irq
> (although knowing the exact time between irq's can only be estimated
> without actually tapping straight into the motherboard hardware); there
> is no reason to stop at simply monitoring keystrokes (would remote
> monitoring of wireless devices offer *useful* info on irq timings?).

i would _think_ its just too unrelated.  even if we can understand the
wireless transmission, the correlation between what is sent and how the
IRQs are triggered is probably pretty vague.

then you have the whole issue of skew between times, etc.

> I noticed add_timer_randomness depends on time between events, and that
> it isn't necessarily irq that matters; but irq is most likely the least
> predictable event to use, and nobody has bothered to implement any other
> random timing source to feed the function.

yep, entropy is gathered as the difference (delta value) between
different registered events.  so far, irqs are used.  i think the way
the block devices work is seperate, too. they dont work off irqs per se
(but if a block device has hardware behind it, its irqs can add entropy
on top of the block device functions).

> Something else might be used
> as a substitute, e.g., perhaps the temperature monitor on a cpu could be
> used to modify a moving snapshot of loopback traffic. I don't know if
> the raw data from cpu temperature monitoring is available with
> sufficient precision (without regard to the accuracy of the value) to
> count on it as a source of "environment noise" that in turn, during
> change, can be used to trigger the equivalent of random timing. Some of
> the hardware crypto devices seem to use diode noise (which can make a
> nice microwave generator as well), perhaps temperature monitoring could
> be used for a lower quality version; instead of simply passing the
> timing of rising and falling peaks/valleys (since it wouldn't be as
> rapid or random as a diode noise generator), one could use that timing
> in conjunction with a hash on a sliding window of loopback traffic bytes
> (or even to act as a coefficient, and not just a timing trigger).

CPU temp is not a bad idea.  the RNG built into the i810/i815/i820
chipsets is like your diode example -- a chip measures some sort of
flucuations over the PCI bus.  quantum physics says that is truly
unpredictable :)

> The general weakness with irq seems to be that (a) it isn't always
> occurring at a sufficient rate in systems without mouse/keyboard (and
> worse on diskless sytems), and (b) there is some very minor possibility
> that outside monitoring or influence can sway the pool or provide help
> to crackers (the tech to do this usefully doesn't seem to exist right
> now, but I wouldn't bet on it staying that way). Loopback is probably
> one of the largest sources of byte traffic, is not subject to irq
> monitoring, and does not fall down on the job for
> mouseless/keyboardless/headless/diskless stations. What it lacks is a
> truly random way of using the traffic; supposing something like
> temperature monitoring could be found as an alternate timing device (in
> place of irq), loopback could be used (or if any event that occurs in
> relation to loopback is random in the way that irq is, some other
> alternate timing event could be used). Does anyone happen to know
> exactly how much "noise" could be extracted from hardware temperature
> monitors (would it be practical)?

(a) is why we need more sources of entropy, like my network patch or
your loopback idea

(b) is debatable. i disagree it poses any true threat to the system.

i dont think temperature probes would have that much noise.  i suppose
if they were precise enough you could use the least significant bits,
but what really matters is how much of that precision is exported via
its interface. i suppose the lsb may be useful.

what i think we really need it to audit more drivers and, of those that
would be "entropic", have them contributed to the entropy pool.

> D. Stimits, stimits@idcomm.com

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

