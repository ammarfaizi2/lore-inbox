Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318024AbSG2FDm>; Mon, 29 Jul 2002 01:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSG2FDm>; Mon, 29 Jul 2002 01:03:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318024AbSG2FDl>;
	Mon, 29 Jul 2002 01:03:41 -0400
Message-ID: <3D44CF79.11082B2D@zip.com.au>
Date: Sun, 28 Jul 2002 22:15:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <3D44CA21.71742425@zip.com.au> <Pine.LNX.4.44.0207282147090.962-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> >
> > Problem is that the rmap VM doesn't perform swapout via pagetables.
> > It performs it via the LRU.
> >
> > If someone is sleeping on a pagefault against a mmapped file, and a
> > truncate happens meanwhile, that page comes back as an anonymous
> > page.  It's not on the LRU any more so it has become unswappable.
> 
> Note that there is nothing fundamentally wrong with keeping the anonymous
> page on the LRU either.
> 
> Some of th e2.4.x kernels kept _all_ anonymous pages on the LRU. That
> added a lot of LRU overhead, but there could be a fairly simple
> workaround: don't add anon pages to the LRU normally, but if a LRU page is
> turned into an anonymous page _and_ it is still mapped, keep it on the LRU
> list as an anonymous page.

All 2.4 and 2.5 kernels currently put all anon pages on the LRU all the
time.  And, yes, this creates great amounts of list scanning in
Andrea's VM.  Quite expensive for some workloads.

He took anon pages on and off the LRU several times shortly after
2.4.10.  They ended up "on". When I asked him if we could take them
off again earlier this month he said

"the only advantage they give us in 2.4 vm is that they let us know
 better when it's time to swap_out. without them, we'd start to swapout
 only when there's some significant amount of mapped cache, without
 regard of the amount of the amount of anonymous ram. In short swap
 performance are higher with this information. We could try to collect
 this info without having to waste time on the lru but I've never tried
 that."


However, with rmap things are different.  When an anon page
reaches the tail of the LRU and the access info is right, it
gets added to swapcache.  So anon pages on the LRU is a fundamental
part of rmap - there's no other way of getting at them.

I haven't yet checked whether the rmap design has reduced the CPU
load which I was observing in 2.5.24 from churning these
anon pages through shrink_cache().  Rik thinks it may do so.

-
