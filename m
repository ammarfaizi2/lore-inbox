Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWDEQe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDEQe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDEQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:34:27 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:18639 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751261AbWDEQe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:34:26 -0400
Subject: Re: [Fastboot] [PATCH] kexec on ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <m1r74d43a9.fsf@ebiederm.dsl.xmission.com>
References: <1144102818.8279.6.camel@localhost.localdomain>
	 <m1r74d43a9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 10:34:24 -0600
Message-Id: <1144254864.16025.30.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 12:13 -0600, Eric W. Biederman wrote:
> Khalid Aziz <khalid_aziz@hp.com> writes:
> > +void
> > +machine_crash_shutdown(struct pt_regs *pt)
> > +{
> > +	/* This function is only called after the system
> > +	 * has paniced or is otherwise in a critical state.
> > +	 * The minimum amount of code to allow a kexec'd kernel
> > +	 * to run successfully needs to happen here.
> > +	 *
> > +	 * In practice this means shooting down the other cpus in
> > +	 * an SMP system.
> > +	 */
> > +	if (in_interrupt()) {
> > +		terminate_irqs();
> > +		ia64_eoi();
> > +	}
> > +	system_state = SYSTEM_RESTART;
> > +	device_shutdown();
> > +	system_state = SYSTEM_BOOTING;
> > +	machine_shutdown();
> > +}
> 
> machine_crash_shutdown must not call device_shutdown.  That has
> been shown to way exceed the minimum necessary to shutdown a system.
> I would prefer this to be a noop stub that doesn't work at all than
> something like this that does way too much, and makes people think
> the code will work.
> 
> As for terminate_irqs on x86 we do that on bootup not in the middle
> of a crash shutdown.  The apics and xapics are close enough you
> should be able to do the same on ia64.
> 
> You display remarkable faith in a kernel that has paniced.

I will look into eliminating this as much as possible.

> Having machine_shutdown only build when you have PCI present
> and then not making KEXEC depend on PCI is wrong.
> 
> The #ifdef needs to move inside machine_shutdown.

Fixed.

> 
> > +
> > +/*
> > + * Do not allocate memory (or fail in any way) in machine_kexec().
> > + * We are past the point of no return, committed to rebooting now. 
> > + */
> > +void machine_kexec(struct kimage *image)
> > +{
> > +	unsigned long indirection_page;
> > +	relocate_new_kernel_t rnk;
> > +	unsigned long pta, impl_va_bits;
> > +	void *pal_addr = efi_get_pal_addr();
> > + unsigned long code_addr = (unsigned
> > long)page_address(image->control_code_page);
> > +
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu != smp_processor_id())
> > +			cpu_down(cpu);
> > +	}
> > +#elif CONFIG_SMP
> > +	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
> > +#endif
> 
> This CPU and HOTPUG_CPU stuff belongs in machine shutdown.

Moved to machine_shutdown().

> 
> > +
> > +	ia64_set_itv(1<<16);
> > +	/* Interrupts aren't acceptable while we reboot */
> > +	local_irq_disable();
> > +
> > +	/* set kr0 to the appropriate address */
> > +	set_io_base();
> > +
> > +	/* Disable VHPT */
> > +	impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
> > +	pta = POW2(61) - POW2(vmlpt_bits);
> > +	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
> > +
> > +#ifdef CONFIG_IA64_HP_ZX1
> > +	ioc_iova_disable();
> > +#endif
> 
> This also looks like it needs to be part of machine_shutdown.
> I have no confidence in ioc_iova_disable when the machine is crashing.
> Basically anything that touches a pointer is likely to be bad.

I have moved above code to machine_shutdown. I would prefer to delay
disabling VHPT as much as possible, but since machine_kexec gets called
soon after machine_shutdown and we should be executing kernel code
strictly at this point which uses pinned TR entries, disabling VHPT
should not have any deleterious effect.

> 
> > +	/* now execute the control code.
> > +	 * We will start by executing the control code linked into the 
> > + * kernel as opposed to the code we copied in control code buffer * page. When
> > this code switches to physical mode, we will start
> > +	 * executing the code in control code buffer page. Reason for
> > +	 * doing this is we start code execution in virtual address space.
> > +	 * If we were to try to execute the newly copied code in virtual
> > +	 * address space, we will need to make an ITLB entry to avoid ITLB 
> > +	 * miss. By executing the code linked into kernel, we take advantage
> > +	 * of the ITLB entry already in place for kernel and avoid making
> > +	 * a new entry.
> > +	 */
> > +	indirection_page = image->head & PAGE_MASK;
> > +
> > +	rnk = (relocate_new_kernel_t)&code_addr;
> > +	(*rnk)(indirection_page, image->start, ia64_boot_param,
> > +		     GRANULEROUNDDOWN((unsigned long) pal_addr));
> > +	BUG();
> > +	for (;;)
> > +		;
> > +}
> 
> 
> Eric

Thanks for the review.

-- 
Khalid

====================================================================
Khalid Aziz                       Open Source and Linux Organization
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


