Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVD3RI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVD3RI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 13:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVD3RI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 13:08:27 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:9173 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261304AbVD3RIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 13:08:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0DiLwOT8qDHGnkxec35d76PEDFmha9R2AWrd9BgK/ziqsuBau01+pFXX5wM0FU62NiuUlQ0IImrayXVdsg6oGBVdJXRaN/zblLaxlSHF8LkTXM/8Yc8JbpCfCMS4/voe/UtO9bsl0O97eImifkI1yhsXntZDlgqjhUbV2gA4ag=
Message-ID: <2cd57c9005043010051c6455fb@mail.gmail.com>
Date: Sun, 1 May 2005 01:05:52 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.12-rc3-mm1
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <20050430142035.GB3571@stusta.de>
	 <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> On Sat, 30 Apr 2005, Adrian Bunk wrote:
> 
> > The static inline set_irq_info() is not available
> > for CONFIG_GENERIC_PENDING_IRQ=n, resulting in the following warning:
> 
> This could have been compile tested more :/
> 
> >   CC      arch/i386/kernel/io_apic.o
> > arch/i386/kernel/io_apic.c: In function `set_ioapic_affinity_irq':
> > arch/i386/kernel/io_apic.c:251: warning: implicit declaration of function `set_irq_info'
> > ...
> >
> > <--  snip  -->
> >
> >
> > The second bug is that although irq.h defines set_irq_info() as a static
> > inline, this patch adds an empty function to kernel/irq/manage.c .
> 
> That stuff shouldn't even be built on UP (altough it does provide more
> coverage)
> 
> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> 
> Index: linux-2.6.12-rc3-mm1-up/arch/i386/kernel/io_apic.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 io_apic.c
> --- linux-2.6.12-rc3-mm1-up/arch/i386/kernel/io_apic.c  30 Apr 2005 15:29:08 -0000      1.1.1.1
> +++ linux-2.6.12-rc3-mm1-up/arch/i386/kernel/io_apic.c  30 Apr 2005 16:19:06 -0000
> @@ -221,6 +221,7 @@ static void clear_IO_APIC (void)
>                         clear_IO_APIC_pin(apic, pin);
>  }
> 
> +#ifdef CONFIG_SMP
>  static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t cpumask)
>  {
>         unsigned long flags;
> @@ -252,8 +253,6 @@ static void set_ioapic_affinity_irq(unsi
>         spin_unlock_irqrestore(&ioapic_lock, flags);
>  }
> 
> -#ifdef CONFIG_SMP
> -
>  #if defined(CONFIG_IRQBALANCE)
>  # include <asm/processor.h>    /* kernel_thread() */
>  # include <linux/kernel_stat.h>        /* kstat */
> @@ -816,6 +815,7 @@ int IO_APIC_get_PCI_irq_vector(int bus,
>   * we need to reprogram the ioredtbls to cater for the cpus which have come online
>   * so mask in all cases should simply be TARGET_CPUS
>   */
> +#ifdef CONFIG_SMP
>  void __init setup_ioapic_dest(void)
>  {
>         int pin, ioapic, irq, irq_entry;
> @@ -834,6 +834,7 @@ void __init setup_ioapic_dest(void)
> 
>         }
>  }
> +#endif
> 
>  /*
>   * EISA Edge/Level control register, ELCR
> @@ -1973,6 +1974,7 @@ static void unmask_IO_APIC_vector (unsig
>         unmask_IO_APIC_irq(irq);
>  }
> 
> +#ifdef CONFIG_SMP
>  static void set_ioapic_affinity_vector (unsigned int vector,
>                                         cpumask_t cpu_mask)
>  {
> @@ -1982,6 +1984,7 @@ static void set_ioapic_affinity_vector (
>         set_ioapic_affinity_irq(irq, cpu_mask);
>  }
>  #endif
> +#endif
> 
>  /*
>   * Level and edge triggered IO-APIC interrupts need different handling,
> @@ -1999,7 +2002,9 @@ static struct hw_interrupt_type ioapic_e
>         .disable        = disable_edge_ioapic,
>         .ack            = ack_edge_ioapic,
>         .end            = end_edge_ioapic,
> +#ifdef CONFIG_SMP
>         .set_affinity   = set_ioapic_affinity,
> +#endif
>  };
> 
>  static struct hw_interrupt_type ioapic_level_type = {
> @@ -2010,7 +2015,9 @@ static struct hw_interrupt_type ioapic_l
>         .disable        = disable_level_ioapic,
>         .ack            = mask_and_ack_level_ioapic,
>         .end            = end_level_ioapic,
> +#ifdef CONFIG_SMP
>         .set_affinity   = set_ioapic_affinity,
> +#endif
>  };
> 
>  static inline void init_IO_APIC_traps(void)

I was trying to fix this too. You are quicker and better than me. In
addition, this redundant  include should be removed.

diff -pruN 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c
2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c
--- 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c   2005-04-30
19:15:46.000000000 +0800
+++ 2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c       2005-05-01
00:49:27.000000000 +0800
@@ -32,7 +32,6 @@
 #include <linux/compiler.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
-#include <linux/irq.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
