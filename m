Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVI0Dnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVI0Dnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVI0Dnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:43:33 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:3486 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750832AbVI0Dnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:43:32 -0400
Date: Mon, 26 Sep 2005 23:40:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Message-ID: <200509262342_MC3-1-AB3C-C0FF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.61.0509251101060.1684@montezuma.fsmlabs.com>

On Sun, 25 Sep 2005 at 11:01:29 -0700, Zwane Mwaikambo wrote:

> --- linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S     24 Sep 2005 18:26:49 -0000      1.1.1.1
> +++ linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S     25 Sep 2005 05:15:29 -0000
> @@ -410,27 +410,18 @@ syscall_badsys:
>       FIXUP_ESPFIX_STACK \
>  28:  popl %eax;
>  
> -/*
> - * Build the entry stubs and pointer table with
> - * some assembler magic.
> - */
> -.data
> -ENTRY(interrupt)
> -.text
> -
> +/* Build the IRQ entry stubs */
>  vector=0
> -ENTRY(irq_entries_start)
> +     .align IRQ_STUB_SIZE,0x90
> +ENTRY(interrupt)
>  .rept NR_IRQS
>       ALIGN     <===================================
> -1:   pushl $vector-256
> +     pushl $vector-0x10000
>       jmp common_interrupt
> -.data
> -     .long 1b
> -.text
> +     .align IRQ_STUB_SIZE,0x90
>  vector=vector+1
>  .endr
>  
> -     ALIGN
>  common_interrupt:
>       SAVE_ALL
>       movl %esp,%eax

  That ALIGN could cause problems if someone changed default i386 alignment to
something larger than IRQ_STUB_SIZE.  Why is it there?


> --- linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h   24 Sep 2005 18:27:12 -0000      1.1.1.1
> +++ linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h   25 Sep 2005 05:15:35 -0000
> @@ -2,11 +2,15 @@
>  #define _ASM_IRQ_VECTORS_LIMITS_H
>  
>  #ifdef CONFIG_PCI_MSI
> -#define NR_IRQS FIRST_SYSTEM_VECTOR
> +#define NR_IRQS 224
> +#define IRQ_STUB_SIZE 16
>  #define NR_IRQ_VECTORS NR_IRQS
> +#define NR_IRQ_NODES MAX_NUMNODES
>  #else
>  #ifdef CONFIG_X86_IO_APIC
>  #define NR_IRQS 224
> +#define IRQ_STUB_SIZE 16
> +#define NR_IRQ_NODES MAX_NUMNODES
>  # if (224 >= 32 * NR_CPUS)
>  # define NR_IRQ_VECTORS NR_IRQS
>  # else
> @@ -14,8 +18,13 @@
>  # endif
>  #else
>  #define NR_IRQS 16
> +#define IRQ_STUB_SIZE 16        <=================================
> +#define NR_IRQ_NODES 1
>  #define NR_IRQ_VECTORS NR_IRQS
>  #endif
>  #endif
>  
> +/* number of vectors available for external interrupts in Linux */
> +#define NR_DEVICE_VECTORS    190
> +
>  #endif /* _ASM_IRQ_VECTORS_LIMITS_H */

 Can't these be 8 bytes when there are only 16 IRQs?

 And is there any way to special-case kernels built with max of two CPUs so there are
only 24 IRQs allocated?  That seems to be the maximum for that case.

__
Chuck
