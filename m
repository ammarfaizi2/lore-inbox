Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUGGSVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUGGSVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUGGSVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:21:41 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:407 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265276AbUGGSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:20:37 -0400
Date: Wed, 7 Jul 2004 20:20:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: mason@suse.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707182025.GJ28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707175724.GB3106@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:57:24PM -0300, Marcelo Tosatti wrote:
> 
> Hi Chris,
> 
> I was talking to Andrew about this memory barrier 
> 
> static inline int sync_page(struct page *page)
> {
>         struct address_space *mapping;
>                                                                                         
>         /*
>          * FIXME, fercrissake.  What is this barrier here for?
>          */
>         smp_mb();
>         mapping = page_mapping(page);
>         if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
>                 return mapping->a_ops->sync_page(page);
>         return 0;
> }
> 
> And does not seem to be a reason for it. The callers are:
> 
> void fastcall wait_on_page_bit(struct page *page, int bit_nr)
> {
>         wait_queue_head_t *waitqueue = page_waitqueue(page);
>         DEFINE_PAGE_WAIT(wait, page, bit_nr);
>                                                                                         
>         do {
>                 prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
>                 if (test_bit(bit_nr, &page->flags)) {
>                         sync_page(page);
>                         io_schedule();
>                 }
>         } while (test_bit(bit_nr, &page->flags));
>         finish_wait(waitqueue, &wait.wait);
> } 
> 
> void fastcall __lock_page(struct page *page)
> {
>         wait_queue_head_t *wqh = page_waitqueue(page);
>         DEFINE_PAGE_WAIT_EXCLUSIVE(wait, page, PG_locked);
>                                                                                         
>         while (TestSetPageLocked(page)) {
>                 prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
>                 if (PageLocked(page)) {
>                         sync_page(page);
>                         io_schedule();
>                 }
>         }
>         finish_wait(wqh, &wait.wait);
> }
> 
> Both callers call set_bit (atomic operation which cannot be reordered) before 

set_bit is atomic but it _can_ be reordered just fine. atomic !=
barrier (they're the same only in x86 due the lack of specific smp-aware
opcodes).

however the smp_mb() isn't needed in sync_page, simply because it's
perfectly ok if we start running sync_page before reading pagelocked.
All we care about is to run sync_page _before_ io_schedule() and that we
read PageLocked _after_ prepare_to_wait_exclusive.

So the locking in between PageLocked and sync_page is _absolutely_
worthless and the smp_mb() can go away.
