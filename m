Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSG2ENS>; Mon, 29 Jul 2002 00:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSG2ENS>; Mon, 29 Jul 2002 00:13:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317935AbSG2ENR>;
	Mon, 29 Jul 2002 00:13:17 -0400
Message-ID: <3D44C3A9.982C0205@zip.com.au>
Date: Sun, 28 Jul 2002 21:25:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com> <20020728.204302.44950225.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Sun, 28 Jul 2002 20:51:13 -0700 (PDT)
> 
>    On Sun, 28 Jul 2002, David S. Miller wrote:
>    > They must never run from HW irqs, in fact there is a BUG()
>    > check there against this.
> 
>    From a page cache standpoint softirq's are 100% equivalent to
>    hardware irq's, so that doesn't much help here.
> 
> Wait are we trying to make the final freeing of (potentially)
> LRU/page-cache pages from any non-base context illegal?

It already is.  The combination of circumstances is pretty
remote, and indeed may never happen.  But the final put_page()
against an LRU page will go BUG() because the page is on the LRU.
And a page_cache_reelase() in IRQ context could deadlock over
pagemap_lru_lock() (it'll go BUG in -aa kernels).

> If that really becomes an issue we can do something which moves
> this back to user context when the result of doing it in irq
> context would be problematic.

I don't think it can happen in 2.4.  In the truncate case,
the page is taken off the LRU by hand.  If do_flushpage()
failed then the buffers still have a ref on the page, which
is undone in shrink_cache(), inside pagemap_lru_lock.

So, probably safe, but way too subtle.

-
