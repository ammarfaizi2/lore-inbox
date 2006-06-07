Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWFGFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWFGFLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWFGFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:11:13 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:64436 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750852AbWFGFLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:11:12 -0400
Message-ID: <44865FD8.4060801@foo-projects.org>
Date: Tue, 06 Jun 2006 22:10:48 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Subject: Re: [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644A2.7000208@jp.fujitsu.com>
In-Reply-To: <448644A2.7000208@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige wrote:
> This patch makes Intel e1000 driver legacy I/O port free.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

(adding netdev and the other e1000 maintainers to cc:)

without sending this to any of the listed e1000 maintainers???? *and* not even 
including netdev???


I'm going to take a look at it first, and have some other colleagues look at 
this and the impact, which is unclear to me at the moment. Please don't commit 
  this like this.

Auke


> 
> ---
>  drivers/net/e1000/e1000.h      |    6 +
>  drivers/net/e1000/e1000_main.c |  130 ++++++++++++++++++++++-------------------
>  2 files changed, 75 insertions(+), 61 deletions(-)
> 
> Index: linux-2.6.17-rc6/drivers/net/e1000/e1000.h
> ===================================================================
> --- linux-2.6.17-rc6.orig/drivers/net/e1000/e1000.h	2006-06-06 21:39:11.000000000 +0900
> +++ linux-2.6.17-rc6/drivers/net/e1000/e1000.h	2006-06-06 21:56:41.000000000 +0900
> @@ -77,8 +77,9 @@
>  #define BAR_1		1
>  #define BAR_5		5
>  
> -#define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
> -	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
> +#define E1000_NO_IOPORT	(1 << 0)
> +#define INTEL_E1000_ETHERNET_DEVICE(device_id, flags) {\
> +	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id), .driver_data = flags}
>  
>  struct e1000_adapter;
>  
> @@ -338,6 +339,7 @@
>  #ifdef NETIF_F_TSO
>  	boolean_t tso_force;
>  #endif
> +	int bars;	/* BARs to be enabled */
>  };
>  
>  
> Index: linux-2.6.17-rc6/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.17-rc6.orig/drivers/net/e1000/e1000_main.c	2006-06-06 21:39:11.000000000 +0900
> +++ linux-2.6.17-rc6/drivers/net/e1000/e1000_main.c	2006-06-06 21:56:41.000000000 +0900
> @@ -86,54 +86,54 @@
>   *   {PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
>   */
>  static struct pci_device_id e1000_pci_tbl[] = {
> -	INTEL_E1000_ETHERNET_DEVICE(0x1000),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1001),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1004),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1008),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1009),
> -	INTEL_E1000_ETHERNET_DEVICE(0x100C),
> -	INTEL_E1000_ETHERNET_DEVICE(0x100D),
> -	INTEL_E1000_ETHERNET_DEVICE(0x100E),
> -	INTEL_E1000_ETHERNET_DEVICE(0x100F),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1010),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1011),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1012),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1013),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1014),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1015),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1016),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1017),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1018),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1019),
> -	INTEL_E1000_ETHERNET_DEVICE(0x101A),
> -	INTEL_E1000_ETHERNET_DEVICE(0x101D),
> -	INTEL_E1000_ETHERNET_DEVICE(0x101E),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1026),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1027),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1028),
> -	INTEL_E1000_ETHERNET_DEVICE(0x105E),
> -	INTEL_E1000_ETHERNET_DEVICE(0x105F),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1060),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1075),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1076),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1077),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1078),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1079),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107A),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107B),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107C),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107D),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107E),
> -	INTEL_E1000_ETHERNET_DEVICE(0x107F),
> -	INTEL_E1000_ETHERNET_DEVICE(0x108A),
> -	INTEL_E1000_ETHERNET_DEVICE(0x108B),
> -	INTEL_E1000_ETHERNET_DEVICE(0x108C),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1096),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1098),
> -	INTEL_E1000_ETHERNET_DEVICE(0x1099),
> -	INTEL_E1000_ETHERNET_DEVICE(0x109A),
> -	INTEL_E1000_ETHERNET_DEVICE(0x10B5),
> -	INTEL_E1000_ETHERNET_DEVICE(0x10B9),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1000, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1001, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1004, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1008, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1009, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x100C, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x100D, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x100E, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x100F, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1010, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1011, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1012, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1013, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1014, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1015, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1016, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1017, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1018, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1019, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x101A, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x101D, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x101E, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1026, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1027, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1028, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x105E, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x105F, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1060, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1075, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1076, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1077, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1078, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1079, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107A, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107B, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107C, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107D, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107E, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x107F, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x108A, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x108B, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x108C, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1096, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1098, 0),
> +	INTEL_E1000_ETHERNET_DEVICE(0x1099, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x109A, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x10B5, E1000_NO_IOPORT),
> +	INTEL_E1000_ETHERNET_DEVICE(0x10B9, 0),
>  	/* required last entry */
>  	{0,}
>  };
> @@ -621,7 +621,14 @@
>  	int i, err, pci_using_dac;
>  	uint16_t eeprom_data;
>  	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
> -	if ((err = pci_enable_device(pdev)))
> +	int bars;
> +
> +	if (ent->driver_data & E1000_NO_IOPORT)
> +		bars = pci_select_bars(pdev, IORESOURCE_MEM);
> +	else
> +		bars = pci_select_bars(pdev, IORESOURCE_MEM | IORESOURCE_IO);
> +
> +	if ((err = pci_enable_device_bars(pdev, bars)))
>  		return err;
>  
>  	if (!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
> @@ -634,7 +641,8 @@
>  		pci_using_dac = 0;
>  	}
>  
> -	if ((err = pci_request_regions(pdev, e1000_driver_name)))
> +	err = pci_request_selected_regions(pdev, bars, e1000_driver_name);
> +	if (err)
>  		return err;
>  
>  	pci_set_master(pdev);
> @@ -654,6 +662,7 @@
>  	adapter->pdev = pdev;
>  	adapter->hw.back = adapter;
>  	adapter->msg_enable = (1 << debug) - 1;
> +	adapter->bars = bars;
>  
>  	mmio_start = pci_resource_start(pdev, BAR_0);
>  	mmio_len = pci_resource_len(pdev, BAR_0);
> @@ -664,12 +673,15 @@
>  		goto err_ioremap;
>  	}
>  
> -	for (i = BAR_1; i <= BAR_5; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
> -			adapter->hw.io_base = pci_resource_start(pdev, i);
> -			break;
> +	if (!(ent->driver_data & E1000_NO_IOPORT)) {
> +		for (i = BAR_1; i <= BAR_5; i++) {
> +			if (pci_resource_len(pdev, i) == 0)
> +				continue;
> +			if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
> +				adapter->hw.io_base =
> +					pci_resource_start(pdev, i);
> +				break;
> +			}
>  		}
>  	}
>  
> @@ -880,7 +892,7 @@
>  err_ioremap:
>  	free_netdev(netdev);
>  err_alloc_etherdev:
> -	pci_release_regions(pdev);
> +	pci_release_selected_regions(pdev, bars);
>  	return err;
>  }
>  
> @@ -935,7 +947,7 @@
>  #endif
>  
>  	iounmap(adapter->hw.hw_addr);
> -	pci_release_regions(pdev);
> +	pci_release_selected_regions(pdev, adapter->bars);
>  
>  	free_netdev(netdev);
>  
> @@ -4577,7 +4589,7 @@
>  	if (retval)
>  		DPRINTK(PROBE, ERR, "Error in setting power state\n");
>  	e1000_pci_restore_state(adapter);
> -	ret_val = pci_enable_device(pdev);
> +	ret_val = pci_enable_device_bars(pdev, adapter->bars);
>  	pci_set_master(pdev);
>  
>  	retval = pci_enable_wake(pdev, PCI_D3hot, 0);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

