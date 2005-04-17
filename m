Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVDQJWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVDQJWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 05:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDQJWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 05:22:08 -0400
Received: from science.horizon.com ([192.35.100.1]:43333 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261292AbVDQJVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 05:21:46 -0400
Date: 17 Apr 2005 09:21:45 -0000
Message-ID: <20050417092145.15673.qmail@science.horizon.com>
From: linux@horizon.com
To: daw@taverner.cs.berkeley.edu
Subject: Re: Fortuna
Cc: jlcooke@certainkey.com, linux@horizon.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've merged several e-mails here for compactness...

>> I'm not sure which claim you're skeptical of.  The claim that it's
>> a design goal, or the claim that it achieves it?
>
> Oops!  Gosh, I was unclear, wasn't it?  Sorry about that.
> I meant the latter claim.
>
> I certainly agree that information-theoretic security is a stated goal
> of /dev/random.  I'm just not certain that it achieves this goal.
> (Caveat: I don't think that failing to achieve this goal is problematic.)

Great, there's one point of contention disposed of.  As I said, a
*more* important goal is universal availability.  Theoretical perfection
can be sacrificed to achieve practicality.  In particular, we want
to limit code size, data size, and particularly execution time for
entropy gathering.  Execution time for entropy output is not a major
concern.

>> [Description of attack requiring truly preposterous amount of computaton.]

> Well, wait a second.  You have to make up your mind about whether you
> are claiming information-theoretic security, or claiming computational
> security.  If the former, then this is absolutely an admissible attack.
> There is nothing whatsoever wrong with this attack, from an
> information-theoretic point of view.  On the other hand, if we are talking
> about computational security, then I totally agree that this is a
> (computationally) infeasible attack.

I don't diasgree with anything you're saying, but I'd like to point out
a large grey area between information-theoretic and computation security,
which is "robustness in the face of failure of the crypto primitives".

Computational security would be plenty, and everyone would be happy to
scale back /dev/random's ambitions to that, if we could strictly bound
the amount of effort required for a break.  But until someone comes
up with an explicit hard function (and proves that P != NP), that's
not available.  So all computational security statements are based on
the somewhat unsatisfactory assumption that our cryptographic primtive
is a hard function when we don't actually have a proof that there are any.

And I'm really not up on quantum computing, but there's a whole 'nother
pile of risk that NP-hard might not be hard enough.

Given all that, there is a continual danger that any particular crypto
primitive will be broken.  The recent developments in hash functions
are an excellent example.

So /dev/random, where it relies on computational assumptions, wants to
be very robust in the face of compromise of the primitives.  Like the
example I gave: finding collisions in a hash function is one thing;
the attack I described makes finding a first preimage look easy.

No, it's not information-theoretic secure, but I'm not losing a lot
of sleep worrying about it, either.


But anyway, does that make sense?  The goal is "rely as little as possible
on the unproven hardness of cryptographic functions", which reaches
information-theoretic security in the limit.  So that's the *goal*, but
not reaching it isn't quite *failure*, either.

> As for your question about what one could do to achieve
> information-theoretic security, there is a bunch of theoretical work
> in the CS theory world on this subject (look up, e.g., "extractors").
> Here is my summary about what is possible:

Thank you very much.  I've been reading on the subject and learned this,
but it's nice to have it confirmed that I didn't miss anything.

> [Descrptions snipped for conciseness]

Given that we *do* have multiple mostly-independent sources,
perhaps the two-source construction could be adapted.  What would be
really nice is if it could be extended to n sources such that if any
pair were independent, it would be secure.

Oh, duh, that's trivial... run the two-source construction over every
pair of sources, and XOR all the outputs together.  Of course,
I still need to take care of that nasty word "mostly".

Even if that's horribly inefficient, it could be used to bootstrap a short
seed to start an efficient seed-using extractor.

> 3) If you make certain assumptions about the source, you can extract
> entropy in a way that is provably information-theoretically secure,
> without needing the short seed.  However, the assumptions required are
> typically fairly strong: e.g., that your source is completely memoryless;
> that you have multiple sources that are totally independent (i.e.,
> uncorrelated in any way); or that your source has a certain structure
> (e.g., k of the n bits are uniformly random and independent, and the
> other n-k bits are fixed in advance).  People are actively working to
> push the boundaries in this category.

[BST03] added a nice one to this: if your source can't adapt to
your seed, you can use a fixed seed.

Also, unless I'm misunderstanding the definition very badly, any "strong
extractor" can use a fixed secret seed.

> I'm not sure whether any of the above will be practically relevant.
> They may be too theoretical for real-world use.  But if you're interested,
> I could try to give you more information about any of these categories.

I'm doing some reading to see if something practical can be dug out of the
pile.  I'm also looking at "compressors", which are a lot like our random
pools; they reduce the size of an input while preserving its entropy,
just not necesarily to 100% density like an extractor.

This is attractive because our entropy measurement is known to be
heavily derated for safety.  An extractor, in producing an output that
is as large as our guaranteed entropy, will throw away any additional
entropy that might be remaining.

Th other thing that I absolutely need is some guarantee that things will
still mostly work if our entropy estimate is wrong.  If /dev/random
produces 128 bits of output that only have 120 bits of entropy in them,
then your encryption is still secure.  But these extractor constructions
are very simple and linear.  If everything falls apart if I overestimate
the source entropy by 1 bit, it's probably a bad idea.  Maybe it can be
salvaged with some cryptographic techniques as backup.

>> 3) Fortuna's design doesn't actually *work*.  The authors' analysis
>>    only works in the case that the entropy seeds are independent, but
>>    forgot to state the assumption.  Some people reviewing the design
>>    don't notice the omission.

> Ok, now I understand your objection.  Yup, this is a real objection.
> You are right to ask questions about whether this is a reasonable assumption.
>
> I don't know whether /dev/random makes the same assumption.  I suspect that
> its entropy estimator is making a similar assumption (not exactly the same
> one), but I don't know for sure.

Well, the entropy *accumulator* doesn't use any such assumption.
Fortuna uses the independence assumption when it divides up the seed
material round-robin among the various subpools.  The current /dev/random
doesn't do anything like that.  (Of course, non-independence affects
us by limiting us to the conditional entropy of any given piece of
seed material.)

> I also don't know whether this is a realistic assumption to make about
> the physical sources we currently feed into /dev/random.  That would require
> some analysis of the physics of those sources, and I don't have the skills
> it would take to do that kind of analysis.

And given the variety of platforms that Linux runs on, it gets insane.
Yes, it can be proved based on fluid flow computations that hard drive
rotation rates are chaotic and thus disk access timing is a usable
entropy source, but then someone installs a solid-state disk.

That's why I like clock jitter.  That just requires studying oscillators
and PLLs, which are universal across all platforms.

> Actually, this example scenario is not a problem.  I'll finish the
> analysis for you.

Er... thank you, but I already knew that; I omitted the completion
because it seemed obvious.  And yes, there are many other distributions
which are worse.

But your 200-round assumption is flawed; I'm assuming the Fortuna
schedule, which is that subpool i is dumped into the main pool (and
thus inforation-theoretically available at the output) every 2^i
rounds.  So the second pool is dumped in every 2 rounds, not every 200.
And with 1/3 the entropy rate, if the first pool is brute-forceable
(which is our basic assumption), then the second one certainly is.

Now, this simple construction doesn't extend to more pools, but it's
trying to point out the lack of a *disproof* of a source distribution
where higher-order pools get exponentially less entropy per seed
due to the exposure of lower-order pools.

Which would turn Fortuna into an elaborate exercise in bit-shuffling
for no security benefit at all.

This can all be dimly seen through the papers on extractors, where
low-k sources are really hard to work with; all the designs want you
to accumulate enough input to get a large k.

> If you want a better example of where the two-pool scheme completely
> falls apart, consider this: our source picks a random bit, uses this
> same bit the next two times it is queried, and then picks a new bit.
> Its sequence of outputs will look like (b0,b0,b1,b1,b2,b2,..,).  If
> we alternate pools, then the first pool sees the sequence b0,b1,b2,..
> and the second pool sees exactly the same sequence.  Consequently, an
> adversary who can observe the entire evolution of the first pool can
> deduce everything there is to know about the second pool.  This just
> illustrates that these multiple-pool solutions make some assumptions
> about the time-independence of their sources, or at least that the bits
> going into one pool don't have too much correlation with the bits going
> into the other pool.

Yes, exactly.  I had a more elaborate construction (based on a shift
register as long as the number of pools) that actually delivered one
fresh shiny bit of conditional entropy per source sample and yet still
totally broke Fortuna.

What I'd like to figure out is a way of expressing what the correlation
requirements *are* for Fortuna to be secure.  Then we could have a
meaningful discussion as to whether real-world sources meet those
conditions.


> Yeah, [BST03] seems worth reading.  It has a reasonable survey of some
> previous work, and is well-written.
>
> However, I'm pretty skeptical about [BST03] as a basis for a real-world
> randomness generator.  It assumes that there are only 2^t possible
> distributions for the source, and the set of possible distributions has
> been fixed in advance (before the design of your randomness generator
> is revealed).  Consequently, it fails to defend against adaptive attacks.

Yes, but as the authors claim, if you can use physics/hardware arguments
to *bound* the extent of the adaptability (which is what their parameter
t is all about), then you can used a fixed-parameter extractor.

Just for future reference, the usual extractor parameters are:
n = Input size (bits)
k = Input entropy (min-entropy measure, not Shanon!)
m = Output size (<= k)
eps (epsilon, really) = Statistical distance from perfect uniformity,
   a very small number that measures the quality of the output.
   Technically, it's 1/2 the sum, over all 2^m possible outputs x,
   of abs(probability(output = x) - 1/(2^m)).  The worst possible
   value, for a constant function, approaches 1 (actually 1 - 1/(2^m)).

> If the attacker can feed in maliciously chosen inputs (chosen after the
> attacker learns which randomness extraction algorithm you are using),
> then the BST03 scheme promises nothing.  For instance, if you feed in
> timings of network packets, then even if you don't count them as providing
> any entropy, the mere act of feeding them into your randomness generator
> causes their theorems to be clearly inapplicable (since no matter what
> value of t you pick, the adversary can arrange to get more than t bits
> of freedom in the network packets he sends you).

That wouldn't be a problem if we could extract the k bits of entropy
from the m-t uncontrolled degrees of freedom; just make m proportional
to the non-malicious source rate.

However, their proof only works for m =  k - 2*t - 4*log(1/eps) - 2.
Malicious bits count twice as bad as known bits, so a source that's more
than half malicious bits is useless.

It may turn out that trying to use this for information-theoretic security
requires throwing out bits we can't prove aren't malicious, which would
require giving up so many possibly good bits that we don't want to do it.

But the seeded extractors still look promising.  They don't care how
the n-k non-random input bits are chosen.

> One of the standard constructions of a 2-universal hash function is
> as a LFSR-like scheme, where the seed K is used to select the feedback
> polynomial.  But notice that it is critical that the feedback polynomial
> be chosen uniformly at random, in a way that is unpredictable to the
> attacker, and kept secret until you receive data from the source.

Ah, it *is* a 2-universal hash, good.  I was getting confused between
2-universal hash and epsilon-almost universal hash, and wasn't quite
sure if the definitions were compatible.

> What /dev/random does is quite different from the idea of 2-universal
> hashing developed in the theory literature and recounted in [BST03].
> /dev/random fixes a single feedback polynomial in advance, and publishes
> it for the world to see.  The theorems about 2-universal hashing promise
> nothing about use of a LFSR with a fixed feedback polynomial.

I know it doesn't, but what it *does* say mirrors what the /dev/random
soruce says... *if* the source is *not* adaptive to the polynomial,
*then* it's a good extractor.

The tolerance of malicious inputs is a separate argument based on the
reversibility of the LFSR input mix and the computational infeasibility
of creating collisions in the output mixing function.  This is the
the attack I pointed out a couple of messages ago, but it's such
a hard problem that I'm not worried about it.

Briefly, suppose an attacker has partial information about the state
of the input pool.  This can be expressed as a list of probabilities
for each of the 2^4096 possible states.  The attacker can feed whatever
data he likes into the input hash, and the effect will only be to
permute those states, which won't change the Shannon- or min-entropy
measures of the pool in any way.

The only thing the attacker can do is try to cluster those states in
places that cause hash collisions.  By feeding data to the input
mix, he can:
- Multiply the state of the pool by any desired power of x (mod the
  polynomial), and
- XOR the pool with any desired number.
If the attacker can use this freedom, combined with *partial* knowledge
of the pool, to cause excess collisions in the output mixing function,
he can (partially) control the RNG output.   (The fact that the attacker
is limited to 2^8192 of the (2^4096)! possible state permutations
definitely limits him somewhat.  As does the fact that he can't actually
multiply by *any* power of x, since the time taken is proportional to
the power, and not all 2^4096-1 possibilities can be reached before
the sun goes nova.)


But what I am figuring out is that *if* we can consider the input stream
to be a sort of bit-fixing source (some bits of the input are *not*
observable or controllable by the attacker), then the current LFSR is
a decent concentrator.  That seems like a pretty plausible assumption,
and applies no matter how large a fraction of the input is under enemy
control, as long as we account for the entropy properly.

In particular, this gets our input entropy k up to a reasonable fraction
of our input block size n, which makes the information-theoretic extractors
work better.  (The downside is that it's no longer a bit-fixing source.)

If we can then add an information-theoretic extractor as an output hash,
things are looking very promising.  First of all, this is not a performance-
critical step, so I have a lot of run-time to play with.  And second, the
first-stage concentrator has got k up to a reasonable fraction of the
input block size n, which helps all of the extractor constructions.

(Further, I can limit my extractor function to a fixed output size m,
chosen to be a suitable catastrophic-reseed value for subsequent stages.)

I'm sure the Leftover Hash Lemma applies here, and I've found a couple of
statements of it, but I don't *quite* understand it yet.  That is, I
understand one statement ("If H is a universal hash family from n bits
to l bits, where l = k - 2 * log(1/eps), then Ext(x,h) = (h, h(x)) is
a (k,eps)-extractor."), but I don't see how it's the same as the
other, which indicates that my understanding is incomplete.  But I'm
still working on it.


Anyway, thanks a lot for all the pointers!
