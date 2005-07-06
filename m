Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVGFJjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVGFJjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVGFJi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:38:59 -0400
Received: from fmr18.intel.com ([134.134.136.17]:1445 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262139AbVGFHfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:35:40 -0400
Subject: Re: [PATCH] [16/48] Suspend2 2.1.9.8 for 2.6.12:
	406-dynamic-pageflags.patch
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11206164411593@foobar.com>
References: <11206164411593@foobar.com>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 15:46:23 +0800
Message-Id: <1120635983.6970.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 12:20 +1000, Nigel Cunningham wrote:
> +
> +/*
> + * Save and restore processor state for secondary processors.
> + * IRQs (and therefore preemption) are already disabled 
> + * when we enter here (IPI).
> + */
> +
> +static volatile int loop __nosavedata;
> +
> +void __smp_suspend_lowlevel(void * data)
> +{
> +	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
> +
> +	if (test_suspend_state(SUSPEND_NOW_RESUMING)) {
> +		BUG_ON(!irqs_disabled());
> +		kernel_fpu_begin();
> +		c_loops_per_jiffy_ref[_smp_processor_id()] = current_cpu_data.loops_per_jiffy;
> +		atomic_inc(&suspend_cpu_counter);
> +
> +		/* Only image copied back while we spin in this loop. Our
> +		 * task info should not be looked at while this is happening
> +		 * (which smp_processor_id() will do( */
> +		while (test_suspend_state(SUSPEND_FREEZE_SMP)) { 
> +			cpu_relax();
> +			barrier();
> +		}
> +
> +		while (atomic_read(&suspend_cpu_counter) != _smp_processor_id()) {
> +			cpu_relax();
> +			barrier();
> +		}
> +	       	my_saved_context = (unsigned char *) (suspend2_saved_contexts + _smp_processor_id());
> +		for (loop = sizeof(struct suspend2_saved_context); loop--; loop)
> +			*(((unsigned char *) &suspend2_saved_context) + loop - 1) = *(my_saved_context + loop - 1);
> +		suspend2_restore_processor_context();
> +		cpu_clear(_smp_processor_id(), per_cpu(cpu_tlbstate, _smp_processor_id()).active_mm->cpu_vm_mask);
> +		load_cr3(swapper_pg_dir);
> +		wbinvd();
> +		__flush_tlb_all();
> +		current_cpu_data.loops_per_jiffy = c_loops_per_jiffy_ref[_smp_processor_id()];
> +		mtrr_restore_one_cpu();
> +		atomic_dec(&suspend_cpu_counter);
> +	} else {	/* suspending */
> +		BUG_ON(!irqs_disabled());
> +		/* 
> +		 *Save context and go back to idling.
> +		 * Note that we cannot leave the processor
> +		 * here. It must be able to receive IPIs if
> +		 * the LZF compression driver (eg) does a
> +		 * vfree after compressing the kernel etc
> +		 */
> +		while (test_suspend_state(SUSPEND_FREEZE_SMP) &&
> +			(atomic_read(&suspend_cpu_counter) != (_smp_processor_id() - 1))) {
> +			cpu_relax();
> +			barrier();
> +		}
> +		suspend2_save_processor_context();
> +		my_saved_context = (unsigned char *) (suspend2_saved_contexts + _smp_processor_id());
> +		for (loop = sizeof(struct suspend2_saved_context); loop--; loop)
> +			*(my_saved_context + loop - 1) = *(((unsigned char *) &suspend2_saved_context) + loop - 1);
> +		atomic_inc(&suspend_cpu_counter);
> +		/* Now spin until the atomic copy of the kernel is made. */
> +		while (test_suspend_state(SUSPEND_FREEZE_SMP)) {
> +			cpu_relax();
> +			barrier();
> +		}
> +		atomic_dec(&suspend_cpu_counter);
> +		kernel_fpu_end();
> +	}
> +}
we are using cpu hotplug for S3 & S4 SMP to avoid nasty deadlocks. Could
this be avoided in suspend2 SMP?

Thanks,
Shaohua

