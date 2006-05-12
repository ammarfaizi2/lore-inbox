Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWELLPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWELLPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWELLPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:15:11 -0400
Received: from science.horizon.com ([192.35.100.1]:14899 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751222AbWELLPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:15:09 -0400
Date: 12 May 2006 07:15:08 -0400
Message-ID: <20060512111508.24971.qmail@science.horizon.com>
From: linux@horizon.com
To: ak@suse.de, chrisw@sous-sol.org, ian.pratt@xensource.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, rdreier@cisco.com, shemminger@osdl.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [Keir.Fraser@cl.cam.ac.uk: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.]
Cc: herbert@gondor.apana.org.au
In-Reply-To: <20060512044654.26724.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This subthread in the Xen patch thread has now digressed onto discussions
> about entropy and security.  Perhaps you guys could add some points.

Well, I can try.  I don't think this answers any questions, but
perhaps it informs the discussion.  Apologies if the Cc: list is
getting a bit bloated.

> On 11 May 2006, at 01:33, Herbert Xu wrote:
>>> But if sampling virtual events for randomness is really unsafe (is it
>>> really?) then native guests in Xen would also get bad random numbers
>>> and this would need to be somehow addressed.
>>
>> Good point.  I wonder what VMWare does in this situation.
> 
> Well, there's not much they can do except maybe jitter interrupt 
> delivery. I doubt they do that though.

There are two aspects which are often confused.  It doesn't sound
like people are confused here, but I'll say it explicitly just to
make sure:

One is the concern that by feeding malicious data into the /dev/random
pool, you can control its output.  This can't happen; the input mixing
is safe against that, which is why /dev/random is globally writeable.
Whatever data you feed into the pool, you can't increase your level of
knowledge about the state of it.  So there is no need whatsoever to stop
potentially bad data from being fed into the pool.  The worst it can do
is nothing.

The second, which CAN happen, is an entropy estimation failure.
The /dev/random system tries to guess by how much a given piece of input
DECREASES an attacker's knowledge about the state of the pool.  If it
guesses wrong, it can produce output (which gives away information)
beyond the limits of the unicity distance and then an attacker with
unbounded computational power can figure out the state of the pool and
thereby predict future output.

Underestimating the entropy is always safe, so adding suspect data is
fine as long as you give it a zero entropy score.  But you need to find
some entropy somewhere or you'll never make any progress.  That's where
it gets tricky.  It's not what seed material you use (use it all), but
what seed material do you TRUST?

Also, for this second kind of problem, an attacker only has to KNOW what
the data being introduced into the pool is (or, to be even more specific,
know more about it than the entropy estimate thinks is possible),
not control it in any way.  Thus, there is no possible test of the
input data itself which can prove an attacker's ignorance of it; some
assumptions about its origin must be made.

/dev/random's main entropy source is interrupt timing, based on the
assumption that the real-world I/O devices are driven by sources at least
partly uncorrelated with the processor clock.  But if the interrupts
are virtualized and come from hypervisor software, how unknown to an
attacker are they?

> The original complaint in our case was that we take entropy from 
> interrupts caused by other local VMs, as well as external sources. 
> There was a feeling that the former was more predictable and could form 
> the basis of an attack. I have to say I'm unconvinced: I don't really 
> see that it's significantly easier to inject precisely-timed interrupts 
> into a local VM. Certainly not to better than +/- a few microseconds. 
> As long as you add cycle-counter info to the entropy pool, the least 
> significant bits of that will always be noise.

It's not a matter if injecting *controlled* interrupts, just *known*
interrupts.  If the duration of cross-VM interrupt delivery is
predictable, an attacker reading the timestamp counter before sending
a packet could predict the timestamp on arrival and figure out what's
going into the pool.  If that's the main source of entropy going in to
the target domain and the attacker has a way to read the vast majority
of the output of /dev/random there, an attacker has a chance to guess
the fraction of /dev/random output they don't see.

> The alternatives are unattractive:
>   1. We have no good way to distinguish interrupts caused by packets 
> from local VMs versus packets from remote hosts. Both get muxed on the 
> same virtual interface.

Doesn't the source MAC address offer a clue?

>   2. An entropy front/back is tricky -- how do we decide how much 
> entropy to pull from domain0? How much should domain0 be prepared to 
> give other domains? How easy is it to DoS domain0 by draining its 
> entropy pool? Yuk.

THAT, at least, is not terribly hard.  It's exactly the same sort
of fair CPU scheduling problem as has been solved many times before.
As entropy comes in, credit it round-robin to various child domains.
There's a pool in domain0 which can buffer a certain about of credit
for child domains even if they don't want it yet.  When that buffered
credit reaches the limit that domain0 can store, it spills over and is
allocated to other domains with non-full accounts.

So after an initial accumulation period to fill up the buffers, the
available entropy is divided evenly among all the domains that want it.

I don't know how Xen works at all, whether it's easier to buffer the
entropy in domain0 until requested or immediately push it to the
subdomains, but either way, it's doable.


So I guess, before doing any fancy design, it's worth asking: do people
prefer to have entropy be a service that the Xen hypervisor delivers to
client domains, or should the domains manage it themselves?
They may not both be practicable, but which do you people to explore
first?


A few more issues which have arisen since /dev/random was first written:

- Modern processors change clock rate, causing a real-world jitter
  number to translate into a variable number of timestamp ticks.  +/-10 ns
  may be +/-32 timestamp ticks, or less if the clock is running slower.

  The most recent processors run their timestamp counters at a fixed
  rate, regardless of clock divisor, by incrementing it by more than
  one per cycle at times.  But either way, you still have to reduce
  the entropy estimate when reducing clock speed.

- Wireless keyboards and mice are a lot less unobservable than wired ones.

- On the upside, full-speed timestamp counters are widely available, as
  are > 1 GHz clock rates, making for a rich source of clock jitter.


Oh, and on the theoretical front, there's been a lot of research
into so-called "randomness extraction functions".  In particular,
it's been shown that Shannon entropy (the sum, over the various random
possibilities i = 1, 2, ... n of -p[i] * log(p[i])) is not possible to
base a secure extractor on; you need your sources to have good min-entropy
min -log(p[i]).  In my previous post to linux-kernel, I completely forgot
about this... arrgh, have to post a retraction.

Anyway, min-entropy, being simply the negative log of the highest
probability, is always less than or equal to the Shannon entropy.
It's equal for uniform distributions (all choices equally likely),
but more conservative for lopsided distributions.

Here's the classic teaching example: say you have a source, which produces
31 truly random bits (0..0x7fffffff) half the time, but produces -1
(0xffffffff) the other half of the time.  (If this seems too trivial,
assume it is encrypted with a one-time pad known only to the attacker;
that doesn't change the analysis.)

It is simple to compute the Shannon entropy of this source: 16.5 bits
per sample.  p[-1] = 1/2, while p[0..0x7fffffff] = 2^-32, and plug all
that into the Shannon entropy formula.

Now, if I take 8 samples from this source (total entropy 132 bits) and mix
them up together (say, with MD5), I should get a good 128-bit key, right?
But 1/256 of the time, the MD5 input is simply zero and the attacker
knows my key in one guess.  An additional 1/32 of the time, only one of
the 8 samples was random and there's only 34 bits of entropy in my key.
(31 for the sample value plus 3 for the sample number.)

The reason for this paradox is that, half of the time, my input contains
more than 128 bits of entropy, and compressing it with MD5 is throwing
the excess away.  The naive Shannon entropy computation is averaging
that excess entropy with the low-entropy cases, which is not valid if
you are producing finite-length output.

The min-entropy measure of 1 bit per sample correctly predicts the
8-bit min-entropy of the output.
