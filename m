Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVDPPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVDPPqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVDPPqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 11:46:42 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:27587 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S262687AbVDPPqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 11:46:35 -0400
Date: Sat, 16 Apr 2005 11:46:25 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
Subject: Re: Fortuna
Message-ID: <20050416154625.GD17029@certainkey.com>
References: <20050415170450.GB23277@certainkey.com> <20050416100555.25344.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416100555.25344.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 10:05:55AM -0000, linux@horizon.com wrote:
> Anyway, back to the long-suffering jlcooke@certainkey.com:

;)

> >> something?  Because it makes zero difference, and reduces the code
> >> size and execution time.  Which is obviously a Good Thing.)
> 
> > It just bugged me when I was reading random.c for the first time.  First
> > impressions and all.

> Interesting.  Hopefully, further reflecton has shown you that the change
> has zero security implications.  (For the same reason, cryptanalysts
> studying DES ignore the initial permutation.)

Yes I saw that the first time, just struck me as "why?  why did I have to sit
here and add a that to the litany of things to remember when it's so easy to
just do it right?"

Guess I just see a different approach to software engineering, making it
easier to analyse makes it easier to improve.  You're 100% correct - security
wise it doesn't matter.

> 1) Fortuna is trying to sidestep the hard problem of entropy measurement,
>    to make it unnecessary.  This is a laudable goal, but /dev/random's
>    information-theoretic design goal precludes this simplification.
>    It *has* to measure entropy.  Are Fortuna's benefits sufficient to
>    motivate a public interface change like that?  If you can argue that
>    the current entropy measurement is such crap that it's not actually
>    delivering its promise anyway, that would be a good reason.
> 
>    But as long as you *have* entropy measurement, you don't *need*
>    Fortuna's elaborate scheme for avoiding it.  You only need *one*
>    sub-pool.

I agree with the statement:
 "If the current entropy estimation does not over estimate and crypto
  primitives don't fail to leak information, then we're OK"

What I've seen in my study of an older kernel (2.6.x) (the estimation scheme
hasn't changed afaik) is it's very conservative from what I understand of my
devices (keyboard,mouse not included, which is good.  But they don't contribute
as much randomness as disks and interrupts.)

> 2) Fortuna tries to support such a wide range of entropy source rates,
>    down to very low rates, that it sequesters some entropy for literally
>    years.  Ted thinks that's inexcusable, and I can't really disagree.
>    This can be fixed to a significant degree by tweaking the number
>    of subpools.

Well, I'd take hording entropy for 7 years over trusting a general entropy
accounting heuristic that is impossible to determine proper functioning.
Assuming again that the problems of malicious entropy event injection is
overcome.  Havn't come up with anything yet on how to do this nicely.

> 3) Fortuna's design doesn't actually *work*.  The authors' analysis
>    only works in the case that the entropy seeds are independent, but
>    forgot to state the assumption.  Some people reviewing the design
>    don't notice the omission.
...
>    Assuming that an attacker can see the first pool, they can find n.
>    After the second step, their uncertainty about the second pool is 1
>    bit, the value of b0.
...
>    Half a bit of entropy has leaked from the second pool back into the first!
...
>    *That* is my big problem with Fortuna.  If someone can finish the
>    analysis and actually bound the leakage, then we can construct something
>    that works.  But I've pushed the idea around for a while and not figured
>    it out.

I feel this goes back to the round-robin event input system.  Your argument
of n, n+b0, n+b0+b1, ... makes sense, in the state compromise / state
initialisation scenarios if the attacker can know for certain that they will
see 1 out of every 32 inputs.  If each of the pools has a 1:32 probability of
landing into any of the pools, then the things get a lot harder.

Does this make sense?  Ignoring the "where are you going to get a secure 1-in-32
RNG" issue.

If we look at this "slow-incremental entropy event input" situation with current
random.c, do we get a similar result?

Assuming an attacker can see the secondary-pool (/dev/random output) and
events {n, n+b0, b+b0+b1} enter primary-pool at times {t, t+t1, t+t1+t2}.
If the rate is slow enough, then an accurate entropy estimation will stop
anything from getting out, great.

"How does the entropy estimator measure entropy of the event?" becomes a
crucial concern here.  What if, by your leading example, there is 1/2 bit of
entropy in each event?  Will the estimator even account for 1/2 bits?  Or
will it see each event as 3 bits of entropy?  How much of a margin of error
can we tolerate?

/dev/random will output once it has at least 160 bits of entropy (iirc), 1/2
bit turning into 3 bits would mean that 160bits of output it effectively only
27 bits worth of true entropy (again, assuming the catastrophic reseeder and
output function don't waste entropy).

It's a lot of "ifs" for my taste.
waste any entropy

> > I'll take my patch and not bother you anymore.  I'm sure I've taken a
> > lot of your time as it is.
> 
> And you've spent a lot of time preparing that patch.  It's not a bad idea
> to revisit the ideas occasionally, but let's talk about the real *meat*
> of the issue.
> 
> If you think my analysis of Fortuna's issues above is flawed, please
> say so!  If you disagree about the importance of the issues, that's
> worth discussing too, although I can't promise that such a difference
> of opinions will ever be totally resolved.  But arguing about the
> relative importance  of good and bad points is meaningful.
> 
> Ideally, we manage to come up with a solution that has all the good points.
> 
> The only thing that's frustrating is discussing it with someone who doesn't
> even seem to *see* the issues.

Well, I'll do what I can then.  I understand your position and do my best to
explain in the thread in LKML.

> Actually, the GNU GPL doesn't.  It only requires that you give out the
> source if and when you give out the binary.  You can make as many
> private changes as you like.  (Search debian-legal for "desert island
> test".)

Humm, must be confused with another license then.  One that effects my
company required we submit back to the authors, so we just assumed that to be
the case for all of them and save the legal fees.

JLC
