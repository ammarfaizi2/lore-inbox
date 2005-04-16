Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVDPLLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVDPLLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVDPLLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:11:04 -0400
Received: from science.horizon.com ([192.35.100.1]:49219 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262148AbVDPLKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:10:34 -0400
Date: 16 Apr 2005 11:10:33 -0000
Message-ID: <20050416111033.28308.qmail@science.horizon.com>
From: linux@horizon.com
To: daw@taverner.cs.berkeley.edu, tytso@mit.edu
Subject: Re: Fortuna
Cc: jlcooke@certainkey.com, linux@horizon.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> First, a reminder that the design goal of /dev/random proper is
>> information-theoretic security.  That is, it should be secure against
>> an attacker with infinite computational power.

> I am skeptical.
> I have never seen any convincing evidence for this claim,
> and I suspect that there are cases in which /dev/random fails
> to achieve this standard.

I'm not sure which claim you're skeptical of.  The claim that it's
a design goal, or the claim that it achieves it?


I'm pretty sure that's been the *goal* since the beginning, and it says
so in the comments:
 * Even if it is possible to
 * analyze SHA in some clever way, as long as the amount of data
 * returned from the generator is less than the inherent entropy in
 * the pool, the output data is totally unpredictable. 

That's basically the information-theoretic definition, or at least
alluding to it.  "We're never going to give an attacker the unicity
distance needed to *start* breaking the crypto."

The whole division into two pools was because the original single-pool
design allowed (information-theoretically) deriving previous
/dev/random output from subsequent /dev/urandom output.  That's
discussed in section 5.3 of the paper you cited, and has been fixed.

There's probably more discussion of the subject in linux-kernel around
the time that change went in.


Whether the goal is *achieved* is a different issue.  random.c tries
pretty hard, but makes some concessions to practicality, relying on
computational security as a backup.  (But suggestions as to how to get
closer to the goal are still very much appreciated!)

In particular, it is theoretically possible for an attacker to exploit
knowledge of the state of the pool and the input mixing transform to
feed in data that permutes the pool state to cluster in SHA1 collisions
(thereby reducing output entropy), or to use the SHA1 feedback to induce
state collisions (therby reducing pool entropy).  But that seems to bring
whole new meaning to the word "computationally infeasible", requiring
first preimage solutions over probability distributions.

Also, the entropy estimation may be flawed, and is pretty crude, just
heavily derated for safety.  And given recent developments in keyboard
skiffing, and wireless keyboard deployment, I'm starting to think that
the idea (taken from PGP) of using the keyboard and mouse as an entropy
source is one whose time is past.

Given current processor clock rates and the widespread availability of
high-resolution timers, interrupt synchronization jitter seems like
a much more fruitful source.  I think there are many bits of entropy
in the lsbits of the RDTSC time of interrupts, even from the periodic
timer interrupt!  Even derating that to 0.1 bit per sample, that's still
a veritable flood of seed material.


/dev/random has an even more important design goal of being universally
available; it should never cost enough to make disabling it attractive.
If this conflicts with information-theoretic security, the latter will
be compromised.  But if a practical information-theoretic /dev/random is
(say) just too bulky for embedded systems, perhaps making a scaled-back
version available for such hosts (as a config option) could satisfy
both goals.

Ted, you wrote the thing in the first place; is my summary of the goals
correct?  Would you like comment patches to clarify any of this?


Thank you for pointing out the paper; Appendix A is particularly
interesting.  And the [BST03] reference looks *really* nice!  I haven't
finished it yet, but based on what I've read so far, I'd like to
*strongly* recommnd that any would-be /dev/random hackers read it
carefully.  It can be found at
http://www.wisdom.weizmann.ac.il/~tromer/papers/rng.pdf

Happily, it *appears* to confirm the value of the LFSR-based input
mixing function.  Although the suggested construction in section 4.1 is
different, and I haven't seen if the proof can be extended.
