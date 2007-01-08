Return-Path: <linux-kernel-owner+w=401wt.eu-S932635AbXAHJIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbXAHJIf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbXAHJIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:08:35 -0500
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:6859 "EHLO
	mis011.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932635AbXAHJIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:08:34 -0500
Message-ID: <45A20A0A.70403@qumranet.com>
Date: Mon, 08 Jan 2007 11:08:26 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com> <20070107174416.GA14607@elte.hu> <45A1FF4E.1020106@qumranet.com> <20070108083935.GB18259@elte.hu>
In-Reply-To: <20070108083935.GB18259@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2007 09:08:34.0384 (UTC) FILETIME=[9314AD00:01C73304]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Avi Kivity <avi@qumranet.com> wrote:
>
>   
>>> the cache is zapped upon pagefaults anyway, so unpinning ought to be 
>>> possible. Which one would you prefer?
>>>       
>> It's zapped by the equivalent of mmu_free_roots(), right?  That's 
>> effectively unpinning it (by zeroing ->root_count).
>>     
>
> no, right now only the guest-visible cache is zapped - the roots are 
> zapped by natural rotation. I guess they should be zapped in 
> kvm_cr3_cache_clear() - but i wanted to keep that function an invariant 
> to the other MMU state, to make it easier to call it from whatever mmu 
> codepath.
>
>   

Ok.  Some mechanism is then needed to unpin the pages in case they are 
recycled by the guest.

>> However, kvm takes pagefaults even for silly things like setting (in 
>> hardware) or clearing (in software) the dirty bit.
>>     
>
> yeah. I think it also does some TLB flushes that are not needed. For 
> example in rmap_write_protect() we do this:
>
>                 rmap_remove(vcpu, spte);
>                 kvm_arch_ops->tlb_flush(vcpu);
>
> but AFAICS rmap_write_protect() is only ever called if we write a new 
> cr3 - hence a TLB flush will happen anyway, because we do a 
> vmcs_writel(GUEST_CR3, new_cr3). Am i missing something? 

No, rmap_write_protect() is called whenever we shadow a new guest page 
table (the mechanism used to maintain coherency is write faults on page 
tables).

> I didnt want to 
> remove it as part of the cr3 patches (to keep things simpler), but that 
> flush looks quite unnecessary to me. The patch below seems to work in 
> light testing.
>
> 	Ingo
>
> Index: linux/drivers/kvm/mmu.c
> ===================================================================
> --- linux.orig/drivers/kvm/mmu.c
> +++ linux/drivers/kvm/mmu.c
> @@ -404,7 +404,11 @@ static void rmap_write_protect(struct kv
>  		BUG_ON(!(*spte & PT_WRITABLE_MASK));
>  		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
>  		rmap_remove(vcpu, spte);
> -		kvm_arch_ops->tlb_flush(vcpu);
> +		/*
> +		 * While we removed a mapping there's no need to explicitly
> +		 * flush the TLB here, because this codepath only triggers
> +		 * if we write a new cr3 - which will flush the TLB anyway.
> +		 */
>  		*spte &= ~(u64)PT_WRITABLE_MASK;
>  	}
>  }
>   

This will kill svm.

I don't think the tlb flushes are really necessary on today's Intel 
machines, as they probably flush the tlb on each vmx switch.  But AMD 
keeps the TLB, and the flushes are critical there.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

