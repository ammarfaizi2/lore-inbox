Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSHSFkC>; Mon, 19 Aug 2002 01:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSHSFkC>; Mon, 19 Aug 2002 01:40:02 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:7855 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S318162AbSHSFkA>;
	Mon, 19 Aug 2002 01:40:00 -0400
Date: Mon, 19 Aug 2002 01:43:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020819054359.GB26519@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020818021522.GA21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818021522.GA21643@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:15:22PM -0500, Oliver Xymoron wrote:
> 
> Non-Uniform Distribution Of Timing
> 
>  Unfortunately, our sample source is far from uniform. For starters, each
>  interrupt has a finite time associated with it - the interrupt latency.
>  Back to back interrupts will result in samples that are periodically
>  spaced by a fixed interval.

This is true.  But that's also why /dev/random measures not just the
first order delta, but the second and third order delta's as well, and
takes the minimum of the three delta's, capped by 12 bits, as the
entropy estimate.  So for example, if the interrupts are happening as
fast as possible (back to back) and there is merely the fixed interval
caused by the interrupt latency, then delta_1 will be the interrupt
latency, but delta_2 will be zero!  

The rest of your analysis also ignores the fact that the current
/dev/random code uses the second and third order delta's (think of
them as second and third order deritives, except that we're in the
discrete rather than continous domain).

>  Assuming the interrupt actually has a nice gamma-like distribution
>  (which is unlikely in practice), then this is indeed true. The
>  trouble is that Linux assumes that if a delta is 13 bits, it contains
>  12 bits of actual entropy. A moment of thought will reveal that
>  binary numbers of the form 1xxxx can contain at most 4 bits of
>  entropy - it's a tautology that all binary numbers start with 1 when
>  you take off the leading zeros. This is actually a degenerate case of
>  Benford's Law (http://mathworld.wolfram.com/BenfordsLaw.html), which
>  governs the distribution of leading digits in scale invariant
>  distributions.
> 
>  What we're concerned with is the entropy contained in digits
>  following the leading 1, which we can derive with a simple extension
>  of Benford's Law (and some Python):

I'm not a statistician, and my last probability class was over 15
years ago, but I don't buy your extension of Benford's law.  Sure, if
we take street addresses numbering from 1 to 10000, the probability
that the leading digit will be 1 will be roughly 30%.  But the
distribution of the low two digits will be quite evenly distributed.
Put another way, by picking a house at random, and looking at the low
two digits, and can very fairly choose a number between 0 and 99.  

> Interrupt Timing Independence
> -----------------------------
> 
>  Linux entropy estimate also wrongly assumes independence of different
>  interrupt sources. While SMP complicates the matter, this is
>  generally not the case. Low-priority interrupts must wait on high
>  priority ones and back to back interrupts on shared lines will
>  serialize themselves ABABABAB. Further system-wide CLI, cache flushes
>  and the like will skew -all- the timings and cause them to bunch up
>  in predictable fashion.
> 
>  Furthermore, all this is observable from userspace in the same way
>  that worst-case latency is measured. 
> 
>  To protect against back to back measurements and userspace
>  observation, we insist that at least one context switch has occurred
>  since we last sampled before we trust a sample.

First of all, the second order delta already protects against
back-to-back measurements.  

Secondly, what is observable from userpsace is time which is not spent
in a particular process.  But whether that time was spent in the
system or in another process is not at all obvious, and it's also not
obvious whether that time is spent handling interrupts or processing
bottom half tasks (i.e., processing network packets, et. al).
Moreover, it is not observable to the user process when multiple
interrupts might be happening in this whole mess.

That being said, global CLI's are a problem in that it does mean that
multiple interrupts could be serviced at the same time, and while the
outside adversary won't know exactly when a global CLI/STI might have
happened, it does reduce the quality of the randomness.  The solution
to this though is to avoid global CLI's, not to throw away randomness
samples until after a context switch.  

> Questionable Sources and Time Scales
> ------------------------------------
> 
>  Due to the vagarities of computer architecture, things like keyboard
>  and mouse interrupts occur on their respective scanning or serial
>  clock edges, and are clocked relatively slowly. Worse, devices like
>  USB keyboards, mice, and disks tend to share interrupts and probably
>  line up on USB clock boundaries. Even PCI interrupts have a
>  granularity on the order of 33MHz (or worse, depending on the
>  particular adapter), which when timed by a fast processor's 2GHz
>  clock, make the low six bits of timing measurement predictable.

We are not mixing in solely the low order bits of the timing
measurement; we're mixing in the entire timestamp.  So the fact that
the low-order bits of the timing measurement might be predictable
isn't necessarily a problem.  

We are looking at the low 12 bits of the first, second, and third
order deltas when estimating the entropy.  So predictibility in the
low six bits of the timing measurement will tend to drag the entropy
estiamte down, not up.

>  And as far as I can find, no one's tried to make a good model or
>  estimate of actual keyboard or mouse entropy. 

Since a human is involved, and we're measuring to a fairly high level
of accuracy, I'm not particularly worried.

>  Randomness caused by
>  disk drive platter turbulence has actually been measured and is on
>  the order of 100bits/minute and is well correlated on timescales of
>  seconds - we're likely way overestimating it. 

This has worried me.  The Davis paper was done a long time ago and I
suspect the turblence values has gone down over time, not up.  But
let's be clear what the problem is.  If the adversary knows the exact
stream of requests sent to a disk, it can probably model the time
necesasry to service those requests very accurately --- possibly
missing much less than the 100 bits/minute guestimated by the Davis
pater, given modern disk drives. 

So when we measure the disk drive completion interrupts, what we are
really measuring is the uncertainity to the attacker exactly *when*
those disk drive requests were made, and what order of disk drive
requests were sent to it.

Can the adversary control this, or know this?  Sometimes, to a certain
extent.  But remember, we're using a very high resolution timer, and
while the adversary might not the rough time to a few milliseconds
when a request might be issued, it would be much harder for the
adversary to know at what exact time stamp clock value was at a
particular event.

> Trusting Predictable or Measurable Sources
> ------------------------------------------
> 
>  What entropy can be measured from disk timings are very often leaked
>  by immediately relaying data to web, shell, or X clients.  Further,
>  patterns of drive head movement can be remotely controlled by clients
>  talking to file and web servers. Thus, while disk timing might be an
>  attractive source of entropy, it can't be used in a typical server
>  environment without great caution.

This is something to be concerned about, to be sure.  But generally a
client won't have complete control of the drive head movement ---
there are other clients involved --- and the adversary generally won't
have complete knowledge of the block allocation of files, for example,
so he/she would not be able to characterize the disk drive timings to
the degree of accuracy required.

Certianly a major concern that I've always had is measuring network
device interrupts, since packet arrial times can be measured by an
outsider.  Such an attack would require that the adversary have a
sophisticated device on the local LAN segment of the attack victim
(since the attacker needs to see all of the packets directed at the
victim in order to make guesses about the inter-packet arrival times,
however.  So the how practical this attack might be is certainly quite
debatable.

>  (Incidentally, tricks like Matt Blaze's truerand clock drift
>  technique probably don't work on most PCs these days as the
>  "realtime" clock source is often derived directly from the
>  bus/PCI/memory/CPU clock.)

Actually, many peripherals do have their own clock crystals and clock
circuitry (network cards, serial cards, IDE disks, etc.).....

> Batching
> --------
> 
>  Samples to be mixed are batched into a 256 element ring
>  buffer. Because this ring isn't allowed to wrap, it's dangerous to
>  store untrusted samples as they might flood out trusted ones.

It's not dangerous in the sense that we might suffer a security breach
(assuming that our entropy estimation routines are accurate).  It's a
bad thing in that we might lose some good randomness, but that's not a
disaster.

That being said, if we are running out space in the ring buffer, it
would be good to increase its size.

						- Ted
