Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWDQA1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWDQA1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 20:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDQA1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 20:27:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:6848 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750866AbWDQA1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 20:27:20 -0400
Subject: Re: Improve PCI config space writeback.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060416224215.GA732@redhat.com>
References: <20060416224215.GA732@redhat.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 10:27:07 +1000
Message-Id: <1145233627.9833.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-16 at 17:42 -0500, Dave Jones wrote:
> At least one laptop blew up on resume from suspend with a black screen
> due to a lack of this patch.  By only writing back config space that
> is different, we minimise the possibility of accidents like this.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

I think it's a mistake to restore the command register before the rest.
It should be restored last.

> 
> --- linux-2.6.16.noarch/drivers/pci/pci.c~	2006-04-16 17:36:34.000000000 -0500
> +++ linux-2.6.16.noarch/drivers/pci/pci.c	2006-04-16 17:37:42.000000000 -0500
> @@ -461,9 +461,17 @@ int 
>  pci_restore_state(struct pci_dev *dev)
>  {
>  	int i;
> +	int val;
>  
> -	for (i = 0; i < 16; i++)
> -		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
> +	for (i = 0; i < 16; i++) {
> +		pci_read_config_dword(dev, i * 4, &val);
> +		if (val != dev->saved_config_space[i]) {
> +			printk (KERN_DEBUG "PM: Writing back config space on device %s at offset %x. (Was %x, writing %x)\n",
> +				pci_name(dev), i,
> +				val, (int) dev->saved_config_space[i]);
> +			pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
> +		}
> +	}
>  	pci_restore_msi_state(dev);
>  	pci_restore_msix_state(dev);
>  	return 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

