Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVKFXNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKFXNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKFXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:13:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbVKFXNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:13:36 -0500
Date: Sun, 6 Nov 2005 15:13:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051106151326.63cf16bd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
	<20051106112838.0d524f65.akpm@osdl.org>
	<Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Sun, 6 Nov 2005, Andrew Morton wrote:
> > 
> > This patch makes the ppc64 crash.  See
> > http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg
> > 
> > I don't know what the access address was (ia32 nicely tells you), but if
> > it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab
> > page which backs the mm_struct itself is getting freed-up-pte-page
> > treatment, which is deeply screwed up.
> > 
> > I'll try it on x86_64 and ia64, see if it's specific to ppc64.
> 
> I think it'll turn out to be (my patch, yes, but) the way mm/slab.c does
> 
> #define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
> #define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
> #define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
> #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
> 
> and needs those fields preserved while that page is in the slab.
> Though I've not tried to work out why it crashes on an mm_struct.
> 
> I'd checked that none of the architectures were using those page fields
> of a page table page, but never considered that slab was using them: my
> patch probably breaks all those which use slab for their page tables.

Ah, of course, yes.  pagetable pages which come from slab have a live
page.lru even while the memory is in use by the caller.

> Drat.  I'm trying to think of the best way to retrieve the situation.

I suspect a slab-based fix/workaround would be unpleasant.  Simpler to not
use slab for pagetable pages.

I doubt if there's much benefit to pagetable-pages-in-slab, really.  It
_used_ to make sense because slab has the per-cpu LIFO magazines.  But now
the page allocator has them too, it's probably better to rely upon that
magazine to provide cache-warm pages.

> The priority must be for you to get 2.6.14-mm1 out: is the easiest for
> now simply to revert my patch (and the _private one(s) you added on top)?

yup, when I can get the steaming pile to compile.

