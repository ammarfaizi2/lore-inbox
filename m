Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271829AbRHUTFL>; Tue, 21 Aug 2001 15:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRHUTFE>; Tue, 21 Aug 2001 15:05:04 -0400
Received: from waste.org ([209.173.204.2]:14106 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271826AbRHUTEo>;
	Tue, 21 Aug 2001 15:04:44 -0400
Date: Tue, 21 Aug 2001 14:04:57 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <2348622871.998419449@[10.132.112.53]>
Message-ID: <Pine.LNX.4.30.0108211258080.13373-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Alex Bligh - linux-kernel wrote:

> > You're throwing the baby out with the bathwater. If you overestimate the
> > entropy added by even a small amount, /dev/random is no better than
> > /dev/urandom.
>
> I guess the option I'm asking for is really 'Say [Y] if you think
> network IRQ timing contributes more than 0 bits of entropy'.

The trouble is no one has a good model of how much more than zero it is.

> Your logic so far is fine bar one minor nit: If we assume SHA-1 was
> not breakable, then /dev/urandom in a ZERO ENTROPY environment would
> give the the same value on a reboot of your machine as a simultaneous
> reboot of a hacker's machine.

That's why you seed your pool at boot. Zero entropy is reducio ad absurdum
argument anyway.

> So let's use Occam's razor and assume the attacker could have an SHA-1
> exploit, because if they could not, and if thus we don't need to
> consider this situation, as a couple of other posters have pointed
> out, you don't need to worry about this whole entropy thing at all,
> and never need to block on /dev/random.

Again, /dev/random is an exercise in paranoia. If the blocking thing is a
hassle, then you probably shouldn't be using it.

> Here's the leap of logic I don't understand.
>
> Firstly, the cost of breaking SHA-1 to read the contents of my
> server will not be worth it. The cost
> of breaking into the data center may well not be worth it!

So then /dev/urandom is good enough.

> However, if someone has already broken it... I was talking to someone
> this afternoon who had DES (56 bit) cracking in FPGA (read cheap
> board) in a couple of hours. He has triple-DES (112 bit) cracking in
> twice the time WHERE THERE ARE ALGORITHMIC OR IMPLEMENTATION
> WEAKNESSES. So far, of the 4 hardware accelerators he's examined
> (things with glue and gunk on), in default config, he's found these in
> two. The same thing that's said (now) about SHA-1 was said about
> triple-DES years ago. So I am assuming the hacker / intelligence
> agency already has the tool (as we said above), and it was developed
> for other purposes, cost 0.

Ok, you're going to assume that the 160-bit SHA hash with lots and lots
and lots of mixing is more vulnerable than the IDEA or Blowfish or 3DES
that you're using for your actual encryption?

> Secondly, to put the argument the other way around, if I have no other
> entropy sources, and no other random number generator, then using
> entropy from the network INCREASES the cost of an attack, IF the
> alternative is to use /dev/urandom. This is because all that network
> timing information is expensive to gather. Sure, if I am getting
> entropy from elsewhere, then by potentially overcontributing
> entropy, it may well DECREASE the cost of an attack, if the
> alternative is to continue using /dev/random. Hence the config option.

How about simply adding possible entropy from the network but not
accounting for it? /dev/urandom then becomes as strong as the proposed
/dev/random (up to the load that /dev/random would allow), while
/dev/random isn't weakened.

> >> Measuring it there at least 16 network IRQs for the minimum
> >> SSL transaction. That generates 16x12 = 192 bits of
> >> entropy (each IRQ contributes 12 bits).
> >
> > 12 bits is a maximum and it's based on the apparent randomness of the
> > interrupt timing deltas. If your attacker is impatient, she can just ping
> > you at pseudo-random intervals tuned to clean your pool more rapidly.
>
> Correct, and it's quite possible it should be contributing less bits
> than 12 if the option is turned on. However, a better response would
> be to fix the timers to be more accurate :-)

We're already using cycle counters - do you propose being more accurate
than that?

> > You're also forgetting that TCP initial sequence numbers come from the
> > pool to prevent connection spoofing - more entropy lost.
>
> I /think/ this irrelevant. Let's assume that the TCP initial sequence
> numbers are also observable by the attacker, and contribute to knowledge
> about the pool (which is I think your point) - well, the relevant amount
> of entropy is knocked off (actually, more is as not all the bits are
> used), which means you have to block for more if entropy gets short.
> Provided that (and this is the key thing) the entropy contribution of
> network IRQ timing is not overestimated (but I allege can be non-zero),
> this shouldn't be a problem.

ISNs are 32 bits and it takes one interrupt to trigger a SYN. Happily, the
network stack doesn't block when it runs out of entropy, otherwise your
headless box would never get anywhere.

> I agree with your point that Robert's patch /could/ taint /dev/random,
> but only if you switch it on!

As it stands, it does. Assuming a 1GHz processor and hitting the maximum
12 bits of entropy per interrupt, we only need to guess the interrupt
timing to within 4us - probably not hard. As I've pointed out, it's not
hard to send our own apparently random packets to open up that window.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

