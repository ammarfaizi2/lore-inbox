Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272568AbTHRQpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272664AbTHRQpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:45:22 -0400
Received: from [63.247.75.124] ([63.247.75.124]:26769 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272568AbTHRQpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:45:13 -0400
Date: Mon, 18 Aug 2003 12:45:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ALPHA] Update for "name" out of struct device.
Message-ID: <20030818164512.GF24693@gtf.org>
References: <200308181611.h7IGBEcW024487@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308181611.h7IGBEcW024487@hera.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 05:24:13AM +0000, Linux Kernel Mailing List wrote:
> --- a/arch/alpha/kernel/sys_marvel.c	Mon Aug 18 09:11:18 2003
> +++ b/arch/alpha/kernel/sys_marvel.c	Mon Aug 18 09:11:18 2003
> @@ -33,6 +33,13 @@
> +/* ??? Should probably be generic.  */
> +#ifdef CONFIG_PCI_NAMES
> +#define pci_pretty_name(x) ((x)->pretty_name)
> +#else
> +#define pci_pretty_name(x) ""
> +#endif
> +

> @@ -378,7 +385,7 @@
>  		       PCI_SLOT(dev->devfn), 
>  		       PCI_FUNC(dev->devfn),
>  		       hose->index,
> -		       dev->dev.name);
> +		       pci_pretty_name (dev));
>  		printk("  %d message(s) from 0x%04x\n", 

hmmm, I think a better fix can be had...  We store all that information.

What do you think about the following patch?  It follows the style of
other PCI core messages, and prints out the same information as before.

This assumes, of course, marvel_map_irq is called after pci_name() is
assigned a value...

	Jeff





===== arch/alpha/kernel/sys_marvel.c 1.7 vs edited =====
--- 1.7/arch/alpha/kernel/sys_marvel.c	Mon Aug 18 01:23:05 2003
+++ edited/arch/alpha/kernel/sys_marvel.c	Mon Aug 18 12:43:51 2003
@@ -33,13 +33,6 @@
 # error NR_IRQS < MARVEL_NR_IRQS !!!
 #endif
 
-/* ??? Should probably be generic.  */
-#ifdef CONFIG_PCI_NAMES
-#define pci_pretty_name(x) ((x)->pretty_name)
-#else
-#define pci_pretty_name(x) ""
-#endif
-
 
 /*
  * Interrupt handling.
@@ -380,12 +373,7 @@
 		irq += 0x80;			/* offset for lsi       */
 
 #if 1
-		printk("PCI:%d:%d:%d (hose %d) [%s] is using MSI\n",
-		       dev->bus->number, 
-		       PCI_SLOT(dev->devfn), 
-		       PCI_FUNC(dev->devfn),
-		       hose->index,
-		       pci_pretty_name (dev));
+		printk("PCI:%s is using MSI\n", pci_name (dev));
 		printk("  %d message(s) from 0x%04x\n", 
 		       1 << ((msg_ctl & PCI_MSI_FLAGS_QSIZE) >> 4),
 		       msg_dat);
