Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWHPQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWHPQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHPQa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:30:27 -0400
Received: from hera.kernel.org ([140.211.167.34]:58511 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751150AbWHPQaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:30:25 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH for review] [54/145] x86_64: Remove obsolete PIC mode
Date: Wed, 16 Aug 2006 12:31:49 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193609.2977113C0B@wotan.suse.de>
In-Reply-To: <20060810193609.2977113C0B@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161231.49856.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:36, Andi Kleen wrote:


> PIC mode is an outdated way to drive the APICs that was used on 
> some early MP boards. It is not supported in the ACPI model.
> 
> It is unlikely to be ever configured by any x86-64 system
> 
> Remove it thus.

Is there any reason we can't entirely remove MPS from x86_64?
(asside from the routines that ACPI uses)

-Len

> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/x86_64/kernel/apic.c    |   92 +++++++++++++------------------------------
>  arch/x86_64/kernel/mpparse.c |    8 ---
>  arch/x86_64/kernel/smpboot.c |    1 
>  include/asm-x86_64/mpspec.h  |    1 
>  include/asm-x86_64/smp.h     |    1 
>  5 files changed, 29 insertions(+), 74 deletions(-)
> 
> Index: linux/arch/x86_64/kernel/apic.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/apic.c
> +++ linux/arch/x86_64/kernel/apic.c
> @@ -136,72 +136,40 @@ void clear_local_APIC(void)
>  	apic_read(APIC_ESR);
>  }
>  
> -void __init connect_bsp_APIC(void)
> -{
> -	if (pic_mode) {
> -		/*
> -		 * Do not trust the local APIC being empty at bootup.
> -		 */
> -		clear_local_APIC();
> -		/*
> -		 * PIC mode, enable APIC mode in the IMCR, i.e.
> -		 * connect BSP's local APIC to INT and NMI lines.
> -		 */
> -		apic_printk(APIC_VERBOSE, "leaving PIC mode, enabling APIC mode.\n");
> -		outb(0x70, 0x22);
> -		outb(0x01, 0x23);
> -	}
> -}
> -
>  void disconnect_bsp_APIC(int virt_wire_setup)
>  {
> -	if (pic_mode) {
> -		/*
> -		 * Put the board back into PIC mode (has an effect
> -		 * only on certain older boards).  Note that APIC
> -		 * interrupts, including IPIs, won't work beyond
> -		 * this point!  The only exception are INIT IPIs.
> -		 */
> -		apic_printk(APIC_QUIET, "disabling APIC mode, entering PIC mode.\n");
> -		outb(0x70, 0x22);
> -		outb(0x00, 0x23);
> -	}
> -	else {
> -		/* Go back to Virtual Wire compatibility mode */
> -		unsigned long value;
> -
> -		/* For the spurious interrupt use vector F, and enable it */
> -		value = apic_read(APIC_SPIV);
> -		value &= ~APIC_VECTOR_MASK;
> -		value |= APIC_SPIV_APIC_ENABLED;
> -		value |= 0xf;
> -		apic_write(APIC_SPIV, value);
> -
> -		if (!virt_wire_setup) {
> -			/* For LVT0 make it edge triggered, active high, external and enabled */
> -			value = apic_read(APIC_LVT0);
> -			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
> -				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
> -				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
> -			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
> -			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
> -			apic_write(APIC_LVT0, value);
> -		}
> -		else {
> -			/* Disable LVT0 */
> -			apic_write(APIC_LVT0, APIC_LVT_MASKED);
> -		}
> +	/* Go back to Virtual Wire compatibility mode */
> +	unsigned long value;
>  
> -		/* For LVT1 make it edge triggered, active high, nmi and enabled */
> -		value = apic_read(APIC_LVT1);
> -		value &= ~(
> -			APIC_MODE_MASK | APIC_SEND_PENDING |
> +	/* For the spurious interrupt use vector F, and enable it */
> +	value = apic_read(APIC_SPIV);
> +	value &= ~APIC_VECTOR_MASK;
> +	value |= APIC_SPIV_APIC_ENABLED;
> +	value |= 0xf;
> +	apic_write(APIC_SPIV, value);
> +
> +	if (!virt_wire_setup) {
> +		/* For LVT0 make it edge triggered, active high, external and enabled */
> +		value = apic_read(APIC_LVT0);
> +		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
>  			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
> -			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
> +			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
>  		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
> -		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
> -		apic_write(APIC_LVT1, value);
> +		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
> +		apic_write(APIC_LVT0, value);
> +	} else {
> +		/* Disable LVT0 */
> +		apic_write(APIC_LVT0, APIC_LVT_MASKED);
>  	}
> +
> +	/* For LVT1 make it edge triggered, active high, nmi and enabled */
> +	value = apic_read(APIC_LVT1);
> +	value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
> +			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
> +			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
> +	value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
> +	value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
> +	apic_write(APIC_LVT1, value);
>  }
>  
>  void disable_local_APIC(void)
> @@ -418,7 +386,7 @@ void __cpuinit setup_local_APIC (void)
>  	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
>  	 */
>  	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
> -	if (!smp_processor_id() && (pic_mode || !value)) {
> +	if (!smp_processor_id() && !value) {
>  		value = APIC_DM_EXTINT;
>  		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", smp_processor_id());
>  	} else {
> @@ -1096,8 +1064,6 @@ int __init APIC_init_uniprocessor (void)
>  
>  	verify_local_APIC();
>  
> -	connect_bsp_APIC();
> -
>  	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_id);
>  	apic_write(APIC_ID, SET_APIC_ID(boot_cpu_id));
>  
> Index: linux/arch/x86_64/kernel/mpparse.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/mpparse.c
> +++ linux/arch/x86_64/kernel/mpparse.c
> @@ -56,7 +56,6 @@ struct mpc_config_intsrc mp_irqs[MAX_IRQ
>  int mp_irq_entries;
>  
>  int nr_ioapics;
> -int pic_mode;
>  unsigned long mp_lapic_addr = 0;
>  
>  
> @@ -514,13 +513,6 @@ void __init get_smp_config (void)
>   		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
>  
>  	printk("Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
> -	if (mpf->mpf_feature2 & (1<<7)) {
> -		printk(KERN_INFO "    IMCR and PIC compatibility mode.\n");
> -		pic_mode = 1;
> -	} else {
> -		printk(KERN_INFO "    Virtual Wire compatibility mode.\n");
> -		pic_mode = 0;
> -	}
>  
>  	/*
>  	 * Now see if we need to read further.
> Index: linux/include/asm-x86_64/mpspec.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/mpspec.h
> +++ linux/include/asm-x86_64/mpspec.h
> @@ -178,7 +178,6 @@ extern int mp_irq_entries;
>  extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
>  extern int mpc_default_type;
>  extern unsigned long mp_lapic_addr;
> -extern int pic_mode;
>  
>  #ifdef CONFIG_ACPI
>  extern void mp_register_lapic (u8 id, u8 enabled);
> Index: linux/include/asm-x86_64/smp.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/smp.h
> +++ linux/include/asm-x86_64/smp.h
> @@ -33,7 +33,6 @@ extern cpumask_t cpu_initialized;
>   
>  extern void smp_alloc_memory(void);
>  extern volatile unsigned long smp_invalidate_needed;
> -extern int pic_mode;
>  extern void lock_ipi_call_lock(void);
>  extern void unlock_ipi_call_lock(void);
>  extern int smp_num_siblings;
> Index: linux/arch/x86_64/kernel/smpboot.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/smpboot.c
> +++ linux/arch/x86_64/kernel/smpboot.c
> @@ -1090,7 +1090,6 @@ void __init smp_prepare_cpus(unsigned in
>  	/*
>  	 * Switch from PIC to APIC mode.
>  	 */
> -	connect_bsp_APIC();
>  	setup_local_APIC();
>  
>  	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
