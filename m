Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270263AbRH1FyJ>; Tue, 28 Aug 2001 01:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRH1FyA>; Tue, 28 Aug 2001 01:54:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10770 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270263AbRH1Fxn>; Tue, 28 Aug 2001 01:53:43 -0400
Date: Mon, 27 Aug 2001 22:51:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.GSO.4.21.0108280107180.1663-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0108272231290.8067-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, Alexander Viro wrote:
>
> > The problem with putting the "type" in the name of the function/macro
> > is/was that
> >
> >  - there's a _lot_ of types. David actually had a version for this, and
> >    there were separate versions for everything ranging from "int" to
> >    "uint", to "s32" to "u32", to "size_t" etc etc.
>
> Ugh. I have a serious feeling that most of them would be redundant, but...
> OK, I guess that somebody might want "unsigned max of x and y % 256" (x
> being unsigned char and y - unsigned long).

It doesn't matter if the two things are of a different type - there is
always just one type that the comparison is done in, anyway (and returning
any other type doesn't make any sense to me, at least).

And yes, they _are_ redundant in the sense that "size_t" is obviously the
same as "unsigned int" or "unsigned long" on just about all architectures:
but we obviously don't know that on a source level, so you do end up
needing various different versions.

You could, of course, just always do the type expansion, and really boil
it all down to just "large enough" types, the obvious ones being "unsigned
long" and "signed long". However, that implies either depending on a smart
compiler or accepting an extra type expansion in the resulting binary, and
it also wouldn't work on 64-bit quantities (which NTFS actually _does_
use, for example), so you'd still have to have at least

 - umin()/umax()/smin()/smax() - for "long" and shorter
 - u64min()/u64max()/s64min()s64max() - for "long long" and "u64/s64"

to make sure that the min/max operations do not truncate any bits. Even
so, I'd really want to make sure it gets truncated down too - I'd be
nervous about doing "umax()" on two "char" entities: it's MUCH more clear
what you get from

	x = max(unsigned char, char, char)

than if you have signed chars that are expanded to unsigned long's and
then compared (the compare gets the same result, but how is the final
result of "min()" then expanded, if at all?). It gets worse if one of the
sides is unsigned and the other signed, at which point the "extend to a
larger type" approach doesn't work at all.

In short, I really think you want to have the exact types. And a quick
grep of the 2.4.9 diff shows that at least for "min()" we have at least
the following types already being used: "int" "long" "s64" "u32" "unsigned
int" "unsigned long".

So that's at _least_ 6 different versions of "min()" if you want to make
them different functions.

Or, with the 2.4.9 approach, it's just a single macro (well, and another
one for "max()"). And when somebody needs a new type, he doesn't have to
worry about creating a new instantiation of the macro.

		Linus

