Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTBKTqf>; Tue, 11 Feb 2003 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBKTqf>; Tue, 11 Feb 2003 14:46:35 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:61316 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265250AbTBKTqc>; Tue, 11 Feb 2003 14:46:32 -0500
Subject: Re: Is -fno-strict-aliasing still needed?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: ahaas@airmail.net, brand@jupiter.cs.uni-dortmund.de,
       helgehaf@aitel.hist.no
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Feb 2003 14:52:33 -0500
Message-Id: <1044993153.3133.517.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting various people:

> The problem with strict aliasing is that it allows
> the compiler to assume that in:
> 
>      void somefunc(int *foo, int *bar)
> 
> foo and bar will _*never*_ point to the same memory area

Nope, because foo and bar are compatible types.
These are compatible:

int*, unsigned*, const signed int *, register int*, etc.

For a pointer to an integer type, it pretty much boils
down to "compatible ones are the same size on an Alpha".
There is a special exception for (char*) though, and
a poorly-documented "restrict" keyword to let the compiler
know when aliasing (pointing to the same memory) won't happen.

Here are some examples:

#define restrict __restrict__    // or do "gcc -std=c99"
int fn(int *foo, int *bar);          // may alias
int fn(int *foo, int *restrict bar);  // may NOT alias
int fn(int *foo, long *bar);        // may NOT alias
int fn(int *foo, char *bar);      // may alias (char exception)
int fn(int *foo, char *restrict bar); // restrict w/ (char*) ?
int fn(int *restrict foo, char *bar); // restrict w/ (char*) ?
// New gcc feature, due to Linus complaining:
typedef unsigned long __attribute__((__may_alias__)) ula;
int fn(int *foo, ula *bar);    // may alias

The big problem is testing. Lots of people assume that,
as long as alignment is satisfied, it is safe to cast
from one pointer type to another for accessing data.
This is not true. The half-legit solution to put both
pointers into a union, but that can get ugly. So some
determined person must go add __may_alias__ all over the
kernel, not missing any spot where it may be needed.

>> This is wrong.  Only if they are declared restrict.
>
> ... can they point to the same area.

You have that exactly backwards. With restrict, they
MAY NOT point to the same area. With (char*) they MAY.
Otherwise, it's a question of compatible types.

> That is exactly the problem: If you do nothing, the
> language definition assumes the programmer made sure
> (LOL!) that they don't point the same way. That's why
> the flag is needed in the first place, as nobody
> writes "restrict" all over the place.

I do. (http://procps.sf.net/) Ulrich Drepper does. (glibc)

You should see the description of how "restrict" can
interact with scope. Magic smoke may leak out of your brain.
IMHO the "restrict" keyword was really botched.

If you really want to get fancy, alter the language
to suit your desires:

-fargument-alias
-fargument-noalias 
-fargument-noalias-global

> I got biten by that when the optimizations (and the flag)
> were introduced into gcc (egcs branch perhaps?).

Me too, casting (double*) to (short*) to examine bits.
Now I don't do that. It's not legal in the C language.

-------
Grrr... why isn't Evolution good for editing code?


