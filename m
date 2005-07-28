Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVG1B0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVG1B0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVG1BZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:25:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261483AbVG1BZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:25:53 -0400
Date: Wed, 27 Jul 2005 18:24:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: akpm@zip.com.au, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86_64: fix cpu_to_node setup for sparse apic_ids
Message-Id: <20050727182445.52be6000.akpm@osdl.org>
In-Reply-To: <20050728011540.GA23923@localhost.localdomain>
References: <20050728011540.GA23923@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> While booting with SMT disabled in bios, when using acpi srat to setup
> cpu_to_node[],  sparse apic_ids create problems.  Here's a fix for that.
> 

Again, I don't have enough info here to judge the urgency of this patch.

What are the consequences and risks of not having this patch in 2.6.13, and
to how many machines?

> 
> Index: linux-2.6.13-rc3/arch/x86_64/mm/srat.c
> ===================================================================
> --- linux-2.6.13-rc3.orig/arch/x86_64/mm/srat.c	2005-06-17 12:48:29.000000000 -0700
> +++ linux-2.6.13-rc3/arch/x86_64/mm/srat.c	2005-07-27 15:36:23.000000000 -0700
> @@ -20,6 +20,9 @@
>  
>  static struct acpi_table_slit *acpi_slit;
>  
> +/* Internal processor count */
> +static unsigned int __initdata num_processors = 0;
> +
>  static nodemask_t nodes_parsed __initdata;
>  static nodemask_t nodes_found __initdata;
>  static struct node nodes[MAX_NUMNODES] __initdata;
> @@ -101,16 +104,18 @@
>  		bad_srat();
>  		return;
>  	}
> -	if (pa->apic_id >= NR_CPUS) {
> -		printk(KERN_ERR "SRAT: lapic %u too large.\n",
> -		       pa->apic_id);
> +	if (num_processors >= NR_CPUS) {
> +		printk(KERN_ERR "SRAT: Processor #%d (lapic %u) INVALID. (Max ID: %d).\n",
> +			num_processors, pa->apic_id, NR_CPUS);
>  		bad_srat();
>  		return;
>  	}
> -	cpu_to_node[pa->apic_id] = node;
> +	cpu_to_node[num_processors] = node;
>  	acpi_numa = 1;
> -	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n",
> -	       pxm, pa->apic_id, node);
> +	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> CPU %u -> Node %u\n",
> +	       pxm, pa->apic_id, num_processors, node);
> +
> +	num_processors++;
>  }
>  
>  /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
