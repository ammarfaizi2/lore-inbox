Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbTLaS77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbTLaS77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:59:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13543 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265236AbTLaS7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:59:55 -0500
Date: Wed, 31 Dec 2003 18:59:53 +0000
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_set_dac helper
Message-ID: <20031231185953.GJ6791@parcelfarce.linux.theplanet.co.uk>
References: <3FF2F57A.80801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2F57A.80801@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 11:12:42AM -0500, Jeff Garzik wrote:
> It seems to me like a lot of drivers wind up getting their 
> pci_set_dma_mask stuff wrong, occasionally in subtle ways.  So, I 
> created a "give me 64-bit PCI DMA" helper function.

I like it, but I think it could be better.  A lot of drivers want
64-bit streaming DMA but 32-bit consistent DMA.  So how about this:

> @@ -7530,21 +7531,16 @@
>  	}
>  
>  	/* Configure DMA attributes. */
> -	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
> -		pci_using_dac = 1;
> -		if (pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL)) {
> -			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
> -			       "for consistent allocations\n");
> -			goto err_out_free_res;
> -		}
> -	} else {
> -		err = pci_set_dma_mask(pdev, 0xffffffffULL);
> -		if (err) {
> -			printk(KERN_ERR PFX "No usable DMA configuration, "
> -			       "aborting.\n");
> -			goto err_out_free_res;
> -		}
> -		pci_using_dac = 0;
> +	dac_flags = 0;
> +	err = pci_set_dac(pdev, &dac_flags);
> +	if (err)

-	dac_flags = 0;
-	err = pci_set_dac(pdev, &dac_flags);
-	if (err)
+	dac_flags = PCI_DAC_EN | PCI_DAC_CONS_EN;
+	err = pci_set_dac(pdev, dac_flags);
+	if (err < 0)

> +		goto err_out_free_res;

+	dac_flags = err;

> +
> +	if ((dac_flags & (PCI_DAC_EN | PCI_DAC_CONS_EN)) == PCI_DAC_EN) {
> +		printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
> +		       "for consistent allocations\n");
> +		err = -EIO;
> +		goto err_out_free_res;
>  	}
>  
>  	tg3reg_base = pci_resource_start(pdev, 0);

/**
 * pci_set_dac - Sets the Dual-Address-Cycle capabilities for this device
 * @dev: The device
 * @flags: Indicates the desired capabilities
 *
 * Returns a negative errno on error, otherwise returns the flags that were
 * successfully set.
 */
int pci_set_dac(struct pci_dev *dev, int flags)
{
	int err;

	if (flags == 0)
		goto 32bit;

	if (flags & PCI_DAC_EN) {
		if (pci_set_dma_mask(dev, 0xffffffffffffffffULL)) {
			flags = 0;
			goto 32bit;
		}
	}

	if (flags & PCI_DAC_CONS_EN) {
		if (pci_set_consistent_dma_mask(dev, 0xffffffffffffffffULL)) {
			printk(KERN_WARNING
			       "PCI(%s): Unable to obtain 64 bit DMA "
			       "for consistent allocations\n", pci_name(dev));
			flags &= ~PCI_DAC_CONS_EN;
		}
	}

	return flags;

 32bit:
	err = pci_set_dma_mask(dev, 0xffffffffULL);
	if (err)
		printk(KERN_ERR "PCI(%s): No usable DMA configuration",
		       pci_name(dev));
	return err;
}

I note ithat both this and your patch will lead to two errors being
printed on 64-bit consistent failure; one by tg3 and one by the PCI
layer; this seems suboptimal.  I suspect you want to do away with the
error printk in the tg3 driver.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
