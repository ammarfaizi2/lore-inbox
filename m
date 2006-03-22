Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWCVIgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCVIgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWCVIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:36:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38823 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751093AbWCVIgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:36:50 -0500
Subject: Re: [RFC PATCH 23/35] Add support for Xen event channels.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063758.453555000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063758.453555000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:36:47 +0100
Message-Id: <1143016607.2955.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:31 -0800, Chris Wright wrote:
> plain text document attachment (22-evtchn)
> Support Xen event channels instead of the i8259 PIC.
> 
> Event channels are used to inject events into the kernel, either from
> the hypervisor or from another VM.  The injected events are mapped to
> interrupts.
> 
> If an event needs to be injected, the hypervisor causes an upcall into
> the kernel.  The upcall handler then scans the event pending bitmap
> and calls do_IRQ for each pending event.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/i386/kernel/Makefile               |    6 
>  arch/i386/mach-xen/evtchn.c             |  844 ++++++++++++++++++++++++++++++++
>  drivers/xen/core/Makefile               |    2 
>  include/asm-i386/hw_irq.h               |    4 
>  include/asm-i386/mach-xen/irq_vectors.h |  126 ++++
>  include/xen/evtchn.h                    |  113 ++++
>  6 files changed, 1093 insertions(+), 2 deletions(-)
> 
> --- xen-subarch-2.6.orig/arch/i386/kernel/Makefile
> +++ xen-subarch-2.6/arch/i386/kernel/Makefile
> @@ -5,7 +5,7 @@
>  extra-y := head.o init_task.o vmlinux.lds
>  
>  obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
> -		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
> +		ptrace.o time.o ioport.o ldt.o setup.o hw_irq.o sys_i386.o \
>  		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
>  		quirks.o i8237.o topology.o
>  
> @@ -42,6 +42,10 @@ EXTRA_AFLAGS   := -traditional
>  
>  obj-$(CONFIG_SCx200)		+= scx200.o
>  
> +hw_irq-y			:= i8259.o
> +
> +hw_irq-$(CONFIG_XEN)		:= ../mach-xen/evtchn.o
> +
>  # vsyscall.o contains the vsyscall DSO images as __initdata.
>  # We must build both images before we can assemble it.
>  # Note: kbuild does not track this dependency due to usage of .incbin
> --- xen-subarch-2.6.orig/include/asm-i386/hw_irq.h
> +++ xen-subarch-2.6/include/asm-i386/hw_irq.h
> @@ -68,7 +68,9 @@ extern atomic_t irq_mis_count;
>  
>  #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
>  
> -#if defined(CONFIG_X86_IO_APIC)
> +#if defined(CONFIG_X86_XEN)
> +extern void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i);
> +#elif defined(CONFIG_X86_IO_APIC)
>  static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
>  {
>  	if (IO_APIC_IRQ(i))
> --- /dev/null
> +++ xen-subarch-2.6/arch/i386/mach-xen/evtchn.c
> @@ -0,0 +1,844 @@
> +/******************************************************************************
> + * evtchn.c
> + * 
> + * Communication via Xen event channels.
> + * 
> + * Copyright (c) 2002-2005, K A Fraser
> + * 
> + * This file may be distributed separately from the Linux kernel, or
> + * incorporated into other software packages, subject to the following license:
> + * 


again no allowance for use inside the kernel


> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/version.h>

this highly looks that it's not possible to be used outside the linux
kernel so the license is odd

> +/* Convenient shorthand for packed representation of an unbound IRQ. */
> +#define IRQ_UNBOUND	mk_irq_info(IRQT_UNBOUND, 0, 0)
> +/* Accessor macros for packed IRQ information. */
> +#define evtchn_from_irq(irq) ((u16)(irq_info[irq]))
> +#define index_from_irq(irq)  ((u8)(irq_info[irq] >> 16))
> +#define type_from_irq(irq)   ((u8)(irq_info[irq] >> 24))

static inlines please

> +#ifdef CONFIG_XEN_EVTCHN_DEVICE
> +				evtchn_device_upcall(port);
> +#else
> +				mask_evtchn(port);
> +#endif

why this ifdef ?

> +static int find_unbound_irq(void)
> +{
> +	int irq;
> +
> +	for (irq = 0; irq < NR_IRQS; irq++)
> +		if (irq_bindcount[irq] == 0)
> +			break;
> +
> +	if (irq == NR_IRQS) {
> +		printk(KERN_ERR "No available IRQ to bind to: increase NR_IRQS!\n");

there is no way to share interrupts? A shame


> +EXPORT_SYMBOL(bind_virq_to_irqhandler);

this is highly low level interfact, please make this and the others a
_GPL export



