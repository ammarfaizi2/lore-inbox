Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWCUL3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWCUL3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWCUL3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:29:20 -0500
Received: from fmr23.intel.com ([143.183.121.15]:7321 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030328AbWCUL3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:29:18 -0500
Message-ID: <441FE14E.3040507@intel.com>
Date: Tue, 21 Mar 2006 19:19:42 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, prasanna@in.ibm.com,
       hiramatu@sdl.hitachi.co.jp
Subject: Re: [PATCH] kretprobe spinlock recursive remove
References: <441FCCF8.1060300@intel.com> <20060321021418.19e01b30.akpm@osdl.org>
In-Reply-To: <20060321021418.19e01b30.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "bibo,mao" <bibo.mao@intel.com> wrote:
>> In recent linux kernel version, kretprobe in IA32 is implemented in 
>> kretprobe_trampoline. And break trap code is removed from 
>> retprobe_trampoline, instead trampoline_handler is called directly. 
>> Currently if kretprobe hander hit one trap which causes another 
>> kretprobe, there will be SPINLOCK recursive bug. This patch fixes this, 
>> and will skip trap during kretprobe handler execution. This patch is 
>> based on 2.6.16-rc6-mm2.
> 
> What is "recent linux kernel"?  2.6.16?  This patch does apply to 2.6.16 so
> I assume that's what you were referring to?
> 
> If you're referring to the kretprobes patches in -mm then which one
> introduced the problem?
Sorry, I did not clarify it out, it is againt 
kretprobe-kretprobe-booster.patch in -mm tree.

> 
> If you're referring to 2.6.16 then is this problem sufficiently serious to
> warrant inclusion of this patch in 2.6.16.1?
> 
> Please remember to include Signed-off-by: tags.
> 
>> --- arch/i386/kernel/kprobes.c.bak	2006-03-21 10:35:34.000000000 +0800
>> +++ arch/i386/kernel/kprobes.c	2006-03-21 10:37:44.000000000 +0800
> 
> Please prepare patches in `patch -p1' form.
> 
>> @@ -390,8 +390,11 @@ fastcall void *__kprobes trampoline_hand
>>   			/* another task is sharing our hash bucket */
>>                           continue;
>>
>> -		if (ri->rp && ri->rp->handler)
>> +		if (ri->rp && ri->rp->handler){
>> +			__get_cpu_var(current_kprobe) = &ri->rp->kp;
>>   			ri->rp->handler(ri, regs);
>> +			__get_cpu_var(current_kprobe) = NULL;
>> +		}
>>
>>   		orig_ret_address = (unsigned long)ri->ret_addr;
>>   		recycle_rp_inst(ri);
> 
> Your email client appears to be altering the patches in some manner.  It
> required `patch -l' to make this apply.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

