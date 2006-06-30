Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWF3MG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWF3MG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWF3MG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:06:28 -0400
Received: from ns2.suse.de ([195.135.220.15]:49624 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932180AbWF3MG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:06:27 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] 2.6.17-rc6 perfmon2 patch for review: modified x86_64 files
References: <200606150907.k5F97kCC008264@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2006 14:06:24 +0200
In-Reply-To: <200606150907.k5F97kCC008264@frankl.hpl.hp.com>
Message-ID: <p73odwax2yn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:

> This patch contains the modified files for x86_64 (AMD and Intel EM64T).
> 

Description/rationale/what you changed/why/etc. missing here...

In general your patches would be easier to review if you used diff -p

The patch is too big and should be split into smaller pieces.

>  	.quad sys_sync_file_range
>  	.quad sys_tee
>  	.quad compat_sys_vmsplice
> +   	.quad sys_pfm_create_context
> +       	.quad sys_pfm_write_pmcs
> +       	.quad sys_pfm_write_pmds
> +       	.quad sys_pfm_read_pmds		/* 320 */
> +       	.quad sys_pfm_load_context
> +       	.quad sys_pfm_start
> +       	.quad sys_pfm_stop
> +       	.quad sys_pfm_restart
> +       	.quad sys_pfm_create_evtsets	/* 325 */
> +       	.quad sys_pfm_getinfo_evtsets
> +       	.quad sys_pfm_delete_evtsets
> +  	.quad sys_pfm_unload_context

I suppose all these system calls need separate review. 
The indentation is unusual


I trust you tested they are all 32bit emulation clean.
>  	/*
> diff -ur linux-2.6.17-rc6.orig/arch/x86_64/kernel/nmi.c linux-2.6.17-rc6/arch/x86_64/kernel/nmi.c
> --- linux-2.6.17-rc6.orig/arch/x86_64/kernel/nmi.c	2006-06-08 01:42:31.000000000 -0700
> +++ linux-2.6.17-rc6/arch/x86_64/kernel/nmi.c	2006-06-08 01:49:22.000000000 -0700
> @@ -248,6 +248,7 @@
>  	old_owner = lapic_nmi_owner;
>  	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
>  	spin_unlock(&lapic_nmi_owner_lock);
> +

?? 

>  		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
>  		if (!p->thread.io_bitmap_ptr) {
> @@ -482,6 +486,8 @@
>  		if (err) 
>  			goto out;
>  	}
> +
> +

?? 

>  	err = 0;
>  out:
>  	if (err && p->thread.io_bitmap_ptr) {
> @@ -615,6 +621,7 @@
>  			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
>  		}
>  	}
> +	pfm_ctxswin(next_p);

You definitely add far too much code to the context switch.

Please fold the existing debug register check and the existing 
io bitmap check together into a single bitmap test and do the individual checks
then only inside that if (). The non debug case is supposed to be fast
and not weighted down by so many checks.

>  	}
> +	/*
> +	 * must be done before signals
> +	 */
> +	pfm_handle_work();

The comment is not very enlightening. 

Also this should be inside the usual bitmap checks.


> diff -ur linux-2.6.17-rc6.orig/include/asm-x86_64/hw_irq.h linux-2.6.17-rc6/include/asm-x86_64/hw_irq.h
> --- linux-2.6.17-rc6.orig/include/asm-x86_64/hw_irq.h	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.17-rc6/include/asm-x86_64/hw_irq.h	2006-06-08 01:49:22.000000000 -0700
> @@ -67,6 +67,7 @@
>   * sources per level' errata.
>   */
>  #define LOCAL_TIMER_VECTOR	0xef
> +#define LOCAL_PERFMON_VECTOR	0xee
>  
>  /*
>   * First APIC vector available to drivers: (vectors 0x30-0xee)
> @@ -74,7 +75,7 @@
>   * levels. (0x80 is the syscall vector)
>   */
>  #define FIRST_DEVICE_VECTOR	0x31
> -#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
> +#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
>  
>  
>  #ifndef __ASSEMBLY__
> diff -ur linux-2.6.17-rc6.orig/include/asm-x86_64/irq.h linux-2.6.17-rc6/include/asm-x86_64/irq.h
> --- linux-2.6.17-rc6.orig/include/asm-x86_64/irq.h	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.17-rc6/include/asm-x86_64/irq.h	2006-06-08 01:49:22.000000000 -0700
> @@ -29,7 +29,7 @@
>   */
>  #define NR_VECTORS 256
>  
> -#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
> +#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
>  
>  #ifdef CONFIG_PCI_MSI
>  #define NR_IRQS FIRST_SYSTEM_VECTOR
> Only in linux-2.6.17-rc6/include/asm-x86_64: perfmon.h
> Only in linux-2.6.17-rc6/include/asm-x86_64: perfmon_em64t_pebs_smpl.h
> diff -ur linux-2.6.17-rc6.orig/include/asm-x86_64/system.h linux-2.6.17-rc6/include/asm-x86_64/system.h
> --- linux-2.6.17-rc6.orig/include/asm-x86_64/system.h	2006-06-08 01:42:36.000000000 -0700
> +++ linux-2.6.17-rc6/include/asm-x86_64/system.h	2006-06-08 01:49:22.000000000 -0700
> @@ -27,6 +27,7 @@
>  	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
>  
>  #define switch_to(prev,next,last) \
> +	pfm_ctxswout(prev);							  \

No way. At best please a single shared test in the context switch as described above, not a multitude
of different hooks all over the fast paths. This should be in __switch_to()

-Andi
