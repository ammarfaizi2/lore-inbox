Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSDYQGt>; Thu, 25 Apr 2002 12:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSDYQGs>; Thu, 25 Apr 2002 12:06:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38528 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313299AbSDYQGq>; Thu, 25 Apr 2002 12:06:46 -0400
Date: Thu, 25 Apr 2002 12:08:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: rpm <rajendra.mishra@timesys.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Nikita@Namesys.COM,
        Andrey Ulanov <drey@rt.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <20020425112435.A16346@mark.mielke.cc>
Message-ID: <Pine.LNX.3.95.1020425114416.10329A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002, Mark Mielke wrote:

> On Thu, Apr 25, 2002 at 10:22:49AM -0400, Richard B. Johnson wrote:
> > To use the math macros, the comparison should be something like:
> >         if (isless(fabs(a-b), 1.0e-38))
> >              break;
> 
> I might be saying something stupid, but, I was under the impression
> that floating point '==', assuming it follows IEEE rules, does exactly
> this.
> 

A floating-point '==' tests for the two oprands to be exact. The
only time they will be exact is:

   float a, b;
   a = b = 10.000;

  At this instant a = b and (a==b) will return TRUE.
  However, if by previous math, you expected a to equal 10.0, by
  doing:

  a = b = 10.00

  a += 12345.678;
  a -= 12345.678;

  Now, 'a' is not equal to 'b' if the 'C' compiler actually performed
  the indicated operations (the compiler may obtimize them away).

  In this case (a==b) will return FALSE because they are not equal.

Script started on Thu Apr 25 11:52:46 2002

# cat >xxx.c
#include <stdio.h>
#include <math.h>

int main()
{
    double a, b;
    a = b = 10.0;

    printf("%d\n", (a==b));
    a += 10.234567890;
    printf("%d\n", (a==b));
    a -= 10.234567890;
    printf("%d\n", (a==b));
    return 0;

}

# gcc -o xxx xxx.c
# ./xxx
1
0
0
# exit
exit

Script done on Thu Apr 25 11:53:10 2002

So, as you can see, when first initialized with the same value,
regardless of how inaccurately in can be represented, it does
show equality.

However, as soon as I muck with it, add, then subtract the same
number, it will no longer be egual.

This is why you NEVER use '==' when dealing with floating-point
numbers. The use of '==' in floating-point operations is a bug.
'C' allows you to write buggy code. It will probably call
a floating-point compare routine in the FPU (fcom, fcomp, fcompp)
which will promptly return the 'not-equal' in C1 and the CPU flags.

'C' will even allow you to use floating-point numbers in loops, i.e.,

     while(a--)
       do_something_forever();

Just because it's allowed, it doesn't mean that it's not a bug.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

