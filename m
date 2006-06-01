Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWFAPJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWFAPJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWFAPJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:09:56 -0400
Received: from xenotime.net ([66.160.160.81]:25784 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030191AbWFAPJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:09:55 -0400
Date: Thu, 1 Jun 2006 08:12:35 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060601081235.eda3d8d6.rdunlap@xenotime.net>
In-Reply-To: <20060601061440.GA19236@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<20060531182507.aaf1f9fd.rdunlap@xenotime.net>
	<20060531184302.9e79f518.akpm@osdl.org>
	<20060601061440.GA19236@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 08:14:40 +0200 Ingo Molnar wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > [   36.489028] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> > > [   36.500245]  [<0000000000000000>] stext+0x7feff0e8/0xe8
> 
> > > [   37.103370] Call Trace:
> > > [   37.140640]  <IRQ> [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
> > > [   37.167285]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
> > > [   37.193322]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
> > > [   37.219723]  <EOI>
> 
> Randy, do you have an MSI-X device perhaps? Could you try the patch 
> below?

Sorry, not that I know of.  /proc/interrupts does show this (on
2.6.17-rc5-mm1) (note PCI-MSI-<NULL>):

rddunlap@midway:~> cat /proc/interrupts 
           CPU0       CPU1       
  0:    4651467          0   IO-APIC-edge    timer
  1:       7099          0   IO-APIC-edge    i8042
  7:          0          0   IO-APIC-edge    parport0
  9:          0          0   IO-APIC-level   acpi
 12:      77137          0   IO-APIC-edge    i8042
 14:     414494          0   IO-APIC-edge    ide0
 58:      55174          0   PCI-MSI-<NULL>  eth0
 66:     786408     682074   PCI-MSI-<NULL>  libata
 74:          0          0   IO-APIC-level   ehci_hcd:usb1, uhci_hcd:usb6
 82:         31          0   IO-APIC-level   ohci_hcd:usb2, ohci_hcd:usb3, ohci_hcd:usb4, ohci_hcd:usb5
 90:        242          0   IO-APIC-level   HDA Intel
169:          3          0   IO-APIC-level   ohci1394
177:          0          0   IO-APIC-level   uhci_hcd:usb8
185:          0          0   IO-APIC-level   uhci_hcd:usb7
193:          0          0   IO-APIC-level   uhci_hcd:usb9
NMI:       1533       1541 
LOC:    4651126    4651099 
ERR:          1
MIS:          0


> 	Ingo
> 
> ------------------------------------------------------
> Subject: genirq MSI fixes
> From: Ingo Molnar <mingo@elte.hu>
> 
> 
> This is a fixed up and cleaned up replacement for genirq-msi-fixes.patch,
> which should solve the i386 4KSTACKS problem.  I also added Ben's idea of
> pushing the __do_IRQ() check into generic_handle_irq().
> 
> I booted this with MSI enabled, but i only have MSI devices, not MSI-X
> devices.  I'd still expect MSI-X to work now.
> 
> irqchip migration helper: call __do_IRQ() if a descriptor is attached to an
> irqtype-style controller.  This also fixes MSI-X IRQ handling on i386 and
> x86_64.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Roland Dreier <rolandd@cisco.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/irq.c |    5 +++++
>  include/linux/irq.h    |   27 ++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff -puN arch/i386/kernel/irq.c~genirq-msi-fixes-2 arch/i386/kernel/irq.c
> --- devel/arch/i386/kernel/irq.c~genirq-msi-fixes-2	2006-05-30 23:47:30.000000000 -0700
> +++ devel-akpm/arch/i386/kernel/irq.c	2006-05-30 23:47:30.000000000 -0700
> @@ -77,6 +77,10 @@ fastcall unsigned int do_IRQ(struct pt_r
>  	}
>  #endif
>  
> +	if (!irq_desc[irq].handle_irq) {
> +		__do_IRQ(irq, regs);
> +		goto out_exit;
> +	}
>  #ifdef CONFIG_4KSTACKS
>  
>  	curctx = (union irq_ctx *) current_thread_info();
> @@ -109,6 +113,7 @@ fastcall unsigned int do_IRQ(struct pt_r
>  #endif
>  		desc->handle_irq(irq, desc, regs);
>  
> +out_exit:
>  	irq_exit();
>  
>  	return 1;
> diff -puN include/linux/irq.h~genirq-msi-fixes-2 include/linux/irq.h
> --- devel/include/linux/irq.h~genirq-msi-fixes-2	2006-05-30 23:47:30.000000000 -0700
> +++ devel-akpm/include/linux/irq.h	2006-05-30 23:47:30.000000000 -0700
> @@ -176,17 +176,6 @@ typedef struct irq_desc		irq_desc_t;
>   */
>  #include <asm/hw_irq.h>
>  
> -/*
> - * Architectures call this to let the generic IRQ layer
> - * handle an interrupt:
> - */
> -static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
> -{
> -	struct irq_desc *desc = irq_desc + irq;
> -
> -	desc->handle_irq(irq, desc, regs);
> -}
> -
>  extern int setup_irq(unsigned int irq, struct irqaction *new);
>  
>  #ifdef CONFIG_GENERIC_HARDIRQS
> @@ -324,6 +313,22 @@ handle_irq_name(void fastcall (*handle)(
>   */
>  extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
>  
> +/*
> + * Architectures call this to let the generic IRQ layer
> + * handle an interrupt. If the descriptor is attached to an
> + * irqchip-style controller then we call the ->handle_irq() handler,
> + * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
> + */
> +static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
> +{
> +	struct irq_desc *desc = irq_desc + irq;
> +
> +	if (likely(desc->handle_irq))
> +		desc->handle_irq(irq, desc, regs);
> +	else
> +		__do_IRQ(irq, regs);
> +}
> +
>  /* Handling of unhandled and spurious interrupts: */
>  extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
>  			   int action_ret, struct pt_regs *regs);
> _
> 


---
~Randy
