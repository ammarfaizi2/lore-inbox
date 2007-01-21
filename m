Return-Path: <linux-kernel-owner+w=401wt.eu-S1751650AbXAUVnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXAUVnn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbXAUVnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:43:43 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:41298 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751650AbXAUVnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:43:42 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 16:43:41 EST
Date: Sun, 21 Jan 2007 23:36:58 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/irda/vlsi_ir.{h,c}: remove kernel 2.4 code
Message-ID: <20070121213657.GA9464@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <20070118215613.GH9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118215613.GH9093@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Ovh-Remote: 83.205.187.176 (aannecy-152-1-40-176.w83-205.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 10:56:13PM +0100, Adrian Bunk wrote:
> This patch removes kernel 2.4 compatibility code.
Looks correct to me, thanks.


> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Samuel Ortiz <samuel@sortiz.org>

 
> ---
> 
>  drivers/net/irda/vlsi_ir.c |   16 ++++++++--------
>  drivers/net/irda/vlsi_ir.h |   33 ---------------------------------
>  2 files changed, 8 insertions(+), 41 deletions(-)
> 
> --- linux-2.6.20-rc4-mm1/drivers/net/irda/vlsi_ir.h.old	2007-01-18 21:50:43.000000000 +0100
> +++ linux-2.6.20-rc4-mm1/drivers/net/irda/vlsi_ir.h	2007-01-18 21:53:54.000000000 +0100
> @@ -41,39 +41,6 @@
>  #define PCI_CLASS_SUBCLASS_MASK		0xffff
>  #endif
>  
> -/* in recent 2.5 interrupt handlers have non-void return value */
> -#ifndef IRQ_RETVAL
> -typedef void irqreturn_t;
> -#define IRQ_NONE
> -#define IRQ_HANDLED
> -#define IRQ_RETVAL(x)
> -#endif
> -
> -/* some stuff need to check kernelversion. Not all 2.5 stuff was present
> - * in early 2.5.x - the test is merely to separate 2.4 from 2.5
> - */
> -#include <linux/version.h>
> -
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> -
> -/* PDE() introduced in 2.5.4 */
> -#ifdef CONFIG_PROC_FS
> -#define PDE(inode) ((inode)->i_private)
> -#endif
> -
> -/* irda crc16 calculation exported in 2.5.42 */
> -#define irda_calc_crc16(fcs,buf,len)	(GOOD_FCS)
> -
> -/* we use this for unified pci device name access */
> -#define PCIDEV_NAME(pdev)	((pdev)->name)
> -
> -#else /* 2.5 or later */
> -
> -/* whatever we get from the associated struct device - bus:slot:dev.fn id */
> -#define PCIDEV_NAME(pdev)	(pci_name(pdev))
> -
> -#endif
> -
>  /* ================================================================ */
>  
>  /* non-standard PCI registers */
> --- linux-2.6.20-rc4-mm1/drivers/net/irda/vlsi_ir.c.old	2007-01-18 21:53:58.000000000 +0100
> +++ linux-2.6.20-rc4-mm1/drivers/net/irda/vlsi_ir.c	2007-01-18 21:54:56.000000000 +0100
> @@ -166,7 +166,7 @@
>  	unsigned i;
>  
>  	seq_printf(seq, "\n%s (vid/did: %04x/%04x)\n",
> -		   PCIDEV_NAME(pdev), (int)pdev->vendor, (int)pdev->device);
> +		   pci_name(pdev), (int)pdev->vendor, (int)pdev->device);
>  	seq_printf(seq, "pci-power-state: %u\n", (unsigned) pdev->current_state);
>  	seq_printf(seq, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
>  		   pdev->irq, (unsigned)pci_resource_start(pdev, 0), (unsigned long long)pdev->dma_mask);
> @@ -1401,7 +1401,7 @@
>  
>  	if (vlsi_start_hw(idev))
>  		IRDA_ERROR("%s: failed to restart hw - %s(%s) unusable!\n",
> -			   __FUNCTION__, PCIDEV_NAME(idev->pdev), ndev->name);
> +			   __FUNCTION__, pci_name(idev->pdev), ndev->name);
>  	else
>  		netif_start_queue(ndev);
>  }
> @@ -1643,7 +1643,7 @@
>  		pdev->current_state = 0; /* hw must be running now */
>  
>  	IRDA_MESSAGE("%s: IrDA PCI controller %s detected\n",
> -		     drivername, PCIDEV_NAME(pdev));
> +		     drivername, pci_name(pdev));
>  
>  	if ( !pci_resource_start(pdev,0)
>  	     || !(pci_resource_flags(pdev,0) & IORESOURCE_IO) ) {
> @@ -1728,7 +1728,7 @@
>  
>  	pci_set_drvdata(pdev, NULL);
>  
> -	IRDA_MESSAGE("%s: %s removed\n", drivername, PCIDEV_NAME(pdev));
> +	IRDA_MESSAGE("%s: %s removed\n", drivername, pci_name(pdev));
>  }
>  
>  #ifdef CONFIG_PM
> @@ -1748,7 +1748,7 @@
>  
>  	if (!ndev) {
>  		IRDA_ERROR("%s - %s: no netdevice \n",
> -			   __FUNCTION__, PCIDEV_NAME(pdev));
> +			   __FUNCTION__, pci_name(pdev));
>  		return 0;
>  	}
>  	idev = ndev->priv;	
> @@ -1759,7 +1759,7 @@
>  			pdev->current_state = state.event;
>  		}
>  		else
> -			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state.event);
> +			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, pci_name(pdev), pdev->current_state, state.event);
>  		up(&idev->sem);
>  		return 0;
>  	}
> @@ -1787,7 +1787,7 @@
>  
>  	if (!ndev) {
>  		IRDA_ERROR("%s - %s: no netdevice \n",
> -			   __FUNCTION__, PCIDEV_NAME(pdev));
> +			   __FUNCTION__, pci_name(pdev));
>  		return 0;
>  	}
>  	idev = ndev->priv;	
> @@ -1795,7 +1795,7 @@
>  	if (pdev->current_state == 0) {
>  		up(&idev->sem);
>  		IRDA_WARNING("%s - %s: already resumed\n",
> -			     __FUNCTION__, PCIDEV_NAME(pdev));
> +			     __FUNCTION__, pci_name(pdev));
>  		return 0;
>  	}
>  	
> 
