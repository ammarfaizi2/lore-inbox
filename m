Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSAEFGq>; Sat, 5 Jan 2002 00:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287514AbSAEFG0>; Sat, 5 Jan 2002 00:06:26 -0500
Received: from holomorphy.com ([216.36.33.161]:10435 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S287513AbSAEFGY>;
	Sat, 5 Jan 2002 00:06:24 -0500
Date: Fri, 4 Jan 2002 21:06:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com, mjc@kernel.org, bcrl@redhat.com, akpm@zip.com.au,
        phillips@bonn-fries.net
Subject: Re: hashed waitqueues
Message-ID: <20020104210611.C10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
	bcrl@redhat.com, akpm@zip.com.au, phillips@bonn-fries.net
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com> <E16Mgoj-0001Ew-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E16Mgoj-0001Ew-00@starship.berlin>; from phillips@bonn-fries.net on Sat, Jan 05, 2002 at 03:44:06AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 02:39 am, William Lee Irwin III wrote:
>> 2 or 3 shift/adds is really not possible, the population counts of the
>> primes in those ranges tends to be high, much to my chagrin.

On Sat, Jan 05, 2002 at 03:44:06AM +0100, Daniel Phillips wrote:
> It doesn't really have to be a prime, being relatively prime is also 
> good, i.e., not too many or too small factors.  Surely there's a multiplier 
> in the right range with just two prime factors that can be computed with 3 
> shift-adds.

Trying to keep the factors even will probably be difficult, if you were
going to sieve for it you'd probably want to try sieving with various
polynomials something like the quadratic sieving factorization methods,
in order to start from a list of candidates with sparse bit patterns.
Or one can just iterate and filter by population counts...

On Sat, Jan 05, 2002 at 03:44:06AM +0100, Daniel Phillips wrote:
> Right, it's not worth it unless you can get it down to a handful of 
> shift-adds.  How does 2**17 - 1 (Mersenne prime #6) with right-shift by
> (16 - bits) work?

I haven't started benchmarking different hash functions yet. Also
interesting would be Fermat prime #4. The ratio phi falls in the
range 4/7 < theta < 2/3, so perhaps to be sparse a slight overestimate
like a prime in the range 0xA0000000 < p < 0xA7FFFFFF might be good.
I did a little sieving for numbers in those ranges coprime to the small
prime factors up to 29, and I found the natural numbers in this range
with a population count strictly less than 5 are:

$ factor `./prime`
2483027969: 2483027969
2684354593: 43 61 1023391
2684355073: 101 139 367 521
2684362753: 2684362753
2684485633: 2684485633
2717908993: 2717908993

of these, 2684362753/2^32 differs by a mere 0.69679% from phi, and
so appears to be the most promising. It has a population count of
precisely 4. Among the numbers >= 0xA0000000, there was a consistent
pattern of the hexadecimal digits, which was interesting. It is
unfortunate, though, that among those primes there are none with
population counts less than 4.

The continued fraction expansion of 2684362753/2^32 appears to be:
0, 1, 1, 1, 2, 8190, 1, 1, 1, 2, ... which has the disturbing
sixth term, where on the other hand, theta is better for the seemingly
further away ones:
2483027969/2^32: 0, 1, 1, 2, 1, 2, 3, 1048575, 1, 2
2684485633/2^32: 0, 1, 1, 1, 2, 511, 1, 1, 1, 1
2717908993/2^32: 0, 1, 1, 1, 2, 1, 1, 1, 1, 1

So in the continued fraction representation, 2717908993/2^32 is the
closest to phi (though I am concerned about the term 262143 further out),
and so 2717908993 is probably the best bet. I'll try these out and see
if there is a significant difference in computational expense or key
distribution.


Cheers,
Bill
