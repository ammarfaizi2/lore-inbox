Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVDOBe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDOBe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVDOBe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:34:27 -0400
Received: from science.horizon.com ([192.35.100.1]:60463 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261711AbVDOBeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:34:18 -0400
Date: 15 Apr 2005 01:34:17 -0000
Message-ID: <20050415013417.3536.qmail@science.horizon.com>
From: linux@horizon.com
To: tytso@mit.edu
Subject: Re: Fortuna
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20050414133336.GA16977@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if someone accesses the seed file directly before the machine
> boots?  Well, either (a) they have broken root already, or (b) have
> direct access to the disk.  In either case, the attacker with such
> powers can just has easily trojan an executable or a kernel, and
> you've got far worse problems to worry about that the piddling worries
> of (cue Gilbert and Sullivan overly dramatic music, <Oh, horror!>) the
> dreaded state-extension attack.

So the only remaining case is where an attacker can read the random
seed file before boot but can't install any trojans.  Which seems
like an awfully small case.  (Although in some scenarios, passive
attacks are much easier to mount than active ones.)

> Actually, if you check the current random.c code, you'll see that it
> has catastrophic reseeding in its design already.

Yes, I know.  Fortuna's claim to fame is that it tries to achieve that
without explicitly measuring entropy.

> My big concern with Fortuna is that it really is the result of
> cryptographic masturbation.  It fundamentally assumes that crypto
> primitives are secure (when the recent break of MD4, MD5, and now SHA1
> should have been a warning that this is a Bad Idea (tm)), and makes
> assumptions that have no real world significance (assume the attacker
> has enough privileges that he might as well be superuser and can
> trojan your system to a fare-thee-well ---- now, if you can't recover
> from a state extension attack, your random number generator is fatally
> flawed.)

I'm not a big fan of Fortuna either, but the issues are separate.
I agree that trusting crypto prmitives that you don't have to is a bad
idea.  If my application depends on SHA1 being secure, then I might as
well go ahead and use SHA1 in my PRNG.  But a kernel service doesn't
know what applications are relying on.

(Speaking of which, perhaps it's time, in light of the breaking of MD5,
to revisit the cut-down MD4 routine used in the TCP ISN selection?
I haven't read the MD5 & SHA1 papers in enough detail to understand the
flaw, but perhaps some defenses could be erected?)

But still, all else being equal, an RNG resistant to a state extension
attack *is* preferable to one that's not.  And the catastrophic
reseeding support in /dev/random provides exactly that feature.

What Fortuna tries to do is sidestep the hard problem of entropy
measurement.  And that's very admirable.  It's a very hard thing to do in
general, and the current technique of heuristics plus a lot of derating
is merely adequate.

If a technique could be developed that didn't need an accurate entropy
measurement, then things would be much better.


> In addition, Frotuna is profligate with entropy, and wastes it in
> order to be able make certain claims of being able to recover from a
> state-extension attack.  Hopefully everyone agrees that entropy
> collected from the hardware is precious (especially if you don't have
> special-purpose a hardware RNG), and shouldn't be wasted.  Wasting
> collected entropy for no benefit, only to protect against a largely
> theoretical attack --- where if a bad guy has enough privileges to
> compromise your RNG state, there are far easier ways to compromise
> your entire system, not just the RNG --- is Just Stupid(tm).

Just to be clear, I don't remember it ever throwing entropy away, but
it hoards some for years, thereby making it effectively unavailable.
Any catastrophic reseeding solution has to hold back entropy for some
time.

And I think that, even in the absence of special-purpose RNG hardware,
synchronization jitter on modern GHz+ CPUs is a fruitful source of
entropy.
