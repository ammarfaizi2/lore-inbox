Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWBXHBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBXHBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWBXHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:01:43 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:30611 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750762AbWBXHBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:01:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2klBq8E2vQTUwT94U9mnLqerCn7YBUSCg77uly9jCNbni3/O3bSFyL76k4L7QVCqqtIkvt7CobwGcBpx0caxwzuC2iDS6BjR8Isxz1dv7MEa2BrSPlT3qnhdoGtUNmb6Ek4yOoX3wZBEp7QICgRbSbUBVgXoXrfPUS1RZWPBmxg=  ;
Message-ID: <43FEAF52.80705@yahoo.com.au>
Date: Fri, 24 Feb 2006 18:01:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu> <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au> <20060223132954.GA16074@elte.hu> <43FEA97D.2000609@yahoo.com.au> <20060224064912.GB7243@elte.hu>
In-Reply-To: <20060224064912.GB7243@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>couldnt the new pte be flipped in atomically via cmpxchg? That way 
>>>we could do the page clearing close to where we are doing it now,
>>>but without holding the mmap_sem.
>>
>>We have nothing to pin the pte page with if we're not holding the 
>>mmap_sem.
> 
> 
> why does it have to be pinned? The page is mostly private to this thread 
> until it manages to flip it into the pte. Since there's no pte presence, 
> there's no swapout possible [here i'm assuming anonymous malloc() 
> memory, which is the main focus of Arjan's patch]. Any parallel 
> unmapping of that page will be caught and the installation of the page 
> will be prevented by the 'bit-spin-lock' embedded in the pte.
> 

No, I was talking about page table pages, rather than the newly
allocated page.

But I didn't realise you wanted the bit lock to go the other way
as well (ie. a real bit spinlock). Seems like that would have to
add overhead somewhere.

> 
>>But even in that case, there is nothing in the mmu gather / tlb flush 
>>interface that guarantees an architecture cannot free the page table 
>>pages immediately (ie without waiting for the flush IPI). This would 
>>make sense on architectures that don't walk the page tables in 
>>hardware.
> 
> 
> but the page wont be found by any other CPU, so it wont be freed! It is 
> private to this CPU. The page has no pte presence. It will only be 
> present and lookupable as a result of the cmpxchg() flipping the page 
> into the pte.
> 

Yeah, as I said above, the newly allocated page is fine, it is the
page table pages I'm worried about.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
