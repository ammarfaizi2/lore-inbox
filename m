Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936250AbWLDMzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936250AbWLDMzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936141AbWLDMzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:55:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:61636 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S936791AbWLDMzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:55:49 -0500
Date: Mon, 4 Dec 2006 13:55:41 +0100
From: Karsten Keil <kkeil@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: fix warnings
Message-ID: <20061204125541.GA3674@pingi.kke.suse.de>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061204014203.GA6938@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204014203.GA6938@havoc.gtf.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 08:42:03PM -0500, Jeff Garzik wrote:
> 
> * diva, sedlbauer: the 'ready' label is only used in certain configurations
> * hfc_pci:
> 	- cast 'arg' to proper size for testing and printing
> 	- print out 'void __iomem *' variables with %p,
> 	  rather than using incorrect casts that throw warnings
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 

Acked-by: Karsten keil <kkeil@suse.de>

> diff --git a/drivers/isdn/hisax/diva.c b/drivers/isdn/hisax/diva.c
> index 3dacfff..6eebeb4 100644
> --- a/drivers/isdn/hisax/diva.c
> +++ b/drivers/isdn/hisax/diva.c
> @@ -1121,7 +1121,11 @@ #endif /* CONFIG_PCI */
>  			bytecnt = 32;
>  		}
>  	}
> +
> +#ifdef __ISAPNP__
>  ready:
> +#endif
> +
>  	printk(KERN_INFO
>  		"Diva: %s card configured at %#lx IRQ %d\n",
>  		(cs->subtyp == DIVA_PCI) ? "PCI" :
> diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
> index 93f60b5..463b8ac 100644
> --- a/drivers/isdn/hisax/hfc_pci.c
> +++ b/drivers/isdn/hisax/hfc_pci.c
> @@ -1211,7 +1211,7 @@ #endif
>  			break;
>  		case (HW_TESTLOOP | REQUEST):
>  			spin_lock_irqsave(&cs->lock, flags);
> -			switch ((int) arg) {
> +			switch ((long) arg) {
>  				case (1):
>  					Write_hfc(cs, HFCPCI_B1_SSL, 0x80);	/* tx slot */
>  					Write_hfc(cs, HFCPCI_B1_RSL, 0x80);	/* rx slot */
> @@ -1229,7 +1229,7 @@ #endif
>  				default:
>  					spin_unlock_irqrestore(&cs->lock, flags);
>  					if (cs->debug & L1_DEB_WARN)
> -						debugl1(cs, "hfcpci_l1hw loop invalid %4x", (int) arg);
> +						debugl1(cs, "hfcpci_l1hw loop invalid %4lx", (long) arg);
>  					return;
>  			}
>  			cs->hw.hfcpci.trm |= 0x80;	/* enable IOM-loop */
> @@ -1709,9 +1709,9 @@ #ifdef CONFIG_PCI
>  		pci_write_config_dword(cs->hw.hfcpci.dev, 0x80, (u_int) virt_to_bus(cs->hw.hfcpci.fifos));
>  		cs->hw.hfcpci.pci_io = ioremap((ulong) cs->hw.hfcpci.pci_io, 256);
>  		printk(KERN_INFO
> -		       "HFC-PCI: defined at mem %#x fifo %#x(%#x) IRQ %d HZ %d\n",
> -		       (u_int) cs->hw.hfcpci.pci_io,
> -		       (u_int) cs->hw.hfcpci.fifos,
> +		       "HFC-PCI: defined at mem %p fifo %p(%#x) IRQ %d HZ %d\n",
> +		       cs->hw.hfcpci.pci_io,
> +		       cs->hw.hfcpci.fifos,
>  		       (u_int) virt_to_bus(cs->hw.hfcpci.fifos),
>  		       cs->irq, HZ);
>  		spin_lock_irqsave(&cs->lock, flags);
> diff --git a/drivers/isdn/hisax/sedlbauer.c b/drivers/isdn/hisax/sedlbauer.c
> index 9522141..030d162 100644
> --- a/drivers/isdn/hisax/sedlbauer.c
> +++ b/drivers/isdn/hisax/sedlbauer.c
> @@ -677,7 +677,11 @@ #else
>  		return (0);
>  #endif /* CONFIG_PCI */
>  	}	
> +
> +#ifdef __ISAPNP__
>  ready:	
> +#endif
> +
>  	/* In case of the sedlbauer pcmcia card, this region is in use,
>  	 * reserved for us by the card manager. So we do not check it
>  	 * here, it would fail.

-- 
Karsten Keil
SuSE Labs
ISDN development
