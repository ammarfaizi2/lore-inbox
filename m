Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272288AbRHXSRH>; Fri, 24 Aug 2001 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272290AbRHXSQ6>; Fri, 24 Aug 2001 14:16:58 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:35058 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S272288AbRHXSQr>; Fri, 24 Aug 2001 14:16:47 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Tim Walberg <twalberg@mindspring.com>,
        "J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <2606707256.998677533@[10.132.112.53]> <14764.998658214@redhat.com> <6242.998674456@redhat.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 24 Aug 2001 14:12:35 -0400
In-Reply-To: David Woodhouse's message of "Fri, 24 Aug 2001 18:34:16 +0100"
Message-ID: <m24rqxfht8.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

> printf ("%d %d\n", min(foo, 10), min (bar, 20)); }

 David> Well, ideally both of them would BUG() and the user would have
 David> to explicitly cast one (or both) of the arguments so the types
 David> match. But as Keith pointed out, it won't work.

Why would both BUG? 20 is a signed integer and bar _could be_ a signed
char.  This is fine.  As a matter of fact, both constants are positive
and fit in the range so I don't really think this is a bug in either
case.  I guess the constants should be written as 10U and 20U.  There
are other problems as the code without a specifically type char will
have bugs on the ARM (and others with different sign default).  I
don't think that the casting handles this well either.

I did a little more beautification.  Gcc does warn if you compare a
pointer to an integral type.  Do you need more?  The bug_paste macro
would pollute the name-space, but it is nice to see where things go
wrong.

fwiw,
Bill Pringlemeir.

[test.c]
#define bug_paste_chain(a,b) a##b
#define bug_paste(a) bug_paste_chain(BUG_AT_LINE_,a)
#define min(x,y)                                       \
                                                       \
  ({extern void bug_paste(__LINE__) (void);            \
    typeof(x) _x = 0; typeof(y) _y = 0;                \
    if ((_x-1>0 && _y-1<0) || (_x-1<0 && _y-1>0))      \
            bug_paste(__LINE__)();                     \
        _x = (x), _y = (y); (_x>_y)?_y:_x;             \
   }) 

#include <stdio.h>
int main(int argc, char *argv[])
{
      signed char  cx = 1, cy = 2;
      signed short sx = 1, sy = 2;
      signed int   ix = 1, iy = 2;
      signed long  lx = 1, ly = 2;
    unsigned char  Cx = 1, Cy = 2;
    unsigned short Sx = 1, Sy = 2;
    unsigned int   Ix = 1, Iy = 2;
    unsigned long  Lx = 1, Ly = 2;

    cx = min(cx,cy);    Cx = min(Cy,Cx);    sx = min(sx,sy);
    Sx = min(Sx,Sy);    ix = min(iy,ix);    Ix = min(Iy,Ix);
    lx = min(ly,ly);    Lx = min(Lx,Ly);

    /* No warning. */
/*  Lx = (typeof(Lx))min(Lx,&Ly); */

    printf("%d %d %hd %hd %d %d %ld %ld\n", cx, Cx,
           sx,Sx,ix,Ix,lx,Lx);

    cx = -1;    Cx = 0;
    cx = min(cx,cy);    sx = min(cx,sy);
    ix = min(cx,ix);    lx = min(cx,ly);
    Cx = min(Cx,Cx);    Sx = min(Cx,Sy);
    Ix = min(Ly,Ix);    Lx = min(Ix,Ly);

    /* correctly gives warning! Promotion to int before compare. */
/*  Ix = min(Cy,Ix);    Lx = min(Cx,Ly); */

    printf("%d %d %hd %hd %d %d %ld %ld\n", cx, Cx,
           sx,Sx,ix,Ix,lx,Lx);
    
/* BUG? printf ("%d\n", min(Iy, 10)); */
    printf ("%d\n", min(cx, 20));

    return 0;
}


