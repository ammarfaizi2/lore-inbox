Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWGJOmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWGJOmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWGJOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:42:04 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:41049 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161165AbWGJOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:42:02 -0400
Message-ID: <44B26733.6090904@de.ibm.com>
Date: Mon, 10 Jul 2006 16:41:55 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: heiko.carstens@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 9
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <p73ac7qql4a.fsf@verdi.suse.de> <44AD406A.7090709@de.ibm.com> <200607061900.39406.ak@suse.de>
In-Reply-To: <200607061900.39406.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Good question. Btw. - faster by what order of magnitude?
> 
> pushf + popf is on K8 at least ~18 cycles, on P4 it is much more
> because they synchronize the pipeline there (hundreds of cycles)
> 
> cpu local add would be a few cycles at best and doesn't have
> any impact on the pipeline
> 
> 
>> local_irq_save/restore seems to be fine for kernel/profile.c
>>
>>
>> Reason 1:
>> cpu_local_* uses __get_cpu_var, which conflicts with struct statistic
>> being embedded into struct xyz that is allocated whenever the client
>> needs it.
>>
>> I could try to use local_t in conjunction with local_add etc.
>> (as seen in include/linux/dmaengine.h in 2.6.17-mm6).
>> Does this also yield a performance gain worth consideration?
> 
> Yes, but you would need preempt_disable() then. For non preemptible
> kernels (far majority) that would be already a big win.
> 
> 
>> So, removing local_irq_save/restore would require statistics to be
>> switched on and their buffers being available all the time. That is,
>> buffers holding counters etc. can't be allocated at run time - what
>> if allocation fails? (Should I leave this issue to clients?).
> 
> Can't you use RCU for this?
> 
> 
>> Reason 4:
>> The alleged overhead of local_irq_save/restore (as compared
>> to atomic operations) 
> 
> local_* doesn't need to be atomic. IT isn't on x86 at least.
> On some other architectures it can be, but i think it's just a SMOP
> of fixing them.
> 
> -Andi

Thanks. I am seriously considering these techniques.

If I manage to use RCU for most of the read-mostly struct statistic
and to push any other locking issues down into individual statistic
disciplines (utilisation indicator, histogram and so on), I should be
able to use local_t for some disciplines (particularyl counter and
histogram) without needing other locking primitives, like
local_irq_save/restore currently currently found in the code.

Not a change that can be done this afternoon, though.
And it will require careful review.

Martin

