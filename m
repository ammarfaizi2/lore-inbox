Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVDEEOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVDEEOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 00:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDEEOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 00:14:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27536 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261441AbVDEEOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 00:14:42 -0400
Date: Tue, 5 Apr 2005 06:13:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: ext3 allocate-with-reservation latencies
Message-ID: <20050405041359.GA17265@elte.hu>
References: <1112673094.14322.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112673094.14322.10.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I can trigger latencies up to ~1.1 ms with a CVS checkout.  It looks
> like inside ext3_try_to_allocate_with_rsv, we spend a long time in this
> loop:
> 
> ext3_test_allocatable (bitmap_search_next_usable_block)
> find_next_zero_bit (bitmap_search_next_usable_block)
> find_next_zero_bit (bitmap_search_next_usable_block)
> 
> ext3_test_allocatable (bitmap_search_next_usable_block)
> find_next_zero_bit (bitmap_search_next_usable_block)
> find_next_zero_bit (bitmap_search_next_usable_block)

Breaking the lock is not really possible at that point, and it doesnt 
look too easy to make that path preemptable either. (To make it 
preemptable rsv_lock would need to become a semaphore (this could be 
fine, as it's only used when a new reservation window is created).)

The hard part is the seqlock - the read side is performance-critical, 
maybe it could be solved via a preemptable but still scalable seqlock 
variant that uses a semaphore for the write side? It all depends on what 
the scalability impact of using a semaphore for the new-window code 
would be.

the best longterm solution for these types of tradeoffs seems to be to 
add a locking primitive that is a spinlock on !PREEMPT kernels and a 
semaphore on PREEMPT kernels. I.e. not as drastic as a full PREEMPT_RT 
kernel, but good enough to make latency-critical codepaths of ext3 
preemptable, without having to hurt scalability on !PREEMPT. The 
PREEMPT_RT kernel has all the 'compile-time type-switching' 
infrastructure for such tricks, all that needs to be changed to switch a 
lock's type is to change the spinlock definition - all the 
spin_lock(&lock) uses can remain unchanged. (The same method is used on 
PREEMPT_RT to have 'dual-type' spinlocks.)

the same thing could then also be used for things like the mm lock, and 
other longer-held locks that PREEMPT would like to see preemptable. It 
would also be a good first step towards merging the PREEMPT_RT 
infrastructure ;-) I'll cook up something.

	Ingo
