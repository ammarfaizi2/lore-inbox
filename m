Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWEFQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWEFQxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWEFQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:53:20 -0400
Received: from waste.org ([64.81.244.121]:58030 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750720AbWEFQxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:53:20 -0400
Date: Sat, 6 May 2006 11:48:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: Theodore Tso <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060506164808.GY15445@waste.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506115502.GB18880@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 07:55:02AM -0400, Theodore Tso wrote:
> On Fri, May 05, 2006 at 03:34:37PM -0500, Matt Mackall wrote:
> > Nonetheless, the current SA_SAMPLE_RANDOM scheme should go. A) it's in
> > the IRQ fast path B) most of its users are bogus which strongly
> > indicates it's a bad API.
> > 
> > Instead (if we want network entropy) we should add an
> > add_network_randomness call in some central location in the network
> > stack (probably right next to netpoll's RX hooks) and probably have it
> > compiled out by default.
> 
> I disagree.  It really wants to be a run-time controllable thing, and
> probably on a per-interface/per-device driver basis, since it should
> be up to the system administrator who is deploying the box, not the
> developer or distribution compiling the kernel, to make that
> determination.

Ok, I can agree with that. The interface would have to be extended to
pass more than just IRQ number to do anything vaguely intelligent in
random.c.

> Also, the entropy sampling *really* wants to be done in the hard IRQ
> handling path, not some place higher in the stack since the scheduler
> would smooth out the unpredictable timing information.  Moving it into
> the interrupt routines is in fact a problem for CONFIG_PREEMPT_RT,
> since the device driver's interrupt handlers become a schedulable
> entity, since the IRQ handling is moved into a separate kernel thread.

Yes, PREEMPT_RT definitely does break my proposal. Sigh.

> So I would much prefer to see the entropy sampling stay in its current
> location, since people using real-time deserve real randomness too.
> (In fact, some of them may have a **much** stronger need for it.  :-)

This is the point that bothers me. It's one thing to optimistically
mix network samples (or any other convenient source) into the entropy
pool. I'm all for that. The more, the better.

But let's take a step back from network devices and look at entropy
accounting in the abstract for a moment. The whole point of
/dev/random vs /dev/urandom is: entropy(output) < entropy(input) so
that even if the hash function is broken, we can't guess the internal
pool state and we still have some security. Consider these cases:

Case 1:
Hash function not broken: /dev/random and /dev/urandom are equally
secure, but /dev/random blocks at inconvenient moments. One should
thus really use /dev/urandom for everything unless one suspects that
an attacker is able to observe and record enough /dev/urandom output
that they'll be able to make use of it should the following happen
(aka forward security):

Case 2:
Hash function broken, entropy accounting is conservative: /dev/urandom
is breakable when entropy runs low because it's revealing more
internal entropy than it's collecting and an attacker can eventually
collect enough information to guess the internal state. Fortunately
/dev/random stays secure but blocks.

Case 3:
Hash function broken, entropy accounting is over-optimistic:
/dev/urandom and /dev/random are both equally insecure because both
are revealing more internal entropy than they're collecting. So you
should just use /dev/urandom because at least it doesn't block.

Putting aside all the practical issue of what exactly is entropy and
what decent entropy sources are, we should be able to agree on this
much. And this basically says that if you do your entropy accounting
badly, you throw the baby out with the bathwater.

Now I'll throw out a proposed definition of entropy for our purposes:
the amount of information in a sample that's both unpredictable and
unobservable. If something is partially observable or predictable, we
must take the minimum of the two.

Our current entropy estimator assumes its sources are unobservable and
are at least largely unpredictable. This is arguably not the case, but
that's a separate discussion. Let's assume for the sake of argument
that our entropy estimator gets it right.

But network traffic should be _assumed_ to be observable to some
degree. Everything else in network security makes the assumption that
traffic is completely snoopable. By contrast, we assume people can't
see us type our passwords[1]. So while our entropy estimator assumes
observability == 0, for the network case, 0 < observability <= 1. And
if it's greater than what our entropy estimator assumes, our entropy
estimates are now too optimistic and /dev/random security degrades to
that of /dev/urandom.

Yes, this is all strictly theoretical. But the usefulness of
/dev/random is exactly as theoretical. So if you use /dev/random for
it's theoretical advantages (and why else would you?), this defeats
that.

On the other hand, another approach to this is probably to just be
much more paranoid about our entropy estimates and take a factor of 10
or so off of all of them (and do our accounting in fixed point).
Thoughts?

[1] though hearing someone type a password is actually enough
-- 
Mathematics is the supreme nostalgia of our time.
