Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTKZQaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKZQaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:30:22 -0500
Received: from siaar1aa.compuserve.com ([149.174.40.9]:3829 "EHLO
	siaar1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264246AbTKZQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:30:13 -0500
Message-ID: <3FC4D5B8.2010808@aol.com>
Date: Wed, 26 Nov 2003 17:32:56 +0100
From: Kai Bankett <kbankett@aol.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Kai Bankett <kbankett@aol.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_balance does not make sense with HT but single physical
 CPU
References: <3FC4B5C8.6020405@aol.com> <Pine.LNX.4.58.0311261042540.1683@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311261042540.1683@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Wed, 26 Nov 2003, Kai Bankett wrote:
> 
>> this patch should disable irq_balance threat in case of only one
>> installed physical cpu thats running in HyperThreading-mode (so reported
>> as 2 cpus).
>> I think it should make no sense to run irq_blanance in that special case
>> - please correct me if i´m wrong.
> 
> 
> +#ifdef CONFIG_X86_HT
> +   /* On Hyper-Threading CPUs - if only one physical installed
> +      balance does not make sense */
> +   if (cpu_has_ht && smp_num_siblings == 2 && num_online_cpus() == 2) {
> +       irqbalance_disabled = 1;
> +       return 0;
> +   }
> +#endif
> 
> Further down, i believe the following would have the same effect;
> 
>    /*
>     * Enable physical balance only if more than 1 physical processor
>     * is present
>     */
>    if (smp_num_siblings > 1 && !cpus_empty(tmp))
>        physical_balance = 1;
> 
> 
> tmp = cpu_online_map >> 2;
> 
> so we drop the first two processors (logical or physical) and only enable
> physical balance if there are still processors present in the map. Or are
> you observing something else?
> 

Ok - inserted an printk(smp_num_siblings) to have a look into 
smp_num_siblings at that point.

It says : smp_num_siblings = 2

But anyways if physical_balance is set to 1 that won´t prevent anything 
from running through/sleeping in the kernel_thread-loop.
The kernel_thread(balance_irq ...) later on will be started/will run not 
matter what physical_balance says.

Do there exist any cases where smp_siblings are created without 
HyperThreading ? (As far as I remember it´s only incremented/used on 
i386 hyperthreaded architectures - but not 100% sure)

-> At least the if has to look like :

...
if (smp_num_siblings > 2 && !cpus_empty(tm))
     physical_balance = 1;
...

(if - like in my case - smp_num_siblings == 2 on a single P4 system)

That one still does not solve the case in which the kernel_thread is not 
needed and only eats resources.
Of course - maybe the whole thing can be merged together. Not sure about 
that. But source will become more complex in that case - k.i.s.s. may be 
the better approach.

Thanks,

Kai

-- 
--------------------------------------------
Kai Bankett
Network Engineering

AOL Deutschland GmbH & Co. KG

Millerntorplatz 1
20359 Hamburg
Tel.:  +49 40 36159 - 7559
Fax.:  +49 40 36159 - 7510
Mobil: +49 172 2353870
eMail to  kbankett@aol.com
AIM:      kbankett
--------------------------------------------

