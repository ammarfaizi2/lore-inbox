Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156183-17480>; Sun, 9 May 1999 07:07:08 -0400
Received: by vger.rutgers.edu id <156160-17480>; Sun, 9 May 1999 07:06:19 -0400
Received: from p3E9D19DF.dip.t-online.de ([62.157.25.223]:1154 "EHLO kaili.steiner.local" ident: "root") by vger.rutgers.edu with ESMTP id <156154-17483>; Sun, 9 May 1999 07:05:54 -0400
Date: Sun, 9 May 1999 13:46:04 +0200
From: Peter Steiner <p.steiner@t-online.de>
Message-Id: <199905091146.NAA01844@kaili.steiner.local>
To: linux-kernel@vger.rutgers.edu
Cc: andrea@e-mind.com
Subject: Re: Hash functions (was Re: 2.2.6_andrea2.bz2)
In-Reply-To: <Pine.LNX.4.05.9905070349030.577-100000@laser.random>
Sender: owner-linux-kernel@vger.rutgers.edu

>BTW: 2**32*(sqrt(5)-1)/2 is 2654435770 and not 2654425957UL that you are
>using in your hashfn. So were does 2654425957UL came from?

2654425957UL was an early multiplier (40499 * 65543). Kind of quick way
to get an almost prime near the golden ratio. Later it changed to
2654435761 which is a real prime (read Chucks page, section "A Little
Theory" for more information).

The golden ratio isn't really necessary. Instead of using the 'correct'
shift value:

   (hash * 0x9E3779B1) >> (32 - HASH_BITS)

he uses a general:

  (hash * 0x9E3779B1) >> SHIFT

where SHIFT can be (32 - HASH_BITS) but may be varied.

- --

Why using (32 - HASH_BITS) is 'correct' (in theory):

The golden ratio method uses no integer multiplier but an irrational
one (m), with  m = (sqrt(5) - 1) / 2 = 0.618033988

Calculation of the hash index goes

  h: hash table size
  i: index into the hash table
  x: position in the hash buffer x = [0;1)
  i: index into the hash table
  k: hash key

  x = frac(m * k)
  i = int(x * h)

Doing that in integer an integer representation of m is needed. However
there obviously is no integer representation for an irrational number,
so it has to be rounded.

  X: integer representation of x
  M: integer representation of m

For 32 bit systems:

  M = m * 2^32 = 2654435770

Getting X is easy since 'fract' is automatically done by overflowing
the range of an integer:

  X = M * k

To get i:

  i = int( x * h )
    = int( X * h / 2^32 )

using h = 2^HASH_BITS:

  i = int( X * 2^HASH_BITS / 2^32 )
    = int( X / 2^(32 - HASH_BITS) )
    = X >> (32 - HASH_BITS)

So we get:

  i = (M * k) >> (32 - HASH_BITS)

- --

At this point it should be clear, why M doesn't need to be a prime. It
represents a number between 0 and 1 which obviously never is a prime at
all.

However, according to Chuck's benchmarks SHIFT = (32 - HASH_BITS) does
not necessarily give the best results. It's often better to to use a
SHIFT smaller than (32 - HASH_BITS).

I really don't understand why. For example the hashfn for SHIFT=11
(best SHIFT for the buffer cache) could be written as ('normalized'):

 i = (hash * 0x1BBCD880 ) >> (32 - HASH_BITS)

This is not even near the golden ratio nor in one of Knuth's
recommended intervals...

Peter
-- 
   _   x    ___
  / \_/_\_ /,--'  p.steiner@t-online.de (Peter Steiner)
  \/>'~~~~//
    \_____/   signature V0.2 alpha

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
