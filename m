Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286381AbSAEBjx>; Fri, 4 Jan 2002 20:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSAEBjl>; Fri, 4 Jan 2002 20:39:41 -0500
Received: from holomorphy.com ([216.36.33.161]:26306 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286215AbSAEBjg>;
	Fri, 4 Jan 2002 20:39:36 -0500
Date: Fri, 4 Jan 2002 17:39:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Message-ID: <20020104173923.B10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E16MeqE-0001Ea-00@starship.berlin>; from phillips@bonn-fries.net on Sat, Jan 05, 2002 at 01:37:40AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 06:40 pm, William Lee Irwin III wrote:
+       unsigned long hash = (unsigned long)page;

On Sat, Jan 05, 2002 at 01:37:40AM +0100, Daniel Phillips wrote:
> Just to be anal here, 'long' doesn't add anything useful to this 
> declaration.  In fact, u32 is what you want since you've chosen your 
> multiplier with a 32 bit register in mind - on 64bit arch I think you'll get 
> distinctly non-random results as it stands.

On January 4, 2002 06:40 pm, William Lee Irwin III wrote:
+	hash *= GOLDEN_RATIO_PRIME;
+	hash >>= BITS_PER_LONG - zone->wait_table_bits;
+	hash &= zone->wait_table_size - 1;

On Sat, Jan 05, 2002 at 01:37:40AM +0100, Daniel Phillips wrote:
> Nice hash!  For arches with expensive multiplies you might want to look 
> for a near-golden ratio multiplier that has a simple contruction in terms of 
> 1's & 0's so it can be computed with 2 or 3 shift-adds, dumping the 
> efficiency problem on the compiler.  You don't have to restrict your search 
> to the neighbourhood of 32 bits, you can go a few bits less than that and 
> substract from a smaller value than BITS_PER_LONG (actually, you should just 
> write '32' there, since that's what you really have in mind).

For 64-bit machines an entirely different multiplier should be used,
one with p/2^64 approximately phi. And I'd rather see something like:

	hash   = (unsigned long)pages;
	hash  *= GOLDEN_RATIO_PRIME;
	hash >>= zone->wait_table_shift;

with no masking, since the above shift should be initialized so as
to annihilate all the high-order bits above where the table's page
size should be. On the other hand, shifting all the way may not be
truly optimal, and so it may be better to mask with a smaller shift.

2 or 3 shift/adds is really not possible, the population counts of the
primes in those ranges tends to be high, much to my chagrin. I actually
tried unrolling it by hand a few times, and it was slower than
multiplication on i386 (and uncomfortably lengthy). So Fibonacci
hashing may well not be the best strategy for architectures without
hardware integer multiplies.

I believe to address architectures where multiplication is prohibitively
expensive I should do some reading to determine a set of theoretically
sound candidates for non-multiplicative hash functions and benchmark them.
Knuth has some general rules about design but I would rather merely test
some already verified by someone else and use the one that benches best
than duplicate the various historical efforts to find good hash functions.


Cheers,
Bill
