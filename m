Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276962AbRJQQ2T>; Wed, 17 Oct 2001 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRJQQ2J>; Wed, 17 Oct 2001 12:28:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276957AbRJQQ15>; Wed, 17 Oct 2001 12:27:57 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Date: Wed, 17 Oct 2001 16:27:25 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qkbhd$h8m$1@penguin.transmeta.com>
In-Reply-To: <20011016081639.A209@earthlink.net> <20011017021242.S2380@athlon.random> <20011017043103.D2380@athlon.random> <20011017004839.A15996@earthlink.net>
X-Trace: palladium.transmeta.com 1003336083 29707 127.0.0.1 (17 Oct 2001 16:28:03 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Oct 2001 16:28:03 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011017004839.A15996@earthlink.net>, <rwhron@earthlink.net> wrote:
>> 
>> So I'd suggest to try again after "echo 4 > /proc/sys/vm/page-cluster"
>> to see if it makes any difference.
>> 
>> Andrea
>
>You Rule!
>
>The tweak to page-cluster is basically magic for this test.
>
>With page-cluster=4, the mp3blaster sputtered like 2.4.13pre2aa1.
>Better, but not beautiful.
>
>Real beauty happens with page-cluster=2.  There is virtually no sputter.  
>And the wall clock time is a little better than 2.4.13pre2aa1!

This is good information.

The problem is that "page-cluster" is actually used for two different
things: it's used for mmap page-in clustering, and it's used for swap
page-in clustering, and they probably have rather different behaviours.

Setting page-cluster to 2 means that both mmap and page-in will cluster
only four pages, which might slow down mmap throughput when not swapping
(and make program loading in particular slow down under disk load).  At
the same time it's probably perfectly fine for swapping - I think
Marcelo eventually wants to re-do the swapin read-clustering anyway. 

And wall-clock time apparently did decrease with page-clustering
lowered, although personally I like latency more than throughput so that
doesn't really bother me.

However, I'd really like to know whether it is mmap or swap clustering
that matters more, so it would be interesting to hear what happens if
you remove the "swapin_readahead(entry)" line in mm/memory.c (in
do_swap_page()).  Does a large page-cluster value still make matters
worse when it's disabled for swapping? (In other words: does
page-cluster actually hurt for mmap too, or is the problem strictly
related to swapping?)

Willing to test your load?

	Thanks,
		Linus
