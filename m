Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEARcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTEARcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:32:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45584 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261780AbTEARcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:32:05 -0400
Date: Thu, 1 May 2003 19:16:27 +0200
From: Willy TARREAU <willy@w.ods.org>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, dphillips@sistina.com
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501171627.GA1785@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030430135512.6519eb53.akpm@digeo.com> <20030501130318.459a4776.hugang@soulinfo.com> <20030430221129.11595e2e.akpm@digeo.com> <20030501133307.158c7e10.hugang@soulinfo.com> <20030501150557.6dc913f7.hugang@soulinfo.com> <20030501135204.GC308@pcw.home.local> <20030501225321.6b30e8dc.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501225321.6b30e8dc.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 10:53:21PM +0800, hugang wrote:
 
> Here is test in my machine, The faster is still table.

because, as Falk said, the tests are incremental and the branch prediction
works very well. I proposed a simple scrambling function based on bswap. Please
consider this function :

      f(i) = i ^ htonl(i) ^ htonl(i<<7)

It returns such values :

0x00000001 => 0x81000001
0x00000002 => 0x02010002
0x00000003 => 0x83010003
0x00000004 => 0x04020004
0x00000005 => 0x85020005
0x00000006 => 0x06030006
0x00000007 => 0x87030007
0x00000008 => 0x08040008
0x00000009 => 0x89040009
0x0000000a => 0x0a05000a
0x0000000b => 0x8b05000b

etc...

As you see, high bits move fast enough to shot a predictor.

The tree function as well as Daniel's "new" resist better to non linear suites.
BTW, the latest changes I did show that the convergence should be between
Daniel's function and mine, because there are common concepts. I noticed that
the expression used in Daniel's function is too complex for gcc to optimize it
well enough. In my case, gcc 3.2.3 coded too many jumps instead of conditional
moves. I saw that playing with -mbranch-cost changes the code. A mix between
the two is used here (and listed after). It's still not optimial, reading the
code, because there's always one useless jump and move. But in the worst case,
it gives exactly the same result as Daniel's. But in other cases, it is even
slightly faster. Honnestly, now it's just a matter of taste. Daniel's easier to
read, mine produces smaller code. This time, it's faster than others Athlon,
Alpha and Sparc. I Don't know about the PentiumIII nor the P4.

Here are the results on Athlon, gcc-3.2.3, then Alpha and Sparc.

Willy

====

4294967295 iterations of bswap/nil... checksum = 4294967295

real    0m53.133s
user    0m53.114s
sys     0m0.005s

4294967295 iterations of bswap/fls_table... checksum = 4294967262

real    1m44.686s
user    1m44.163s
sys     0m0.487s

4294967295 iterations of bswap/new... checksum = 4294967262

real    1m16.463s
user    1m16.144s
sys     0m0.314s

4294967295 iterations of bswap/fls_tree... checksum = 4294967262

real    1m16.511s
user    1m16.169s
sys     0m0.296s

== alpha 466 MHz , gcc-3.2.3
   gcc -O3 -o testfls -fomit-frame-pointer -mcpu=ev67 ===

4294967295 iterations of bswap/fls_tree... checksum = 4294967262

real    4m14.432s
user    4m13.540s
sys     0m0.038s

4294967295 iterations of bswap/fls_table... checksum = 4294967262

real    4m36.204s
user    4m35.368s
sys     0m0.030s

== ultra-sparc 333 MHz, gcc 3.1.1 (linear only)
   gcc -O3 -mcpu=v9 -fomit-frame-pointer ===

4294967295 iterations of fls_tree... checksum = 4294967265

real    1m52.680s
user    1m52.640s
sys     0m0.010s

4294967295 iterations of fls_table... checksum = 4294967265

real    3m24.514s
user    3m24.430s
sys     0m0.010s

======= here is the function :

unsigned fls_tree_fls(unsigned n) {
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
		return t + 3 + (n>>3);
	else
	    if (n < (1<<6))
		return t + 5 + (n>>5);
	    else
		return t + 7 + (n>>7);
    else
	if (n < (1<<12))
	    if (n < (1<<10))
		return t + 9 + (n>>9);
	    else
		return t + 11 + (n>>11);
	else
	    if (n < (1<<14))
		return t + 13 + (n>>13);
	    else
		return t + 15 + (n>>15);
}

