Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSAHHmc>; Tue, 8 Jan 2002 02:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287955AbSAHHmX>; Tue, 8 Jan 2002 02:42:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8467 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287048AbSAHHmH>;
	Tue, 8 Jan 2002 02:42:07 -0500
Date: Tue, 8 Jan 2002 08:42:00 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bounce buffer usage
Message-ID: <20020108084200.B19380@suse.de>
In-Reply-To: <20011223150940.E7438@suse.de> <Pine.LNX.4.33L2.0201071740350.7535-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0201071740350.7535-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07 2002, Randy.Dunlap wrote:
> On Sun, 23 Dec 2001, Jens Axboe wrote:
> 
> | On Fri, Dec 21 2001, Randy.Dunlap wrote:
> | > Are there any drivers in 2.4.x that support highmem directly,
> | > or is all of that being done in 2.5.x (BIO patches)?
> |
> | 2.4 + my block-highmem patches support direct highmem I/O.
> |
> | > Would it be useful to try this with a 2.5.1 kernel?
> |
> | Sure
> 
> 
> OK, here's 'fillmem 700' run against 5 kernels as described below,
> with my bounce io/swap statistics patch added.
> 
> All tests are 6 instances of "fillmem 700" (700 MB) on a 4-way 4 GB
> x86 VA 4450 server.
> 
> I'm including a reduced version of /proc/stat -- before and after the
> fillmem test in each case.
> 
> Let me know if you'd like to see other variations.

The results look very promising, although I'm a bit surprised that 2.5
is actually that much quicker :-)

The bounce counts you are doing don't make too much sense to me though,
how come 2.4 + block-high and 2.5 show any bounced numbers at all? Maybe
you are not doing the accounting correctly? To get the right counts do
something ala:

+++ mm/highmem.c
@@ -409,7 +409,9 @@
                        vfrom = kmap(from->bv_page) + from->bv_offset;
                        memcpy(vto, vfrom, to->bv_len);
                        kunmap(from->bv_page);
-               }
+                       bounced_write++;
+               } else
+                       bounced_read++;
        }

Of course those are all bounces, not just (or only) swap bounces. Also
note that the above is not SMP safe.

-- 
Jens Axboe

