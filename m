Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbRGUUV6>; Sat, 21 Jul 2001 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbRGUUVs>; Sat, 21 Jul 2001 16:21:48 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21000 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267805AbRGUUVh>; Sat, 21 Jul 2001 16:21:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: Common hash table implementation
Date: Sat, 21 Jul 2001 22:25:51 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01071815464209.12129@starship> <3B58CBA3.BD2C194@compaq.com>
In-Reply-To: <3B58CBA3.BD2C194@compaq.com>
MIME-Version: 1.0
Message-Id: <01072122255100.02679@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 21 July 2001 02:24, Brian J. Watson wrote:
> Daniel Phillips wrote:
> > On Wednesday 18 July 2001 03:34, Larry McVoy wrote:
> > > We've got a fairly nice hash table interface in BitKeeper that
> > > we'd be happy to provide under the GPL.  I've always thought it
> > > would be cool to have it in the kernel, we use it everywhere.
> > >
> > > http://bitmover.com:8888//home/bk/bugfixes/src/src/mdbm
>
> Thanks, Larry. Your hashing functions are much more sophisticated
> than the simple modulo operator I've been using for hashing by inode
> number.

Yes, I tested almost all of them to see how well they worked my
directory index application.  There are really only two criterea:

  1) How random is the hash
  2) How efficient is it

My testing was hardly what you would call rigorous.  Basically, what I 
do is hash a lot of very unrandom strings and see how uniform the 
resulting hash bucket distribution is.  The *only* function from 
Larry's set that did well on the randomness side is the linear 
congruential hash - it did nearly as well as my dx_hack_hash.

Surprisingly, at least to me, the CRC32 turned in an extremely variable 
performance.  With a small number of buckets (say 100) it did ok, but 
with a larger numbers it showed a very lumpy distribution.  Yes, this 
is way too imprecise a way of describing what happened and I should 
take a closer look at it.  I don't have the mathematical background to 
be really sure about this, but I suspect CRC32 isn't optimized at all 
for randomness - it's optimized for detecting bit errors and has good 
properties with respect to neighbouring bits, properties that are no 
use at all to a randomizing funciton.  Anyway, I wasn't all that 
unhappy to see CRC32 turn in a poor performance for two reasons: a) the 
1K xor table would represent a 25% increase of the indexing code and b) 
hashing through the table eats an extra 1K of precious L1 cache.

The linear congruential hash from Larry's set and my dx_hack_hash share 
a common characteristic: they both munge each character against a 
pseudorandom sequence.  In Larry's hash it's a linear congruential 
sequence, and in my case it's a feedback shift register.  In addition,
I use a multiply to spread the effect of each character over a broader 
range of bits.

Larry's hash doesn't do this and you can see right away that strings 
that vary only in the last character aren't going to be distributed 
very randomly.  It might work a little better with the hashing step 
spelled this way:

-	((h) = 0x63c63cd9*(h) + 0x9c39c33d + (c))
+	((h) = 0x63c63cd9*(h + (c)) + 0x9c39c33d)

I haven't tried this, but I will.

There are people out there who know a lot more about analyzing hash 
functions than I do, and I have their names somewhere in my mailbox.  
I'll go look them up soon and submit for proper testing the whole batch 
of functions that have been suggested to me over the last few months.  
By the way, in case you haven't already deduced this, this stuff is 
really time consuming.

[...]
> Richard Guenther sent the following link to his own common hashing
> code, which makes nice use of pseudo-templates:
>
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/~checkout~/glame/glame
>/src/include/hash.h?rev=1.5&content-type=text/plain
>
> A few things I would consider changing are:
>
>   - ditching the pprev pointer

Yes, you want to use the generic list macros there.

>   - encapsulating the next pointer inside a struct hash_head_##FOOBAR

I think the generic list macros give you that for free.

>   - stripping out the hard-coded hashing function, and allowing the
>     user to provide their own

Naturally.  And trying to reduce the size of the macros.  It's not that 
easy to get stuff that has dozens of lines ending with "\" into the 
kernel.  You might have better luck just generalizing a few short sets 
of common operations used in hashes, and showing examples of how you'd 
use them to rewrite some of the existing hash code.  Obviously, the 
new, improved approach has to be no less efficient than the current way 
of doing things.

> All the backslashes offend my aesthetic sensibility, but the
> preprocessor provides no alternative. ;)

It's hard to argue against using inlines there.  It's true that there 
are a lot of generalizations you just can't do with inlines, but so 
what?  What matters is how efficient the generated code is and to a 
lesser extent, how readable the source is.  You could make that source 
quite a bit more readable with a few *small* macros and some inline 
functions.  Suggestion: express the bucket probe as an inline, compute 
the hash outside and pass it in.  Then you can wrap the whole thing up 
in a really short macro.

--
Daniel
