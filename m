Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWCVPDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWCVPDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCVPDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:30 -0500
Received: from cantor.suse.de ([195.135.220.2]:62879 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750994AbWCVPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:29 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 23/35] Add support for Xen event channels.
Date: Wed, 22 Mar 2006 15:07:15 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063758.453555000@sorel.sous-sol.org>
In-Reply-To: <20060322063758.453555000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221507.15620.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:31, Chris Wright wrote:
> Support Xen event channels instead of the i8259 PIC.
> 
> Event channels are used to inject events into the kernel, either from
> the hypervisor or from another VM.  The injected events are mapped to
> interrupts.
> 
> If an event needs to be injected, the hypervisor causes an upcall into
> the kernel.  The upcall handler then scans the event pending bitmap
> and calls do_IRQ for each pending event.

This looks like mostly generic code. Shouldn't most of this belong
into drivers/xen to be used by other architectures too? Putting 
so much generic code into i386 looks wrong.

> 
> -#if defined(CONFIG_X86_IO_APIC)
> +#if defined(CONFIG_X86_XEN)
> +extern void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i);
> +#elif defined(CONFIG_X86_IO_APIC)
>  static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
>  {
>  	if (IO_APIC_IRQ(i))

Better just put this out of line in the native case too.

> +/* Upcall to generic IRQ layer. */
> +#ifdef CONFIG_X86

We don't do such things with ifdef trees. Put the necessary 
code into asm/ 


> --- /dev/null
> +++ xen-subarch-2.6/include/asm-i386/mach-xen/irq_vectors.h
> @@ -0,0 +1,126 @@
> +/*
> + * This file should contain #defines for all of the interrupt vector
> + * numbers used by this architecture.

This is mostly identical with native right? Sharing, sharing, sharing.

-Andi
