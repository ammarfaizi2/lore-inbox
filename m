Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271119AbRHOJoT>; Wed, 15 Aug 2001 05:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRHOJoK>; Wed, 15 Aug 2001 05:44:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57870 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271119AbRHOJoB>; Wed, 15 Aug 2001 05:44:01 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 15 Aug 2001 02:43:24 -0700
Message-Id: <200108150943.f7F9hOh01879@penguin.transmeta.com>
To: s3293115@student.anu.edu.au, linux-kernel@vger.kernel.org
Subject: Re: kswapd using all cpu for long periods in 2.4.9-pre4
Newsgroups: linux.dev.kernel
In-Reply-To: <000c01c12569$65581630$0200a8c0@W2K>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000c01c12569$65581630$0200a8c0@W2K> you write:
>
>Somewhere between 2.4.8 and 2.4.9-pre4 kswapd developed a problem. Actually
>it looks like it is related to the changes in do_try_to_free_pages...
>
>kswapd is using all cpu for long periods (100-200 seconds then 100-200
>seconds break....) there is very little disk activity (heres a vmstat while
>its happening)

For some reason do_try_to_free_pages() doesn't end up ever being happy
with how much memory there is free (that's why kswapd will loop).  But
you actually have a reasonable amount of free memory, so all the memory
free'ers will actually refuse to do anything.  The problem seems to be
that either inactive_shortage() or free_shortage() will just continually
claim that you have a shortage of memory. 

However, you actually do have memory:

>mem info during:
>SysRq: Show Memory
>Mem-info:
>Free pages: 3744kB ( 0kB HighMem)
>( Active: 6946, inactive_dirty: 4296, inactive_clean: 895, free: 936 (256
>512 2048) )
>5*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1036kB)
>263*4kB 105*8kB 5*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB = 2708kB)
> = 0kB)
>Swap cache: add 16680, delete 14047, find 17408/32591
>Free swap: 110016kB
>16368 pages of RAM
>0 pages of HIGHMEM

I bet this is it.

It probably decides that you have a shortage of HIGHMEM pages. Which is
understandable, since you don't have any ;)

Does the following trivial patch fix it for you?

(If it doesn't, please try just removing the "continue" at line 930 or
so in the middle of the kswapd loop.  But I think there's something else
that makes kswapd just think it _should_ loop, and the lack of
zone->size testing in the inactive_shortage() calculations looks like
it).

	Thanks,

		Linus

-----
--- pre4/linux/mm/vmscan.c	Wed Aug 15 02:39:44 2001
+++ linux/mm/vmscan.c	Wed Aug 15 02:37:07 2001
@@ -788,6 +788,9 @@
 			zone_t *zone = pgdat->node_zones + i;
 			unsigned int inactive;
 
+			if (!zone->size)
+				continue;
+
 			inactive  = zone->inactive_dirty_pages;
 			inactive += zone->inactive_clean_pages;
 			inactive += zone->free_pages;

