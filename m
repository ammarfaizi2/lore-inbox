Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271761AbRHURoT>; Tue, 21 Aug 2001 13:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271762AbRHURoK>; Tue, 21 Aug 2001 13:44:10 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:55784 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271761AbRHURoB>;
	Tue, 21 Aug 2001 13:44:01 -0400
Date: Tue, 21 Aug 2001 18:44:09 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <2348622871.998419449@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.30.0108210957060.13373-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108210957060.13373-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're throwing the baby out with the bathwater. If you overestimate the
> entropy added by even a small amount, /dev/random is no better than
> /dev/urandom.

I guess the option I'm asking for is really 'Say [Y] if you think
network IRQ timing contributes more than 0 bits of entropy'.

> Imagine your attacker has broken into your firewall and can observe all
> packets on your network at high accuracy. She's also got an exact
> duplicate of your operational setup, software, hardware, switches,
> routers, so she's got a pretty good idea of what your interrupt latency
> looks like, etc., and she can even try to simulate the loads you're
> experiencing by replaying packets. She's also a brilliant statistician. So
> on each network interrupt, when you're adding, say, 8 bits of entropy to
> the count, she's able to reliably guess 1. Really she only needs to guess
> one bit right more than half the time - so long as she can gather slightly
> more information than we think she can. Since your app is occassionally
> blocking waiting for entropy, you're giving it out faster than you're
> taking it in. Assuming your attacker has broken the hash function (SHA and
> then some), it's just a short matter of time before she has enough
> information to correlate her guesses and what you've sent to figure out
> exactly what's in the pool and start guessing your session keys. Assuming
> she hasn't broken SHA, then /dev/urandom is just as good.

Your logic so far is fine bar one minor nit: If we assume SHA-1 was
not breakable, then /dev/urandom in a ZERO ENTROPY environment would
give the the same value on a reboot of your machine as a simultaneous
reboot of a hacker's machine. /dev/random would block (indefinitely)
under these conditions. So /dev/urandom and /dev/random are
both dysfunctional in this circumstance (one spits out a predictable
number, one blocks), but differently dysfunctional, and
/dev/random's behaviour is better.

Similarly, if entropy disappears later on, then using /dev/urandom
eventually  provides you with information about the state of the pool,
though as the pool is SHA-1 hashed, it's a difficult attack to exploit.

So let's use Occam's razor and assume the attacker could have an SHA-1
exploit, because if they could not, and if thus we don't need to
consider this situation, as a couple of other posters have pointed
out, you don't need to worry about this whole entropy thing at all,
and never need to block on /dev/random.

> So the whole point of /dev/random is to be more secure than just the hash
> function and mixing.

Yes.

> Which do you think is easier, breaking the hash
> function or breaking into your network operations center and walking off
> with your server? If your NOC is so secure, then you can probably afford a
> hardware entropy source..

Here's the leap of logic I don't understand.

Firstly, the cost of breaking SHA-1 to read the contents of my
server will not be worth it. The cost
of breaking into the data center may well not be worth it! However, if
someone has already broken it... I was talking to someone this afternoon
who had DES (56 bit) cracking in FPGA (read cheap board) in a couple of
hours. He has triple-DES (112 bit) cracking in twice the time WHERE THERE
ARE ALGORITHMIC OR IMPLEMENTATION WEAKNESSES. So far, of the 4 hardware
accelerators he's examined (things with glue and gunk on), in default
config, he's found these in two. The same thing that's said (now) about
SHA-1 was said about triple-DES years ago. So I am assuming the hacker /
intelligence agency already has the tool (as we said above), and it
was developed for other purposes, cost 0.

Secondly, to put the argument the other way around, if I have no other
entropy sources, and no other random number generator, then using
entropy from the network INCREASES the cost of an attack, IF the
alternative is to use /dev/urandom. This is because all that network
timing information is expensive to gather. Sure, if I am getting
entropy from elsewhere, then by potentially overcontributing
entropy, it may well DECREASE the cost of an attack, if the
alternative is to continue using /dev/random. Hence the config option.

>> Measuring it there at least 16 network IRQs for the minimum
>> SSL transaction. That generates 16x12 = 192 bits of
>> entropy (each IRQ contributes 12 bits).
>
> 12 bits is a maximum and it's based on the apparent randomness of the
> interrupt timing deltas. If your attacker is impatient, she can just ping
> you at pseudo-random intervals tuned to clean your pool more rapidly.

Correct, and it's quite possible it should be contributing less bits
than 12 if the option is turned on. However, a better response would
be to fix the timers to be more accurate :-)

> You're also forgetting that TCP initial sequence numbers come from the
> pool to prevent connection spoofing - more entropy lost.

I /think/ this irrelevant. Let's assume that the TCP initial sequence
numbers are also observable by the attacker, and contribute to knowledge
about the pool (which is I think your point) - well, the relevant amount
of entropy is knocked off (actually, more is as not all the bits are
used), which means you have to block for more if entropy gets short.
Provided that (and this is the key thing) the entropy contribution of
network IRQ timing is not overestimated (but I allege can be non-zero),
this shouldn't be a problem.

>> The point is simple: We say to authors of cryptographic applications
>> (ssl, ssh etc.) that they should use /dev/random, because /dev/urandom
>> is not cryptographically strong enough.
>
> Who ever said that? /dev/random is a cute exercise in paranoia, not
> practicality. It's nice for seeding personal GPG keys and ssh identities,
> but was never intended for bulk cryptography. It's also nice for keys
> you're going to reuse because if your attacker monitors all your traffic
> and holds onto it for 50 years, and SHA happens to gets broken before El
> Gamal, your GPG key is still safe.

People are using /dev/random for session keys, for various reasons
(possibly because of initial seeding worries, possibly because they
want the additional strength). It has been alleged by some posters
that this is incorrect behaviour. Others seem to think that having
some 'wait for entropy' property for such random-number consumers
is useful, even if that entropy MIGHT be tainted, because there is
a high probability that it's not (not least as other attacks would
be cheaper).

I agree with your point that Robert's patch /could/ taint /dev/random,
but only if you switch it on!

--
Alex Bligh
