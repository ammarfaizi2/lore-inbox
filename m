Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSGEJdb>; Fri, 5 Jul 2002 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSGEJdb>; Fri, 5 Jul 2002 05:33:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316434AbSGEJda>;
	Fri, 5 Jul 2002 05:33:30 -0400
Message-ID: <3D2569E5.A9AC4F3B@zip.com.au>
Date: Fri, 05 Jul 2002 02:41:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch 18/27] always update page->flags atomically
References: <3D24E04A.F4A8B170@zip.com.au> <20020705100637.B23355@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Thu, Jul 04, 2002 at 04:54:50PM -0700, Andrew Morton wrote:
> > It had no right to go clearing PG_arch_1.  I'm now clearing PG_arch_1
> > inside rmqueue() which is still a bit presumptious.
> 
> Davem should know the right behaviour for this bit.  It's not a generic
> "architecture" bit, but it has some defined behaviour behind it.  See
> cachetlb.txt:
> 
>   void flush_dcache_page(struct page *page)
> ...
>         There is a bit set aside in page->flags (PG_arch_1) as
>         "architecture private".  The kernel guarantees that,
>         for pagecache pages, it will clear this bit when such
>         a page first enters the pagecache.
> 
> I think you may have broken this... ;(

For pagecache pages we're OK - they're only added to pagecache
once, and PG_arch_1 is cleared at page allocation time.

However swapcache pages are added and removed.

It's rather moot, because swapcache pages are not subject to
flush_dcache_page() any more.  If you're using swap-over-NBD
then I guess networking makes its own arrangements...

So hmmm.  Actually, I think the current behaviour is correct.
If a page is added to swapcache then removed then added, then
removed, the kernel should never stomp on PG_arch_1.  That's
an arch-private cache to say "you need to perform cache writeback
for this page if another mm later shares it", yes?  So we need
to preserve that info as the page enters and leaves swapcache.

I think.

-
