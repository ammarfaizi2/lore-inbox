Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUIYJQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUIYJQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbUIYJQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:16:50 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:54788 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269290AbUIYJQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:16:40 -0400
Date: Sat, 25 Sep 2004 12:15:27 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
In-Reply-To: <20040924152026.A25742@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>
References: <20040923233410.A19555@unix-os.sc.intel.com>
 <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com>
 <20040924152026.A25742@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Suresh,

On Fri, 24 Sep 2004, Suresh Siddha wrote:

> Ok. How about this patch?
> 
> Add pci quirks to disable irqbalance/affinity for E7520/E7320/E7525
> with revision ID 0x09 and below.

> diff -Nru linux-2.6.9-rc2/drivers/pci/quirks.c linux-irq/drivers/pci/quirks.c
> --- linux-2.6.9-rc2/drivers/pci/quirks.c	2004-09-12 22:31:27.000000000 -0700
> +++ linux-irq/drivers/pci/quirks.c	2004-09-04 12:33:54.373316312 -0700
> @@ -814,6 +814,64 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
>  
> +#ifdef CONFIG_X86_IO_APIC
> +#include <asm/hw_irq.h>
> +#ifdef CONFIG_IRQBALANCE
> +extern int irqbalance_disable(char *str);
> +#endif
> +extern int no_irq_affinity;
> +extern int noirqdebug_setup(char *str);

Ok this is sort of ugly, but it's not your fault, i understand that the
PCI quirks code is too late after IOAPIC setup, x86_64 has some early PCI
bridge detection code which helps in doing IOAPIC quirks.

> +void __devinit quirk_intel_irqbalance(struct pci_dev *dev)

This may as well be moved elsewhere since it's not actually going to be 
used in PCI quirks. I think you should just do the chipset detection in 
io_apic.c and then do the disable from there, it's racy and strange 
(although it may seem natural) to do it in quirks.c

Thanks,
	Zwane
