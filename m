Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSCPUsL>; Sat, 16 Mar 2002 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310642AbSCPUsC>; Sat, 16 Mar 2002 15:48:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35081 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310637AbSCPUrw>; Sat, 16 Mar 2002 15:47:52 -0500
Date: Sat, 16 Mar 2002 12:46:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <davidm@hpl.hp.com>
cc: <yodaiken@fsmlabs.com>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <15507.44228.577059.711997@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0203161238510.32013-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, David Mosberger wrote:
> 
> Yes, Itanium has a two-level DTLB, McKinley has both ITLB and DTLB
> split into two levels.  Not quite as big though: "only" on the order
> of hundreds of entries (partially offset by larger page sizes).  Of
> course, operating the hardware walker in hashed mode can give you an
> L3 TLB as large as you want it to be.

The problem with caches is that if they are not coherent (and TLB's
generally aren't) you need to invalidate them by hand. And if they are 
in main memory, that invalidation can be expensive.

Which brings us back to the whole reason for the discussion: this is not a 
theoretical argument. Look at the POWER4 numbers, and _shudder_ at the 
expense of cache invalidation.

NOTE! The goodness of a cache is not in its size, but how quickly you can 
fill it, and what the hitrate is. I'd be very surprised if you get 
noticeably higher hitrates from "as large as you want it to be" than from 
"a few thousand entries that trivially fit on the die".

And I will guarantee that the on-die ones are faster to fill, and much
faster to invalidate (on-die it is fairly easy to do content-
addressability if you limit the addressing to just a few ways - off-chip 
memory is not).

>   Linus>  - ability to fill multiple entries in one go to offset the
>   Linus> cost of taking the trap.
> 
> The software fill can definitely do that.  I think it's one area where
> some interesting experimentation could happen.

If you can do it, and you don't do it already, you're just throwing away
cycles. If that was your comparison with the "superior hardware fill", it
really wasn't very fair.

Note that by "multiple entry support" I don't mean just a loop that adds 
noticeable overhead for each entry - I mean something which can fairly 
efficiently load contiguous entries pretty much in "one go". A TLB fill 
routine can't afford to spend time setting up tag registers etc.

		Linus

