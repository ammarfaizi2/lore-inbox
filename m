Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSKRUxU>; Mon, 18 Nov 2002 15:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKRUxU>; Mon, 18 Nov 2002 15:53:20 -0500
Received: from holomorphy.com ([66.224.33.161]:19169 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264795AbSKRUxS>;
	Mon, 18 Nov 2002 15:53:18 -0500
Date: Mon, 18 Nov 2002 12:57:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@transmeta.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
Message-ID: <20021118205712.GR11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>, torvalds@transmeta.com,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211181920540.11872-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211181920540.11872-100000@dbl.q-ag.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 07:30:37PM +0100, Manfred Spraul wrote:
> __cpu_up is called in the context of the boot cpu, not in the context of 
> the new cpu.
> I think this patch should keep the interrupts disabled until after
> smp_commenced is set. It's partially tested: bochs boots until all cpus
> are up and then crashes.
> I've tested the interrupt flag (pushfl;popfl), noone else enables them.

That's odd, this should (in theory) enable them:

void __init setup_secondary_APIC_clock(void)
{
        local_irq_disable(); /* FIXME: Do we need this? --RR */
        setup_APIC_timer(calibration_result);
        local_irq_enable();
}


> --- 2.5/arch/i386/kernel/smpboot.c	2002-11-04 23:30:27.000000000 +0100
> +++ build-2.5/arch/i386/kernel/smpboot.c	2002-11-18 19:19:38.000000000 +0100
> @@ -405,8 +405,6 @@
>  		clear_local_APIC();
>  	setup_local_APIC();
>  
> -	local_irq_enable();
> -
>  	/*
>  	 * Get our bogomips.
>  	 */
> @@ -449,6 +447,8 @@
>  	smp_callin();
>  	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
>  		rep_nop();
> +
> +	local_irq_enable();
>  	setup_secondary_APIC_clock();
>  	if (nmi_watchdog == NMI_IO_APIC) {
>  		disable_8259A_irq(0);

I've booted this and it functions equivalently on my machines.


Bill
