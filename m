Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEFLzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEFLzN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWEFLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:55:13 -0400
Received: from THUNK.ORG ([69.25.196.29]:17357 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750790AbWEFLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:55:11 -0400
Date: Sat, 6 May 2006 07:55:02 -0400
From: Theodore Tso <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060506115502.GB18880@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	davem@davemloft.net
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505203436.GW15445@waste.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 03:34:37PM -0500, Matt Mackall wrote:
> Nonetheless, the current SA_SAMPLE_RANDOM scheme should go. A) it's in
> the IRQ fast path B) most of its users are bogus which strongly
> indicates it's a bad API.
> 
> Instead (if we want network entropy) we should add an
> add_network_randomness call in some central location in the network
> stack (probably right next to netpoll's RX hooks) and probably have it
> compiled out by default.

I disagree.  It really wants to be a run-time controllable thing, and
probably on a per-interface/per-device driver basis, since it should
be up to the system administrator who is deploying the box, not the
developer or distribution compiling the kernel, to make that
determination.

Also, the entropy sampling *really* wants to be done in the hard IRQ
handling path, not some place higher in the stack since the scheduler
would smooth out the unpredictable timing information.  Moving it into
the interrupt routines is in fact a problem for CONFIG_PREEMPT_RT,
since the device driver's interrupt handlers become a schedulable
entity, since the IRQ handling is moved into a separate kernel thread.
So I would much prefer to see the entropy sampling stay in its current
location, since people using real-time deserve real randomness too.
(In fact, some of them may have a **much** stronger need for it.  :-)

As far as your reasons that you've given, (A) I find it hard to
believe a single conditional jump is really going to be measurable,
and (B) sure, fix the bad users, but the downside of screwing up
SA_SAMPLE_RANDOM is fairly limited; it only messes up the entropy
estimator, and in practice most users are using /dev/urandom anyway.
The random driver's algorithms are designed so that /dev/random can be
world writable, and an attacker can write arbitrary data, include all
zero's, without degrading the entropy in the pool.(*) Hence, while a
bad user of SA_SAMPLE_RANDOM should be fixed, it is hardly a
catastrophic failure.

						- Ted

(*)So if User A writes data which he knows into /dev/random, it
doesn't help User A guess what /dev/random or /dev/urandom might
produce next --- and if User B doesn't know what User A has written
into the pool, User B's job just got harder.  So if User's B, C, and D
all do the same thing, the net result is that effective
unpredictability of the random pool has increased for everyone.)
