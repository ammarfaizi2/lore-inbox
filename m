Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSKRVWl>; Mon, 18 Nov 2002 16:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSKRVWl>; Mon, 18 Nov 2002 16:22:41 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:24709 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264785AbSKRVWk>;
	Mon, 18 Nov 2002 16:22:40 -0500
Message-ID: <3DD95B7B.20400@colorfullife.com>
Date: Mon, 18 Nov 2002 22:28:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: torvalds@transmeta.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
References: <Pine.LNX.4.44.0211181920540.11872-100000@dbl.q-ag.de> <20021118205712.GR11776@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Mon, Nov 18, 2002 at 07:30:37PM +0100, Manfred Spraul wrote:
>  
>
>>__cpu_up is called in the context of the boot cpu, not in the context of 
>>the new cpu.
>>I think this patch should keep the interrupts disabled until after
>>smp_commenced is set. It's partially tested: bochs boots until all cpus
>>are up and then crashes.
>>I've tested the interrupt flag (pushfl;popfl), noone else enables them.
>>    
>>
>
>That's odd, this should (in theory) enable them:
>
>void __init setup_secondary_APIC_clock(void)
>{
>        local_irq_disable(); /* FIXME: Do we need this? --RR */
>        setup_APIC_timer(calibration_result);
>        local_irq_enable();
>}
>  
>

That's ok.

>
>> +
>> +	local_irq_enable();
>>  	setup_secondary_APIC_clock();
>> 
>
Irqs are enabled just before setup_secondary_APIC_clock();

SMP bootstrap for i386 is
init() [linux/init/main.c()]
-> smp_prepare_cpus()
    -> smp_boot_cpus() [arch/i386/kernel/smpboot.c]
        ->do_boot_cpu()
            -> kick the new cpu.
            new cpu: spinns on the smp_commenced_mask
***** start of critical area: new cpu must not get an irq
-> do_pre_smp_initcalls()
-> smp_init()
    ->cpu_up() [kernel/cpu.c]
        -> CPU_ONLINE_PREPARE notifier call
***** end of critical area: memory for new cpu initialized
        ->__cpu_up() [arch/i386/kernel/smpboot.c]
            -> set_bit(smp_commenced_mask);

--
    Manfred


