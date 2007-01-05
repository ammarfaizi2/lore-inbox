Return-Path: <linux-kernel-owner+w=401wt.eu-S1750829AbXAEWuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXAEWuQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXAEWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:50:15 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53419 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXAEWuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:50:14 -0500
Message-ID: <459ED624.1080100@vmware.com>
Date: Fri, 05 Jan 2007 14:50:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu> <459ECDF7.9040309@vmware.com> <20070105223009.GA15369@elte.hu>
In-Reply-To: <20070105223009.GA15369@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Zachary Amsden <zach@vmware.com> wrote:
>
>   
>> What you really want is more like 
>> EXPORT_SYMBOL_READABLE_GPL(paravirt_ops);
>>     
>
> yep. Not a big issue - what is important is to put the paravirt ops into 
> the read-only section so that it's somewhat harder for rootkits to 
> modify. (Also, it needs to be made clear that this is fundamental, 
> lowlevel system functionality written by people under the GPLv2, so that 
> if you utilize it beyond its original purpose, using its internals, you 
> likely create a work derived from the kernel. Something simple as irq 
> disabling probably doesnt qualify, and that we exported to modules for a 
> long time, but lots of other details do. So the existence of 
> paravirt_ops isnt a free-for all.)
>   

I agree completely.  It would be nice to have a way to make certain 
kernel structures available, but non-mutable to non-GPL modules.

>> But I'm not sure that is technically feasible yet.
>>
>> The kvm code should probably go in kvm.c instead of paravirt.c.
>>     
>
> no. This is fundamental architecture boot code, not module code. kvm.c 
> should eventually go into kernel/ and arch/*/kernel, not the other way 
> around.
>   

What I meant was kvm.c in arch/i386/kernel - as symmetric to the other 
paravirt-ops modules, which live in arch/i386/kernel/vmi.c / lhype.c, 
etc.  Either that, or we should move them to be symmetric, but I don't 
think paravirt.c is the proper place for kvm specific code.


>   
>> Index: linux/drivers/serial/8250.c
>> ===================================================================
>> --- linux.orig/drivers/serial/8250.c
>> +++ linux/drivers/serial/8250.c
>> @@ -1371,7 +1371,7 @@ static irqreturn_t serial8250_interrupt(
>>
>> 		l = l->next;
>>
>> -		if (l == i->head && pass_counter++ > PASS_LIMIT) {
>> +		if (!kvm_paravirt 
>>
>> Is this a bug that might happen under other virtualizations as well, 
>> not just kvm? Perhaps it deserves a disable feature instead of a kvm 
>> specific check.
>>     
>
> yes - this limit is easily triggered via the KVM/Qemu virtual serial 
> drivers. You can think of "kvm_paravirt" as "Linux paravirt", it's just 
> a flag.
>   

Can't you just test paravirt_enabled() in that case?


Zach
