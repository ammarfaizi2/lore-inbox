Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUGGR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUGGR7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUGGR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:59:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265262AbUGGR72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:59:28 -0400
Date: Wed, 7 Jul 2004 14:57:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: mason@suse.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Unnecessary barrier in sync_page()? 
Message-ID: <20040707175724.GB3106@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

I was talking to Andrew about this memory barrier 

static inline int sync_page(struct page *page)
{
        struct address_space *mapping;
                                                                                        
        /*
         * FIXME, fercrissake.  What is this barrier here for?
         */
        smp_mb();
        mapping = page_mapping(page);
        if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
                return mapping->a_ops->sync_page(page);
        return 0;
}

And does not seem to be a reason for it. The callers are:

void fastcall wait_on_page_bit(struct page *page, int bit_nr)
{
        wait_queue_head_t *waitqueue = page_waitqueue(page);
        DEFINE_PAGE_WAIT(wait, page, bit_nr);
                                                                                        
        do {
                prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
                if (test_bit(bit_nr, &page->flags)) {
                        sync_page(page);
                        io_schedule();
                }
        } while (test_bit(bit_nr, &page->flags));
        finish_wait(waitqueue, &wait.wait);
} 

void fastcall __lock_page(struct page *page)
{
        wait_queue_head_t *wqh = page_waitqueue(page);
        DEFINE_PAGE_WAIT_EXCLUSIVE(wait, page, PG_locked);
                                                                                        
        while (TestSetPageLocked(page)) {
                prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
                if (PageLocked(page)) {
                        sync_page(page);
                        io_schedule();
                }
        }
        finish_wait(wqh, &wait.wait);
}

Both callers call set_bit (atomic operation which cannot be reordered) before 
sync_page(), so.. what is the barrier trying to guarantee? 

TIA

