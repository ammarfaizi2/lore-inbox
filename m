Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbTDHJES (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbTDHJES (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:04:18 -0400
Received: from cs.rice.edu ([128.42.1.30]:26780 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S262701AbTDHJEE (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:04:04 -0400
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Better hash functions (was Re: Route cache performance under stress)
References: <oydznn1okqh.fsf@bert.cs.rice.edu>
	<20030408050145.GA16516@alpha.home.local>
	<oydvfxpo71x.fsf@bert.cs.rice.edu>
	<20030408075950.GA18222@alpha.home.local>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 08 Apr 2003 04:15:06 -0500
In-Reply-To: <20030408075950.GA18222@alpha.home.local>
Message-ID: <oydn0j1nyed.fsf_-_@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-DCC--Metrics: cs.rice.edu 1067; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 09:59:50 +0200, Willy Tarreau <willy@w.ods.org> writes:

> > > I wouldn't consider a hash that ignores certain bits. In my case, reduce(x)
> > > uses all bits, so I really have saddr=0xAAAAAAAA daddr=0xBBBBBBBB
> > 
> > Its not the hash that ignores the bits. Its the function that maps
> > from hash values to buckets that may ignore bits. For instance:
> > 
> >      bucket = hash(string) & ((1<<table.order)-1)
> 
> Hmmm I must be missing something. In my case, my reduce() function returns a
> hash that is never higher than the bucket size, so I basically have :
> 
>        bucket = hash(string, table.order)

As stated, I was assuming that you masked off the lowest 12 bits and
used that for the bucket number. This is typical in most code; if your
function doesn't do that, you should have said so.

So in that case if order=12, bucket is constant for any XXXXX, YYYYY;
it is only a function of AAA, BBB. This gives complete flexibility to
choose XXXXX and YYYYY to create collisions.

> inadequate processors can take a bit more than one cycle per bit for
> the multiply, and sometimes 2 or 3 cycles for the divide. So, on 32
> bits, we would have between 150 and 200 cycles just for this
> part. Since this operation may be done at several places during the
> packet processing, sometimes on smaller bits sets, it might grow to
> about one thousand cycles. This may not seem enourmous, but might
> count for a few percent during packet processing. In fact, when I
> generate 148000 pkts/s on a PIII/533, this gives me 3600 cycles per
> packet. So several hundreds to nearly a thousand may count.

And the cost of a an attacker creating 10,000 collisions is what? :)

On a P2 benchmark system, hashing one byte at a time this approach
with 64 bit multiplies and 32-bit modulation operation is just as fast
as Perl's shift-based hash function.

> > It Doesn't matter how it behaves in the typical case, its the worst
> > case that I can and WILL exploit.
> 
> I think we don't speak the same language :-) My empirical check
> gives me nearly the same distribution as the xor.  I tried to find
> something which doesn't have a PREDICTABLE worst case (thus the
> introduction of the random), while still behaving correctly for

My point is that the introduction of the random doesn't alter the
predictability of it. I can still force bucket collisions in at least
one way, without knowing RND1, RND2. Randomness isn't a magic fix
unless correctly used.

> average case.  My first goal is clearly to avoid the worst case as
> much as possible. I don't pretend that the worst case doesn't exist,
> because I cannot demonstrate that, and that would be obviously
> absurd, since there's no limitation. But I say that, not knowning

You can make the randomized expected worst case be O(1). Right now
with a predictable function, the worst case is O(n). With your flawed
hash function, the worst case is O(n). With a good hash function, the
randomized expected worst case is O(1). 

My function, oops. Using h(x) = jx (mod P), and hash(saddr,daddr) =
h(saddr) + h(daddr) has an algebraic structure that makes it
unacceptable. My mistake. But one can find an appropriate function. :)

[[Another likely mistake deleted]]

> the initial random, you will not exploit it. That's the whole
> point. Try to find a generic attack against this part of code, where
> 0x12345678 is a random number. Perhaps you can, but I couldn't.

Actually, this is relatively strightforward to break.

Now, lets assume that hashsize=12.

let addr1 = 0xXXXXX0AA
let addr2 = 0xXXXXX0BB

XXXXX may be anything, AA, BB, are fixed and arbitrarily chosen.

Now, if the random number has at least one one-bit in position:
  0x-----*--  (which has probability 15/16)

Then, $0x12345678-addr1$ and $0x12345678-addr2$ will be identical in
the top 20 bits.

Thus, 
   foo = ((0x12345678 - addr2) ^ (0x12345678 - addr1))


foo will be zero in the top 20 bits. It will be some unknown, but
constant value in the low 12 bits. Furthermore, (addr1+addr2) has its
lowest 12 bits fixed, but the upper 20 bits are completely
controllable to any choice. The calculation from hash value to bucket
restricts my flexibility by 12 bits, but I can still forge 256
collision. (Or 4096 collisions if I make AA and BB 4 bits, or 16k
collisions if AA, BB are 2 bits.)

Thus, foo ^ (addr1+addr2) will be a  value for any arbitrary
XXXXX. Here come a million collisions. :)

Some might remark that this isn't interesting; I require that both
addr1 and addr2 have the same prefix. Not an issue. I can swap the low
order and high order positions and repeat the attack. IE:

   addr1 = 0xAA0XXXXX
   addr2 = 0xBB0XXXXX

and assume that the random value has at least one one bit in 0x--*-----

I suspect that a stronger attack is possible, but I'm rusty. The flaw
with both of your hash functions is that the bucket is a linear
function of the bits in the individual terms: (0x12345678 - addr2),
(0x12345678 - addr1), (addr1 + addr2). All I have to do is to choose
my inputs carefully to cause these terms to cancel each other out.

> 
>     addr1 = ((0x12345678 - addr2) ^ (0x12345678 - addr1)) ^ (addr1 + addr2);
>     while (addr1 >= (1 << hashsize)) {
>         addr1 = (addr1 >> hashsize) ^ (addr1 & ((1 << hashsize) - 1));
>     }
>     bucket = addr1;

Trust me. Find a good universal hash function in the literature and
use it. I don't know about you, but inventing my own is beyond my
skill. I already tried it once, in my earlier message, and made a
mistake; I've already elided out two others I was about to make in
this message.


Scott

CC'ed back to linux kernel to convince others not to invent their own
hash functions either.
