Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTBFXKp>; Thu, 6 Feb 2003 18:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTBFXKo>; Thu, 6 Feb 2003 18:10:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37394 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267536AbTBFXKl>; Thu, 6 Feb 2003 18:10:41 -0500
Date: Thu, 6 Feb 2003 15:16:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc -O2 vs gcc -Os performance
In-Reply-To: <279800000.1044572300@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302061456370.14478-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Feb 2003, Martin J. Bligh wrote:
> 
> The observation re low repeat rate is interesting ... might be amusing 
> to do some really basic profile-guided optimisation on this grounds,
> take readprofile / oprofile output, and compile the files that don't
> get hammered at all with -Os rather than -O2. Given their low frequency
> (by definition), I'm not sure that improving their icache footprint will
> have a measureable effect though.

Icache footprint has nothing to do with repeat rates, which is exactly why 
repeat rates are interesting for -Os.

Icache footprint is directly proportional to the _static_ size of the code 
(ie exactly the thing that -Os is supposed to optimize for), while 
instruction-level performance measurement is only valid on the _dynamic_ 
code.

And with modern CPU's with big caches, a _lot_ of cache misses are the 
forced kind - the startup costs, not the actual runtime cost. That's not 
always true (if you touch big data sets, you'll have replacement misses 
too, of course), but it's not really false either.

So think of the I$ (and TLB, and page load/map - all the same) cost as a 
fixed cost that will always be there, but that -Os tries to minimize. 
That's _one_ dimension in the total cost.

The "traditional" -O2 kind of "try to make the code run fast" 
optimizations tend to try to minimize a totally different dimension, 
namely the dynamic code speed.

And the time required for running the program is the sum of the static and 
dynamic factors. In other words, a _good_ optimization should try to 
minimize not one or the other, but the sum.

And low repeat rates means that the dynamic component is smaller, which 
clearly makes the static component more important.

For example, if you are doing mp3 encoding, the repeat rates for the core 
loop are huge, and the code is small, so clearly the static component is 
largely insignificant. Use -O2.

But if you're running a GUI program then just the loading time is often
quite noticeable, and if you can improve that by, say, 10%, then that can
_more_ than make up for almost any amount of stupidity in your code.  
Especially since a lot of the code isn't even all that loopy and tends to
have low repeat rates. You're almost guaranteed to be better off using -Os
than -O2.

If you've got performance counter data, check the I$ and ITLB miss ratios, 
and if they are at all noticeable, think about the fact that a I$ miss 
tends to cost a lot more than a few more dynamic instructions. 

I suspect the kernel I$ behaviour is generally pretty good, and the ITLB 
behaviour is improved even further thanks to large pages etc. That said, a 
user app that blows the I$ will blow the kernel out of the I$ too, so 
small is always beautiful, even in the kernel.

		Linus

