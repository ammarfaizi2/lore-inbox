Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWBFXkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWBFXkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWBFXkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:40:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964868AbWBFXkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:40:06 -0500
Date: Mon, 6 Feb 2006 15:42:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Generic AGP PM support.
Message-Id: <20060206154210.5f21942a.akpm@osdl.org>
In-Reply-To: <200602070910.18808.ncunningham@cyclades.com>
References: <200602070910.18808.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> Hi.
> 
> This patch implements generic AGP power management support, and uses it for
> the Ati and NVidia drivers. It is an update on the patch that Matthew
> Garrett broke out of Suspend2 a while ago and sent to the list.
> 

(Don't forget the signed-off-by:s, please)

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

What we tend to do is this:

#ifdef CONFIG_PM
static int foo_resume(...)
{
	...
}
#else
#define foo_resume(...) NULL
#endif
...

static struct pci_driver foo_driver = {
	...
	.resume = foo_resume;
	...
};

I think you could do it that way, so the stubbed agp_common_suspend() and
agp_common_resume() won't need to exist.

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

Lose the extra parens, please.

> +static int agp_ati_resume(struct pci_dev *pdev)
> +{
> +	return agp_common_resume(pdev, &ati_generic_bridge,
> +				 ati_configure);
> +}

Current ati-agp.c already has suspend and resume implementations.


