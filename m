Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156430-17480>; Sun, 9 May 1999 16:52:03 -0400
Received: by vger.rutgers.edu id <156404-17483>; Sun, 9 May 1999 16:50:18 -0400
Received: from pC19F0127.dip.t-online.de ([193.159.1.39]:1060 "EHLO kaili.steiner.local" ident: "root") by vger.rutgers.edu with ESMTP id <156066-17483>; Sun, 9 May 1999 16:47:03 -0400
Date: Sun, 9 May 1999 23:26:57 +0200
From: Peter Steiner <p.steiner@t-online.de>
Message-Id: <199905092126.XAA01906@kaili.steiner.local>
To: Andrea Arcangeli <andrea@e-mind.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Hash functions (was Re: 2.2.6_andrea2.bz2)
In-Reply-To: <Pine.LNX.4.05.9905091555170.333-100000@laser.random>
Sender: owner-linux-kernel@vger.rutgers.edu

>>I really don't understand why. For example the hashfn for SHIFT=11
>>(best SHIFT for the buffer cache) could be written as ('normalized'):
>>
>> i = (hash * 0x1BBCD880 ) >> (32 - HASH_BITS)
>>
>>This is not even near the golden ratio nor in one of Knuth's
>>recommended intervals...

Andrea, may I reorder your questions?

>And what is `hash'? The input of the hashfn of buffers are blocks and dev.

Chuck tuned various hash functions, and only the buffer cache uses
blocks and dev. hash is a generic substitution. In my description I
used 'k' up to this point.

>I don't follow you in this last point. Where does 0x1BBCD880 came from?

Oh yes, I see. I missed an important step here.

The hash function for the buffer cache Chuck suggests is:

#define _hashfn(dev,block) ((((block) * 2654435761UL) >> SHIFT) &bh_hash_mask)

with SHIFT = 11. That's a really good _hashfn even for various hash
table sizes, but if we want to analyse this function we must set
SHIFT = (32 - HASH_BITS) and adjust the multiplier accordingly.

Since my hash table size is 16384 and thus (32 - HASH_BITS) = 18 the
'normalized' hashfn is:

  i = ((k * 2654435761UL) >> 11) & bh_hash_mask
    = ((k * 2654435761UL) << ((32 - HASH_BITS) - 11)) >> (32 - HASH_BITS)
    = (k * (2654435761UL << (18 - 11))) >> (32 - HASH_BITS)

  i = (k * 465361024UL) >> (32 - HASH_BITS) 

or:

#define _hashfn(dev,block) ( ((block) * 0x1BBCD880 ) >> (32 - HASH_BITS) )

So instead of using the golden ratio we set M=465361024 (m=0.108350306).
Using exactly the golden ratio can have some disadvantages and Knuth
gives some hints how to find better m. However, I'd never expect a
multiplier that way off to be that good.

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
