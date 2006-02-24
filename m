Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWBXGgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWBXGgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWBXGgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:36:49 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:171 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932709AbWBXGgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:36:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mi3aRLCOfq26o0FYvKcmY9nKlTrAY0jRry0DoQbi4/kJdNHmrwUNCiPFpgq+0wQcwv80N2KkSSz8EbyReAEmq8HMcqgi6GfAwftTBPKfnxjO9Zj4i9urIM0EEd88fmmsh0SJVexntxs1qm5lncIQ/HNBkHrn+Z95OqFMxTGJzjo=  ;
Message-ID: <43FEA97D.2000609@yahoo.com.au>
Date: Fri, 24 Feb 2006 17:36:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu> <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au> <20060223132954.GA16074@elte.hu>
In-Reply-To: <20060223132954.GA16074@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>I'm worried about the situation where we allocate but don't use the 
>>new page: it blows quite a bit of cache. Then, when we do get around 
>>to using it, it will be cold(er).
> 
> 
> couldnt the new pte be flipped in atomically via cmpxchg? That way we 
> could do the page clearing close to where we are doing it now, but 
> without holding the mmap_sem.
> 

We have nothing to pin the pte page with if we're not holding the
mmap_sem.

> to solve the pte races we could use a bit in the [otherwise empty] pte 
> to signal "this pte can be flipped in from now on", which bit would 
> automatically be cleared if mprotect() or munmap() is called over that 
> range (without any extra changes to those codepaths). (in the rare case 
> if the cmpxchg() fails, we go into a slowpath that drops the newly 
> allocated page, re-lookups the vma and the pte, etc.)
> 

Page still isn't pinned. You might be able to do something wild like
disable preemption and interrupts (to stop the TLB IPI) to get a pin
on the pte pages.

But even in that case, there is nothing in the mmu gather / tlb flush
interface that guarantees an architecture cannot free the page table
pages immediately (ie without waiting for the flush IPI). This would
make sense on architectures that don't walk the page tables in hardware.

Arjan, just to get an idea of your workload: obviously it is a mix of
read and write on the mmap_sem (read only will not really benefit from
reducing lock width because cacheline transfers will still be there).
Is it coming from brk() from the allocator? Someone told me a while ago
that glibc doesn't have a decent amount of hysteresis in its allocator
and tends to enter the kernel quite a lot... that might be something
to look into.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
