Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162498AbWLBBAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162498AbWLBBAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 20:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162530AbWLBBAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 20:00:07 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:34274 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1162526AbWLBBAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 20:00:03 -0500
Date: Fri, 1 Dec 2006 16:59:55 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Be a bit defensive in quirk_nvidia_ck804() so we don't
 risk dereferencing a NULL pdev.
In-Reply-To: <200612020021.56250.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0612011656410.26933@attu4.cs.washington.edu>
References: <200612020021.56250.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Jesper Juhl wrote:

> pci_get_slot() may return NULL if nothing was found. 
> quirk_nvidia_ck804() does not check the value returned from pci_get_slot(),
> so it may end up causing a NULL pointer deref.
> 

Looks good.  The possible NULL pointer is actually not at pci_dev_put, 
but rather at pci_find_capability on the msi_ht_cap_enabled(pdev) call.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5b44838..d3dcbda 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1741,6 +1741,8 @@ static void __devinit quirk_nvidia_ck804
>  	 * a single one having MSI is enough to be sure that MSI are supported.
>  	 */
>  	pdev = pci_get_slot(dev->bus, 0);
> +	if (!pdev)
> +		return;
>  	if (dev->subordinate && !msi_ht_cap_enabled(dev)
>  	    && !msi_ht_cap_enabled(pdev)) {
>  		printk(KERN_WARNING "PCI: MSI quirk detected. "
> 

The check for dev->subordinate in the neighboring conditional can also be 
removed.

		David
