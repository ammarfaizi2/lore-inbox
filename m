Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313902AbSDZWK2>; Fri, 26 Apr 2002 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSDZWK1>; Fri, 26 Apr 2002 18:10:27 -0400
Received: from sendmail.avnet.com ([12.9.139.96]:14864 "EHLO pilsner.avnet.com")
	by vger.kernel.org with ESMTP id <S313902AbSDZWK0>;
	Fri, 26 Apr 2002 18:10:26 -0400
Message-ID: <C08678384BE7D311B4D70004ACA371050B7633F3@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: FPU, i386
Date: Fri, 26 Apr 2002 15:10:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an error here which shouldn't be propagated:

	if (fabs(a-b) < 1.0e-38)
		...

"Machine epsilon" for doubles (namely, the difference between 1.0 and
the next largest number) is on the order of 2e-16.  This is a rough
estimate of the granularity of round-off error; and in fact 1.0 / 0.2
and 5.0 can't possibly be as close as 1.0e-38, unless they're exactly
equal.

There are four epsilon-ish things to be aware of:

*	Difference between 0.0 and next float  above: ~= 1.4e-45
*	Difference between 0.0 and next double above: ~= 4.9e-324
*	Difference between 1.0 and next float  above: ~= 1.2e-7
*	Difference between 1.0 and next double above: ~= 2.2e-16

The first two are more useful for things like detecting underflow; the
last two (some numerical folks suggest using their square roots) are
more useful for implementing an "approximately equals".

----------------------------------------------------------------

The poster was incorrect in expecting 1.0 / 0.2 to be exactly equal to
anything, as was explained to him.  But the problem doesn't have to do
with whether a number is transcendental, or irrational, or rational:
the number must be rational *and* must have a mantissa whose
denominator is a power of two *and* that power of two must be less than
or equal to 23 (for single) or 52 (for double).  And of course 1/5 is
2^-3 * 8/5, of which the mantissa has denominator 5, which isn't a power
of two.

So we all should know not to expect floating-point numbers to be
exactly equal to anything; that's been established.  However, another
more basic question was not answered; curiosity (if nothing else)
demands an answer.  Namely, it's OK to say we can't expect 1.0/0.2 ==
5.0.  But why is the result of (what is apparently) the same
computation *sometimes* the same, and *sometimes* different? That's the
question.

And I think it's fair for the poster to want to know why.

If you disassemble the sample program, you'll see that without
optimization, 1.0 is divided by 0.2 at *run* time, and compared with
5.0; with optimization, the division is done, and the "<" and
"==" comparisons are done, at *compile* time.  OK, but: If we're not
cross-compiling (most people don't), then the compiler creating a.out
is running on perhaps the same box as a.out is!  Why does gcc, folding
the constant in the optimized a.out, get a different answer for 1.0/0.2
than the unoptimized a.out gets for 1.0/0.2?

Not only that, without optimization:

	if (1/h < 5.0)
		...

gives a different answer inside a.out than

	x = 1/h;
	if (x < 5.0)
		...

The key is that Pentiums (Pentia?) have 80-bit floating-point numbers
in the FPU.  Without optimization, at compile time, gcc represents 5.0
as 0x4014000000000000.  0.2 is 0x3fc999999999999a.  These are both
64-bit doubles -- 1 sign bit, 11 exponent bits, & 52 explicit mantissa
bits (and 1 implicit leading mantissa bit, not stored in memory.)

In the case "if (1/h < 5.0)", at run time, 1.0 is loaded into the FPU
using fld1; then "fdivl {address of 0.2 in memory}".  The result is the
*80-bit* number 0x40019ffffffffffffd80.  The 64-bit number 5.0
(0x4014000000000000) is loaded into the FPU to become the 80-bit number
0x4001a000000000000000.  Then, these two 80-bit numbers are compared in
the FPU; they're of course not the same.

What's different in the case "x = 1/h; if (x < 5.0) ..." is that both
80-bit numbers are stored from the FPU to memory as 64-bit (rounding
off the mantissa bits which differ), at which point they're both
0x4014000000000000, then loaded *back* into the FPU where they're
both 0x4001a000000000000000.

This isn't an FPU bug, by any stretch of the imagination, nor is it a
compiler bug.  But it's a subtle difference between the Pentium's FPU
and other FPUs, of which it may occasionally be useful to be aware.




-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Thursday, April 25, 2002 7:23 AM
To: rpm
Cc: Jesse Pollard; Nikita@Namesys.COM; Andrey Ulanov;
linux-kernel@vger.kernel.org
Subject: Re: FPU, i386


On Thu, 25 Apr 2002, rpm wrote:

> On Wednesday 17 April 2002 08:10 pm, Jesse Pollard wrote:
> > ---------  Received message begins Here  ---------
> >
> 
> > if (int(1/h * 100) == int(5.0 * 100))
> >
> > will give a "proper" result within two decimal places. This is still
> > limited since there are irrational numbers within that range that COULD
> > still come out with a wrong answer, but is much less likely to occur.
> >
> > Exact match of floating point is not possible - 1/h is eleveated to a
> > float.
> >
> > If your 1/h was actually num/h, and num computed by summing .01 100
times
> > I suspect the result would also be "wrong".
> >
> 
> why is exact match of floating point not possible ?

Because many (read most) numbers are not exactly representable
in floating-point. The purpose of floating-point it to represent
real numbers with a large dynamic range. The trade-off is that
few such internal representations are exact.

As a simple example, 0.33333333333.....  can't be represented exactly
even with paper-and-pencil. However, as the ratio of two integers
it can be represented exactly, i.e., 1/3 . Both 1 and 3 must
be integers to represent this ratio exactly.

All real numbers (except trancendentials) can represented exactly
as the ratio of two integers but floating-point uses only one
value, not two integers, to represent the value. So, an exact
representation of a real number, when using a single variable
in a general-purpose way, is, for all practical purposes, not
possible. Instead, we get very close.

When it comes to '==' close is not equal. There are macros in
<math.h> that can be used for most floating-point logic. You
should check them out. If we wanted to check for '==' we really
need to do something like this:

    double a, b;
    some_loop() {
       if(fabs(a-b) < 1.0e-38)
           break;
     }
Where we get the absolute value of the difference between two
FP variables and compare against some very small number.

To use the math macros, the comparison should be something like:

        if (isless(fabs(a-b), 1.0e-38))
             break;


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
