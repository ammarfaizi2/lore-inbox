Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263569AbUJ2Uwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbUJ2Uwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbUJ2Uuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:50:54 -0400
Received: from janus.foobazco.org ([198.144.194.226]:65190 "EHLO
	mail.foobazco.org") by vger.kernel.org with ESMTP id S263520AbUJ2U3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:29:21 -0400
Date: Fri, 29 Oct 2004 13:29:12 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: SPARC argument passing bug in sd.c
Message-ID: <20041029202912.GA29267@foobazco.org>
References: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:22:11PM +0100, Mark Fortescue wrote:

> e) To get around incorrect compilation (or a bug in printk) of %llu
> parameters to printk in sd.c. (I use %lu with unsigned long ards instead).

If this is what I looked at about 6 months ago, it's a compiler bug
probably specific to 32-bit SPARC.  The problem occurs if there are
enough arguments that the stack has to be used to pass some of them
(so more than 6 32-bit quantities), and the 6th argument was the first
half of a long long.  So a function with a prototype like:

void foo(int, int, int, int, int, long long);

would be affected, while:

void foo(int, int, int, int, int, int, long long);

and

void foo(long long, long long, long long, int, int);

were ok.

It looks like my 3.4.3-pre gcc now generates:

0000000000000000 <foo>:
   0:   9d e3 bf 90     save  %sp, -112, %sp
   4:   fa 27 a0 58     st  %i5, [ %fp + 0x58 ]
   8:   11 00 00 00     sethi  %hi(0), %o0
                        8: R_SPARC_HI22 .rodata
   c:   b0 06 00 19     add  %i0, %i1, %i0
  10:   90 12 20 00     mov  %o0, %o0
                        10: R_SPARC_LO10        .rodata
  14:   d2 07 a0 58     ld  [ %fp + 0x58 ], %o1
  18:   d4 07 a0 5c     ld  [ %fp + 0x5c ], %o2
  1c:   40 00 00 00     call  1c <foo+0x1c>
                        1c: R_SPARC_WDISP30     printf
  20:   b0 06 00 1a     add  %i0, %i2, %i0
  24:   b0 06 00 1b     add  %i0, %i3, %i0
  28:   b0 06 00 1c     add  %i0, %i4, %i0
  2c:   c2 07 a0 60     ld  [ %fp + 0x60 ], %g1
  30:   81 c7 e0 08     ret 
  34:   91 ee 00 01     restore  %i0, %g1, %o0

0000000000000038 <main>:
  38:   9d e3 bf 88     save  %sp, -120, %sp
  3c:   1b 3f bb 7e     sethi  %hi(0xfeedf800), %o5
  40:   9a 13 62 ce     or  %o5, 0x2ce, %o5     ! feedface <main+0xfeedfa96>
  44:   da 23 a0 5c     st  %o5, [ %sp + 0x5c ]
  48:   82 10 20 08     mov  8, %g1
  4c:   1b 37 ab 6f     sethi  %hi(0xdeadbc00), %o5
  50:   c2 23 a0 60     st  %g1, [ %sp + 0x60 ]
  54:   9a 13 62 ef     or  %o5, 0x2ef, %o5	! deadbeef
  58:   90 10 20 00     clr  %o0
  5c:   92 10 20 01     mov  1, %o1
  60:   94 10 20 02     mov  2, %o2
  64:   96 10 20 03     mov  3, %o3
  68:   40 00 00 00     call  68 <main+0x30>
                        68: R_SPARC_WDISP30     foo
  6c:   98 10 20 04     mov  4, %o4
  70:   81 c7 e0 08     ret 
  74:   91 e8 00 08     restore  %g0, %o0, %o0

for

#include <stdio.h>

int foo(int, int, int, int, int, unsigned long long, int);

int
main(int argc, char *argv[])
{
        return (foo(0, 1, 2, 3, 4, 0xdeadbeeffeedfaceULL, 8));
}

int
foo(int a, int b, int c, int d, int e, unsigned long long f, int g)
{
        printf("ull: %llx\n", f);
        return (a + b + c + d + e + g);
}

when compiled with -m32 -O2.  This code is correct, and moreover,
SunPro generates nearly identical code (and more importantly an
identical argument layout, with the high half in %o5 and the low half
at %sp + 0x5c as seen by the caller):

0000000000000000 <main>:
   0:   9d e3 bf 98     save  %sp, -104, %sp
   4:   3b 37 ab 6f     sethi  %hi(0xdeadbc00), %i5
   8:   b6 10 20 08     mov  8, %i3
   c:   f6 23 a0 60     st  %i3, [ %sp + 0x60 ]
  10:   9a 07 62 ef     add  %i5, 0x2ef, %o5
  14:   3b 3f bb 7e     sethi  %hi(0xfeedf800), %i5
  18:   ba 07 62 ce     add  %i5, 0x2ce, %i5    ! feedface <foo+0xfeedfa8e>
  1c:   fa 23 a0 5c     st  %i5, [ %sp + 0x5c ]
  20:   90 10 20 00     clr  %o0
  24:   92 10 20 01     mov  1, %o1
  28:   94 10 20 02     mov  2, %o2
  2c:   96 10 20 03     mov  3, %o3
  30:   40 00 00 00     call  30 <main+0x30>
                        30: R_SPARC_WDISP30     foo
  34:   98 10 20 04     mov  4, %o4
  38:   81 c7 e0 08     ret 
  3c:   91 e8 00 08     restore  %g0, %o0, %o0

0000000000000040 <foo>:
  40:   9d e3 bf a0     save  %sp, -96, %sp
  44:   fa 27 a0 58     st  %i5, [ %fp + 0x58 ]
  48:   92 10 00 1d     mov  %i5, %o1
  4c:   3b 00 00 00     sethi  %hi(0), %i5
                        4c: R_SPARC_HI22        .rodata1
  50:   d4 07 a0 5c     ld  [ %fp + 0x5c ], %o2
  54:   40 00 00 00     call  54 <foo+0x14>
                        54: R_SPARC_WDISP30     printf
  58:   90 07 60 00     add  %i5, 0, %o0
                        58: R_SPARC_LO10        .rodata1
  5c:   ba 06 00 19     add  %i0, %i1, %i5
  60:   ea 07 a0 60     ld  [ %fp + 0x60 ], %l5
  64:   ae 07 40 1a     add  %i5, %i2, %l7
  68:   ac 05 c0 1b     add  %l7, %i3, %l6
  6c:   a8 05 80 1c     add  %l6, %i4, %l4
  70:   81 c7 e0 08     ret 
  74:   91 ed 00 15     restore  %l4, %l5, %o0

You might try compiling sd.c with 3.4.3 and comparing the generated
assembly with what you get from your usual compiler, referencing the
calling convention shown above.  The particular compiler I use is
configured for Solaris, but I'd be very surprised if the convention
were different when configured for Linux.  Even if it is, the crucial
thing is for the caller and callee to agree on where argument f is
located in the above example.  When I last looked at the sd.c
assembly, they did not.

Changing the type to unsigned long is not the right solution.  If gcc
is severely defective in this area, pass two unsigned longs and put
them back together yourself in the callee.  Of course it's really
better just to fix the compiler.

-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
