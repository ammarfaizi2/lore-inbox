Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVHPJip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVHPJip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHPJio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:38:44 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:21633 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965169AbVHPJin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:38:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FdCjbL/0KJFr6T01OEpi1WtefnpMGTYh39aDRUDr1rTrCL2KQJESZlVo6AoXyLWU0ZlMc1M9NhTN7239ifVwz3kpQ4LI9tclcPSOnh4JNMcaPUMfkZdkJrvc5aJzOn0Phwr95EmnFSOhRuRvW0V7K2uk527VqM1RibPKLRhLC68=
Message-ID: <58cb370e050816023845b57a74@mail.gmail.com>
Date: Tue, 16 Aug 2005 11:38:37 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <200508151507.22776.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/15/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Friday 12 August 2005 2:40 am, Alan Cox wrote:
> > Assuming all IA-64 boxes are PCI or better then you actually want to
> > edit include/asm-ia64/ide.h and edit ide_default_io_base where someone
> > years ago cut and pasted x86-32 values so that case 2-5 are removed.
> > Then you will just probe the compatibility mode PCI addresses for system
> > IDE channels.
> 
> Thanks for the pointer.  There shouldn't be anything arch-
> specific required for ia64, so I think we can get rid of
> just about everything in asm-ia64/ide.h, since everything
> we care about will be discovered by PCI IDE.

Agreed but I have few comments:
* is this change OK w.r.t. IA64_HP_SIM?
* removing IDE_ARCH_OBSOLETE_INIT define has some implications,
  * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
  * ordering change for ide-pnp interfaces in case of no IDE devices
    on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)
  * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
  are these implication fine with IA64?

> There's no ia64 reason to limit MAX_HWIFS, so I used
> CONFIG_IDE_MAX_HWIFS, resulting in a little more Kconfig
> ugliness.  Maybe that should move into linux/ide.h, so
> arches only need to define MAX_HWIFS if they have a need
> for it?

This changes default default MAX_HWIFS value from
10 (6 in case of !CONFIG_PCI) to 4 which is not desirable.

IMO the best thing for now is to leave MAX_HWIFS alone.

> I noticed that on a box with no devices on ide1, we probed
> ide1 twice -- once via ide_setup_pci_device() and again via
> ide_generic_init().  This isn't fatal, since the generic probe
> uses the I/O ports setup by PCI IDE, but it's unnecessary
> and a bit ugly.
> 
> I stuck in a "hwif->noprobe = 1" at the point where probe_hwif()
> decides the interface isn't present, which prevents the second
> probe by ide_generic_init().

Please separate this change out - it is a nice fix but it affects other
archs/drivers and somebody needs to audit all IDE host drivers that
they set hwif->noprobe = 0 correctly before probing in case of re-using
hwif that was already owned/probed by other driver.

> Other comments or advice?

Please make IDE_GENERIC depend on !IA_64.

Thanks!
Bartlomiej

> Index: work-vga/drivers/ide/Kconfig
> ===================================================================
> --- work-vga.orig/drivers/ide/Kconfig   2005-08-11 15:39:27.000000000 -0600
> +++ work-vga/drivers/ide/Kconfig        2005-08-15 12:08:05.000000000 -0600
> @@ -52,9 +52,9 @@
> 
>  if IDE
> 
> -config IDE_MAX_HWIFS
> +config IDE_MAX_HWIFS
>         int "Max IDE interfaces"
> -       depends on ALPHA || SUPERH
> +       depends on ALPHA || SUPERH || IA64
>         default 4
>         help
>           This is the maximum number of IDE hardware interfaces that will
> Index: work-vga/include/asm-ia64/ide.h
> ===================================================================
> --- work-vga.orig/include/asm-ia64/ide.h        2005-08-03 16:48:31.000000000 -0600
> +++ work-vga/include/asm-ia64/ide.h     2005-08-15 14:29:44.000000000 -0600
> @@ -14,58 +14,12 @@
>  #ifdef __KERNEL__
> 
>  #include <linux/config.h>
> -
> -#include <linux/irq.h>
> +#include <asm-generic/ide_iops.h>
> 
>  #ifndef MAX_HWIFS
> -# ifdef CONFIG_PCI
> -#define MAX_HWIFS      10
> -# else
> -#define MAX_HWIFS      6
> -# endif
> -#endif
> -
> -#define IDE_ARCH_OBSOLETE_DEFAULTS
> -
> -static inline int ide_default_irq(unsigned long base)
> -{
> -       switch (base) {
> -             case 0x1f0: return isa_irq_to_vector(14);
> -             case 0x170: return isa_irq_to_vector(15);
> -             case 0x1e8: return isa_irq_to_vector(11);
> -             case 0x168: return isa_irq_to_vector(10);
> -             case 0x1e0: return isa_irq_to_vector(8);
> -             case 0x160: return isa_irq_to_vector(12);
> -             default:
> -               return 0;
> -       }
> -}
> -
> -static inline unsigned long ide_default_io_base(int index)
> -{
> -       switch (index) {
> -             case 0: return 0x1f0;
> -             case 1: return 0x170;
> -             case 2: return 0x1e8;
> -             case 3: return 0x168;
> -             case 4: return 0x1e0;
> -             case 5: return 0x160;
> -             default:
> -               return 0;
> -       }
> -}
> -
> -#define IDE_ARCH_OBSOLETE_INIT
> -#define ide_default_io_ctl(base)       ((base) + 0x206) /* obsolete */
> -
> -#ifdef CONFIG_PCI
> -#define ide_init_default_irq(base)     (0)
> -#else
> -#define ide_init_default_irq(base)     ide_default_irq(base)
> +#define MAX_HWIFS      CONFIG_IDE_MAX_HWIFS
>  #endif
> 
> -#include <asm-generic/ide_iops.h>
> -
>  #endif /* __KERNEL__ */
> 
>  #endif /* __ASM_IA64_IDE_H */
> Index: work-vga/include/linux/ide.h
> ===================================================================
> --- work-vga.orig/include/linux/ide.h   2005-08-03 16:48:32.000000000 -0600
> +++ work-vga/include/linux/ide.h        2005-08-15 12:43:38.000000000 -0600
> @@ -266,7 +266,7 @@
> 
>  #include <asm/ide.h>
> 
> -/* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
> +/* needed on alpha, x86/x86_64, mips, ppc32 and sh */
>  #ifndef IDE_ARCH_OBSOLETE_DEFAULTS
>  # define ide_default_io_base(index)    (0)
>  # define ide_default_irq(base)         (0)
> Index: work-vga/drivers/ide/ide-probe.c
> ===================================================================
> --- work-vga.orig/drivers/ide/ide-probe.c       2005-08-09 15:09:59.000000000 -0600
> +++ work-vga/drivers/ide/ide-probe.c    2005-08-15 14:30:33.000000000 -0600
> @@ -852,6 +852,7 @@
> 
>         if (!hwif->present) {
>                 ide_hwif_release_regions(hwif);
> +               hwif->noprobe = 1;
>                 return;
>         }
