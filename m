Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270557AbRHSPTp>; Sun, 19 Aug 2001 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270558AbRHSPTg>; Sun, 19 Aug 2001 11:19:36 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:29707 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S270557AbRHSPTa>;
	Sun, 19 Aug 2001 11:19:30 -0400
Date: Sun, 19 Aug 2001 11:13:58 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Schwartz <davids@webmaster.com>
Cc: Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010819111357.A3504@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Schwartz <davids@webmaster.com>,
	Andreas Dilger <adilger@turbolinux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010817171834.A24850@thunk.org> <NOEJJDACGOHCKNCOGFOMKEFFDEAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <NOEJJDACGOHCKNCOGFOMKEFFDEAA.davids@webmaster.com>; from davids@webmaster.com on Fri, Aug 17, 2001 at 03:05:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 03:05:39PM -0700, David Schwartz wrote:
> > That's not the only attack, actually.  The much simpler attack pathis
> > for an attack to **observe** the network traffic to such a precise
> > extent as to be able to guess what the entropy numbers are that are
> > going into the pool.  (Think: FBI's Carnivore).
>
> 
> 	This is a non-issue providing the entropy pool code correctly
> estimates the amount of entropy. The Linux entropy code is written
> so that there is no harm from putting fully known or partially known
> numbers into the pool provided that the pool does not overestimate
> the amount of entropy in those numbers.

Err, yes, I know that....

The problem is that by being able to perfectly observe packets on the
LAN, you know a lot more about the numbers that are going in, and it's
therefore extremely likely that the entropy estimate will be
overestimated.  

> 	Even if you could perfectly time the packets on the LAN, you
> still could not tell the clock skew between the clock on the LAN
> card and the TSC. There would still be unknowns involving how long
> it would take for the interrupt to be acknowledged and the entropy
> gathering code to get to the CPU. These unknowns still contain real
> entropy that there is no known way an attacker could know.

Yes, but the problem is that the entropy estimation code needs to
differentiate between the differences caused by packet (which is
observable by an outsider), and differenences caused by interrupt
timings, etc.  At the moment, it doesn't do this at all.  

Also, the clock skew between the TSC and the LAN card has only two
components.  One is the actual clock frequency on the CPU, and the
other is a fixed offset (roughly based on when the system was booted).
So to an determined adversary, the amount of randomness this adds is a
fixed constant, and not something which changes each time entropy is
sampled.  Also, it wouldn't surprise me if a determined adversary
(read: NSA) wouldn't be able to come up with statistical models of
interrupts response times for Linux such that the amount of entropy
that you can dependably rely on is less than you might think.

The bottom line is it really depends on how paranoid you want to be,
and how much and how closely you want /dev/random to reliably replace
a true hardware random number generator which relies on some physical
process (by measuring quantum noise using a noise diode, or by
measuring radioactive decay).  For most purposes, and against most
adversaries, it's probably acceptable to depend on network interrupts,
even if the entropy estimator may be overestimating things.

							- Ted


