Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWBJDkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWBJDkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWBJDkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:40:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:58311 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751034AbWBJDkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:40:12 -0500
Subject: Re: [Patch] Generic AGP PM support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200602070910.18808.ncunningham@cyclades.com>
References: <200602070910.18808.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 14:38:47 +1100
Message-Id: <1139542727.5003.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 09:10 +1000, Nigel Cunningham wrote:
> Hi.
> 
> This patch implements generic AGP power management support, and uses it for
> the Ati and NVidia drivers. It is an update on the patch that Matthew
> Garrett broke out of Suspend2 a while ago and sent to the list.

Are you aware that this will not work in a number of cases because there
is no proper ordering between suspend/resume of the AGP bridge and of
the video card ? Yes it sucks, no we don't have any infrastructure to
deal with that... we sucks for anything remotely related to gfx, news at
11.

Ben.

> Regards,
> 
> Nigel
> 
>  agp_suspend.h |   43 +++++++++++++++++++++++++++++++++++++++++++
>  ati-agp.c     |   14 ++++++++++++++
>  nvidia-agp.c  |   14 ++++++++++++++
>  3 files changed, 71 insertions(+)
> diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/agp_suspend.h 3030-agp-resume-support.patch-new/drivers/char/agp/agp_suspend.h
> --- 3030-agp-resume-support.patch-old/drivers/char/agp/agp_suspend.h	1970-01-01 10:00:00.000000000 +1000
> +++ 3030-agp-resume-support.patch-new/drivers/char/agp/agp_suspend.h	2005-12-05 21:26:57.000000000 +1100
> @@ -0,0 +1,43 @@
> +/*
> + * Generic routines for suspending and resuming an agp bridge.
> + *
> + * Include "agp.h" first.
> + */
> +
> +#ifdef CONFIG_PM
> +static int agp_common_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	pci_save_state(pdev);
> +	pci_set_power_state(pdev, 3);
> +
> +	return 0;
> +}
> +
> +static int agp_common_resume(struct pci_dev *pdev,
> +			     struct agp_bridge_driver * generic_bridge,
> +			     int reconfigure(void))
> +{
> +	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
> +
> +	/* set power state 0 and restore PCI space */
> +	pci_set_power_state(pdev, 0);
> +	pci_restore_state(pdev);
> +
> +	/* reconfigure AGP hardware again */
> +	if (bridge->driver == generic_bridge)
> +		return reconfigure();
> +
> +	return 0;
> +}
> +#else
> +static int agp_common_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int agp_common_resume(struct pci_dev *pdev, _something_ * bridge,
> +			     void *reconfigure)
> +{
> +	return 0;
> +}
> +#endif
> diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c 3030-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c
> --- 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c	2005-11-11 14:12:17.000000000 +1100
> +++ 3030-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c	2005-12-05 21:26:57.000000000 +1100
> @@ -9,6 +9,7 @@
>  #include <linux/agp_backend.h>
>  #include <asm/agp.h>
>  #include "agp.h"
> +#include "agp_suspend.h"
>  
>  #define ATI_GART_MMBASE_ADDR	0x14
>  #define ATI_RS100_APSIZE	0xac
> @@ -507,6 +508,17 @@ static void __devexit agp_ati_remove(str
>  	agp_put_bridge(bridge);
>  }
>  
> +static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return (agp_common_suspend(pdev, state));
> +}
> +
> +static int agp_ati_resume(struct pci_dev *pdev)
> +{
> +	return agp_common_resume(pdev, &ati_generic_bridge,
> +				 ati_configure);
> +}
> +
>  static struct pci_device_id agp_ati_pci_table[] = {
>  	{
>  	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
> @@ -526,6 +538,8 @@ static struct pci_driver agp_ati_pci_dri
>  	.id_table	= agp_ati_pci_table,
>  	.probe		= agp_ati_probe,
>  	.remove		= agp_ati_remove,
> +	.suspend	= agp_ati_suspend,
> +	.resume		= agp_ati_resume,
>  };
>  
>  static int __init agp_ati_init(void)
> diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c 3030-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c
> --- 3030-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c	2005-11-11 14:12:17.000000000 +1100
> +++ 3030-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c	2005-12-05 21:26:59.000000000 +1100
> @@ -12,6 +12,7 @@
>  #include <linux/page-flags.h>
>  #include <linux/mm.h>
>  #include "agp.h"
> +#include "agp_suspend.h"
>  
>  /* NVIDIA registers */
>  #define NVIDIA_0_APSIZE		0x80
> @@ -397,11 +398,24 @@ static struct pci_device_id agp_nvidia_p
>  
>  MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
>  
> +static int agp_nvidia_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return (agp_common_suspend(pdev, state));
> +}
> +
> +static int agp_nvidia_resume(struct pci_dev *pdev)
> +{
> +	return agp_common_resume(pdev, &agp_bridge,
> +				 nvidia_configure);
> +}
> +
>  static struct pci_driver agp_nvidia_pci_driver = {
>  	.name		= "agpgart-nvidia",
>  	.id_table	= agp_nvidia_pci_table,
>  	.probe		= agp_nvidia_probe,
>  	.remove		= agp_nvidia_remove,
> +	.suspend	= agp_nvidia_suspend,
> +	.resume		= agp_nvidia_resume,
>  };
>  
>  static int __init agp_nvidia_init(void)

