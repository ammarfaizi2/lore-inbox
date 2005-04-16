Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVDPXnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVDPXnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDPXnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 19:43:07 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:18697 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261203AbVDPXm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 19:42:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 23:40:58 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3s7qa$j64$1@abraham.cs.berkeley.edu>
References: <20050416111033.28308.qmail@science.horizon.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113694858 19652 128.32.168.222 (16 Apr 2005 23:40:58 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 23:40:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux wrote:
>David Wagner wrote:
>>linux wrote:
>>> First, a reminder that the design goal of /dev/random proper is
>>> information-theoretic security.  That is, it should be secure against
>>> an attacker with infinite computational power.
>
>> I am skeptical.
>> I have never seen any convincing evidence for this claim, [..]
>
>I'm not sure which claim you're skeptical of.  The claim that it's
>a design goal, or the claim that it achieves it?

Oops!  Gosh, I was unclear, wasn't it?  Sorry about that.
I meant the latter claim.

I certainly agree that information-theoretic security is a stated goal
of /dev/random.  I'm just not certain that it achieves this goal.
(Caveat: I don't think that failing to achieve this goal is problematic.)

>Whether the goal is *achieved* is a different issue.  random.c tries
>pretty hard, but makes some concessions to practicality, relying on
>computational security as a backup.  (But suggestions as to how to get
>closer to the goal are still very much appreciated!)

Ok.

>In particular, it is theoretically possible for an attacker to exploit
>knowledge of the state of the pool and the input mixing transform to
>feed in data that permutes the pool state to cluster in SHA1 collisions
>(thereby reducing output entropy), or to use the SHA1 feedback to induce
>state collisions (therby reducing pool entropy).  But that seems to bring
>whole new meaning to the word "computationally infeasible", requiring
>first preimage solutions over probability distributions.

Well, wait a second.  You have to make up your mind about whether you
are claiming information-theoretic security, or claiming computational
security.  If the former, then this is absolutely an admissible attack.
There is nothing whatsoever wrong with this attack, from an
information-theoretic point of view.  On the other hand, if we are talking
about computational security, then I totally agree that this is a
(computationally) infeasible attack.

>Also, the entropy estimation may be flawed, and is pretty crude, just
>heavily derated for safety.  And given recent developments in keyboard
>skiffing, and wireless keyboard deployment, I'm starting to think that
>the idea (taken from PGP) of using the keyboard and mouse as an entropy
>source is one whose time is past.
>
>Given current processor clock rates and the widespread availability of
>high-resolution timers, interrupt synchronization jitter seems like
>a much more fruitful source.  I think there are many bits of entropy
>in the lsbits of the RDTSC time of interrupts, even from the periodic
>timer interrupt!  Even derating that to 0.1 bit per sample, that's still
>a veritable flood of seed material.

Makes sense.


As for your question about what one could do to achieve
information-theoretic security, there is a bunch of theoretical work
in the CS theory world on this subject (look up, e.g., "extractors").
Here is my summary about what is possible:

1) If you don't know anything about your source, and you don't
start with any entropy, then information-theoretically secure randomness
extraction is impossible -- at least in principle.  You pick any
deterministic algorithm for randomness extraction, and I will show you
a source for which that algorithm fails.

2) If you start with a short seed of uniformly distributed perfect
randomness, and you have a lower bound on the amount of entropy provided
by your source, then you can extract random bits in a way that is
provably information-theoretically secure.  Note that you don't have
to know anything about the distribution of the source, other than that
its (min-)entropy is not too small.  The simplest construction uses a
2-universal hash function keyed by the seed (its security is established
by the Leftover Hashing Lemma), but there are other constructions,
including a class of schemes known as "extractors".  This approach
does require a short seed of perfect true randomness for every chunk
of output you want to generate, though.

3) If you make certain assumptions about the source, you can extract
entropy in a way that is provably information-theoretically secure,
without needing the short seed.  However, the assumptions required are
typically fairly strong: e.g., that your source is completely memoryless;
that you have multiple sources that are totally independent (i.e.,
uncorrelated in any way); or that your source has a certain structure
(e.g., k of the n bits are uniformly random and independent, and the
other n-k bits are fixed in advance).  People are actively working to
push the boundaries in this category.

I'm not sure whether any of the above will be practically relevant.
They may be too theoretical for real-world use.  But if you're interested,
I could try to give you more information about any of these categories.
