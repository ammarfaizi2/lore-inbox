Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275318AbTHMSiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275316AbTHMSiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:38:01 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:18048 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275340AbTHMSg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:36:58 -0400
Date: Wed, 13 Aug 2003 19:36:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Matt Mackall <mpm@selenic.com>,
       James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030813183628.GC4405@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030813035257.GB1244@think>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813035257.GB1244@think>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 1) By the time you go through  all of the init scripts, there has been
> quite a  lot of randomness  mixed into the  pool, from the  hard drive
> interrupts if nothing  else.  So it would be  fairly difficult for the
> attacker to get any kind of recognized patterns.

This is not true when booting from ramdisk or ROM.  On some systems,
everything, the initial CPU clock counter, relative timings, and
everything else is deterministic - all locked to the same master clock.

On those systems, the random state has zero entropy until the first
network packet arrives or the pool can be seeded from saved (and well
hidden) state.

> 2) There's a reason why random.c recommends that the init scripts do
> the follwoing at bootup:

>       [save & restore over boot]
> This is subtle.  It's important that random data be saved across a
> reboot, precisely to avoid the backtracking attack.

Agreed.  This is very, very important.

Unfortunately it isn't airtight if the attacker can see the file in
flight to your NFS-mounted diskless box, although booting over NFS
would tend to introduce enough entropy by itself so we are fine here :)

Everything important I have to say is below, and assumes one of:

    1. some kind of weakness in saving/restoring/overwriting the seed.
    2. other flaws which make the pool state non-random in a predictable way.
    3. SHA revealing more than zero bits of useful entropy per hash.

If you don't believe in those scenarios, press "d" in your mailer now :)

> > When you output less of the hash, this reduces the information
> > available to predict the state of the pool.  However, SHA1 is large
> > enough that even half of the hash is a strong predictor, so returning
> > half of the hash still has this weakness.
> > 
> > (Ironically, a much weaker hash would prevent this mode of data leakage).
> 
> Nope, because of a very simple information theoretic argument.  At
> best, each hash can only reveal 80 bits of information, even if the
> hash was totally weak.

This is not true of a strong hash.  If there is insufficient entropy
in the input, a strong hash reveals _more_ bits of input than it
outputs.

In general, if the input has d bits of entropy, where d << strong hash
output size, then a dictionary attack of size 2^d will determine the
whole input with virtual certainty, regardless of the input size.

> The secondary pool is 128 bytes, or 1024 bits.
> A truely stupid/weak hash could at most leak 80 bits of information
> from the pool.  A stronger hash will leak less information, which is a
> good thing, not at a bad thing.

Incorrect, _except_ when you are certain the pool has enough entropy.

> This by the way is why we need to do catastrophic reseeding; if we
> wanted to be truely paranoid, if we reseeded every 1024 bits of
> output, there we would be guaranteed that there was no possible way
> (using an information theoretic argument) that any information from
> the secondary pool could be known.  In fact, we reseed every 1024
> bytes of input, which means we do rely on SHA being at least halfway
> decent.

This is true provided the primary pool always has enough entropy to
keep the secondary pool filled with enough entropy, from the attackers
point of view, to prevent a dictionary matching attach.

It makes your point about retaining the entropy across reboots even
more important.  When there is enough entropy, the dictionary attack
doesn't work - assuming the hash is not invertible, which we do assume.

Note that when I say "entropy from the attacker's point of view", I
don't mean entropy as estimated in random.c.  By assuming SHA1 is
strong enough, when there is adequate entropy in the pool to prevent
dictionary attacks, "entropy from the attacker's point of view" does
not decrease when the pool is read - unlike random.c's estimated
value, which has a different meaning: "entropy assuming SHA1 is
breakable".

It should be noted that, from an information theoretic point of view,
if the strong hash leaks _any_ information about the pool state, this
reduces the pool entropy from the point of view of the attacker, and,
if successive hashes leak different information, may gradually open
up the pool to a dictionary attack regardless of state at boot time.

Practically, we are relying on the hash leaking _zero_ useful
information about the pool state which the attacker can accumulate to
produce a dictionary of possible pool states.  That's just another way
of saying what you said: we rely on SHA being decent.

> > I have just convinced myself of a flaw in the existing random.c -
> > which still holds in your patched version.  Folding the result of the
> > strong hash is useless.  Instead, the _input_ to the strong hash
> > should be folded, so that a single hash result (whether folded or not)
> > doesn't reveal the pool state even when it is recognised.
> 
> No, whether you fold the input or the output, you're still creating a
> new, slightly different hash.  Think about it.  If F(x) is the fold
> operation, and H(x) is the hash operation, then
> 
> 	H'(x) = F(H(x))
> 	H''(x) = H(F(x))
> 
> The reason why folding the output is better is that we're only leaking
> 80 bits at a time, as opposed to 160 bits at a time.  

I disagree for the simple reason that a strong hash can reveal more
bits of input, than it outputs, when there is insufficient entropy in
the input from the point of view of the attacker.

Outputting 80 bits instead of 160 bits makes very little difference,
if the pool has only 32 bits of entropy from the point of view of the attacker.

If the attacker knows the pool state is among a set of 2^32 states
which he knows or has calculated, either hash gives adequate
information to reconstruct the pool state.  If the attacker is merely
testing to see whether the pool state is one of that set of 2^32, 160
bits of hash gives the attacker ~(1-2^-128) probability of determining
the pool state, whereas 80 bits gives the attacker ~(1-2^-48)
probability of determining it.

The point about folding the input, or only using part of the input, is
so that this kind of attack cannot determine the whole input from a
single hash output.  However, the argument isn't that convincing,
because if there's a reason why the pool is in a predictable state,
it's quite likely that the _whole_ pool is in a state which is
predictable given part of the pool.

The only exception I see to that (and I don't claim to see all the
exceptions) is when the input mixer has changed some of the words
which aren't yet being used as input to the hash, but will be on
subsequent hashings.  Then if the attacker develops perfect knowledge
of the input to one hash output, he would still not be able to predict
subsequent outputs.

Of course, all this talk of hashing over a limited part of the pool is
something you do already by having two pools, and hash only over the
bits in the secondary pool.

The subtlety, then, is knowing when to move information from the
primary pool to thwart a dictionary attack on a partially known pool state.

My conclusions
==============

  - The only effect of Matt's change to limit the number of input bits
    to the hash, is to increase the number of hash results that an
    attacker needs, at times when a dictionary attack is feasible,
    before a dictionary hit can predict future and past hash results
    reliably, over whatever time period occurs between catastrophic
    reseedings.  There will be times when a single hash result is
    enough to predict those results anyway - Matt's change doesn't
    protect against all weak pool states.  Note that this mode of
    attack does not require a weakness of the hash; it relies on the
    pool state being predictable due to inadequate seeding _or_
    weakness of the hash.

  - Folding the hash output bits has no useful effect.  It reduces the
    number of bits an attacker needs to read a whole hash result in
    order to run a dictionary attack against a weak pool state, but
    the attacker doesn't need the whole hash result to do that anyway.

  - Folding the hash output bits does not protect against you-know-who
    from inverting the hash, because it simply changes the hash
    function with no justification for calling this a stronger one.

    Anyone inverting SHA1 in order to predict random.c's past or
    future outputs would need to extend the analysis into the
    backtrack-protection feedback anyway, so such an attack would need
    to be specialised for random.c, whether hash output folding is
    present or not.

Final conclusion :)
===================

  - Hashing over fewer input bits is of dubious benefit.  But the
    output folding may as well go because it isn't useful at all.

My 2p,
:)
-- Jamie
