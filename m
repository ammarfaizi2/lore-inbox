Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWEPJCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWEPJCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWEPJCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:02:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:36356 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750720AbWEPJCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:02:25 -0400
Message-ID: <4469945C.90104@vmware.com>
Date: Tue, 16 May 2006 01:59:08 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <44698A74.3090400@vmware.com> <20060516084047.GH2697@moss.sous-sol.org>
In-Reply-To: <20060516084047.GH2697@moss.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> Let's dive into it.  How do you get the randomization without 
>> sacrificing syscall performance?  Do you randomize on boot, dynamically, 
>> or on a per-process level?
>>     
>
> The latter, on exec.
>
>   
>> Because I can see some issues with 
>> per-process randomization that will certainly cost some amount of cycles 
>> on the system call path.  Marginal perhaps, but that is exactly where 
>> you don't want to shed cycles unnecessarily, and the complexity of the 
>> whole thing will go up quite a bit I think.
>>     
>
> The crux is here:
>
> +       OFFSET(TI_sysenter_return, thread_info, sysenter_return);
> ...
>
> -       pushl $SYSENTER_RETURN
> -
> +       /*
> +        * Push current_thread_info()->sysenter_return to the stack.
> +        * A tiny bit of offset fixup is necessary - 4*4 means the 4 words
> +        * pushed above; +8 corresponds to copy_thread's esp0 setting.
> +        */
> +       pushl (TI_sysenter_return-THREAD_SIZE+8+4*4)(%esp)
>
> ...
>
> and in binfmt_elf during exec thread_info->sysenter_return is setup
> based on the randomized mapping it does for vdso
>
> +               ti->sysenter_return = &SYSENTER_RETURN_OFFSET + addr;
>
>
> I think it's not so bad, but I can't say I've benchmarked the cost.
>   

Now that I see it, it doesn't look bad at all.  I had imagined a host of 
holy horrors unfolding from it, but clearly that is not the case.  I 
think there is still the sysexit path that needs some change, but in 
total, there should be almost zero cycle impact.  I envisioned trying to 
get the thread info for the return address would be awkward, but you've 
already switched the stack at this point, so it is really almost free.

Zach

