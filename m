Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267621AbUHRXxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267621AbUHRXxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUHRXxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:53:48 -0400
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:6610 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S267621AbUHRXxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:53:43 -0400
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32     and    512 cpu SMP
Date: Wed, 18 Aug 2004 19:50:21 -0400
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2004.08.18.23.50.13.562750@umich.edu>
References: <2uexw-1Nn-1@gated-at.bofh.it> <2uCTq-2wa-55@gated-at.bofh.it>
To: Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, <raybry@sgi.com>, <ak@muc.de>,
       <benh@kernel.crashing.org>, <manfred@colorfullife.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Aug 18, 2004 at 06:55:07PM +0100, Hugh Dickins wrote:
>> That's interesting, and disappointing.
>> The main lesson I took from your patch (I think wli was hinting at
>> the same) is that we ought now to question page_table_lock usage,
>> should be possible to cut it a lot.
>> I recall from exchanges with Dave McCracken 18 months ago that the
>> page_table_lock is _almost_ unnecessary in rmap.c, should be possible
>> to get avoid it there and in some other places.
>> We take page_table_lock when making absent present and when making
>> present absent: I like your observation that those are exclusive cases.
>> But you've found that narrowing the width of the page_table_lock
>> in a particular path does not help.  You sound surprised, me too.
>> Did you find out why that was?
>
> It also protects against vma tree modifications in mainline, but rmap.c
> shouldn't need it for vmas anymore, as the vma is rooted to the spot by
> mapping->i_shared_lock for file pages and anon_vma->lock for anonymous.

If I am reading the code correctly, then without page_table_lock
in page_referenced_one(), we can race with exit_mmap() and page 
table pages can be freed under us.

William Lee Irwin III wrote:
> On Wed, Aug 18, 2004 at 06:55:07PM +0100, Hugh Dickins wrote:
>> I do think this will be a more fruitful direction than pte locking:
>> just looking through the arches for spare bits puts me off pte locking.
>
> Fortunately, spare bits aren't strictly necessary, and neither is
> cmpxchg. A single invalid value can serve in place of a bitflag. When
> using such an invalid value, just xchg()'ing it and looping when the
> invalid value is seen should suffice. This holds more generally for all
> radix trees, not just pagetables, and happily xchg() or emulation
> thereof is required by core code for all arches.

Good point. 

Another solution may be to use the unused bytes (->lru or
->private) in page table "struct page" as bit_spin_locks. We can 
use a single bit to protect a small set of ptes (8, 16, or 32).

Rajesh
  


