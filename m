Return-Path: <linux-kernel-owner+w=401wt.eu-S1161192AbXAHIWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbXAHIWs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbXAHIWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:22:48 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:28998 "EHLO
	mis011-1.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932632AbXAHIWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:22:47 -0500
Message-ID: <45A1FF4E.1020106@qumranet.com>
Date: Mon, 08 Jan 2007 10:22:38 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com> <20070107174416.GA14607@elte.hu>
In-Reply-To: <20070107174416.GA14607@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2007 08:22:46.0494 (UTC) FILETIME=[2D35EFE0:01C732FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

 

>> This is a little too good to be true.  Were both runs with the same 
>> KVM_NUM_MMU_PAGES?
>>     
>
> yes, both had the same elevated KVM_NUM_MMU_PAGES of 2048. The 'trunk' 
> run should have been labeled as: 'cr3 tree with paravirt turned off'. 
> That's not completely 'trunk' but close to it, and all other changes 
> (like elimination of unnecessary TLB flushes) are fairly applied to 
> both.
>   

Ok.  I guess there's a switch/switch back pattern in there.

> i also did a run with much less MMU cache pages of 256, and hackbench 1 
> stayed the same, while hackbench 5 numbers started fluctuating badly (i 
> think that workload if trashing the MMU cache badly).
>   

Yes, 256 is too low.

>   
>>> -    u64 *pae_root;
>>> +    u64 *pae_root[KVM_CR3_CACHE_SIZE];
>>>       
>> hmm.  wouldn't it be simpler to have pae_root always point at the 
>> current root?
>>     
>
> does that guarantee that it's available? I wanted to 'pin' the root 
> itself this way, to make sure that if a guest switches to it via the 
> cache, that it's truly available and a valid root. cr3 addresses are 
> non-virtual so this is the only mechanism available to guarantee that 
> the host-side memory truly contains a root pagetable.
>
>   

I meant

   u64 *pae_root_cache;
   u64 *pae_root; /* == pae_root_cache + 4*cache_index */

so that the rest of the code need not worry about the cache.

>>> +            vcpu->mmu.pae_root[j][i] = INVALID_PAGE;
>>> +        }
>>>     }
>>>     vcpu->mmu.root_hpa = INVALID_PAGE;
>>> }
>>>       
>> You keep the page directories pinned here. [...]
>>     
>
> yes.
>
>   
>> [...]  This can be a problem if a guest frees a page directory, and 
>> then starts using it as a regular page.  kvm sometimes chooses not to 
>> emulate a write to a guest page table, but instead to zap it, which is 
>> impossible when the page is freed.  You need to either unpin the page 
>> when that happens, or add a hypercall to let kvm know when a page 
>> directory is freed.
>>     
>
> the cache is zapped upon pagefaults anyway, so unpinning ought to be 
> possible. Which one would you prefer?
>   

It's zapped by the equivalent of mmu_free_roots(), right?  That's 
effectively unpinning it (by zeroing ->root_count).

However, kvm takes pagefaults even for silly things like setting (in 
hardware) or clearing (in software) the dirty bit.

>
>   
>>> +#define KVM_API_MAGIC 0x87654321
>>> +
>>>       
>> <linux/kvm.h> is the vmm userspace interface.  The guest/host 
>> interface should probably go somewhere else.
>>     
>
> yeah. kvm_para.h?
>
>   

Sounds good.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

