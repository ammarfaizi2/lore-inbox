Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWEGBWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWEGBWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 21:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEGBWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 21:22:19 -0400
Received: from THUNK.ORG ([69.25.196.29]:58069 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751169AbWEGBWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 21:22:18 -0400
Date: Sat, 6 May 2006 21:22:00 -0400
From: Theodore Tso <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507012200.GC22474@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	davem@davemloft.net
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org> <20060506203304.GF15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506203304.GF15445@waste.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 03:33:04PM -0500, Matt Mackall wrote:
> I'm not talking about any existing attacks, I'm talking about what
> would theoretically be possible were a first preimage attack on our
> hash to become practical.

Note that even the first preimage attack on a hash (none of which have
been demonstrated for MD-5, SHA-0, SHA-1, or reduced-round or
otherwise weakened versions of the same, as far as I know), would be
sufficient by itself to guarantee that the attacker would be able to
determine the contents of the entropy pool from the output stream.  A
preimage attack merely states that the attacker can find a _single_
input which hashes to a particular output value of the crypto
checksum.  Because we are hashing the entire pool to produce each
chunk of output, by the pigeonhole principle and the observed
statistical random distribution properties of the hash, there are a
very large number of potential pool values that could result in that
particular hash (we are compressing 4096 bits down to 80 bits).   

So a successful cryptographic attack would have to combine a
successful preimage attack of the cryptographic hash core with
additional refinements so that the preimage attack technique can
produce *multiple" (in fact, probably all possible) preimages, and
correlate that with the pool mixing function to successful rule out
preimages based on the successive outputs from the algorithm (assuming
that the attacker can determine the exact TSC timestamp when the
extraction happened, since that's mixed into the pool as part of the
extraction process).

The point is that we are using a *very* conservative design, unlike
Yarrow which used a minimally-sized entropy pool and which would be
far more vulnerable to the discovery of a preimage attack on the hash.

> All agreed. But that applies equally to /dev/urandom. The only thing that
> distinguishes the two is entropy accounting and entropy accounting
> only makes a difference if it's conservative. 

OK, but in that case, in order to make /dev/urandom as secure as
possible (which is what most programs would use anyway for things like
session keys, etc.), we shouldn't be throwing away the entropy from
network interrupts, but rather always collecting the input and merely
changing how much entropy credits to assign to various interrupts.

After all, the only application where /dev/random is really justified
is for key generation of long-term public/private keypairs, and in
those cases you almost always have a keyboard attached since the
security requirements are such that you probably don't want ot be
doing it remotely anyway.

My philosophy on the entropy accounting is that it isn't necessarily
accurate; sometimes it over-estimates entropy, and sometimes it
under-estimates entropy.  The main thing it does is to make it
significantly harder for an attacker to gather a huge number of data
points to use for carrying out a theoretical cryptographic attack.  It
provides additional security, but it isn't necessarily perfect
(nothing in this world is).

> Here's a threat model: I remotely break into your LAN and 0wn insecure
> Windows box X that's one switch jump away from the web server Y that
> processes your credit card transactions. I use standard techniques to
> kick the switch into broadcast mode so I can see all its traffic or
> maybe I break into the switch itself and temporarily isolate Y from
> the rest of the world so that only X can talk to it. I'm still in
> Russia, but I might as well be in the same room.

I could ask questions about why the insecure Windows box is on the
same network as the box processing the credit card transactions, or
how the attacker is familiar with the network topology, or knows the
clock frequencies of your CPU(s) and when your box was last rebooted
so it can make guesses about the TSC values that will be hashed in ---
or know which CPU (for SMP boxes) an interrupt will be processed on
since on current Intel/AMD boxes the TSC is not synchronized.  But
even if the attacker knows all of this, the attacker still doesn't
know the current starting point of the pool.   

> Again, I think it's perfectly reasonable to sample from all sorts of
> sources. All my issues are about the entropy accounting.

But in that case your patch which removes the call to add_entropy() is
probably not the right thing, yes?  Maybe making the amount of entropy
which is credited for each device interrupt ought to be configurable,
sure.  But we should be collecting the interrupt-arrival times
regardless of how much we bump the entropy accounting.

						- Ted
