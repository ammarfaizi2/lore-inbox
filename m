Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbTEANmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTEANmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:42:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15376 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261266AbTEANmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:42:24 -0400
Date: Thu, 1 May 2003 15:52:04 +0200
From: Willy TARREAU <willy@w.ods.org>
To: hugang <hugang@soulinfo.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501135204.GC308@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030430135512.6519eb53.akpm@digeo.com> <20030501130318.459a4776.hugang@soulinfo.com> <20030430221129.11595e2e.akpm@digeo.com> <20030501133307.158c7e10.hugang@soulinfo.com> <20030501150557.6dc913f7.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501150557.6dc913f7.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 03:05:57PM +0800, hugang wrote:
> Hello
> 
> Here is the table version of fls. Before version of it is wrong.

Ok, I recoded the tree myself with if/else, and it's now faster than all others,
whatever the compiler. I have cut the tree to only 16 bits evaluations because
it was still faster than a full 32 bits tree on x86, probably because of the
code length. However, on Alpha EV6 (gcc-2.95.3), the 32 bits tree is faster.
The 32 bits code is also the same speed as the 16 bits on gcc-3.2.3 if I
specify -mbranch-cost=2 (because gcc assumes that today's CPUs need one cycle
per jump).

Here is the function, followed by the logs executed on an Athlon.

Disclaimer: Daniel's PentiumIII seems to give very different results than my
Athlon, so every test should be considered for one arch only !!!

To quickly resume the results, on gcc-3.2.3 it's 45% faster than the table algo,
I don't understand why, and just a little bit faster than Daniel's function.

On gcc-2.95.3, it's only 20% faster than the table, but 46% than Daniel's.

However, I have good news for you, the table code is 15% faster than my tree
on an Alpha EV6 ;-)
It may be because gcc can use different tricks on this arch.

Cheers
Willy

static inline int fls_tree_fls(unsigned n) {
#ifndef REALLY_WANT_A_32BITS_TREE
    /* it seems as if working on half a tree is faster than the
       complete tree.
    */
    register t = 0;
    if (n >= (1<<16)) {
	n >>= 16;
	t = 16;
    }
    if (n < (1<<8))
	if (n < (1<<4))
	    if (n < 4)
		return t + n - ((n + 1) >> 2);
	    else
		return t + 3 + (n >= 8);
	else
	    if (n < (1<<6))
		return t + 5 + (n >= (1<<5));
	    else
		return t + 7 + (n >= (1<<7));
    else
	if (n < (1<<12))
	    if (n < (1<<10))
		return t + 9 + (n >= (1<<9));
	    else
		return t + 11 + (n >= (1<<11));
	else
	    if (n < (1<<14))
		return t + 13 + (n >= (1<<13));
	    else
		return t + 15 + (n >= (1<<15));
#else
    /* perhaps this is faster on systems with BIG caches, but on
       athlon, at least, it's slower than the previous one
    */
    if (n < (1<<16))
	if (n < (1<<8))
	    if (n < (1<<4))
		if (n < 4)
		    return n - ((n + 1) >> 2);
		else
		    return 3 + (n >= 8);
	    else
		if (n < (1<<6))
		    return 5 + (n >= (1<<5));
		else
		    return 7 + (n >= (1<<7));
	else
	    if (n < (1<<12))
		if (n < (1<<10))
		    return 9 + (n >= (1<<9));
		else
		    return 11 + (n >= (1<<11));
	    else
		if (n < (1<<14))
		    return 13 + (n >= (1<<13));
		else
		    return 15 + (n >= (1<<15));
    else
	if (n < (1<<24))
	    if (n < (1<<20))
		if (n < (1<<18))
		    return 17 + (n >= (1<<17));
		else
		    return 19 + (n >= (1<<19));
	    else
		if (n < (1<<22))
		    return 21 + (n >= (1<<21));
		else
		    return 23 + (n >= (1<<23));
	else
	    if (n < (1<<28))
		if (n < (1<<26))
		    return 25 + (n >= (1<<25));
		else
		    return 27 + (n >= (1<<27));
	    else
		if (n < (1<<30))
		    return 29 + (n >= (1<<29));
		else
		    return 31 + (n >= (1<<31));
#endif
}

== results on Athlon 1800+ (1.53 GHz), gcc-2.95.3 -O3 -march=i686 :

4294967295 iterations of nil... checksum = 4294967295

real    0m5.600s
user    0m5.590s
sys     0m0.007s
4294967295 iterations of old... checksum = 4294967265

real    0m39.640s
user    0m39.499s
sys     0m0.141s
4294967295 iterations of new... checksum = 4294967265

real    0m45.088s
user    0m44.936s
sys     0m0.158s
4294967295 iterations of fls_table... checksum = 4294967264

real    0m35.988s
user    0m35.833s
sys     0m0.159s
4294967295 iterations of fls_tree... checksum = 4294967265

real    0m28.699s
user    0m28.605s
sys     0m0.096s

== results on Athlon 1800+ (1.53 GHz), gcc-3.2.3 -O3 -march=athlon :

4294967295 iterations of nil... checksum = 4294967295

real    0m16.624s
user    0m16.624s
sys     0m0.001s
4294967295 iterations of old... checksum = 4294967265

real    0m57.685s
user    0m57.568s
sys     0m0.125s
4294967295 iterations of new... checksum = 4294967265

real    0m37.513s
user    0m37.415s
sys     0m0.103s
4294967295 iterations of fls_table... checksum = 4294967264

real    0m56.068s
user    0m55.991s
sys     0m0.085s
4294967295 iterations of fls_tree... 
checksum = 4294967265

real    0m36.636s
user    0m36.516s
sys     0m0.125s

=== alpha EV6 / 466 Mhz, gcc-2.95.3 -O3 ====
4294967295 iterations of new... checksum = 4294967265

real    2m19.951s
user    2m19.543s
sys     0m0.018s
4294967295 iterations of fls_table... checksum = 4294967265

real    1m12.825s
user    1m12.667s
sys     0m0.005s
4294967295 iterations of fls_tree... checksum = 4294967265

real    1m33.469s
user    1m33.242s
sys     0m0.013s

