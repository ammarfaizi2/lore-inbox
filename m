Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTD3UrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTD3UrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:47:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:8208 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262400AbTD3UrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:47:09 -0400
Date: Wed, 30 Apr 2003 22:59:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Daniel Phillips <dphillips@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030430205921.GB7356@alpha.home.local>
References: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com> <200304302115.33424.dphillips@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304302115.33424.dphillips@sistina.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 09:15:33PM +0200, Daniel Phillips wrote:
 
> In the dawn of time, before God gave us Cache, my version would have been the 
> fastest, because it executes the fewest instructions.  In the misty future, 
> as cache continues to scale and processors sprout more parallel execution 
> units, it will be clearly better once again.

Daniel,

I must acknowledge that your simple code was not easy to beat ! You can try this
one on your PIII, I could only test it on an athlon mobile and a P4. With gcc 2.95.3,
it gives me a boost of about 25%, because it seems as gcc cannot optimize shifts
efficiently. On 3.2.3, however, it's between 0 and 5% depending on optimization/CPU.

But the code is a lot smaller (about 105 bytes total for the function). I could also
code a version with parallel execution of several branches, but it was slower,
because every branch not taken was computed for nothing, and the glue around it had
a cost. I tried to implement it with as many booleans as possible so that the compiler
can try to emit conditionnal instructions and make use of carries. I did operations
on an unsigned char because it has some advantages, such as 0x80 being negative ;-)

I also let the other tests in, so that you can try them if you want. Looking through
the generated code, it's clear that an assembler version would be faster. Not much,
but a bit.

Cheers,
Willy

static inline
unsigned new2_fls32(unsigned n32)
{
        unsigned t = 0;
        unsigned char n;

        if (n32 >> 16) {
                n32 >>= 16;
                t = 16;
        }

        n = n32;
        if (n32 >> 8) {
                n = (unsigned char)(n32 >> 8);
                t += 8;
        }
#if 0
        else
                if (!n) return t;
        // this one uses comparisons and jumps, but is short and fast
        return (n < 0x10) ?
                t + ((n < 0x04) ?  2 - (n < 0x02) : 4 - (n < 0x08)) :
                t + ((n < 0x40) ?  6 - (n < 0x20) : 8 - (n < 0x80)) ;
#endif
#if 0
        // this one compiles into several parallel branches, but is slower
        if (n < 0x10) {
                return t += (n < 0x04) ?  n - ((n + 1) >> 2) : 4 - (n < 8);
        } else {
                return t += (n < 0x40) ?  6 - (n < 0x20) : 8 - (n < 0x80) ;
        }
#endif
#if 0
        // the same as above
        return t += (n < 0x10) ? (n < 0x04) ?  n - ((n + 1) >> 2) : 4 - (n < 8) :
                        (n < 0x40) ?  6 - (n < 0x20) : 8 - (n < 0x80) ;
#endif
#if 1
        // this one uses comparisons and jumps, but is short and the fastest
        return (n < 0x10) ?
                (n < 0x04) ?  n + t - ((n + 1) >> 2) : 4 + t - (n < 8) :
                (n < 0x40) ?  6 + t - (n < 0x20) : 8 + t - (n < 0x80) ;
#endif
}

