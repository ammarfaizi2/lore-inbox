Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRH1FC3>; Tue, 28 Aug 2001 01:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270258AbRH1FCU>; Tue, 28 Aug 2001 01:02:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270257AbRH1FCG>; Tue, 28 Aug 2001 01:02:06 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Tue, 28 Aug 2001 04:59:41 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9mf8ft$7pt$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu> <E15b9rU-0002vE-00@localhost>
X-Trace: palladium.transmeta.com 998974928 1273 127.0.0.1 (28 Aug 2001 05:02:08 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 28 Aug 2001 05:02:08 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15b9rU-0002vE-00@localhost>,
Rusty Russell  <rusty@rustcorp.com.au> wrote:
>In message <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu> you wri
>te:
>> _THAT_ _IS_ _WRONG_.  Who the fuck said that we always want type of _first_
>> argument?  Mind you, IMNSHO Dave had been on a seriously bad trip when he
>> had added that "type" argument - separate names would be cleaner.  And yes,
>> it'd be better in prepatch instead of 2.4.9-final.
>
>We're going in circles.  Linus requested that the explicit type arg be
>added.

Yes. "requested" is a bit too politic.

It was not davem who added the type argument.  It was me who _required_
that min/max be very much explicitly type-aware, as I consider any other
alternative to be inherently buggy. 

Yes, the new Linux min/max macros are different from the ones people are
used to.  Yes, I expected a lot of flamage.  And no, I don't care one
whit.  Unlike EVERY SINGLE other C version of min/max I've ever seen,
the new Linux kernel versions at least have a fighting chance in hell of
generating correct code.  And that's to a large degree because they
force the user to specify what type he _thinks_ the comparison should be
done in. 

I know people don't understand about the difference between signed and
unsigned compares, and people may not even realize that just by doing
the patches David ended up fixing a few real bugs that were uncovered
simply by virtue of having to think about what kind of comparison it was
supposed to be. 

There were a few alternatives that we looked at (or rather, David
implemented, and I ended up rejecting due to various reasons), but they
all boiled down to "how do we sanely generate min/max functions while at
the same time forcing people to understand the types in question".  Some
of the intermediate patches had the type in the macro name, ie things
like "min_uint()" and "min_slong()".  The final version (ie the one in
2.4.9) was deemed to be the most flexible. 

The problem with putting the "type" in the name of the function/macro
is/was that

 - there's a _lot_ of types. David actually had a version for this, and
   there were separate versions for everything ranging from "int" to
   "uint", to "s32" to "u32", to "size_t" etc etc.

 - Some people would _still_ not understand what the advantage of
   explicit typing would be, so we'd have drivers doing their own
   min/max functions, not understanding the issues about signs and C
   type conversion. 

Thus the current "min(type,x,y)" approach, which fixes both problems.

I have one thing to say to people who do not like the new min/max
functions: most of them probably never even _understood_ the multitude
of bugs that are inherent in the classical

	#define min(x,y) ((x) < (y) ? (x) : (y))

but even so I'm somewhat surprised that this is still debated.  I hoped
it would be over by the time I came back ;)

		Linus
