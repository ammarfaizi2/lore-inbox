Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRHTPH3>; Mon, 20 Aug 2001 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271287AbRHTPHV>; Mon, 20 Aug 2001 11:07:21 -0400
Received: from waste.org ([209.173.204.2]:11832 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271278AbRHTPHH>;
	Mon, 20 Aug 2001 11:07:07 -0400
Date: Mon, 20 Aug 2001 10:07:14 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <2251207905.998322034@[10.132.112.53]>
Message-ID: <Pine.LNX.4.30.0108200942060.4612-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Alex Bligh - linux-kernel wrote:

> >> Am I correct in assuming that in the absence of other entropy sources, it
> >> would use these (potentially inferior) sources, and /dev/random would
> >> then not block? In which case fine, it solves my problem.
> >
> > No, /dev/random would always keep a conservative estimate of entropy.
> > Assuming that network entropy > 0, this would add more real (but
> > unaccounted) entropy to the pool, and if you agree with this assumption,
> > you would be able to take advantage of it by reading /dev/urandom.
>
> OK; well in which case it doesn't solve the problem. I assert there are
> configurations where using the network to generate accounted for entropy
> is no worse than the other available options. In that case, if my entropy
> pool is low, I want to wait long enough for it to fill up (i.e. have the
> /dev/random blocking behaviour) before reading my random number.

No you don't, that's your whole complaint to start with. You're clearly
entropy-limited. If you were willing to block waiting for enough entropy,
you'd be fine with the current scheme. Now you've just pushed the problem
out a little further.  Let's just assume that your application is some
sorta secure web server, generating session keys for SSL. For short
transactions, you'll need possibly hundreds of bits of entropy for a small
handful of packets. With packet queueing on your NIC, under load you might
only see a couple interrupts for an entire transaction.

Look, /dev/urandom _is_ cryptographically strong, and there's no attack
against it that's even vaguely practical. It's good enough, and we can
make it better. Overestimating entropy makes /dev/random no better in
theory than /dev/urandom, blocking or no. What's the point?

> An alternative approach to all of this, perhaps, would be to use extremely
> finely grained timers (if they exist), in which case more bits of entropy
> could perhaps be derived per sample, and perhaps sample them on
> more operations. I don't know what the finest resolution timer we have
> is, but I'd have thought people would be happier using ANY existing
> mechanism (including network IRQs) if the timer resolution was (say)
> 1 nanosecond.

We can use cycle counters where they exist. They're already used on x86
where available. I suspect that particular code could be made more
generic.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

