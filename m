Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSG2EFS>; Mon, 29 Jul 2002 00:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSG2EFS>; Mon, 29 Jul 2002 00:05:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317924AbSG2EFQ>;
	Mon, 29 Jul 2002 00:05:16 -0400
Message-ID: <3D44C1C8.C1617A09@zip.com.au>
Date: Sun, 28 Jul 2002 21:17:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <20020728.195055.105468330.davem@redhat.com> <Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, David S. Miller wrote:
> >
> >    Also skb_release_data(), ___pskb_trim() and __pskb_pull_tail().  Can these
> >    ever perform the final release against a page which is on the LRU?
> >    In interrupt context?
> >
> > These page releases run from either user or softint context.
> >
> > They must never run from HW irqs, in fact there is a BUG()
> > check there against this.
> 
> >From a page cache standpoint softirq's are 100% equivalent to hardware
> irq's, so that doesn't much help here.

So we cannot take pagemap_lru_lock from softirq context.

hmm.  ia32's do_IRQ() doesn't run do_sotfirq() any more, but the
other architectures do.  What's up with that?

> > Any page that can be found in the page cache can end up here.  So
> > whatever that mean for "release against a page which is on the LRU"
> > applies here.
> 
> Being in the page cache can be ok. What is _not_ ok is if this function
> can ever be the last user to release such a page (ie the original page
> count of the page had better be held on by something else - which usually
> is the page-cacheness itself, since shrinking the page cache will only
> happen for pages that are unused).
> 

shrink_cache() explicitly removes the page from the LRU (well, it
won't even get that far if someone else has a ref).

truncate_complete_page() _used_ to explicitly remove the page from
the lru, but we took that out.  And it was never reliable anyway,
because some pages were left there (invalidatepage failed).

Anyway.  I have patches against 2.5.24, which work, which
turn pagemap_lru_lock into an innermost, irq-safe lock.  If
we get that in place then page_cache_release() from IRQ context
is fine.

-
