Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRHSSCc>; Sun, 19 Aug 2001 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbRHSSCV>; Sun, 19 Aug 2001 14:02:21 -0400
Received: from nef.ens.fr ([129.199.96.32]:30222 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S268617AbRHSSCK>;
	Sun, 19 Aug 2001 14:02:10 -0400
Date: Sun, 19 Aug 2001 20:02:19 +0200 (MET DST)
Message-Id: <200108191802.UAA08251@clipper.ens.fr>
From: david.madore@ens.fr (David Madore)
In-Reply-To: <998193404.653.12.camel@phantasy> <Pine.LNX.4.30.0108191124430.740-100000@waste.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
X-Newsreader: Flrn (0.5.0pre0 - 10/00)
To: linux-kernel@vger.kernel.org
X-Start-Date: 19 Aug 2001 17:15:44 GMT
In-Reply-To: <Pine.LNX.4.30.0108191124430.740-100000@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion is getting nowhere.

Oliver Xymoron in litteris
<Pine.LNX.4.30.0108191124430.740-100000@waste.org> scripsit:
>		      to the real entropy
<...>
>				 'perfect' quality of /dev/random
<...>
>								  real
> entropy

There is no such thing as "real" entropy.  Even in thermodynamics
there is no such thing as "real" entropy.  All entropy is relative to
some knowledge base.  It does not make any sense to say "the entropy
pool contains so-and-so-many logons of entropy".  For a user who can
read the kernel memory, the entropy of the pool is 0 at all times.
For a user who has not come into contact with the box, the entropy is
4096 logons (assuming the pool's size is 4096 bits) when contact is
initiated, and drops by *at most* 8 logons for every bit that is read
from /dev/random - but it is not the state of /dev/random itself which
changes, nor its "absolute" entropy (there is no such thing), it is
only its entropy relative to a certain knowledge base.

Now the kernel makes some very conservative assumptions about the
knowledge base and evaluates the corresponding entropy.  It assumes,
for example, that all outputs of /dev/random are fed to the same
knowledge base.  That is, it maintains only one entropy count (rather
than, e.g., one per process).  This is necessary for simplicity and
security in all cases, but in some cases it may be a tremendous
underestimate of the amount of entropy.  Similarly, it assumes that
every byte that is produced by /dev/random (or /dev/urandom) decreases
the entropy count by 8 logons.  This is also a conservative
assumption; if a program uses only, say, the values it reads mod 26,
then every byte spills only 4.7 logons (relative to the knowledge base
of an observer who can only read those mod 26 values).  Finally, the
kernel assumes that the knowledge base of the observer contains the
mean value and standard deviation and various similar statistical
moments of various "entropy sources", but not their actual contents;
and a choice has been made among those entropy sources.

These are very sensible assumptions, but these are assumptions
nonetheless.  It is utterly naïve to think that the entropy count
maintained by the kernel is the "real entropy count" of the pool, in
some physical sense.  For most useful knowledge bases, the kernel
tremendously *underestimates* the entropy of the pool; in fact, we
might say that for all "useful purposes", the entropy is infinite at
all times.  Supposing it is not means we suppose at least that the
observer can crack the hash function used for stirring the pool, which
is not at all an obvious task.

But the kernel might also overestimate the entropy count.  As I
mentioned before, for someone who can break root in the box, the
entropy is zero at all times.  For someone who can monitor electrical
fluctuations with great enough accuracy, the entropy is not as high as
it may seem.  Also, the assumption made that the added entropy can be
estimated (for timer events) using the first three deltas of the
event's timing, can fail in certain circumstances (and not very nasty
or unreasonable circumstances: if the event occurs at intervals which
follow a cycle of length at least five, you are adding a bounded
amount of entropy to the pool relative to a user who knows this fact,
even if you let the event feed the pool for an arbitrarly long time,
but the kernel will assume that you are, indeed, feeding it boundless
amounts of entropy; so a simple 5-periodic event will cause the
kernel's estimations to fail miserably).

The morale of all this is: the /dev/random device is a useful service,
because the kernel does a pretty good job of producing very pure
random numbers.  But it is not utterly fail-safe.  It nearly always
underestimates the entropy (for what you're concerned with), and it
may overestimate it.

Thus, if you have specific knowledge about your system, it makes
perfect sense to adjust the entropy evaluation.  For example, if you
know that the observers you're concerned about (those against whom you
use the random numbers) cannot observe your network devices (e.g., if
your network device is connected to a local network and you are using
the random numbers across the Internet), it is perfectly reasonable to
add network devices in the estimation of the entropy count.  It does
not make it any less secure.  It merely does not underestimate the
entropy as much.

But all this is completely theoretical, anyway.  Even if your life is
at stake, you can be completely confident that nobody can predict the
next 64 bits that are going to come out of /dev/urandom, even if you
give that would-be-predictor the previous 64kbytes that did come out
of it, and even if you removed *all* the entropy sources from the
system.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
