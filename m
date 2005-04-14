Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVDNRdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDNRdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVDNRdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:33:52 -0400
Received: from thunk.org ([69.25.196.29]:15565 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261558AbVDNRds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:33:48 -0400
Date: Thu, 14 Apr 2005 09:33:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, jlcooke@certainkey.com, mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050414133336.GA16977@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, linux@horizon.com,
	linux-kernel@vger.kernel.org, jlcooke@certainkey.com,
	mpm@selenic.com
References: <20050414141538.3651.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414141538.3651.qmail@science.horizon.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 02:15:38PM -0000, linux@horizon.com wrote:
> I've heard a suggestion that something like /dev/urandom, but which blocks
> until it has received a minimum amount of seed material at least once,
> would be a nice thing.  So boot-time crypto initialization can stall
> until it has achieved a minimum level of security.

With a properly set up set of init scripts, /dev/random is initialized
with seed material for all but the initial boot (and even that problem
can be solved by having the distribution's install scripts set up
/var/lib/urandom/random-seed after installing the system).

If the init scripts aren't set up correctly, then you're screwed, yes,
but (a) all distributions that I know do the init scripts correctly,
and the right of doing this is documented in random.c, and (b) if user
space is screwed up in other ways, you can even worse off.

What if someone accesses the seed file directly before the machine
boots?  Well, either (a) they have broken root already, or (b) have
direct access to the disk.  In either case, the attacker with such
powers can just has easily trojan an executable or a kernel, and
you've got far worse problems to worry about that the piddling worries
of (cue Gilbert and Sullivan overly dramatic music, <Oh, horror!>) the
dreaded state-extension attack.

> It tries to divide up the seed entropy into sub-pools and hold off
> re-seeding the main pool until the sub-pool has accumulated enough entropy
> to cause "catastrophic reseeding" of the main pool, adding enough entropy
> at once that someone who had captured the prior state of the main pool
> would not be able (due to computational limits and the one-way nature
> of the pool output function) to reverse-engineer the post-state.

Actually, if you check the current random.c code, you'll see that it
has catastrophic reseeding in its design already.

> So Fortuna would be helped by some better understanding of what exactly
> makes it fail, so the discussion could move to whether real-world
> seed sources have those properties.
> 
> But until that understanding is gained, Fortuna is questionable.
>...
> Until this cloud is dissipated by further analysis, it's not possible to
> say "this is shiny and new and better; they's use it!" in good conscience.

My big concern with Fortuna is that it really is the result of
cryptographic masturbation.  It fundamentally assumes that crypto
primitives are secure (when the recent break of MD4, MD5, and now SHA1
should have been a warning that this is a Bad Idea (tm)), and makes
assumptions that have no real world significance (assume the attacker
has enough privileges that he might as well be superuser and can
trojan your system to a fare-thee-well ---- now, if you can't recover
from a state extension attack, your random number generator is fatally
flawed.)

In addition, Frotuna is profligate with entropy, and wastes it in
order to be able make certain claims of being able to recover from a
state-extension attack.  Hopefully everyone agrees that entropy
collected from the hardware is precious (especially if you don't have
special-purpose a hardware RNG), and shouldn't be wasted.  Wasting
collected entropy for no benefit, only to protect against a largely
theoretical attack --- where if a bad guy has enough privileges to
compromise your RNG state, there are far easier ways to compromise
your entire system, not just the RNG --- is Just Stupid(tm).

						- Ted
