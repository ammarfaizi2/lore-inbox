Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWCNGqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWCNGqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWCNGqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:46:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbWCNGqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:46:35 -0500
Date: Mon, 13 Mar 2006 22:44:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: fastboot@lists.osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] kexec for ia64
Message-Id: <20060313224404.1133fc28.akpm@osdl.org>
In-Reply-To: <1142271576.10787.15.camel@lyra.fc.hp.com>
References: <1142271576.10787.15.camel@lyra.fc.hp.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid_aziz@hp.com> wrote:
>
> I have updated kexec patch for ia64. Attached patch fixes a couple of
> bugs from previous version and incorporates code developed by Nan Hai.
> This patch works on 2.6.16-rc6 kernel. Also attached is a patch for
> kexec-tools which applies on top of kexec-tools-1.101 release from Eric
> Biederman <http://www.xmission.com/%
> 7Eebiederm/files/kexec/kexec-tools-1.101.tar.gz> and adds support for
> ia64. Please test and provide feedback.
> 
> I am working on integrating kdump support and will post that patch once
> I have tested it.
> 

> diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/crash.c linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/crash.c
> --- linux-2.6.16-rc2/arch/ia64/kernel/crash.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/crash.c	2006-02-09 15:36:23.000000000 -0700
> ...
> +extern void device_shutdown(void);
> ...

extern declarations always go in headers, please.  This patch adds zillions
of them in .c files.  It is risky and duplicative.

> diff -urNp linux-2.6.16-rc2/arch/ia64/kernel/machine_kexec.c linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/machine_kexec.c
> --- linux-2.6.16-rc2/arch/ia64/kernel/machine_kexec.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/machine_kexec.c	2006-03-10 14:36:51.000000000 -0700
> ...
> +#include <linux/kernel.h>
> +#include <linux/config.h>
> +#include <linux/mm.h>
> +#include <linux/kexec.h>
> +#include <linux/pci.h>
> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <linux/cpu.h>
> +#endif

The ifdef shouldn't be needed.

> +
> +DECLARE_PER_CPU(u64, ia64_mca_pal_base);
> +
> +extern unsigned long ia64_iobase;
> +extern unsigned long kexec_reboot;
> +extern void kexec_stop_this_cpu(void *);
> +extern struct subsystem devices_subsys;

In header files.

> +const extern unsigned char relocate_new_kernel[];
> +const extern unsigned long kexec_fake_sal_rendez[];
> +const extern unsigned int relocate_new_kernel_size;

Even things which are defined via vmlinux.lds magic should be declared in
headers.

> +extern void ioc_iova_disable(void);

In a header.

> +volatile extern long kexec_rendez;
> +volatile const extern unsigned char kexec_rendez_reloc[];

Ditto.

> +
> +void machine_shutdown(void)
> +{
> +	struct pci_dev *dev;
> +	irq_desc_t *idesc;
> +	cpumask_t mask = CPU_MASK_NONE;
> +
> +	/* Disable all PCI devices */
> +	list_for_each_entry(dev, &pci_devices, global_list) {
> +		if (!(dev->is_enabled)) {
> +			continue;
> +		}

Unneeded braces.

> +		if (!(idesc = irq_descp(dev->irq)))

This:

		idesc = irq_descp(dev->irq);
		if (!idesc)

is preferred.

> +#ifdef CONFIG_SMP
> +#ifdef CONFIG_HOTPLUG_CPU

#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_CPU)

is tidier.   But CONFIG_HOTPLUG_CPU already depends on CONFIG_SMP.


> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu != smp_processor_id())
> +			cpu_down(cpu);
> +	}
> +#else
> +	smp_call_function(kexec_stop_this_cpu, (void *)image->start, 0, 0);
> +#endif
> +#endif

Why is different code needed for hotplug cpu?

> +	ia64_set_itv(1<<16);
> +	/* Interrupts aren't acceptable while we reboot */
> +	local_irq_disable();
> +
> +	/* set kr0 to the appropriate address */
> +	set_io_base();
> +
> +	{
> +		unsigned long pta, impl_va_bits;
> +
> +#       define pte_bits                 3
> +#       define vmlpt_bits               (impl_va_bits - PAGE_SHIFT + pte_bits)

Why not simply open-code these things?

> +#       define POW2(n)                  (1ULL << (n))

And that.

> +		/* Disable VHPT */
> +		impl_va_bits = ffz(~(local_cpu_data->unimpl_va_mask | (7UL << 61)));
> +		pta = POW2(61) - POW2(vmlpt_bits);
> +		ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | 0);
> +	}
> +
> +#ifdef CONFIG_IA64_HP_ZX1
> +	ioc_iova_disable();
> +#endif

> ...

> --- linux-2.6.16-rc2/arch/ia64/kernel/smp.c	2006-01-02 20:21:10.000000000 -0700
> +++ linux-2.6.16-rc2-ia64kexec/arch/ia64/kernel/smp.c	2006-02-15 16:37:33.000000000 -0700
> @@ -30,6 +30,9 @@
>  #include <linux/delay.h>
>  #include <linux/efi.h>
>  #include <linux/bitops.h>
> +#ifdef CONFIG_KEXEC
> +#include <linux/kexec.h>
> +#endif

The ifdefs shouldn't be needed.

>  #include <asm/atomic.h>
>  #include <asm/current.h>
> @@ -84,6 +87,43 @@ unlock_ipi_calllock(void)
>  	spin_unlock_irq(&call_lock);
>  }
>  
> +#ifdef CONFIG_KEXEC
> +extern void kexec_fake_sal_rendez(void *start, unsigned long wake_up,
> +		unsigned long pal_base);

That should go in a header file.

> +#define pte_bits	3
> +#define vmlpt_bits	(impl_va_bits - PAGE_SHIFT + pte_bits)
> +#define POW2(n)		(1ULL << (n))

Duplicative.

> +DECLARE_PER_CPU(u64, ia64_mca_pal_base);

In a header file.

>  /*
> + * Terminate any outstanding interrupts
> + */
> +void terminate_irqs(void)
> +{
> +	struct irqaction * action;
> +	irq_desc_t *idesc;
> +	int i;
> +
> +	for (i=0; i<NR_IRQS; i++) {
> +		idesc = irq_descp(i);
> +		action = idesc->action;
> +		if (!action)
> +			continue;
> +		if (idesc->handler->end)
> +			idesc->handler->end(i);
> +	}
> +}

Perhaps that should be in kernel/irq/something.c?
