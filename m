Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDDSPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDDSPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDDSPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:15:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8335 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750783AbWDDSPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:15:09 -0400
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] kexec on ia64
References: <1144102818.8279.6.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 12:13:50 -0600
In-Reply-To: <1144102818.8279.6.camel@localhost.localdomain> (Khalid Aziz's
 message of "Mon, 03 Apr 2006 16:20:18 -0600")
Message-ID: <m1r74d43a9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid_aziz@hp.com> writes:

> Add kexec support on ia64.

This looks like a starting place but this patch needs some
more work.

> Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
> ---
>
> diff -urNp linux-2.6.16/arch/ia64/hp/common/sba_iommu.c
> linux-2.6.16-kexec/arch/ia64/hp/common/sba_iommu.c
> --- linux-2.6.16/arch/ia64/hp/common/sba_iommu.c 2006-03-19 22:53:29.000000000
> -0700
> +++ linux-2.6.16-kexec/arch/ia64/hp/common/sba_iommu.c 2006-03-27
> 15:42:47.000000000 -0700
> @@ -1624,6 +1624,28 @@ ioc_iova_init(struct ioc *ioc)
>  	READ_REG(ioc->ioc_hpa + IOC_IBASE);
>  }
>  
> +#ifdef CONFIG_KEXEC
> +void
> +ioc_iova_disable(void)
> +{
> +	struct ioc *ioc;
> +
> +	ioc = ioc_list;
> +
> +	while (ioc != NULL) {
> +		/* Disable IOVA translation */
> + WRITE_REG(ioc->ibase & 0xfffffffffffffffe, ioc->ioc_hpa + IOC_IBASE);
> +		READ_REG(ioc->ioc_hpa + IOC_IBASE);
> +
> +		/* Clear I/O TLB of any possible entries */
> + WRITE_REG(ioc->ibase | (get_iovp_order(ioc->iov_size) + iovp_shift),
> ioc->ioc_hpa + IOC_PCOM);
> +		READ_REG(ioc->ioc_hpa + IOC_PCOM);
> +
> +		ioc = ioc->next;
> +	}
> +}
> +#endif
> +
>  static void __init
>  ioc_resource_init(struct ioc *ioc)
>  {
> diff -urNp linux-2.6.16/arch/ia64/Kconfig linux-2.6.16-kexec/arch/ia64/Kconfig
> --- linux-2.6.16/arch/ia64/Kconfig	2006-03-19 22:53:29.000000000 -0700
> +++ linux-2.6.16-kexec/arch/ia64/Kconfig 2006-03-27 15:42:47.000000000 -0700
> @@ -376,6 +376,23 @@ config IA64_PALINFO
>  config SGI_SN
>  	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC)
>  
> +config KEXEC
> +	bool "kexec system call (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel.  It is like a reboot
> +	  but it is indepedent of the system firmware.   And like a reboot
> +	  you can start any kernel with it, not just Linux.
> +
> +	  The name comes from the similiarity to the exec system call.
> +
> +	  It is an ongoing process to be certain the hardware in a machine
> +	  is properly shutdown, so do not be surprised if this code does not
> +	  initially work for you.  It may help to enable device hotplugging
> +	  support.  As of this writing the exact hardware interface is
> +	  strongly in flux, so no good recommendation can be made.
> +
>  source "drivers/firmware/Kconfig"
>  
>  source "fs/Kconfig.binfmt"
> diff -urNp linux-2.6.16/arch/ia64/kernel/crash.c
> linux-2.6.16-kexec/arch/ia64/kernel/crash.c
> --- linux-2.6.16/arch/ia64/kernel/crash.c 1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.16-kexec/arch/ia64/kernel/crash.c 2006-03-27 15:49:44.000000000
> -0700
> @@ -0,0 +1,43 @@
> +/*
> + * arch/ia64/kernel/crash.c
> + *
> + * Architecture specific (ia64) functions for kexec based crash dumps.
> + *
> + * Created by: Khalid Aziz <khalid.aziz@hp.com>
> + *
> + * Copyright (C) 2005 Hewlett-Packard Development Company, L.P.
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/smp.h>
> +#include <linux/irq.h>
> +#include <linux/reboot.h>
> +#include <linux/kexec.h>
> +#include <linux/irq.h>
> +#include <linux/delay.h>
> +#include <linux/elf.h>
> +#include <linux/elfcore.h>
> +#include <linux/device.h>
> +
> +void
> +machine_crash_shutdown(struct pt_regs *pt)
> +{
> +	/* This function is only called after the system
> +	 * has paniced or is otherwise in a critical state.
> +	 * The minimum amount of code to allow a kexec'd kernel
> +	 * to run successfully needs to happen here.
> +	 *
> +	 * In practice this means shooting down the other cpus in
> +	 * an SMP system.
> +	 */
> +	if (in_interrupt()) {
> +		terminate_irqs();
> +		ia64_eoi();
> +	}
> +	system_state = SYSTEM_RESTART;
> +	device_shutdown();
> +	system_state = SYSTEM_BOOTING;
> +	machine_shutdown();
> +}

machine_crash_shutdown must not call device_shutdown.  That has
been shown to way exceed the minimum necessary to shutdown a system.
I would prefer this to be a noop stub that doesn't work at all than
something like this that does way too much, and makes people think
the code will work.

As for terminate_irqs on x86 we do that on bootup not in the middle
of a crash shutdown.  The apics and xapics are close enough you
should be able to do the same on ia64.

You display remarkable faith in a kernel that has paniced.

> +#ifdef CONFIG_PCI
> +void machine_shutdown(void)
> +{
> +	struct pci_dev *dev;
> +	irq_desc_t *idesc;
> +	cpumask_t mask = CPU_MASK_NONE;
> +
> +	/* Disable all PCI devices */
> +	list_for_each_entry(dev, &pci_devices, global_list) {
> +		if (!(dev->is_enabled))
> +			continue;
> +		idesc = irq_descp(dev->irq);
> +		if (!idesc)
> +			continue;
> +		cpu_set(0, mask);
> +		disable_irq_nosync(dev->irq);
> +		idesc->handler->end(dev->irq);
> +		idesc->handler->set_affinity(dev->irq, mask);
> +		idesc->action = NULL;
> +		pci_disable_device(dev);
> +		pci_set_power_state(dev, 0);
> +	}
> +}
> +#endif

This is peculiar but almost sane.  We don't do this on x86,
because devices are peculiar enough that no generic sequence works.
What you have above belongs in the shutdown methods of the pci
devices.  There is no way to get this right in the general case.

some of the irq disable logic may in fact be sane.

Unless there is a good reason not to machine_shutdown needs
to be called from machine_restart.  So the code is routinely
used and tested.

Having machine_shutdown only build when you have PCI present
and then not making KEXEC depend on PCI is wrong.

The #ifdef needs to move inside machine_shutdown.

> +
> +/*
> + * Do not allocate memory (or fail in any way) in machine_kexec().
> + * We are past the point of no return, committed to rebooting now. 
> + */
> +void machine_kexec(struct kimage *image)
> +{
> +	unsigned long indirection_page;
> +	relocate_new_kernel_t rnk;
> +	unsigned long pta, impl_va_bits;
> +	void *pal_addr = efi_get_pal_addr();
> + unsigned long code_addr = (unsigned
> long)page_address(image->control_code_page);
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu != smp_processor_id())
> +			cpu_down(cpu);
> +	}
> +#elif CONFIG_SMP
> +	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
> +#endif

This CPU and HOTPUG_CPU stuff belongs in machine shutdown.

> +
> +	ia64_set_itv(1<<16);
> +	/* Interrupts aren't acceptable while we reboot */
> +	local_irq_disable();
> +
> +	/* set kr0 to the appropriate address */
> +	set_io_base();
> +
> +	/* Disable VHPT */
> +	impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
> +	pta = POW2(61) - POW2(vmlpt_bits);
> +	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
> +
> +#ifdef CONFIG_IA64_HP_ZX1
> +	ioc_iova_disable();
> +#endif

This also looks like it needs to be part of machine_shutdown.
I have no confidence in ioc_iova_disable when the machine is crashing.
Basically anything that touches a pointer is likely to be bad.

> +	/* now execute the control code.
> +	 * We will start by executing the control code linked into the 
> + * kernel as opposed to the code we copied in control code buffer * page. When
> this code switches to physical mode, we will start
> +	 * executing the code in control code buffer page. Reason for
> +	 * doing this is we start code execution in virtual address space.
> +	 * If we were to try to execute the newly copied code in virtual
> +	 * address space, we will need to make an ITLB entry to avoid ITLB 
> +	 * miss. By executing the code linked into kernel, we take advantage
> +	 * of the ITLB entry already in place for kernel and avoid making
> +	 * a new entry.
> +	 */
> +	indirection_page = image->head & PAGE_MASK;
> +
> +	rnk = (relocate_new_kernel_t)&code_addr;
> +	(*rnk)(indirection_page, image->start, ia64_boot_param,
> +		     GRANULEROUNDDOWN((unsigned long) pal_addr));
> +	BUG();
> +	for (;;)
> +		;
> +}


Eric
