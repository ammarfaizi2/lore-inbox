Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSG2Eky>; Mon, 29 Jul 2002 00:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSG2Eky>; Mon, 29 Jul 2002 00:40:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318017AbSG2Eky>;
	Mon, 29 Jul 2002 00:40:54 -0400
Message-ID: <3D44CA21.71742425@zip.com.au>
Date: Sun, 28 Jul 2002 21:52:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <3D44C3A9.982C0205@zip.com.au> <Pine.LNX.4.44.0207282127560.1003-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> >
> > I don't think it can happen in 2.4.  In the truncate case,
> > the page is taken off the LRU by hand.  If do_flushpage()
> > failed then the buffers still have a ref on the page, which
> > is undone in shrink_cache(), inside pagemap_lru_lock.
> >
> > So, probably safe, but way too subtle.
> 
> That was by no means "subtle", it was all very much "design".

Well Rik and I missed it.  Not that this requires much subtlety ;)

> Just undo the broken patch by Rik, and we should all be home free again.

Problem is that the rmap VM doesn't perform swapout via pagetables.
It performs it via the LRU.

If someone is sleeping on a pagefault against a mmapped file, and a
truncate happens meanwhile, that page comes back as an anonymous
page.  It's not on the LRU any more so it has become unswappable.

Maybe we can check i_size in filemap_nopage and deliver a SIGBUS
or something.

For now we can go back to the explicit lru_cache_del() in truncate;
the little bit of unswappable memory is preferable to a deadlock
in TCP.  I'll send the patch after a bit of testing.

But (squeaky wheel), longer-term I want to make pagemap_lru_lock
irq safe.  This reduces contention on that lock by 30% (bringing
the total reduction for that patch series to around 98% - wiped off
the map).  And it fixes this problem.  And it allows us to move
pages between LRU lists at IO completion, if we want to do that.

-
