Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbTIFBea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTIFBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:34:30 -0400
Received: from fmr09.intel.com ([192.52.57.35]:6132 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265727AbTIFBdU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:33:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Date: Fri, 5 Sep 2003 21:33:14 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD1F@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Thread-Index: AcN0DU1a+aaJavSrQVe+NWhBqIR9IwACT87Q
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew de Quincey" <adq_dvb@lidskialf.net>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: <torvalds@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 01:33:15.0482 (UTC) FILETIME=[D7C80BA0:01C37416]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
I thought it would be a good idea to let this one cook for a bit while
proceeding with a batch of fixes that we've already tested somewhat.

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb@lidskialf.net] 
> Sent: Friday, September 05, 2003 8:15 PM
> To: Jeff Garzik
> Cc: torvalds@osdl.org; lkml; 
> acpi-devel@lists.sourceforge.net; linux-acpi
> Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
> 
> 
> This patch allows ACPI to drop back to PIC mode if ACPI mode 
> setup fails.
> 
> 
> --- linux-2.4.23-pre3.orig/arch/i386/kernel/mpparse.c	
> 2003-09-05 18:55:07.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/i386/kernel/mpparse.c	
> 2003-09-05 23:33:53.460290272 +0100
> @@ -1263,10 +1263,11 @@
>  
>  #ifdef CONFIG_ACPI_PCI
>  
> -void __init mp_parse_prt (void)
> +int __init mp_parse_prt (void)
>  {
>  	struct list_head	*node = NULL;
>  	struct acpi_prt_entry	*entry = NULL;
> + 	struct acpi_prt_list	*prt_list = NULL;
>  	int			ioapic = -1;
>  	int			ioapic_pin = 0;
>  	int			irq = 0;
> @@ -1274,16 +1275,31 @@
>  	int			edge_level = 0;
>  	int			active_high_low = 0;
>  
> + 	/* Get the current PRT */
> + 	prt_list = acpi_pci_get_prt_list();
> +   
> + 	if (!prt_list->count) {
> + 		acpi_pci_destroy_prt_list(prt_list);
> + 		printk(KERN_WARNING "ACPI tables contain no 
> IO-APIC PCI IRQ "
> + 			"routing entries\n");
> + 		return_VALUE(-ENODEV);
> + 	}
> +   
>  	/*
>  	 * Parsing through the PCI Interrupt Routing Table 
> (PRT) and program
>  	 * routing for all entries.
>  	 */
> -	list_for_each(node, &acpi_prt.entries) {
> +	list_for_each(node, &prt_list->entries) {
>  		entry = list_entry(node, struct acpi_prt_entry, node);
>  
>  		/* Need to get irq for dynamic entry */
>  		if (entry->link.handle) {
>  			irq = 
> acpi_pci_link_get_irq(entry->link.handle, entry->link.index, 
> &edge_level, &active_high_low);
> +			if (irq < 0) {
> +				acpi_pci_destroy_prt_list(prt_list);
> +				return -ENODEV;
> +			}
> +		   
>  			if (!irq)
>  				continue;
>  		}
> @@ -1334,8 +1350,11 @@
>  			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
>  			entry->irq);
>  	}
> -	
> -	return;
> +   
> + 	/* if we get here, the PRT was fine. commit it */
> + 	acpi_pci_commit_prt_list(prt_list);
> +
> +	return 0;
>  }
>  
>  #endif /*CONFIG_ACPI_PCI*/
> --- linux-2.4.23-pre3.orig/arch/i386/kernel/pic.c	
> 1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/i386/kernel/pic.c	
> 2003-09-05 23:33:53.461290120 +0100
> @@ -0,0 +1,102 @@
> +/* 
> --------------------------------------------------------------
> --------- *
> + *   
> + *   Copyright 2003 Andrew de Quincey - All Rights Reserved
> + *
> + *   This program is free software; you can redistribute it 
> and/or modify
> + *   it under the terms of the GNU General Public License as 
> published by
> + *   the Free Software Foundation, Inc., 675 Mass Ave, 
> Cambridge MA 02139,
> + *   USA; either version 2 of the License, or (at your 
> option) any later
> + *   version; incorporated herein by reference.
> + *
> + * 
> --------------------------------------------------------------
> --------- */
> +
> +#include <linux/mm.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/config.h>
> +#include <linux/bootmem.h>
> +#include <linux/smp_lock.h>
> +#include <linux/kernel_stat.h>
> +
> +#include <asm/acpi.h>
> +
> +#ifdef CONFIG_ACPI_PCI
> +
> +extern void eisa_set_level_irq(unsigned int irq);
> +
> +int __init pic_parse_prt (void)
> +{
> +	struct list_head	*node = NULL;
> +	struct acpi_prt_entry	*entry = NULL;
> +	struct acpi_prt_list	*prt_list = NULL;
> +	int			edge_level = 0;
> +	int			active_high_low = 0;
> +	int			irq = 0;
> +	int			programmed[16];
> +
> +	/* Get the current PRT */
> +	prt_list = acpi_pci_get_prt_list();
> +   
> +	if (!prt_list->count) {
> +		acpi_pci_destroy_prt_list(prt_list);
> +		printk(KERN_WARNING "ACPI tables contain no PIC 
> PCI IRQ "
> +			"routing entries\n");
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	/* mark all IRQs as unprogrammed */
> +	memset(programmed, 0, sizeof(programmed));
> +   
> +	/*
> +	 * Parsing through the PCI Interrupt Routing Table 
> (PRT) and program
> +	 * IRQs if necessary.
> +	 */
> +	list_for_each(node, &prt_list->entries) {
> +		entry = list_entry(node, struct acpi_prt_entry, node);
> +
> +		/* Need to get irq for dynamic entry */
> +		if (entry->link.handle) {
> +			irq = 
> acpi_pci_link_get_irq(entry->link.handle, entry->link.index, 
> &edge_level, &active_high_low);
> +			if (irq < 0) {
> +				acpi_pci_destroy_prt_list(prt_list);
> +				return -ENODEV;
> +			}
> + 			if (!irq) 
> +				continue;
> +		}
> +	   
> +		/* sanity check + update entry */
> +		if ((irq < 0) || (irq > 15)) {
> +			printk(KERN_ERR "Invalid IRQ (%i) 
> passed to PIC programming code\n", irq);
> +			entry->irq = 0;
> +			continue;
> +		}
> +		entry->irq = irq;
> +
> +		/* check if it has already been dealt with */
> +		if (programmed[irq]) {
> +			printk(KERN_DEBUG "PIC: IRQ (%i) 
> already programmed\n", irq);
> +			continue;
> +		}
> +		programmed[irq] = 1;
> +
> +		/* program it */
> +		if (edge_level) {
> +			eisa_set_level_irq(irq);
> +		}
> +	   
> +		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d 
> Mode %d Trigger %d\n",
> +			entry->id.segment, entry->id.bus, 
> +			entry->id.device, ('A' + entry->pin), 
> +			entry->irq, edge_level, active_high_low);
> +	}
> +	
> +	/* if we get here, the PRT was fine. commit it */
> +	acpi_pci_commit_prt_list(prt_list);
> +   
> +	return 0;
> +}
> +
> +#endif /*CONFIG_ACPI_PCI*/
> --- linux-2.4.23-pre3.orig/arch/i386/kernel/Makefile	
> 2003-08-25 12:44:39.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/i386/kernel/Makefile	
> 2003-09-05 23:33:53.461290120 +0100
> @@ -36,7 +36,7 @@
>  obj-$(CONFIG_X86_CPUID)		+= cpuid.o
>  obj-$(CONFIG_MICROCODE)		+= microcode.o
>  obj-$(CONFIG_APM)		+= apm.o
> -obj-$(CONFIG_ACPI_BOOT)		+= acpi.o
> +obj-$(CONFIG_ACPI_BOOT)		+= acpi.o pic.o
>  obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
>  obj-$(CONFIG_ACPI_HT_ONLY)	+= acpitable.o
>  obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
> --- linux-2.4.23-pre3.orig/include/asm-i386/mpspec.h	
> 2003-08-25 12:44:43.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/asm-i386/mpspec.h	
> 2003-09-05 23:33:53.461290120 +0100
> @@ -228,7 +228,7 @@
>  extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, 
> u8 trigger, u32 global_irq);
>  extern void mp_config_acpi_legacy_irqs (void);
>  extern void mp_config_ioapic_for_sci(int irq);
> -extern void mp_parse_prt (void);
> +extern int mp_parse_prt (void);
>  #else /*!CONFIG_X86_IO_APIC*/
>  static inline void mp_config_ioapic_for_sci(int irq) { }
>  #endif /*!CONFIG_X86_IO_APIC*/
> --- linux-2.4.23-pre3.orig/include/asm-i386/acpi.h	
> 2003-08-25 12:44:43.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/asm-i386/acpi.h	
> 2003-09-05 23:33:53.462289968 +0100
> @@ -180,6 +180,9 @@
>  /* early initialization routine */
>  extern void acpi_reserve_bootmem(void);
>  
> +/* ACPI-based PIC initialisation */
> +extern int pic_parse_prt (void);
> +
>  #endif /*CONFIG_ACPI_SLEEP*/
>  
>  
> --- linux-2.4.23-pre3.orig/arch/x86_64/kernel/mpparse.c	
> 2003-09-05 18:55:07.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/x86_64/kernel/mpparse.c	
> 2003-09-05 23:33:53.463289816 +0100
> @@ -934,6 +934,7 @@
>  {
>  	struct list_head	*node = NULL;
>  	struct acpi_prt_entry	*entry = NULL;
> +	struct acpi_prt_list    *prt_list = NULL;   
>  	int			vector = 0;
>  	int			ioapic = -1;
>  	int			ioapic_pin = 0;
> @@ -942,16 +943,29 @@
>  	int			edge_level = 0;
>  	int			active_high_low = 0;
>  
> +	/* Get the current PRT */
> +	prt_list = acpi_pci_get_prt_list();
> +	if (!prt_list->count) {
> +		acpi_pci_destroy_prt_list(prt_list);
> +		printk(KERN_WARNING "ACPI tables contain no 
> IO-APIC PCI IRQ "
> +			"routing entries\n");
> +		return_VALUE(-ENODEV);
> +	}
> +   
>  	/*
>  	 * Parsing through the PCI Interrupt Routing Table 
> (PRT) and program
>  	 * routing for all static (IOAPIC-direct) entries.
>  	 */
> -	list_for_each(node, &acpi_prt.entries) {
> +	list_for_each(node, &prt_list->entries) 
>  		entry = list_entry(node, struct acpi_prt_entry, node);
>  
>  		/* Need to get irq for dynamic entry */
>  		if (entry->link.handle) {
>  			irq = 
> acpi_pci_link_get_irq(entry->link.handle, entry->link.index, 
> &edge_level, &active_high_low);
> +			if (irq < 0) {
> +				acpi_pci_destroy_prt_list(prt_list);
> +				return -ENODEV;
> +			}
>  			if (!irq)
>  				continue;
>  		} else {
> @@ -998,8 +1012,11 @@
>  			mp_ioapic_routing[ioapic].apic_id, 
> ioapic_pin, vector, 
>  			entry->irq);
>  	}
> -	
> -	return;
> +   
> + 	/* if we get here, the PRT was fine. commit it */
> + 	acpi_pci_commit_prt_list(prt_list);
> +   
> +	return 0;
>  }
>  
>  #endif /*CONFIG_ACPI_PCI*/
> --- linux-2.4.23-pre3.orig/arch/x86_64/kernel/pic.c	
> 1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/x86_64/kernel/pic.c	
> 2003-09-05 23:33:53.463289816 +0100
> @@ -0,0 +1,102 @@
> +/* 
> --------------------------------------------------------------
> --------- *
> + *   
> + *   Copyright 2003 Andrew de Quincey - All Rights Reserved
> + *
> + *   This program is free software; you can redistribute it 
> and/or modify
> + *   it under the terms of the GNU General Public License as 
> published by
> + *   the Free Software Foundation, Inc., 675 Mass Ave, 
> Cambridge MA 02139,
> + *   USA; either version 2 of the License, or (at your 
> option) any later
> + *   version; incorporated herein by reference.
> + *
> + * 
> --------------------------------------------------------------
> --------- */
> +
> +#include <linux/mm.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/config.h>
> +#include <linux/bootmem.h>
> +#include <linux/smp_lock.h>
> +#include <linux/kernel_stat.h>
> +
> +#include <asm/acpi.h>
> +
> +#ifdef CONFIG_ACPI_PCI
> +
> +extern void eisa_set_level_irq(unsigned int irq);
> +
> +int __init pic_parse_prt (void)
> +{
> +	struct list_head	*node = NULL;
> +	struct acpi_prt_entry	*entry = NULL;
> +	struct acpi_prt_list	*prt_list = NULL;
> +	int			edge_level = 0;
> +	int			active_high_low = 0;
> +	int			irq = 0;
> +	int			programmed[16];
> +
> +	/* Get the current PRT */
> +	prt_list = acpi_pci_get_prt_list();
> +   
> +	if (!prt_list->count) {
> +		acpi_pci_destroy_prt_list(prt_list);
> +		printk(KERN_WARNING "ACPI tables contain no PIC 
> PCI IRQ "
> +			"routing entries\n");
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	/* mark all IRQs as unprogrammed */
> +	memset(programmed, 0, sizeof(programmed));
> +   
> +	/*
> +	 * Parsing through the PCI Interrupt Routing Table 
> (PRT) and program
> +	 * IRQs if necessary.
> +	 */
> +	list_for_each(node, &prt_list->entries) {
> +		entry = list_entry(node, struct acpi_prt_entry, node);
> +
> +		/* Need to get irq for dynamic entry */
> +		if (entry->link.handle) {
> +			irq = 
> acpi_pci_link_get_irq(entry->link.handle, entry->link.index, 
> &edge_level, &active_high_low);
> +			if (irq < 0) {
> +				acpi_pci_destroy_prt_list(prt_list);
> +				return -ENODEV;
> +			}
> + 			if (!irq) 
> +				continue;
> +		}
> +	   
> +		/* sanity check + update entry */
> +		if ((irq < 0) || (irq > 15)) {
> +			printk(KERN_ERR "Invalid IRQ (%i) 
> passed to PIC programming code\n", irq);
> +			entry->irq = 0;
> +			continue;
> +		}
> +		entry->irq = irq;
> +
> +		/* check if it has already been dealt with */
> +		if (programmed[irq]) {
> +			printk(KERN_DEBUG "PIC: IRQ (%i) 
> already programmed\n", irq);
> +			continue;
> +		}
> +		programmed[irq] = 1;
> +
> +		/* program it */
> +		if (edge_level) {
> +			eisa_set_level_irq(irq);
> +		}
> +	   
> +		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d 
> Mode %d Trigger %d\n",
> +			entry->id.segment, entry->id.bus, 
> +			entry->id.device, ('A' + entry->pin), 
> +			entry->irq, edge_level, active_high_low);
> +	}
> +	
> +	/* if we get here, the PRT was fine. commit it */
> +	acpi_pci_commit_prt_list(prt_list);
> +   
> +	return 0;
> +}
> +
> +#endif /*CONFIG_ACPI_PCI*/
> --- linux-2.4.23-pre3.orig/arch/x86_64/kernel/Makefile	
> 2003-08-25 12:44:40.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/arch/x86_64/kernel/Makefile	
> 2003-09-05 23:33:53.464289664 +0100
> @@ -37,7 +37,7 @@
>  obj-$(CONFIG_GART_IOMMU) += pci-gart.o aperture.o
>  obj-$(CONFIG_DUMMY_IOMMU) += pci-nommu.o
>  obj-$(CONFIG_MCE) += bluesmoke.o
> -obj-$(CONFIG_ACPI)		+= acpi.o
> +obj-$(CONFIG_ACPI)		+= acpi.o pic.o
>  obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o suspend.o
>   
>  
> --- linux-2.4.23-pre3.orig/include/asm-x86_64/acpi.h	
> 2003-08-25 12:44:44.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/asm-x86_64/acpi.h	
> 2003-09-05 23:33:53.464289664 +0100
> @@ -142,6 +142,9 @@
>  
>  extern void mp_config_ioapic_for_sci(int irq);
>  
> +/* ACPI-based PIC initialisation */
> +extern int pic_parse_prt (void);
> +
>  #endif /*__KERNEL__*/
>  
>  #endif /*_ASM_ACPI_H*/
> --- linux-2.4.23-pre3.orig/include/asm-ia64/acpi.h	
> 2003-06-13 15:51:38.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/asm-ia64/acpi.h	
> 2003-09-05 23:33:53.464289664 +0100
> @@ -109,6 +109,9 @@
>  #define MAX_PXM_DOMAINS		(256)
>  #endif /* CONFIG_DISCONTIGMEM */
>  
> +/* ia64 machines don't have PIC controllers */
> +static inline int pic_parse_prt(void) { return -1; }
> +
>  #endif /*__KERNEL__*/
>  
>  #endif /*_ASM_ACPI_H*/
> --- linux-2.4.23-pre3.orig/drivers/acpi/pci_irq.c	
> 2003-08-25 12:44:41.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/drivers/acpi/pci_irq.c	
> 2003-09-05 23:33:53.465289512 +0100
> @@ -50,7 +50,22 @@
>  
>  #define PREFIX			"PCI: "
>  
> -struct acpi_prt_list		acpi_prt;
> +struct acpi_prt_list*		acpi_prt = NULL;
> +
> +struct acpi_prt_ref {
> +	struct list_head	node;
> +	struct acpi_device	*device;
> +	acpi_handle		handle;
> +	int segment;
> +	int bus;
> +};
> +
> +struct acpi_prt_ref_list {
> +	int			count;
> +	struct list_head	entries;
> +};				
> +
> +struct acpi_prt_ref_list acpi_prt_ref_list;
>  
>  #ifdef CONFIG_X86
>  extern void eisa_set_level_irq(unsigned int irq);
> @@ -73,13 +88,19 @@
>  
>  	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
>  
> +	/* ensure we're not called before the routing table has 
> been determined */
> +	if (acpi_prt == NULL) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Called before 
> acpi_prt determined"));
> +		return_PTR(NULL);
> + 	}
> +   
>  	/*
>  	 * Parse through all PRT entries looking for a match on 
> the specified
>  	 * PCI device's segment, bus, device, and pin (don't 
> care about func).
>  	 *
>  	 * TBD: Acquire/release lock
>  	 */
> -	list_for_each(node, &acpi_prt.entries) {
> +	list_for_each(node, &acpi_prt->entries) {
>  		entry = list_entry(node, struct acpi_prt_entry, node);
>  		if ((segment == entry->id.segment) 
>  			&& (bus == entry->id.bus) 
> @@ -95,6 +116,7 @@
>  
>  static int
>  acpi_pci_irq_add_entry (
> +	struct acpi_prt_list*		prt_list,
>  	acpi_handle			handle,
>  	int				segment,
>  	int				bus,
> @@ -151,12 +173,115 @@
>  		('A' + entry->pin), prt->source, entry->link.index));
>  
>  	/* TBD: Acquire/release lock */
> -	list_add_tail(&entry->node, &acpi_prt.entries);
> -	acpi_prt.count++;
> +	list_add_tail(&entry->node, &prt_list->entries);
> +	prt_list->count++;
>  
>  	return_VALUE(0);
>  }
>  
> +struct acpi_prt_list*
> +acpi_pci_get_prt_list (void)
> +{
> +	acpi_status			status = AE_OK;
> +	struct acpi_buffer		buffer = {0, NULL};
> +	struct acpi_pci_routing_table	*prt = NULL;
> +	struct acpi_pci_routing_table	*entry = NULL;
> +	struct acpi_prt_list		*prt_list = NULL;
> +	struct acpi_prt_ref		*prt_ref_entry = NULL;
> +	struct list_head		*node = NULL;
> +   
> +	ACPI_FUNCTION_TRACE("acpi_pci_irq_get_prt_list");
> +   
> +	/* Create a brand new acpi_prt_list */
> +	prt_list = kmalloc(sizeof(struct acpi_prt_list), GFP_KERNEL);
> +	if (!prt_list)
> +		return_PTR(NULL);
> +	memset(prt_list, 0, sizeof(struct acpi_prt_list));
> +   
> +	prt_list->count = 0;
> +	INIT_LIST_HEAD(&prt_list->entries);
> +   
> +	/* iterate over all entries in acpi_prt_ref_list, 
> extracting the current _PRT entries */
> +	list_for_each(node, &acpi_prt_ref_list.entries) {
> +		prt_ref_entry = list_entry(node, struct 
> acpi_prt_ref, node);
> +   
> +		/* 
> +		 * Evaluate this _PRT and add its entries to 
> our local list (prt_list).
> +		 */
> +
> +		buffer.length = 0;
> +		buffer.pointer = NULL;
> +		status = 
> acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
> +		if (status != AE_BUFFER_OVERFLOW) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _PRT [%s]\n",
> +				acpi_format_exception(status)));
> +			kfree(prt_list);
> +			return_PTR(NULL);
> +		}
> +
> +		prt = kmalloc(buffer.length, GFP_KERNEL);
> +		if (!prt) {
> +			kfree(prt_list);
> +			return_VALUE(NULL);
> +		}
> +		memset(prt, 0, buffer.length);
> +		buffer.pointer = prt;
> +
> +		status = 
> acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _PRT [%s]\n",
> +				acpi_format_exception(status)));
> +			kfree(buffer.pointer);
> +			kfree(prt_list);
> +			return_PTR(NULL);
> +		}
> +
> +		entry = prt;
> +
> +		while (entry && (entry->length > 0)) {
> +			acpi_pci_irq_add_entry(prt_list, 
> prt_ref_entry->handle, prt_ref_entry->segment, 
> +				prt_ref_entry->bus, entry);
> +			entry = (struct acpi_pci_routing_table *)
> +				((unsigned long) entry + entry->length);
> +		}
> +
> +		kfree(prt);
> +	}
> +
> +	return_PTR(prt_list);
> +}
> +
> +int 
> +acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list) {
> +	struct list_head	*node = NULL;
> +	struct list_head	*tmp = NULL;
> +	struct acpi_prt_entry	*entry = NULL;
> +   
> +	ACPI_FUNCTION_TRACE("acpi_pci_irq_destroy_prt_list");
> +
> +	list_for_each_safe(node, tmp, &prt_list->entries) {
> +		entry = list_entry(node, struct acpi_prt_entry, node);
> +		list_del(node);
> +		kfree(entry);
> +	}
> +	kfree(prt_list);
> +   
> +	return_VALUE(0);
> +}	  
> +  
> +int
> +acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list) {
> +
> +	ACPI_FUNCTION_TRACE("acpi_pci_irq_commit_prt_list");
> +   
> +	if (acpi_prt != NULL) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Attempt to 
> commit acpi_prt twice\n"));
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	acpi_prt = prt_list;
> +	return_VALUE(0);
> +}
>  
>  int
>  acpi_pci_irq_add_prt (
> @@ -164,21 +289,20 @@
>  	int			segment,
>  	int			bus)
>  {
> -	acpi_status			status = AE_OK;
> -	char				
> pathname[ACPI_PATHNAME_MAX] = {0};
> -	struct acpi_buffer		buffer = {0, NULL};
> -	struct acpi_pci_routing_table	*prt = NULL;
> -	struct acpi_pci_routing_table	*entry = NULL;
> -	static int			first_time = 1;
> +	static int		first_time = 1;
> +	struct acpi_prt_ref	*entry = NULL;
> +	struct acpi_buffer	buffer = {0, NULL};
> +	char			pathname[ACPI_PATHNAME_MAX] = {0};
>  
>  	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
>  
>  	if (first_time) {
> -		acpi_prt.count = 0;
> -		INIT_LIST_HEAD(&acpi_prt.entries);
> +		acpi_prt_ref_list.count = 0;
> +		INIT_LIST_HEAD(&acpi_prt_ref_list.entries);
>  		first_time = 0;
>  	}
>  
> +   
>  	/* 
>  	 * NOTE: We're given a 'handle' to the _PRT object's 
> parent device
>  	 *       (either a PCI root bridge or PCI-PCI bridge).
> @@ -191,42 +315,19 @@
>  	printk(KERN_DEBUG "ACPI: PCI Interrupt Routing Table 
> [%s._PRT]\n",
>  		pathname);
>  
> -	/* 
> -	 * Evaluate this _PRT and add its entries to our global 
> list (acpi_prt).
> -	 */
> -
> -	buffer.length = 0;
> -	buffer.pointer = NULL;
> -	status = acpi_get_irq_routing_table(handle, &buffer);
> -	if (status != AE_BUFFER_OVERFLOW) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _PRT [%s]\n",
> -			acpi_format_exception(status)));
> -		return_VALUE(-ENODEV);
> -	}
> -
> -	prt = kmalloc(buffer.length, GFP_KERNEL);
> -	if (!prt)
> +   
> +   
> +	entry = kmalloc(sizeof(struct acpi_prt_ref), GFP_KERNEL);
> +	if (!entry)
>  		return_VALUE(-ENOMEM);
> -	memset(prt, 0, buffer.length);
> -	buffer.pointer = prt;
> -
> -	status = acpi_get_irq_routing_table(handle, &buffer);
> -	if (ACPI_FAILURE(status)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _PRT [%s]\n",
> -			acpi_format_exception(status)));
> -		kfree(buffer.pointer);
> -		return_VALUE(-ENODEV);
> -	}
> +	memset(entry, 0, sizeof(struct acpi_prt_ref));
> +   
> +	entry->handle = handle;
> +	entry->segment = segment;
> +	entry->bus = bus;
>  
> -	entry = prt;
> -
> -	while (entry && (entry->length > 0)) {
> -		acpi_pci_irq_add_entry(handle, segment, bus, entry);
> -		entry = (struct acpi_pci_routing_table *)
> -			((unsigned long) entry + entry->length);
> -	}
> -
> -	kfree(prt);
> +	list_add_tail(&entry->node, &acpi_prt_ref_list.entries);
> +	acpi_prt_ref_list.count++;
>  
>  	return_VALUE(0);
>  }
> @@ -387,6 +488,15 @@
>  }
>  
>  
> +static void __init acpi_irq_pic_mode(void)
> +{
> +	acpi_irq_model = ACPI_IRQ_MODEL_PIC;
> +	acpi_bus_init_irq();
> +   
> +        /* recalculate penalties */
> + 	acpi_pci_link_calc_penalties();
> +}
> +
>  int __init
>  acpi_pci_irq_init (void)
>  {
> @@ -394,26 +504,25 @@
>  
>  	ACPI_FUNCTION_TRACE("acpi_pci_irq_init");
>  
> -	if (!acpi_prt.count) {
> -		printk(KERN_WARNING PREFIX "ACPI tables contain 
> no PCI IRQ "
> -			"routing entries\n");
> -		return_VALUE(-ENODEV);
> -	}
> -
> -	/* Make sure all link devices have a valid IRQ. */
> -	if (acpi_pci_link_check()) {
> -		return_VALUE(-ENODEV);
> -	}
> + 	/* Calculate IRQ penalties for each link device */
> + 	acpi_pci_link_calc_penalties();
>  
>  #ifdef CONFIG_X86_IO_APIC
>  	/* Program IOAPICs using data from PRT entries. */
>  	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
> -		mp_parse_prt();
> + 		if (mp_parse_prt()) 
> + 			acpi_irq_pic_mode();
>  #endif
>  #ifdef CONFIG_IOSAPIC
>  	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
> -		iosapic_parse_prt();
> + 		if (iosapic_parse_prt())
> +       			return_VALUE(-ENODEV);
>  #endif
> +   
> + 	/* This one is last, as a catchall */
> + 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
> + 		if (pic_parse_prt()) 
> + 			return_VALUE(-ENODEV);
>  
>  	pci_for_each_dev(dev)
>  		acpi_pci_irq_enable(dev);
> --- linux-2.4.23-pre3.orig/drivers/acpi/pci_link.c	
> 2003-09-05 23:55:06.788714928 +0100
> +++ linux-2.4.23-pre3.picmode/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:45.522947816 +0100
> @@ -312,13 +312,13 @@
>  			return_VALUE(-EINVAL);
>  		}
>  	}
> -
> +   
>  	memset(&resource, 0, sizeof(resource));
>  
>  	/* NOTE: PCI interrupts are always level / active_low / 
> shared. But not all
>  	   interrupts > 15 are PCI interrupts. Rely on the ACPI 
> IRQ definition for 
>  	   parameters */
> -	if (irq <= 15) {
> +	if (irq <= 15) {	
>  		resource.res.id = ACPI_RSTYPE_IRQ;
>  		resource.res.length = sizeof(struct acpi_resource);
>  		resource.res.data.irq.edge_level = link->irq.edge_level;
> @@ -363,7 +363,7 @@
>  	if (result) {
>  		return_VALUE(result);
>  	}
> -   
> +
>  	if (link->irq.active != irq) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
>  			"Attempt to enable at IRQ %d resulted 
> in IRQ %d\n", 
> @@ -399,23 +399,26 @@
>   * as 'best bets' for PCI use.
>   */
>  
> -static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
> +static int acpi_irq_default_penalty[ACPI_MAX_IRQS] = {
>  	1000000,  1000000,  1000000,    10000, 
>  	  10000,        0,    10000,    10000,
>  	  10000,        0,        0,        0, 
>  	  10000,   100000,   100000,   100000,
>  };
>  
> +static int acpi_irq_penalty[ACPI_MAX_IRQS] = { 0 };
>  
>  int
> -acpi_pci_link_check (void)
> +acpi_pci_link_calc_penalties (void)
>  {
>  	struct list_head	*node = NULL;
>  	struct acpi_pci_link    *link = NULL;
>  	int			i = 0;
>  
> -	ACPI_FUNCTION_TRACE("acpi_pci_link_check");
> +	ACPI_FUNCTION_TRACE("acpi_pci_calc_penalties");
>  
> +	memcpy(&acpi_irq_penalty, &acpi_irq_default_penalty, 
> sizeof(acpi_irq_default_penalty));
> +   
>  	/*
>  	 * Update penalties to facilitate IRQ balancing.
>  	 */
> @@ -426,7 +429,8 @@
>  			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> "Invalid link context\n"));
>  			continue;
>  		}
> -
> +		link->irq.setonboot = 0;
> +	   
>  		if (link->irq.active)
>  			acpi_irq_penalty[link->irq.active] += 100;
>  		else if (link->irq.possible_count) {
> @@ -456,18 +460,18 @@
>  		irq = link->irq.possible[0];
>  	}
>  
> -		/* 
> -		 * Select the best IRQ.  This is done in 
> reverse to promote 
> -		 * the use of IRQs 9, 10, 11, and >15.
> -		 */
> -		for (i=(link->irq.possible_count-1); i>0; i--) {
> -			if (acpi_irq_penalty[irq] > 
> acpi_irq_penalty[link->irq.possible[i]])
> -				irq = link->irq.possible[i];
> -		}
> +	/* 
> +	 * Select the best IRQ.  This is done in reverse to promote 
> +	 * the use of IRQs 9, 10, 11, and >15.
> +	 */
> +	for (i=(link->irq.possible_count-1); i>0; i--) {
> +		if (acpi_irq_penalty[irq] > 
> acpi_irq_penalty[link->irq.possible[i]])
> +			irq = link->irq.possible[i];
> +	}
>  
>  	/* Attempt to enable the link device at this IRQ. */
>  	if (acpi_pci_link_set(link, irq)) {
> -		printk(PREFIX "Unable to set IRQ for %s [%s] 
> (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. 
> Try pci=noacpi or acpi=off\n",
> +		printk(PREFIX "Unable to set IRQ for %s [%s] 
> (likely buggy ACPI BIOS, please report to acpi-devel!)\n",
>  			acpi_device_name(link->device),
>  			acpi_device_bid(link->device));
>  		return_VALUE(-ENODEV);
> --- linux-2.4.23-pre3.orig/drivers/acpi/bus.c	2003-08-25 
> 12:44:41.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/drivers/acpi/bus.c	
> 2003-09-05 23:33:53.467289208 +0100
> @@ -1802,7 +1802,7 @@
>                               Initialization/Cleanup
>     
> --------------------------------------------------------------
> ------------ */
>  
> -static int __init
> +int
>  acpi_bus_init_irq (void)
>  {
>  	acpi_status		status = AE_OK;
> --- linux-2.4.23-pre3.orig/include/acpi/acpi_drivers.h	
> 2003-08-25 12:44:43.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/acpi/acpi_drivers.h	
> 2003-09-05 23:33:53.468289056 +0100
> @@ -26,6 +26,9 @@
>  #ifndef __ACPI_DRIVERS_H__
>  #define __ACPI_DRIVERS_H__
>  
> +/* forward definitions */
> +struct acpi_prt_list;
> +
>  #include <linux/acpi.h>
>  #include "acpi_bus.h"
>  
> @@ -173,7 +176,7 @@
>  #define ACPI_PCI_LINK_FILE_INFO		"info"
>  #define ACPI_PCI_LINK_FILE_STATUS	"state"
>  
> -int acpi_pci_link_check (void);
> +int acpi_pci_link_calc_penalties (void);
>  int acpi_pci_link_get_irq (acpi_handle handle, int index, 
> int* edge_level, int* active_high_low);
>  int acpi_pci_link_init (void);
>  void acpi_pci_link_exit (void);
> @@ -181,6 +184,9 @@
>  /* ACPI PCI Interrupt Routing (pci_irq.c) */
>  
>  int acpi_pci_irq_add_prt (acpi_handle handle, int segment, int bus);
> +int acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list);
> +int acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list);
> +struct acpi_prt_list* acpi_pci_get_prt_list (void);
>  
>  /* ACPI PCI Device Binding (pci_bind.c) */
>  
> --- linux-2.4.23-pre3.orig/include/linux/acpi.h	
> 2003-08-25 12:44:44.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/linux/acpi.h	
> 2003-09-05 23:33:53.469288904 +0100
> @@ -401,7 +401,7 @@
>  	struct list_head	entries;
>  };
>  
> -extern struct acpi_prt_list	acpi_prt;
> +extern struct acpi_prt_list*	acpi_prt;
>  
>  struct pci_dev;
>  
> --- linux-2.4.23-pre3.orig/include/acpi/acpi_bus.h	
> 2003-08-25 12:44:43.000000000 +0100
> +++ linux-2.4.23-pre3.picmode/include/acpi/acpi_bus.h	
> 2003-09-05 23:33:53.469288904 +0100
> @@ -309,6 +309,7 @@
>  int acpi_init (void);
>  void acpi_exit (void);
>  
> +int acpi_bus_init_irq (void);
>  
>  #endif /*CONFIG_ACPI_BUS*/
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
