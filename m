Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTE1Ws7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTE1Ws7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:48:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261280AbTE1Wsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:48:55 -0400
Message-ID: <3ED53FE3.8090503@pobox.com>
Date: Wed, 28 May 2003 19:01:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com> <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> --- linux-2.5.70-vector/arch/i386/kernel/i8259.c	27 May 2003 02:20:19 -0000	1.1.1.1
> +++ linux-2.5.70-vector/arch/i386/kernel/i8259.c	28 May 2003 04:44:56 -0000
> @@ -427,7 +427,11 @@ void __init init_IRQ(void)
>  	 * us. (some of these will be overridden and become
>  	 * 'special' SMP interrupts)
>  	 */
> +#ifdef CONFIG_PCI_USE_VECTOR
> +	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
> +#else
>  	for (i = 0; i < NR_IRQS; i++) {
> +#endif

This ifdef isn't necessary.  ifdef in a header somewhere.  For example, 
make NR_IRQS (or some other constant, if changing NR_IRQS definition 
isn't ok) condition on the CONFIG_xxx options.



> --- linux-2.5.70-vector/arch/i386/kernel/io_apic.c	27 May 2003 02:20:19 -0000	1.1.1.1
> +++ linux-2.5.70-vector/arch/i386/kernel/io_apic.c	28 May 2003 21:36:28 -0000
> @@ -1140,6 +1160,35 @@ next:
>  static struct hw_interrupt_type ioapic_level_irq_type;
>  static struct hw_interrupt_type ioapic_edge_irq_type;
>  
> +#define IOAPIC_AUTO	-1
> +#define IOAPIC_EDGE	0
> +#define IOAPIC_LEVEL	1
> +
> +static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
> +{
> +#ifdef CONFIG_PCI_USE_VECTOR
> +			if (!platform_legacy_irq(irq)) {
> +				if ((trigger == IOAPIC_AUTO && 
> +				     IO_APIC_irq_trigger(irq)) ||
> +				    trigger == IOAPIC_LEVEL)
> +					irq_desc[vector].handler = &ioapic_level_irq_type;
> +				else
> +					irq_desc[vector].handler = &ioapic_edge_irq_type;
> +				set_intr_gate(vector, interrupt[vector]);
> +
> +			} else 
> +#endif
> +			{
> +				if ((trigger == IOAPIC_AUTO && 
> +				     IO_APIC_irq_trigger(irq)) ||
> +				    trigger == IOAPIC_LEVEL)
> +					irq_desc[irq].handler = &ioapic_level_irq_type;
> +				else
> +					irq_desc[irq].handler = &ioapic_edge_irq_type;
> +				set_intr_gate(vector, interrupt[irq]);
> +			}
> +}

split into two functions, maybe?  (due to the ifdef)  Your call, it's 
mainly a programmer preference.

A bigger question though:  if platform_legacy_irq() returns zero, will 
the handler _ever_ be edge-triggered?


> @@ -1806,7 +1849,13 @@ static void end_level_ioapic_irq (unsign
>   * operation to prevent an edge-triggered interrupt escaping meanwhile.
>   * The idea is from Manfred Spraul.  --macro
>   */
> +#ifdef CONFIG_PCI_USE_VECTOR
> +	if (!platform_legacy_irq(irq))		/* it's already the vector */
> +		i = irq;
> +	else
> +#endif
>  	i = IO_APIC_VECTOR(irq);
> +
>  	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
>  
>  	ack_APIC_irq();
> @@ -1890,7 +1939,15 @@ static inline void init_IO_APIC_traps(vo
>  	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
>  	 */
>  	for (irq = 0; irq < NR_IRQS ; irq++) {
> +#ifdef CONFIG_PCI_USE_VECTOR
> +		int tmp;
> +		tmp = platform_irq(irq);
> +		if (tmp == -1)
> +			continue;
> +		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
> +#else
>  		if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
> +#endif
>  			/*
>  			 * Hmm.. We don't have an entry for this,
>  			 * so default to an old-fashioned 8259

As I see more and more of these ifdefs, I wonder if they couldn't be 
hidden inside wrappers?


> --- linux-2.5.70-vector/arch/i386/kernel/mpparse.c	27 May 2003 02:20:19 -0000	1.1.1.1
> +++ linux-2.5.70-vector/arch/i386/kernel/mpparse.c	28 May 2003 04:44:56 -0000
> @@ -1125,6 +1125,11 @@ void __init mp_parse_prt (void)
>  		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
>  			printk(KERN_DEBUG "Pin %d-%d already programmed\n",
>  				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
> +#ifdef CONFIG_PCI_USE_VECTOR
> +			if (!platform_legacy_irq(irq))
> +				entry->irq = IO_APIC_VECTOR(irq);
> +			else
> +#endif
>  			entry->irq = irq;
>  			continue;
>  		}
> @@ -1132,6 +1137,11 @@ void __init mp_parse_prt (void)
>  		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
>  
>  		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
> +#ifdef CONFIG_PCI_USE_VECTOR
> +			if (!platform_legacy_irq(irq))
> +				entry->irq = IO_APIC_VECTOR(irq);
> +			else
> +#endif
>  			entry->irq = irq;
>  
>  		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
> Index: linux-2.5.70-vector/arch/i386/pci/irq.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.70/arch/i386/pci/irq.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 irq.c
> --- linux-2.5.70-vector/arch/i386/pci/irq.c	27 May 2003 02:20:20 -0000	1.1.1.1
> +++ linux-2.5.70-vector/arch/i386/pci/irq.c	28 May 2003 04:44:56 -0000
> @@ -742,6 +742,11 @@ static void __init pcibios_fixup_irqs(vo
>  							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
>  				}
>  				if (irq >= 0) {
> +#ifdef CONFIG_PCI_USE_VECTOR
> +					if (!platform_legacy_irq(irq))
> +						irq = IO_APIC_VECTOR(irq);
> +#endif
> +



