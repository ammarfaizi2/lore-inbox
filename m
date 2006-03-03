Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWCCKcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCCKcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCCKcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:32:12 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:38020
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751170AbWCCKcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:32:12 -0500
Message-ID: <44081B32.5000408@ed-soft.at>
Date: Fri, 03 Mar 2006 11:32:18 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EFI: Fix gdt load
References: <4406F0C2.7090002@ed-soft.at>
In-Reply-To: <4406F0C2.7090002@ed-soft.at>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek wrote:
> This patch makes the kernel bootable again on ia32 EFI systems.
> 
> Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -uNr linux-2.6.16-rc5/arch/i386/kernel/efi.c linux-2.6.16-rc5.efi/arch/i386/kernel/efi.c
> --- linux-2.6.16-rc5/arch/i386/kernel/efi.c	2006-03-02 14:08:06.000000000 +0100
> +++ linux-2.6.16-rc5.efi/arch/i386/kernel/efi.c	2006-03-02 14:04:44.000000000 +0100
> @@ -70,7 +70,8 @@
>  {
>  	unsigned long cr4;
>  	unsigned long temp;
> -
> +	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
> +	
>  	spin_lock(&efi_rt_lock);
>  	local_irq_save(efi_rt_eflags);
>  
> @@ -103,18 +104,17 @@
>  	 */
>  	local_flush_tlb();
>  
> -	per_cpu(cpu_gdt_descr, 0).address =
> -				 __pa(per_cpu(cpu_gdt_descr, 0).address);
> -	load_gdt((struct Xgt_desc_struct *)__pa(&per_cpu(cpu_gdt_descr, 0)));
> +	cpu_gdt_descr->address = __pa(cpu_gdt_descr->address);
> +	load_gdt(cpu_gdt_descr);
>  }
>  
>  static void efi_call_phys_epilog(void)
>  {
>  	unsigned long cr4;
> +	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
>  
> -	per_cpu(cpu_gdt_descr, 0).address =
> -			(unsigned long)__va(per_cpu(cpu_gdt_descr, 0).address);
> -	load_gdt((struct Xgt_desc_struct *)__va(&per_cpu(cpu_gdt_descr, 0)));
> +	cpu_gdt_descr->address = __va(cpu_gdt_descr->address);
> +	load_gdt(cpu_gdt_descr);
>  
>  	cr4 = read_cr4();
>  

I don't know if it is a race condition. At least it makes the kernel bootable agin on my box.
Any idea what i could try to make a better patch ?

cu

Edgar (gimli) Hucek
