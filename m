Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUGGTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUGGTAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUGGTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:00:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265311AbUGGTAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:00:33 -0400
Date: Wed, 7 Jul 2004 15:58:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mason@suse.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707185814.GA3323@logos.cnet>
References: <20040707175724.GB3106@logos.cnet> <20040707182025.GJ28479@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707182025.GJ28479@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 08:20:25PM +0200, Andrea Arcangeli wrote:
> On Wed, Jul 07, 2004 at 02:57:24PM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Chris,
> > 
> > I was talking to Andrew about this memory barrier 
> > 
> > static inline int sync_page(struct page *page)
> > {
> >         struct address_space *mapping;
> >                                                                                         
> >         /*
> >          * FIXME, fercrissake.  What is this barrier here for?
> >          */
> >         smp_mb();
> >         mapping = page_mapping(page);
> >         if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
> >                 return mapping->a_ops->sync_page(page);
> >         return 0;
> > }
> > 
> > And does not seem to be a reason for it. The callers are:
> > 
> > void fastcall wait_on_page_bit(struct page *page, int bit_nr)
> > {
> >         wait_queue_head_t *waitqueue = page_waitqueue(page);
> >         DEFINE_PAGE_WAIT(wait, page, bit_nr);
> >                                                                                         
> >         do {
> >                 prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
> >                 if (test_bit(bit_nr, &page->flags)) {
> >                         sync_page(page);
> >                         io_schedule();
> >                 }
> >         } while (test_bit(bit_nr, &page->flags));
> >         finish_wait(waitqueue, &wait.wait);
> > } 
> > 
> > void fastcall __lock_page(struct page *page)
> > {
> >         wait_queue_head_t *wqh = page_waitqueue(page);
> >         DEFINE_PAGE_WAIT_EXCLUSIVE(wait, page, PG_locked);
> >                                                                                         
> >         while (TestSetPageLocked(page)) {
> >                 prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
> >                 if (PageLocked(page)) {
> >                         sync_page(page);
> >                         io_schedule();
> >                 }
> >         }
> >         finish_wait(wqh, &wait.wait);
> > }
> > 
> > Both callers call set_bit (atomic operation which cannot be reordered) before 
> 
> set_bit is atomic but it _can_ be reordered just fine. atomic !=
> barrier (they're the same only in x86 due the lack of specific smp-aware
> opcodes).

Hi Andrea,

OK, got it.

I think this comment on i386 bitops.h can lead to 
misunderstanding and should be changed:

/**
 * set_bit - Atomically set a bit in memory
 * @nr: the bit to set
 * @addr: the address to start counting from
 *
 * This function is atomic and may not be reordered. 

"This function is atomic and may not be reordered (other architectures MAY reorder it)"

Or something like this. The comment as it is leads people to
write nonportable code which assumes set_bit() cant be reordered. Like naive me did.

> however the smp_mb() isn't needed in sync_page, simply because it's
> perfectly ok if we start running sync_page before reading pagelocked.
>
> All we care about is to run sync_page _before_ io_schedule() and that we
> read PageLocked _after_ prepare_to_wait_exclusive.

Ok, I see, yes.

> So the locking in between PageLocked and sync_page is _absolutely_
> worthless and the smp_mb() can go away. 

Andrew, what you think about removing that barrier from sync_page() 
on -mm? 

And what about changing the "may not reordered" comments on i386 bitops.h
to "may not be reordered on i386 only, other arches do reorder it." ?


