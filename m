Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUEOSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUEOSxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUEOSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 14:53:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264155AbUEOSxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 14:53:16 -0400
Message-ID: <40A6670F.3050300@pobox.com>
Date: Sat, 15 May 2004 14:53:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, bunk@fs.tum.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tlan.c for !PCI
References: <200405151823.i4FINj8T001262@hera.kernel.org>
In-Reply-To: <200405151823.i4FINj8T001262@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1691, 2004/05/15 10:23:43-07:00, akpm@osdl.org
> 
> 	[PATCH] fix tlan.c for !PCI
> 	
> 	From: Adrian Bunk <bunk@fs.tum.de>
> 	
> 	drivers/net/tlan.c: In function `tlan_remove_one':
> 	drivers/net/tlan.c:449: warning: implicit declaration of function `pci_release_regions'
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1690  -> 1.1691 
> #	  drivers/net/tlan.c	1.31    -> 1.32   
> #
> 
>  tlan.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> 
> diff -Nru a/drivers/net/tlan.c b/drivers/net/tlan.c
> --- a/drivers/net/tlan.c	Sat May 15 11:23:50 2004
> +++ b/drivers/net/tlan.c	Sat May 15 11:23:50 2004
> @@ -446,7 +446,9 @@
>  		pci_free_consistent(priv->pciDev, priv->dmaSize, priv->dmaStorage, priv->dmaStorageDMA );
>  	}
>  
> +#ifdef CONFIG_PCI
>  	pci_release_regions(pdev);
> +#endif


Ug.  Please revert and fix it the right way.

Think about this one:  we are getting the warning inside a function that 
will only ever be called when CONFIG_PCI is defined, the PCI ->remove hook.

IMO one of two things needs to happen:
a) wrap the PCI probe functions in tlan.c with CONFIG_PCI
	or
b) create the proper wrapper in include/linux/pci.h, following 
established practice in that header


