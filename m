Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTD3HHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 03:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTD3HHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 03:07:00 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2320 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262106AbTD3HG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 03:06:56 -0400
Date: Wed, 30 Apr 2003 09:19:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Daniel Phillips <dphillips@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030430071907.GA30999@alpha.home.local>
References: <200304300446.24330.dphillips@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304300446.24330.dphillips@sistina.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 30, 2003 at 04:46:23AM +0200, Daniel Phillips wrote:
> Here's a faster implementation of generic_fls, that I discovered accidently,
> by not noticing 2.5 already had a generic_fls, and so I rolled my own.  Like
> the incumbent, it's O log2(bits), but there's not a lot of resemblance beyond
> that.  I think the new algorithm is inherently more parallelizable than the
> traditional approach.  A processor that can speculatively evaluate both sides 
> of a conditional would benefit even more than the PIII I tested on.

I did some tests on an Athlon MP2200 (1.8 GHz) and a Pentium 4/2.0 GHz, with
both gcc 2.95.3 and gcc 3.2.3.

The results are interesting, because they show that the compiler used is far
more important than the code ! To resume quickly, your code is faster than the
old one on an athlon, gcc-2.95.2 -O3, and in any combination of gcc-3.2.3.
On a P4, new code compiled with 3.2.3 is still slower than old code with 2.95.3.

But gcc's optimizer seems to be even worse with each new version. The NIL
checksum takes 3 times more to complete on gcc3/athlon than gcc2/athlon !!!
And on some test, the P4 goes faster when the code is optimized for athlon than
for P4 !

Oh, and the new2 function is another variant I have been using by the past, but
it is slower here. It performed well on older machines with gcc 2.7.2. Its main
problem may be the code size, due to the 32 bits masks. Your code has the
advantage of being short and working on small data sets.

#define new2_fls32(___a) ({ \
    register int ___x, ___bits = 0; \
    if (___a) { \
        ___x = (___a); \
        ++___bits; \
        if (___x & 0xffff0000) { ___x &= 0xffff0000; ___bits += 16;} \
        if (___x & 0xff00ff00) { ___x &= 0xff00ff00; ___bits +=  8;} \
        if (___x & 0xf0f0f0f0) { ___x &= 0xf0f0f0f0; ___bits +=  4;} \
        if (___x & 0xcccccccc) { ___x &= 0xcccccccc; ___bits +=  2;} \
        if (___x & 0xaaaaaaaa) { ___x &= 0xaaaaaaaa; ___bits +=  1;} \
    } \
    ___bits; \
    })



Here are the results.

Cheers,
Willy

===== gcc-2.95.3 -march=i686 -O2 / athlon MP/2200 (1.8 GHz) =====

4294967295 iterations of nil... checksum = 4294967295

real    0m4.778s
user    0m4.770s
sys     0m0.010s
4294967295 iterations of old... checksum = 4294967265

real    0m37.923s
user    0m37.920s
sys     0m0.000s
4294967295 iterations of new... checksum = 4294967265

real    0m47.956s
user    0m47.920s
sys     0m0.030s
4294967295 iterations of new2... checksum = 4294967295

real    0m43.884s
user    0m43.860s
sys     0m0.020s


===== gcc-2.95.3 -march=i686 -O3 / athlon MP/2200 =====

4294967295 iterations of nil... checksum = 4294967295

real    0m4.779s
user    0m4.770s
sys     0m0.010s
4294967295 iterations of old... checksum = 4294967265

real    0m39.235s
user    0m39.180s
sys     0m0.050s
4294967295 iterations of new... checksum = 4294967265

real    0m32.175s
user    0m32.170s
sys     0m0.000s
4294967295 iterations of new2... checksum = 4294967295

real    0m37.560s
user    0m37.520s
sys     0m0.020s

===== gcc-2.95.3 -march=i686 -O3 / Pentium4 2.0 GHz =====

4294967295 iterations of nil... checksum = 4294967295

real    0m4.370s
user    0m4.370s
sys     0m0.000s
4294967295 iterations of old... checksum = 4294967265

real    0m22.148s
user    0m22.150s
sys     0m0.000s
4294967295 iterations of new... checksum = 4294967265

real    0m25.854s
user    0m25.850s
sys     0m0.000s
4294967295 iterations of new2... checksum = 4294967295

real    0m30.743s
user    0m28.930s
sys     0m0.160s


==== gcc 3.2.3 -march=i686 -O3 / Pentium 4 / 2.0 GHz ====

4294967295 iterations of nil... checksum = 4294967295

real    0m6.719s
user    0m6.710s
sys     0m0.000s
4294967295 iterations of old... checksum = 4294967265

real    0m45.571s
user    0m43.510s
sys     0m0.180s
4294967295 iterations of new... checksum = 4294967265

real    0m28.251s
user    0m26.420s
sys     0m0.010s
4294967295 iterations of new2... checksum = 4294967265

real    0m48.881s
user    0m47.080s
sys     0m0.000s
-> awful, 60% more time than with gcc-2.95.3 !

==== gcc 3.2.3 -march=pentium4 -O3 / Pentium 4 / 2.0 GHz ====
(yes, gcc 3.2 may be producing better code... for the eyes, not
for the CPU)

4294967295 iterations of nil... checksum = 4294967295

real    0m4.422s
user    0m4.420s
sys     0m0.000s
4294967295 iterations of old... checksum = 4294967265

real    0m34.950s
user    0m34.950s
sys     0m0.000s
4294967295 iterations of new... checksum = 4294967265

real    0m27.667s
user    0m25.810s
sys     0m0.000s
4294967295 iterations of new2... checksum = 4294967295

real    0m42.945s
user    0m42.760s
sys     0m0.160s

==== gcc 3.2.3 -march=athlon-mp -O3 / Pentium 4 / 2.0 GHz ====

4294967295 iterations of nil... checksum = 4294967295

real    0m6.486s
user    0m6.490s
sys     0m0.000s
4294967295 iterations of old... checksum = 4294967265

real    0m41.240s
user    0m39.220s
sys     0m0.160s
4294967295 iterations of new... checksum = 4294967265

real    0m25.780s
user    0m25.780s
sys     0m0.000s
4294967295 iterations of new2... checksum = 4294967295

real    0m51.789s
user    0m49.750s
sys     0m0.010s

==== gcc 3.2.3 -march=athlon-mp -O3 / Athlon MP2200 / 1.8 GHz ====

4294967295 iterations of nil... checksum = 4294967295

real    0m14.544s
user    0m14.540s
sys     0m0.000s
4294967295 iterations of old... checksum = 4294967265

real    0m44.609s
user    0m44.600s
sys     0m0.000s
4294967295 iterations of new... checksum = 4294967265

real    0m26.765s
user    0m26.760s
sys     0m0.000s
4294967295 iterations of new2... checksum = 4294967295

real    1m6.066s
user    1m6.030s
sys     0m0.030s

==== gcc 3.2.3 -march=pentium4 -O3 / Athlon MP2200 / 1.8 GHz ====

4294967295 iterations of nil... checksum = 4294967295

real    0m10.775s
user    0m10.750s
sys     0m0.030s
4294967295 iterations of old... checksum = 4294967265

real    0m45.837s
user    0m45.830s
sys     0m0.000s
4294967295 iterations of new... checksum = 4294967265

real    0m24.414s
user    0m24.410s
sys     0m0.010s
4294967295 iterations of new2... checksum = 4294967295

real    1m7.299s
user    1m7.280s
sys     0m0.010s


==== gcc 3.2.3 -march=i686 -O3 / Athlon MP2200 / 1.8 GHz ====

4294967295 iterations of nil... checksum = 4294967295

real    0m13.010s
user    0m13.000s
sys     0m0.010s


