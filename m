Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266216AbSKFXZp>; Wed, 6 Nov 2002 18:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266217AbSKFXZp>; Wed, 6 Nov 2002 18:25:45 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60844 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266216AbSKFXZn>;
	Wed, 6 Nov 2002 18:25:43 -0500
Date: Wed, 06 Nov 2002 16:27:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
Message-ID: <150020000.1036628836@flay>
In-Reply-To: <3DC99892.A3750D7E@digeo.com>
References: <3DC975DC.77231191@digeo.com> <132110000.1036622931@flay> <3DC99892.A3750D7E@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> BOOT CPU:
>> ... 
>
> Nice!
 
Thanks. Of course it leaves out various bits, I just put in what I 
thought was interesting. But otherwise you can't see anything easily
anyway.

> So this is the bug, isn't it?  Can the calibrate_delay stuff be moved
> until _after_ the bit has been set in smp_commenced_mask??

Mmmm .... not sure ... that'll need some more thought.
For now I did:

---------------------

BOOT CPU:

init
	smp_prepare_cpus
		smp_boot_cpus
			setup_local_APIC
			foreach cpu
				do_boot_cpu
					wakeup_secondary_via_(NMI|INIT)
					{set bit in cpu_callout_map}
					{spin on cpu_callin_map}
			setup_IO_APIC
			synchronize_tsc_bp
	smp_init
		foreach cpu 
			cpu_up
				notifier_call_chain(CPU_UP_PREPARE)
				__cpu_up
					{set bit in smp_commenced_mask}
					{spin on cpu_online_map}
+					local_irq_enable
				notifier_call_chain(CPU_ONLINE)
		smp_cpus_done
		smp_commence

------------------------

SECONDARY CPU:

start_secondary
	cpu_init
	smp_callin
		{spin on cpu_callout_map}
		setup_local_APIC
		local_irq_enable
		calibrate_delay
		disable_APIC_timer
+		local_irq_disable
		{set our bit in cpu_callin_map}
		synchronise_tsc_api	
	{spin on smp_commenced_mask}
	enable_APIC_timer
	{set our bit in cpu_online_map}
	idle

Which seems to work, and is similar to what James did, I think.

> Maybe you could copy the boot cpu's calibrate_delay result
> over to all cpu_possible secondaries, then redo the calibration
> for real once the secondary is actually legally up and running.

Not sure that's any less ugly than the above ;-) I prefer your
idea of moving calibrate_delay, I'll try that sometime soonish,
but need to stare at what uses the result for a while first.

diff -purN -X /home/mbligh/.diff.exclude virgin/arch/i386/kernel/smpboot.c noearlyirq/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Mon Nov  4 14:30:27 2002
+++ noearlyirq/arch/i386/kernel/smpboot.c	Wed Nov  6 15:22:12 2002
@@ -419,6 +419,7 @@ void __init smp_callin(void)
  	smp_store_cpu_info(cpuid);
 
 	disable_APIC_timer();
+	local_irq_disable();
 	/*
 	 * Allow the master to continue.
 	 */
@@ -1186,6 +1187,7 @@ int __devinit __cpu_up(unsigned int cpu)
 	if (!test_bit(cpu, &cpu_callin_map))
 		return -EIO;
 
+	local_irq_enable();
 	/* Unleash the CPU! */
 	set_bit(cpu, &smp_commenced_mask);
 	while (!test_bit(cpu, &cpu_online_map))



