Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVJDUa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVJDUa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVJDUa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:30:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12240 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964962AbVJDUa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:30:26 -0400
Date: Tue, 4 Oct 2005 15:30:19 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       johnrose@linux.ibm.com
Subject: Re: [PATCH] ppc64: Crash in DLPAR code on PCI hotplug add
Message-ID: <20051004203019.GV29826@austin.ibm.com>
References: <20051003185739.GR29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003185739.GR29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After discussion with John Rose, I relize that this patch breaks 
something else, and so its no good.  I'll try to come up with a 
different patch, which will unfortunately be a bit more complex.

--linas

On Mon, Oct 03, 2005 at 01:57:39PM -0500, linas was heard to remark:
> 
> 08-hotplug-bugfix.patch
> 
> In the current 2.6.14-rc2-git6 kernel, performing a Dynamic LPAR Add 
> of a hotplug slot will crash the system, with the following (abbreviated) 
> stack trace:
> 
> cpu 0x3: Vector: 700 (Program Check) at [c000000053dff7f0]
>     pc: c0000000004f5974: .__alloc_bootmem+0x0/0xb0
>     lr: c0000000000258a0: .update_dn_pci_info+0x108/0x118
>         c0000000000257c8 .update_dn_pci_info+0x30/0x118 (unreliable)
>         c0000000000258fc .pci_dn_reconfig_notifier+0x4c/0x64
>         c000000000060754 .notifier_call_chain+0x68/0x9c
> 
> The root cause was that the phb was not marked "dynamic", and so instead
> of having kmalloc() being called, the __init __alloc_bootmem() was called,
> resulting in access of garage data.  The patch below fixes this crash,
> and adds some docs to clarify the code.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> 
> Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c
> ===================================================================
> --- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci_dn.c	2005-10-03 13:45:58.011393833 -0500
> +++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c	2005-10-03 13:52:26.421786761 -0500
> @@ -121,6 +121,12 @@
>  	return NULL;
>  }
>  
> +/** pci_devs_phb_init_dynamic -- setup pci devices under this PHB
> + *
> + * This routine is called both during boot, (before the memory
> + * subsystem is set up, before kmalloc is valid) and during the 
> + * dynamic lpar operation of adding a PHB to a running system.
> + */
>  void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
>  {
>  	struct device_node * dn = (struct device_node *) phb->arch_data;
> @@ -201,17 +207,19 @@
>  	.notifier_call = pci_dn_reconfig_notifier,
>  };
>  
> -/*
> - * Actually initialize the phbs.
> - * The buswalk on this phb has not happened yet.
> +/** pci_devs_phb_init -- Initialize phbs and pci devs under them.
> + * 
> + * When this is called, the buswalk of PHB's has not happened yet.
>   */
>  void __init pci_devs_phb_init(void)
>  {
>  	struct pci_controller *phb, *tmp;
>  
>  	/* This must be done first so the device nodes have valid pci info! */
> -	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
> +	list_for_each_entry_safe(phb, tmp, &hose_list, list_node) {
>  		pci_devs_phb_init_dynamic(phb);
> +		phb->is_dynamic = 1;
> +	}
>  
>  	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
>  }
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
> 
