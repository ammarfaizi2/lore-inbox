Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVDEGKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVDEGKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDEGKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:10:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19097 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261569AbVDEGK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:10:28 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050405041359.GA17265@elte.hu>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 04 Apr 2005 23:10:24 -0700
Message-Id: <1112681424.3811.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 06:13 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I can trigger latencies up to ~1.1 ms with a CVS checkout.  It looks
> > like inside ext3_try_to_allocate_with_rsv, we spend a long time in this
> > loop:
> > 

We have not modify the reservation create algorithm for a long time.
Sorry, I missed the background here, on which kernel did you see this
latency? And what tests you were running?

> > ext3_test_allocatable (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > 
> > ext3_test_allocatable (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> 

The loop in bitmap_search_next_usable_block tries to find the next zero
bit on the bitmap, if it find, then it need to check whether this zero
bit is also be zero on the journalling last copy the the bitmap. The
double check is there prevent re-use the just freed block on disk before
it is committed from journalling. If it's not marked as a free block on
the journalling copy, then it will find the next free bit on that copy
first, then loop back etc.etc.

The bitmap_search_next_usable_block() code is quite simple:

static int
bitmap_search_next_usable_block(int start, struct buffer_head *bh,
                                        int maxblocks)
{
        int next;
        struct journal_head *jh = bh2jh(bh);

        /*
         * The bitmap search --- search forward alternately through the actual
         * bitmap and the last-committed copy until we find a bit free in
         * both
         */
        while (start < maxblocks) {
                next = ext3_find_next_zero_bit(bh->b_data, maxblocks, start);
                if (next >= maxblocks)
                        return -1;
                if (ext3_test_allocatable(next, bh))
                        return next;
                jbd_lock_bh_state(bh);
                if (jh->b_committed_data)
                        start = ext3_find_next_zero_bit(jh->b_committed_data,
                                                        maxblocks, next);
                jbd_unlock_bh_state(bh);
        }
        return -1;
}

The latency report shows the pattern of two calls of ext3_find_next_zero_bit () after a call to ext3_test_allocatable(), matches what I suspect above.


I wonder if re-run the test with -0 noreservation mount option make any difference?

> Breaking the lock is not really possible at that point, and it doesnt 
> look too easy to make that path preemptable either. (To make it 
> preemptable rsv_lock would need to become a semaphore (this could be 
> fine, as it's only used when a new reservation window is created).)
> 
> The hard part is the seqlock - the read side is performance-critical, 
> maybe it could be solved via a preemptable but still scalable seqlock 
> variant that uses a semaphore for the write side? It all depends on what 
> the scalability impact of using a semaphore for the new-window code 
> would be.
> 
The seqlock was there to prevent a smp race, but actually turns out to be unnecessary,  and it has been removed recently. While even if it is there, it will not cause much latency here: the whole ext3_try_to_allocate_with_rsv is guard by ei->truncate_sem, thus no multiple readers/writers at the same time.



