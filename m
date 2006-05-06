Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEFSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEFSGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWEFSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:06:09 -0400
Received: from thunk.org ([69.25.196.29]:62417 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750700AbWEFSGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:06:08 -0400
Date: Sat, 6 May 2006 14:05:51 -0400
From: Theodore Tso <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060506180551.GB22474@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	davem@davemloft.net
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506164808.GY15445@waste.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 11:48:08AM -0500, Matt Mackall wrote:
> Case 3:
> Hash function broken, entropy accounting is over-optimistic:
> /dev/urandom and /dev/random are both equally insecure because both
> are revealing more internal entropy than they're collecting. So you
> should just use /dev/urandom because at least it doesn't block.
> 
> Putting aside all the practical issue of what exactly is entropy and
> what decent entropy sources are, we should be able to agree on this
> much. And this basically says that if you do your entropy accounting
> badly, you throw the baby out with the bathwater.

Agreed, but I'd an additional point of nuance; this assumes that the
attacker (call him Boris for the sake of argument) can actually gain
access to enough /dev/random or /dev/urandom outputs, and be
knowledgable about all other calls to /dev/random and exactly when
they happen (since entropy extractions cause the TSC to be mixed into
the pool) so Boris can can actually determine the contents of the
pool.  Note that simply "breaking" a cryptographic hash, in the sense
of finding two input values that collide to the same output value,
does not mean that the hash has been sufficiently analyzed that it
would be possible to accomplish this feat.  And given that it took
80,000 CPU hours to determine find this collision, and the complexity
of the attack was 2**51, it seems highly likely that with a poolsize
of 4096 bits, that it would take a huge amount of /dev/random
extractions, complete with the exact TSC timestamp when the
extractions were happening, such that an attacker would be able to
have enough information to break the pool.

Does this mean we should __depend__ on this?  No, we should always do
the best job that we can.  But it's also fair to say that even if the
hash function is "broken", that the results are not automatically
going to be catastrophic.  If the attacker can't get their hands on
enough of an output stream from /dev/random, then it's not likely to
do much.  For an attacker who only has network access, this could be
quite difficult.

> But network traffic should be _assumed_ to be observable to some
> degree. Everything else in network security makes the assumption that
> traffic is completely snoopable. By contrast, we assume people can't
> see us type our passwords[1]. So while our entropy estimator assumes
> observability == 0, for the network case, 0 < observability <= 1. And
> if it's greater than what our entropy estimator assumes, our entropy
> estimates are now too optimistic and /dev/random security degrades to
> that of /dev/urandom.

The timing of network arrivals is observable to *some* degree.  Of
course, so is the timing from block I/O interrupts.  The question is
whether or not it is predictable enough at the finest resolution.  For
block device interrupts, there has been papers showing that air
currents inside the spinning media is chaotic enough that it can
actually influence the timing at which interrupts are returned --- at
least for systems a decade ago.  To be honest, it would probably be a
useful and worthwhile masters thesis for a grad student to revisit the
problem using modern disk drive technologies, controllers, and
interconnects to see if this is still a valid assumption.

For network traffic, again, it depends on your threat model.  For an
attacker stationed in Fort Mead, Maryland, with over a dozen router
and ethernet switches between them and the target system, there are
enough packet queues and buffers that any hope of observing packet
interarrival times is almost certainly hopeless.  As I've said, if an
attacker has direct physical access to the ethernet segment between
your host and the switch, then while the attacker is busy installing a
keyboard switcher and possibly doing a black bag job on your hard disk
to install monitoring software directly in the OS software, yes, the
FBI agent could probably install something on the ethernet between
your host and the switch that could precisely measure packet arrival
times very accurately.  Is that something the system administrator
should care about?  Maybe, maybe not.

That's why I think it should be configurable.  If you don't have a
real hardware number generator, maybe blocking would be preferable to
not having good entropy.  But in other circumstances, what people need
is the best possible randomness they can get, and their security is
not enhanced by simply taking it away from them altogether.  That
makes about as much sense as GNOME making its applications "easier to
use" by removing functionality (to quote Linus).

> Yes, this is all strictly theoretical. But the usefulness of
> /dev/random is exactly as theoretical. So if you use /dev/random for
> it's theoretical advantages (and why else would you?), this defeats
> that.

This becomes a philosophical arugment.  Yes, we should strive for as
much theoretical perfection as possible.  But at the same time, we
need to live in the real world, and adding network entropy which can
defeat the bored high school student in Russia using some black hat
toolkit they downloaded of the internet is useful --- even if it can't
defeat the NSA/FBI agent who can perform a black bag job and place a
monitoring device on your internal ethernet segment.

							- Ted
