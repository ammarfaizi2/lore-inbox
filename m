Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbUJ1G1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUJ1G1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUJ1G1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:27:18 -0400
Received: from fmr10.intel.com ([192.55.52.30]:1258 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262868AbUJ1GUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:20:37 -0400
Subject: Re: [PATCH 1/5]Avoid ACPI assign legacy devices' IRQ for PCI
	devices
From: Len Brown <len.brown@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <1098327558.6132.220.camel@sli10-desk.sh.intel.com>
References: <1098327558.6132.220.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098944421.5403.2.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Oct 2004 02:20:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2004-10-20 at 22:59, Li Shaohua wrote:
> Hi,
> The patch introduces acpi_penalize_isa_irq, its goal is to avoid PCI
> devices use IRQ of legacy PNP devices.
> 
> Thanks,
> Shaohua
> 
> 
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> 
> ===== include/linux/acpi.h 1.36 vs edited =====
> --- 1.36/include/linux/acpi.h   2004-06-02 23:02:20 +08:00
> +++ edited/include/linux/acpi.h 2004-09-22 10:09:23 +08:00
> @@ -439,6 +439,7 @@ extern struct acpi_prt_list acpi_prt;
>  struct pci_dev;
> 
>  int acpi_pci_irq_enable (struct pci_dev *dev);
> +void acpi_penalize_isa_irq(int irq);
> 
>  struct acpi_pci_driver {
>         struct acpi_pci_driver *next;
> ===== drivers/acpi/pci_link.c 1.31 vs edited =====
> --- 1.31/drivers/acpi/pci_link.c        2004-08-05 03:55:16 +08:00
> +++ edited/drivers/acpi/pci_link.c      2004-09-22 10:08:09 +08:00
> @@ -786,6 +786,11 @@ static int __init acpi_irq_penalty_updat
>         return 1;
>  }
> 
> +void acpi_penalize_isa_irq(int irq)
> +{
> +       acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
> +}
> +
>  /*
>   * Over-ride default table to reserve additional IRQs for use by ISA
>   * e.g. acpi_irq_isa=5
> ===== arch/i386/pci/irq.c 1.47 vs edited =====
> --- 1.47/arch/i386/pci/irq.c    2004-08-02 16:00:43 +08:00
> +++ edited/arch/i386/pci/irq.c  2004-09-22 10:27:30 +08:00
> @@ -17,6 +17,7 @@
>  #include <asm/smp.h>
>  #include <asm/io_apic.h>
>  #include <asm/hw_irq.h>
> +#include <linux/acpi.h>
> 
>  #include "pci.h"
> 
> @@ -989,13 +990,24 @@ static int __init pcibios_irq_init(void)
>  subsys_initcall(pcibios_irq_init);
> 
> 
> -void pcibios_penalize_isa_irq(int irq)
> +static void pirq_penalize_isa_irq(int irq)
>  {
>         /*
>          *  If any ISAPnP device reports an IRQ in its list of
> possible
>          *  IRQ's, we try to avoid assigning it to PCI devices.
>          */
> -       pirq_penalty[irq] += 100;
> +       if (irq < 16)
> +               pirq_penalty[irq] += 100;
> +}
> +
> +void pcibios_penalize_isa_irq(int irq)
> +{
> +#ifdef CONFIG_ACPI_PCI
> +       if (!acpi_noirq)
> +               acpi_penalize_isa_irq(irq);
> +       else
> +#endif
> +               pirq_penalize_isa_irq(irq);
>  }
> 
>  int pirq_enable_irq(struct pci_dev *dev)
> ===== drivers/pnp/pnpbios/rsparser.c 1.4 vs edited =====
> --- 1.4/drivers/pnp/pnpbios/rsparser.c  2004-09-14 08:23:17 +08:00
> +++ edited/drivers/pnp/pnpbios/rsparser.c       2004-09-22 10:31:09
> +08:00
> @@ -7,6 +7,7 @@
>  #include <linux/ctype.h>
>  #include <linux/pnp.h>
>  #include <linux/pnpbios.h>
> +#include <linux/pci.h>
> 
>  #include "pnpbios.h"
> 
> @@ -58,6 +59,7 @@ pnpbios_parse_allocated_irqresource(stru
>                 }
>                 res->irq_resource[i].start =
>                 res->irq_resource[i].end = (unsigned long) irq;
> +               pcibios_penalize_isa_irq(irq);
>         }
>  }
> 
> 
> 
> 

