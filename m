Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTEAKKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEAKKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:10:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11280 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261195AbTEAKKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:10:53 -0400
Date: Thu, 1 May 2003 12:22:30 +0200
From: Willy TARREAU <willy@w.ods.org>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501102230.GA308@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030430135512.6519eb53.akpm@digeo.com> <20030501131605.02066260.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501131605.02066260.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 01:16:05PM +0800, hugang wrote:

> Here is table version of the fls. Yes it fast than other.

Sorry, but this code returns wrong results. Test it with less
iterations, it doesn't return the same result.

>         unsigned i = 0;
> 
>         do {
>                 i++;
>         } while (n <= fls_table[i].max && n > fls_table[i].min);

You never even compare with table[0] !

> --test log is here----

I recoded a table based on your idea, and it's clearly faster than others, and
even faster than yours :

============
static unsigned tbl[33] = { 2147483648, 1073741824, 536870912, 268435456,
			    134217728, 67108864, 33554432, 16777216,
			    8388608, 4194304, 2097152, 1048576,
			    524288, 262144, 131072, 65536,
			    32768, 16384, 8192, 4096,
			    2048, 1024, 512, 256,
			    128, 64, 32, 16,
			    8, 4, 2, 1, 0 };


static inline int fls_tbl_fls(unsigned n)
{
        unsigned i = 0;

	while (n < tbl[i])
	    i++;

        return 32 - i;
}
===========

it returns the right result. Compiled with gcc 2.95.3 -march=i686 -O3, athlon
1.533 GHz (1800+) :

4294967295 iterations of new... checksum = 4294967265

real    1m6.182s
user    1m6.060s
sys     0m0.133s
4294967295 iterations of new2... checksum = 4294967265

real    0m36.504s
user    0m36.294s
sys     0m0.202s
4294967295 iterations of fls_table... checksum = 4294967295

real    0m21.962s
user    0m21.833s
sys     0m0.124s
4294967295 iterations of fls_tbl... checksum = 4294967265

real    0m19.268s
user    0m19.102s
sys     0m0.168s

The same compiled with gcc-3.2.3 :

4294967295 iterations of fls_table... checksum = 4294967295

real    0m14.211s
user    0m14.210s
sys     0m0.000s

Cheers,
Willy

