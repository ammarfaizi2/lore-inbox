Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWCQCwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWCQCwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWCQCwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:52:32 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:27986 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751454AbWCQCwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:52:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cCnPZyc/6bBPu4Cb4dKurJtiV4YycaNXubDrF+0LMQzKG0zs/dsCKIZYYCs6hu2kaQMvctxE2S1o+E88+n6eZXbGfhC9U0zI4V7vjh8QAf0tEr0wZzBpjzWyJi9IlagR4pLEIXs9YVpqjlqY405Iw2PNzakaTYTbkaqgcbUvB9M=  ;
Message-ID: <441A246A.4090208@yahoo.com.au>
Date: Fri, 17 Mar 2006 13:52:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, rlrevell@joe-job.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix free swap cache latency
References: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com> <20060316173808.3be343b0.akpm@osdl.org>
In-Reply-To: <20060316173808.3be343b0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> 
>> 			(*zap_work)--;
>> 			continue;
>> 		}
>>+
>>+		(*zap_work) -= PAGE_SIZE;
> 
> 
> Sometimes we subtract 1 from zap_work, sometimes PAGE_SIZE.  It's in units
> of bytes, so PAGE_SIZE is correct.  Although it would make sense to
> redefine it to be in units of PAGE_SIZE.  What's up with that?
> 

Subtracting 1 if there is no work to do for that cacheline entry.

> Even better, define it in units of "approximate number of touched
> cachelines".  After all, it is a sort-of-time-based thing.
> 

Yeah that was the rough intention, but I never actually measured
to see whether the results were right.

The pte_none case touches about 1/32 of a cacheline on my P4
(add a bit for setup costs, subtract a bit for linear prefetchable
access over multiple lines).

pte_present touches the pte, the page once or twice -- first
directly, then from mmu gather, the vma and the mapping (mostly be
the same though so cost is small), a whole host of locks and atomic
operations (put_page_testzero, lru_lock, tree_lock, page_remove_rmap,
zone->lock), an IPI to other CPUs, tlb invalidates etc. some things
batched, some not.

So it gets hard to count, especially if you have other CPUs contending
the same locks. I suspect the per-page cost is not really 128 cache
misses most of the time, but it was just a number I pulled out. Anyone
can feel free to turn the knob if they feel they have a better idea.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
