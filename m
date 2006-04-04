Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWDDEVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWDDEVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWDDEVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:21:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751437AbWDDEVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:21:43 -0400
Date: Mon, 3 Apr 2006 21:20:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] kexec on ia64
Message-Id: <20060403212049.480ad388.akpm@osdl.org>
In-Reply-To: <1144102818.8279.6.camel@localhost.localdomain>
References: <1144102818.8279.6.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid_aziz@hp.com> wrote:
>
> Add kexec support on ia64.
> 

Neat.  How well does it work?

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

Ahem.

  /* Do NOT directly access these two variables, unless you are arch specific pci
   * code, or pci core code. */
  extern struct list_head pci_root_buses;	/* list of all known PCI buses */
  extern struct list_head pci_devices;	/* list of all devices */

I think it would be kinder to the API to use pci_find_device(PCI_ANY_ID,
PCI_ANY_ID, ...) here.

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
> +	unsigned long code_addr = (unsigned long)page_address(image->control_code_page);
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu != smp_processor_id())
> +			cpu_down(cpu);
> +	}
> +#elif CONFIG_SMP

This will generate a CPP warning if CONFIG_SMP is not defined.

	#elif defined(CONFIG_SMP)

would be preferred.

> --- linux-2.6.16/kernel/irq/manage.c	2006-03-19 22:53:29.000000000 -0700
> +++ linux-2.6.16-kexec/kernel/irq/manage.c	2006-03-27 17:02:08.000000000 -0700
> @@ -377,3 +377,22 @@ int request_irq(unsigned int irq,
>  
>  EXPORT_SYMBOL(request_irq);
>  
> +/*
> + * Terminate any outstanding interrupts
> + */
> +void terminate_irqs(void)
> +{
> +	struct irqaction * action;
> +	irq_desc_t *idesc;
> +	int i;
> +
> +	for (i=0; i<NR_IRQS; i++) {

	for (i = 0; i < NR_IRQS; i++) {

> +		idesc = irq_descp(i);
> +		action = idesc->action;
> +		if (!action)
> +			continue;
> +		if (idesc->handler->end)
> +			idesc->handler->end(i);
> +	}
> +}

Could we have a bit more description of what this function does, and why we
need it?

Should other kexec-using architectures be using this?  If not, why does
ia64 need it?

Thanks.
