Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTEBNMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 09:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTEBNMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 09:12:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63249 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262883AbTEBNMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 09:12:18 -0400
Date: Fri, 2 May 2003 15:24:06 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: dphillips@sistina.com, hugang <hugang@soulinfo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030502132406.GB1803@alpha.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030502001050.GA25789@alpha.home.local> <200305020243.15248.dphillips@sistina.com> <200305020347.42682.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305020347.42682.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 03:47:37AM +0200, Thomas Schlichter wrote:
 
> That is what I posted in my first message in this thread... The shift 
> algorithm only works fine for uniform distributed input values... But here is 
> a version that behaves better for small values, too. I don't think it will 
> reach the tree version but it should be much better that the old version!

I also tried to change your version into this, and at least it's not slower,
so it's good anyway, considering the small code size.

> If this is the case the tree version will surely be the best!
> 
> But I think this topic is not worth any further work as this is not used very 
> often... So this version will be my last one!

I agree. Just for the record, I'll post two other original implementations
which are not intersting for their real-life performance, but may be
interesting to reuse in other projects or in cheap hardware implementations,
or as a base for other algos. One of the downsides is that they need many
registers. They both are about twice as slow as the tree on athlon, alpha and
sparc.

The first one uses no jump at all if the CPU can do CMOV. It's about twice as
slow as tree, but may be a win on machines with a big jump cost. And since
there's no jump, its execution time is constant :

unsigned fls32_1(unsigned n)
{
    /* this code is totally jumpless on architectures that support CMOV,
       and can execute up to 4 instructions per cycle. However, it uses
       lots of instructions and registers and is not as fast as it should be.
       It's about 20 cycles on a dual-pipeline CPU.
    */
    register unsigned x = n, bits = 0, bits2, a, b;
        
    a = x & 0xffff0000;
    bits2 = bits + 16;

    b = x & 0xff00ff00;
    if (x & a) { bits = bits2;}
    if (x & a) { x &= a;}

    bits2 = bits + 8;
    a = x & 0xf0f0f0f0;

    if (x & b) { bits = bits2;}
    if (x & b) { x &= b;}

    bits2 = bits + 4;
    b = x & 0xcccccccc;

    if (x & a) { bits = bits2;}
    if (x & a) { x &= a;}

    bits2 = bits + 2;
    a = x & 0xaaaaaaaa;

    if (x & b) { bits = bits2;}

    if (x & b) { x &= b;}
    bits2 = bits + 1;

    if (x & a) { bits = bits2;}
    if (x & a) { x &= a;}

    if (x) { bits += 1; }

    return bits;
}

The second one has a radically different approach. It converges int 5 shifts.
However, each iteration has a non neglileable cost, and its time is nearly
constant too. The code is rather small (about 70 bytes), but it needs a CPU
which can shift and jump fast to be efficient. It consumes about the same
time as above.

unsigned fls32_2(unsigned n)
{
    register unsigned t = 16, r = 0;
    register unsigned m = 0xffff0000;

    // it only needs 5 iterations to complete, and some
    // instructions can be executed in parallel. It's
    // more efficient than the pure shift on small values.
    // But it needs many registers :-(
    if (n) {
        while (t) {
            if (n & m) {
                n >>= t;
                r += t;
                t >>= 1;
                m >>= t;
            } else {
                n <<= t;
                t >>= 1;
                m <<= t ? t : 1;
            }
        }
        return  r + 1;
    }
    else
        return n;
}


These were my last versions, and not particularly performant ones ;-)

Regards,
Willy

