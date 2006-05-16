Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWEPJnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWEPJnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWEPJnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:43:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:44069 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751715AbWEPJnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:43:02 -0400
X-IronPort-AV: i="4.05,132,1146466800"; 
   d="scan'208"; a="37917008:sNHT50872997"
Message-ID: <44699E8C.2070002@intel.com>
Date: Tue, 16 May 2006 17:42:36 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, "bibo,mao" <bibo.mao@intel.com>,
       jbeulich@novell.com, anil.s.keshavamurthy@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]x86_64 debug_stack nested patch (again)
References: <200605101726.08338.bibo.mao@intel.com> <20060511041700.49c3bab0.akpm@osdl.org> <200605111328.45244.ak@suse.de>
In-Reply-To: <200605111328.45244.ak@suse.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late reply, interrupt is disabled when int3/int1 trap happens 
and NMI is not permitted for kprobe in x86_64 platform,nest level of kprobe 
is 2 at most. So that will work well if DEBUG_STACK is set to 8K when CONFIG_KPROBE
option is set.

Thanks
bibo,mao

Andi Kleen wrote:
> On Thursday 11 May 2006 13:17, Andrew Morton wrote:
>> "bibo,mao" <bibo.mao@intel.com> wrote:
>>> Hi,
>>> In x86_64 platform, INT1 and INT3 trap stack is IST stack called DEBUG_STACK,
>>> when INT1/INT3 trap happens, system will switch to DEBUG_STACK by hardware. 
>>> Current DEBUG_STACK size is 4K, when int1/int3 trap happens, kernel will 
>>> minus current DEBUG_STACK IST value by 4k. But if int3/int1 trap is nested, 
>>> it will destroy other vector's IST stack. This patch modifies this, it sets 
>>> DEBUG_STACK size as 8K and allows two level of nested int1/int3 trap.
>>>
>>> Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
>>> by other kprobes. This patch is against 2.6.17-rc3. Thanks jbeulich for pointing out error in the first patch.
>>>
>>> Signed-Off-By: bibo, mao <bibo.mao@intel.com>
>>>
>>> --- 2.6.17-rc3.org/include/asm-x86_64/page.h	2006-05-10 12:07:18.000000000 +0800
>>> +++ 2.6.17-rc3/include/asm-x86_64/page.h	2006-05-10 12:19:24.000000000 +0800
>>> @@ -20,7 +20,7 @@
>>>  #define EXCEPTION_STACK_ORDER 0
>>>  #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
>>>  
>>> -#define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
>>> +#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
>>>  #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
>>>  
>>>  #define IRQSTACK_ORDER 2
>> So....   why not do it this way?
> 
> Last time we discussed this I was told it could nest upto 3 or 4 times
> So that still wouldn't work.
> 
> If anything they should decrease the int3/debug stack to 2K, then 8K 
> might be enough.
> 
> Or even better would be to fix kprobes to not do that.
> 
> I think paranoidentry would need to be fixed for that too.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
