Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUIXClS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUIXClS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUIXCkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:40:25 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:19381 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S266835AbUIXCeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:34:37 -0400
Date: Thu, 23 Sep 2004 22:34:13 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz, jmorris@redhat.com,
       tytso@mit.edu
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924023413.GH28317@certainkey.com>
References: <20040924005938.19732.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924005938.19732.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux",

The Fortuna patch I've submitted tried to achieve this "more than 256 bits per
pool" by carrying forward the digest output to the next pool.  Stock Fortuna
does not carry forward digest output form previous iterations.

reseed:
  reseedCount++;
  for (i=0..31) {
    if (2^i is a factor of reseedCount) {
      hash_final(pool[i], dgst);
      hash_init(pool[i]);
      hash_update(pool[i], dgst); // my addition
      ...
    }
  }
  ...

Considering each pool has 256 bits of digest output, and there are 32 pools,
this gives about 8192 bits for the pool size.  Far greater then current
design.  If you extremely pessimistically consider the probability of drawing
pool j is 1/2 that of {j-1}, then it's a 512bit RNG.


But I'd like talk to your attack for a second.  I'd argue that it is valid
for the current /dev/random and Yarrow with entropy estimators as well.

I agree that if the state is known by an active attacker, then a trickle of
entropy into Fortuna compared to the output gathered by an attacker would
make for an argument that "Fortuna doesn't have it right."  And no matter
what PRNG engine you but between the attack and the random sources, there is
no solution other than accurate entropy measurement (*not* estimation).

However, this places the security of the system in the hands of the entropy
estimator.  If it is too liberal, we have the nearly the same situation with
Fortuna.  As much as I rely on Ted's work everyday for the smooth running of
my machine, I can't concede to the notion that Ted got it right.

Fortuna, I'd argue reduces the attack on the PRNG to that of the base
crypto primitives, the randomness of the events and the rate at which data is
output by /dev/random.  This holds true for the current /dev/random except:
 1) crypto primitives are do not pass test vectors, and the input mixing
    function is linear.
 2) The randomness of the events can only be estimated, their true randomness
    requires analysis of the hardware device itself... not Feasible
    considering all the possible IRQ sources, mice, and hard disks that Linux
    drives.
 3) Following on (2) above, the output rate of /dev/random is directly
    related to the estimated randomness.

If you have ideas on how to make a PRNG that can more closely tie output rate
to input events and survive state compromise attacks (backtracking, forward
secrecy, etc) then please drop anonymity and contact me at my email address.
Perhaps a collaboration is possible.

Cheers,

JLC


On Fri, Sep 24, 2004 at 12:59:38AM -0000, linux@horizon.com wrote:
> Fortuna is an attempt to avoid the need for entropy estimation.
> It doesn't do a perfect job.  And I don't think it's received enough
> review to be "regarded as the state of the art".
> 
> Entropy estimation is very difficult, but not doing it leads to problems.
> 
> Bruce Schneier's "catastrophic reseeding" ideas have some merit.  If,
> for some reason, the state of your RNG pool has been captured, then
> adding one bit of seed material doesn't hurt an attacker who can look
> at the output and brute-force that bit.
> 
> Thus, once you've lost security, you never regain it.  If you save up,
> say, 128 bits of seed material and add it all at once, your attacker
> can't brute-force it.
> 
> /dev/random tries to solve this my never letting anyone see more output
> than there is seed material input.  So regardless of the initial state
> of the pool, an attacker can never get enough output to compute a unique
> solution to the seed material question.  (See "unicity distance".)
> 
> However, this requires knowing the entropy content of the input, which is
> a hard thing to measure.
> 
> The while issue of catastrophic reseeding applies to output-larger-than-key
> generators like  something like /dev/urandom (that uses cryptographic
> 
> 
> Here's an example of how Fortuna's design fails.
> 
> Suppose we have a source which produces 32-bit samples, which are
> guaranteed to contain 1 bit of new entropy per sample.  We should be
> able to feed that into Fortuna and have a good RNG, right?  Wrong.
> 
> Suppose that each time you sample the source, it adds one bit to a 32-bit
> shift register, and gives you the result.  So sample[0] shares 31 bits
> with sample[1], 30 bits with sample[2], etc.
> 
> Now, suppose that we add samples to 32 buckets in round-robin order,
> and dump bucket[i] into the pool every round 2^i rounds.  Further,
> assume that our attacker can query the pool's output and brute-force 32
> bits of seed material.  In the following, "+=" is some cryptographic
> mixing primitive, not literal addition.
> 
> Pool: Initial state known to attacker (e.g. empty)
> Buckets: Initial state known to attacker (e.g. empty)
> bucket[0] += sample[0]; pool += bucket[0]
> 	-> attacker can query the pool and brute-force compute sample[0].
> bucket[1] += sample[1] (= sample[0] << 1 | sample[32] >> 31)
> bucket[2] += sample[2] (= sample[0] << 2 | sample[32] >> 30)
> ...
> bucket[31] += sample[31] (= sample[0] << 31 | sample[32] >> 1)
> bucket[0] += sample[32]; pool += bucket[0]
> 	-> attacker can query the pool and brute-force compute sample[32].
> 	-> Attacker now knows sample[1] through sample[31]
> 	-> Attacker now knows bucket[1] through bucket[31.
> 
> Note that the attacker now knows the value of sample[1] through sample[31] and
> thus the state of all the buckets, and can continue tracking the pool's
> state indefinitely:
> 
> bucket[1] += sample[33]; pool += bucket[1]
> 	-> attacker can query the pool and brute-force compute sample[33].
> etc.
> 
> This shift register behaviour should be obvious, but suppose that sample[i]
> is put through an encryption (known to the attacker) before being presented.
> You can't tell that you're being fed cooked data, but the attack works just the
> same.
> 
> 
> Now, this is, admittedly, a highly contrived example, but it shows that
> Fortuna does not completely achieve its stated design goal of achieving
> catastrophic reseeding after having received some contant times the
> necessary entropy as seed material.  Its round-robin structure makes it
> vulnerable to serial correlations in the input seed material.  If they're
> bad enough, its security can be completely destroyed.  What *are* the
> requirements for it to be secure?  I don't know.
> 
> All I know is that it hasn't been analyzed well enough to be a panacea.
> 
> (The other thing I don't care for is the limited size of the
> entropy pools.  I like the "big pool" approach.  Yes, 256 bits is
> enough if everything works okay, but why take chances?  But that's a
> philosophical/style/gut feel argument more than a really technical one.)
> 
> 
> I confess I haven't dug into the /dev/{,u}random code lately.  The various
> problems with low-latency random numbers needed by the IP stack suggest
> that perhaps a faster PRNG would be useful in-kernel.  If so, there may
> be a justification for an in-kernel PRNG fast enough to use for disk
> overwriting or the like.  (As people persist in using /dev/urandom for,
> even though it's explicitly not designed for that.)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
