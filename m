Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTHKENQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270927AbTHKENQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:13:16 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:48041 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270882AbTHKENI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:13:08 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Albert Cahalan <albert@users.sf.net>
To: Chip Salzenberg <chip@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Willy Tarreau <willy@w.ods.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
In-Reply-To: <20030811023912.GJ24349@perlsupport.com>
References: <1060488233.780.65.camel@cube>
	 <20030810072945.GA14038@alpha.home.local>
	 <20030811012337.GI24349@perlsupport.com>
	 <20030811020957.GE10446@mail.jlokier.co.uk>
	 <20030811023912.GJ24349@perlsupport.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060574558.949.207.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Aug 2003 00:02:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-10 at 22:39, Chip Salzenberg wrote:
> According to Jamie Lokier:
> > Chip Salzenberg wrote:
> > > According to Willy Tarreau:
> > > >   likely => __builtin_expect(!(x), 0)
> > > > unlikely => __builtin_expect((x), 0)
> > > 
> > > Well, I'm not sure about the polarity, but that unlikely() macro isn't
> > > good -- it the same old problem that first prompted my message, namely
> > > that it's nonportable when (x) has a pointer type.
> > 
> > It's portable as long as the compiler is GCC :)
> 
> No; wrong; please pay attention.
> 
> Both parameters of __builtin_expect() are long ints.

They are, so you must do something to convert
pointers into integers.

>   On an
> architecture where there's a pointer type larger than long[1],

Linux will absolutely not work in this case.
(No way, never, no can do, end of story, & give up now)

When you port to Win64 and MS-DOS "huge" model,
you can consider this problem.

You do realize that __builtin_expect() is a
non-portable gcc extension, don't you?

> __builtin_expect() won't just warn, it'll *fail*.  Also, on an
> architecture where a conversion of a null pointer to long results in
> a non-zero value[2], it'll *fail*.

I once worked on an OS for such a machine.
We used the word-addressed SHARC DSP with a
hacked-up gcc to allow for byte pointers.
Casting was a nightmare. Once again:

Linux will absolutely not work in this case.
(No way, never, no can do, end of story, & give up now)

> That makes it non-portable twice
> over.  Wouldn't you agree?
> 
> Allow me to quote gcc's documentation:
> 
>    Since you are limited to integral expressions for exp, you should use constructions such as
> 
>         if (__builtin_expect (ptr != NULL, 1))
>           error ();
> 
>    when testing pointer or floating-point values.
> 
> Could you please believe the docs?

No, because NULL could be "(void*)0". This would
make the unlikely() macro fail for integers!
Change that NULL to a 0 and it might be OK though.

The procps code works great:

#define likely(x)       __builtin_expect(!!(x),1)
#define unlikely(x)     __builtin_expect(!!(x),0)

The goal is to turn any pointer or integer type
into a plain 0 or 1, so that the input can match
the constants provided in the macro. We like the
double "!" for ease of use.

The ?: operator could be used, but !! is a nice
idiom for booleanizing a value.

At this point, I might as well post my rules for
semi-portable code. News flash: Linux isn't completely
portable, and we don't care! In theory, theory and
practice are the same, but in practice they are not.
(whereupon Larry McVoy will flame me I'm sure)
Some of you may remember this from June 2000; it's
been patched a bit to cut down on confusion.

--------------- the rules -----------------

In anticipation of flames, I have the damn 1999 ISO C draft.
I know full well that a "legal" compiler can put 42 chars of
padding after everything and, just for fun, make every type
be 101 bits wide.

Moderately portable code assumes a sane compiler and sane hardware.
You may assume:

1. The "char" type is 8 bits. It might be unsigned though. :-/
2. sizeof(short) == 2
3. sizeof(int) == 4      (for real Linux, not the 8088 hack)
4. sizeof(long) == sizeof(void *)
5. (sizeof(long) == 4) | (sizeof(long) == 8)
6. sizeof(long long) == 8       (good for 10 years at least)
7. You can freely cast between any two pointer types [note #1]
8. You can freely cast between long and any pointer type
9. (long)(int*)(long)foo == (long)(char*)(int*)(long)foo
10. signed integers are represented in two's complement form
11. all integers wrap around instead of causing faults
12. assuming "good" struct layout, padding only occurs at the end
13. ... that padding won't happen if you supply a multiple of 16 bytes
14. The binary representation of NULL is all zero bits
15. The hardware is either big-endian or little-endian.
16. Assignment to "int", "long" or a pointer is atomic

Note #1: I only said you could do the cast. That is,
you won't get an exception during the cast. You should
still satisfy alignment requirements... although Linux
supposedly has exception handlers to hide the problem
in kernel code. You'll also need to be aware of type
aliasing, unless the cast involves (char*) or you specify
-fno-strict-aliasing as the kernel build system does.

One can define "good" struct layout as being an order that puts
items with the largest natural alignments first. For example, an
array of 6 shorts has a natural alignment of 4 bytes. I suppose
you could define natural alignment as gcd(16,sizeof(foo)).

I used to work with a system that violates rule 9.
>From experience, I assure you that it is a mess to deal with.
Casting gets really nasty. There is no hope of porting Linux
to this system.

Compiler wish list:

1. -Wstruct-padding    warn if compiler added padding
2. __bag__             like a struct, but the compiler chooses order

(and no, -Wpadded isn't good; padding at the end of a
struct or added with __attribute__ should only cause a
warning when sizeof is used, if even then, and the compiler
shouldn't spew warnings about its own built-in structures)
--------------------------------------------------------


