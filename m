Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSG2ErB>; Mon, 29 Jul 2002 00:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSG2ErA>; Mon, 29 Jul 2002 00:47:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318019AbSG2ErA>; Mon, 29 Jul 2002 00:47:00 -0400
Date: Sun, 28 Jul 2002 21:50:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D44CA21.71742425@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207282147090.962-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> Problem is that the rmap VM doesn't perform swapout via pagetables.
> It performs it via the LRU.
>
> If someone is sleeping on a pagefault against a mmapped file, and a
> truncate happens meanwhile, that page comes back as an anonymous
> page.  It's not on the LRU any more so it has become unswappable.

Note that there is nothing fundamentally wrong with keeping the anonymous
page on the LRU either.

Some of th e2.4.x kernels kept _all_ anonymous pages on the LRU. That
added a lot of LRU overhead, but there could be a fairly simple
workaround: don't add anon pages to the LRU normally, but if a LRU page is
turned into an anonymous page _and_ it is still mapped, keep it on the LRU
list as an anonymous page.

Then, when it is unmapped, the last unmapper (even if it isn't necessarily
the last count) removes it from the LRU list.

This wouldn't have worked in 2.4.x - because without rmap you can't know
whether a count comes from mapping or not. But with rmap you can know, and
you can also notice the "last unmapper" thing.

		Linus

