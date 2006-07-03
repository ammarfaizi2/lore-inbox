Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWGCA2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGCA2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWGCA2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:28:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750788AbWGCA2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:28:17 -0400
Date: Sun, 2 Jul 2006 17:28:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] genirq:fixup missing SA_PERCPU replacement
Message-Id: <20060702172802.2b84a426.akpm@osdl.org>
In-Reply-To: <1151886032.24611.28.camel@localhost.localdomain>
References: <1151886032.24611.28.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 02:20:32 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The irqflags consolidation converted SA_PERCPU_IRQ to IRQF_PERCPU but
> did not define the new constant.
> 

No, I fixed that up (you were cc'ed).  Only I fixed it up the "old" way,
by putting it in include/asm-ia64/irq.h.

> 
> Index: linux-2.6.git/include/linux/interrupt.h
> ===================================================================
> --- linux-2.6.git.orig/include/linux/interrupt.h	2006-07-02 23:38:32.000000000 +0200
> +++ linux-2.6.git/include/linux/interrupt.h	2006-07-03 01:57:20.000000000 +0200
> @@ -45,6 +45,7 @@
>  #define IRQF_SHARED		0x00000080
>  #define IRQF_PROBE_SHARED	0x00000100
>  #define IRQF_TIMER		0x00000200
> +#define IRQF_PERCPU		0x00000400
>  
>  /*
>   * Migration helpers. Scheduled for removal in 1/2007
> @@ -54,6 +55,7 @@
>  #define SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
>  #define SA_SHIRQ		IRQF_SHARED
>  #define SA_PROBEIRQ		IRQF_PROBE_SHARED
> +#define SA_PERCPU		IRQF_PERCPU
>  
>  #define SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
>  #define SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
> Index: linux-2.6.git/kernel/irq/manage.c
> ===================================================================
> --- linux-2.6.git.orig/kernel/irq/manage.c	2006-07-02 23:38:32.000000000 +0200
> +++ linux-2.6.git/kernel/irq/manage.c	2006-07-03 01:58:45.000000000 +0200
> @@ -234,7 +234,7 @@ int setup_irq(unsigned int irq, struct i
>  		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))
>  			goto mismatch;
>  
> -#if defined(CONFIG_IRQ_PER_CPU) && defined(IRQF_PERCPU)
> +#if defined(CONFIG_IRQ_PER_CPU)
>  		/* All handlers must agree on per-cpuness */
>  		if ((old->flags & IRQF_PERCPU) !=
>  		    (new->flags & IRQF_PERCPU))
> @@ -250,7 +250,7 @@ int setup_irq(unsigned int irq, struct i
>  	}
>  
>  	*p = new;
> -#if defined(CONFIG_IRQ_PER_CPU) && defined(IRQF_PERCPU)
> +#if defined(CONFIG_IRQ_PER_CPU)
>  	if (new->flags & IRQF_PERCPU)
>  		desc->status |= IRQ_PER_CPU;
>  #endif

This is of course better, but we'll also need:

--- a/include/asm-ia64/irq.h~a
+++ a/include/asm-ia64/irq.h
@@ -14,8 +14,6 @@
 #define NR_IRQS		256
 #define NR_IRQ_VECTORS	NR_IRQS
 
-#define IRQF_PERCPU	0x02000000
-
 static __inline__ int
 irq_canonicalize (int irq)
 {
_

