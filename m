Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271728AbRHUQOB>; Tue, 21 Aug 2001 12:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271731AbRHUQNl>; Tue, 21 Aug 2001 12:13:41 -0400
Received: from waste.org ([209.173.204.2]:12300 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271728AbRHUQN3>;
	Tue, 21 Aug 2001 12:13:29 -0400
Date: Tue, 21 Aug 2001 11:13:39 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <605104920.998386381@[169.254.45.213]>
Message-ID: <Pine.LNX.4.30.0108210957060.13373-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Alex Bligh - linux-kernel wrote:

> > No you don't, that's your whole complaint to start with. You're clearly
> > entropy-limited. If you were willing to block waiting for enough entropy,
> > you'd be fine with the current scheme.
>
> Yes I /do/. I want to wait for sufficient entropy. I count inter-IRQ
> timing from network as a source of entropy. IE if the entropy pool
> is exhausted, I'm prepared to, and desire to, block, until a few packets
> have arrived. However, I do not wish to block indefinitely (actually
> about 3 minutes as there's a little periodic block I/O) which is what
> happens if I do not count network IRQ timing as an entropy source
> (current /dev/random result, without Robert's patch, on most NICs).
> Equally, I do not want want to read /dev/urandom (and not block)
> which, in an absence of entropy, is (arguably) cryptographically weaker
> (see below).

You're throwing the baby out with the bathwater. If you overestimate the
entropy added by even a small amount, /dev/random is no better than
/dev/urandom.

Imagine your attacker has broken into your firewall and can observe all
packets on your network at high accuracy. She's also got an exact
duplicate of your operational setup, software, hardware, switches,
routers, so she's got a pretty good idea of what your interrupt latency
looks like, etc., and she can even try to simulate the loads you're
experiencing by replaying packets. She's also a brilliant statistician. So
on each network interrupt, when you're adding, say, 8 bits of entropy to
the count, she's able to reliably guess 1. Really she only needs to guess
one bit right more than half the time - so long as she can gather slightly
more information than we think she can. Since your app is occassionally
blocking waiting for entropy, you're giving it out faster than you're
taking it in. Assuming your attacker has broken the hash function (SHA and
then some), it's just a short matter of time before she has enough
information to correlate her guesses and what you've sent to figure out
exactly what's in the pool and start guessing your session keys. Assuming
she hasn't broken SHA, then /dev/urandom is just as good.

So the whole point of /dev/random is to be more secure than just the hash
function and mixing. Which do you think is easier, breaking the hash
function or breaking into your network operations center and walking off
with your server? If your NOC is so secure, then you can probably afford a
hardware entropy source..

Read Schneier's essay on attack trees if the above argument doesn't make
sense to you:

 http://www.ddj.com/articles/1999/9912/9912a/9912a.htm?topic=security

> Measuring it there at least 16 network IRQs for the minimum
> SSL transaction. That generates 16x12 = 192 bits of
> entropy (each IRQ contributes 12 bits).

12 bits is a maximum and it's based on the apparent randomness of the
interrupt timing deltas. If your attacker is impatient, she can just ping
you at pseudo-random intervals tuned to clean your pool more rapidly.
You're also forgetting that TCP initial sequence numbers come from the
pool to prevent connection spoofing - more entropy lost.

> The point is simple: We say to authors of cryptographic applications
> (ssl, ssh etc.) that they should use /dev/random, because /dev/urandom
> is not cryptographically strong enough.

Who ever said that? /dev/random is a cute exercise in paranoia, not
practicality. It's nice for seeding personal GPG keys and ssh identities,
but was never intended for bulk cryptography. It's also nice for keys
you're going to reuse because if your attacker monitors all your traffic
and holds onto it for 50 years, and SHA happens to gets broken before El
Gamal, your GPG key is still safe.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

