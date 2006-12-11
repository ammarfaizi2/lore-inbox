Return-Path: <linux-kernel-owner+w=401wt.eu-S1760331AbWLKETQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760331AbWLKETQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760406AbWLKETQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:19:16 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:59241 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760328AbWLKETP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:19:15 -0500
Date: Sun, 10 Dec 2006 20:20:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: <davej@codemonkey.org.uk>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
       "Satt, Shai" <shai.satt@intel.com>
Subject: Re: [PATCH 2.6.19-rc5-git2] EFI: calling efi_get_time during
 suspend
Message-Id: <20061210202000.674d5b34.randy.dunlap@oracle.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B07401704459@hasmsx411.ger.corp.intel.com>
References: <C1467C8B168BCF40ACEC2324C1A2B07401704459@hasmsx411.ger.corp.intel.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 11:43:45 +0200 Myaskouvskey, Artiom wrote:

> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> 
> Function efi_get_time called not only during init kernel phase but also
> during suspend (from get_cmos_time). 
> When it is called from get_cmos_time the corresponding runtime service
> should be called in virtual and not in physical mode.
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> ---
> 
> diff -uprN linux-2.6.19-rc5-git2.orig/include/linux/efi.h
> linux-2.6.19-rc5-git2/include/linux/efi.h
> --- linux-2.6.19-rc5-git2.orig/include/linux/efi.h	2006-11-13
> 11:15:19.000000000 +0200
> +++ linux-2.6.19-rc5-git2/include/linux/efi.h	2006-11-13
> 11:15:38.000000000 +0200
> @@ -300,7 +300,7 @@ extern int efi_mem_attribute_range (unsi
>  extern int __init efi_uart_console_only (void);
>  extern void efi_initialize_iomem_resources(struct resource
> *code_resource,
>  					struct resource *data_resource);
> -extern unsigned long __init efi_get_time(void);
> +extern unsigned long efi_get_time(void);
>  extern int __init efi_set_rtc_mmss(unsigned long nowtime);

Hi--

Shouldn't the /__init/ on efi_set_rtc_mmss() also be dropped?

>  extern struct efi_memory_map memmap;
>  
> diff -uprN linux-2.6.19-rc5-git2.orig/arch/i386/kernel/efi.c
> linux-2.6.19-rc5-git2/arch/i386/kernel/efi.c
> --- linux-2.6.19-rc5-git2.orig/arch/i386/kernel/efi.c	2006-11-13
> 11:15:17.000000000 +0200
> +++ linux-2.6.19-rc5-git2/arch/i386/kernel/efi.c	2006-11-13
> 11:15:38.000000000 +0200
> @@ -194,17 +194,25 @@ inline int efi_set_rtc_mmss(unsigned lon
>  	return 0;
>  }
>  /*
> - * This should only be used during kernel init and before runtime
> - * services have been remapped, therefore, we'll need to call in
> physical
> - * mode.  Note, this call isn't used later, so mark it __init.
> + * This is used during kernel init before runtime
> + * services have been remapped and also during suspend, therefore, 
> + * we'll need to call both in physical and virtual modes. 
>   */
> -inline unsigned long __init efi_get_time(void)
> +inline unsigned long efi_get_time(void)
>  {
>  	efi_status_t status;
>  	efi_time_t eft;
>  	efi_time_cap_t cap;
>  
> -	status = phys_efi_get_time(&eft, &cap);
> +	if (efi.get_time) {
> +		/* if we are in virtual mode use remapped function */ 
> + 		status = efi.get_time(&eft, &cap);
> +        }
> +        else {
> +	    /* we are in physical mode */
> +            status = phys_efi_get_time(&eft, &cap);
> +        }
> +
>  	if (status != EFI_SUCCESS)
>  		printk("Oops: efitime: can't read time status:
> 0x%lx\n",status);

---
~Randy
