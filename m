Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271365AbTHMD6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTHMD6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:58:39 -0400
Received: from thunk.org ([140.239.227.29]:29837 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S271365AbTHMD63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:58:29 -0400
Date: Tue, 12 Aug 2003 23:52:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Matt Mackall <mpm@selenic.com>, James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030813035257.GB1244@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jamie Lokier <jamie@shareable.org>, Matt Mackall <mpm@selenic.com>,
	James Morris <jmorris@intercode.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811020919.GD10446@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 03:09:19AM +0100, Jamie Lokier wrote:
> If you return xy, you are returning a strong digest of the pool state.
> Even with the backtrack-prevention, if the attacker reads 20 bytes
> from /dev/random and sees a _recognised_ pattern, they immediately
> know the entire state of the secondary pool.
> 
> This can happen if, for example, a machine has just rebooted and
> hasn't had time to collect much entropy since the initial state.

No, for the following reasons:

1) By the time you go through  all of the init scripts, there has been
quite a  lot of randomness  mixed into the  pool, from the  hard drive
interrupts if nothing  else.  So it would be  fairly difficult for the
attacker to get any kind of recognized patterns.

2) There's a reason why random.c recommends that the init scripts do
the follwoing at bootup:

	echo "Initializing random number generator..."
	random_seed=/var/run/random-seed
	# Carry a random seed from start-up to start-up
	# Load and then save the whole entropy pool
	if [ -f $random_seed ]; then
		cat $random_seed >/dev/urandom
	else
		touch $random_seed
	fi
	chmod 600 $random_seed
	poolfile=/proc/sys/kernel/random/poolsize
	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
	dd if=/dev/urandom of=$random_seed count=1 bs=$bytes

and this at shutdown:

	# Carry a random seed from shut-down to start-up
	# Save the whole entropy pool
	echo "Saving random seed..."
	random_seed=/var/run/random-seed
	touch $random_seed
	chmod 600 $random_seed
	poolfile=/proc/sys/kernel/random/poolsize
	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
	dd if=/dev/urandom of=$random_seed count=1 bs=$bytes

This is subtle.  It's important that random data be saved across a
reboot, precisely to avoid the backtracking attack.  It is also very
important the seed file be overwritten immediately after it is used,
both (a) so that the pool is initialized to some other value if the
machine reboots uncleanly without the shutdown script being executed,
and (b) so that an attacker which breaches root can not read out the
previously used seed file in an attempt to carry out the back-tracking
attack. 

> This means that, for a short time after, they can predict further
> output bits exactly.  "Catastrophic reseeding" from the primary pool
> limits how many bits they can predict like this - unless, if they're
> lucky, it tells them the state of the primary pool too.

Given the small amount of information which is transfered from the
primary pool to the secondary pool, it can't give them much
information about the primary pool.  I thought very carefully about
this design....

> When you output less of the hash, this reduces the information
> available to predict the state of the pool.  However, SHA1 is large
> enough that even half of the hash is a strong predictor, so returning
> half of the hash still has this weakness.
> 
> (Ironically, a much weaker hash would prevent this mode of data leakage).
> 

Nope, because of a very simple information theoretic argument.  At
best, each hash can only reveal 80 bits of information, even if the
hash was totally weak.  The secondary pool is 128 bytes, or 1024 bits.
A truely stupid/weak hash could at most leak 80 bits of information
from the pool.  A stronger hash will leak less information, which is a
good thing, not at a bad thing.

This by the way is why we need to do catastrophic reseeding; if we
wanted to be truely paranoid, if we reseeded every 1024 bits of
output, there we would be guaranteed that there was no possible way
(using an information theoretic argument) that any information from
the secondary pool could be known.  In fact, we reseed every 1024
bytes of input, which means we do rely on SHA being at least halfway
decent.

> As far as I can tell, folding the hash result doesn't help, because
> that simply creates a different kind of hash which can also be
> recognised, and which is large enough to predict the pool state.
> 
> Which leaves...
> 
> I have just convinced myself of a flaw in the existing random.c -
> which still holds in your patched version.  Folding the result of the
> strong hash is useless.  Instead, the _input_ to the strong hash
> should be folded, so that a single hash result (whether folded or not)
> doesn't reveal the pool state even when it is recognised.

No, whether you fold the input or the output, you're still creating a
new, slightly different hash.  Think about it.  If F(x) is the fold
operation, and H(x) is the hash operation, then

	H'(x) = F(H(x))
	H''(x) = H(F(x))

The reason why folding the output is better is that we're only leaking
80 bits at a time, as opposed to 160 bits at a time.  

						- Ted
