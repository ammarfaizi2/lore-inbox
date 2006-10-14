Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752066AbWJNElt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbWJNElt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 00:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWJNEls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 00:41:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752062AbWJNElr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 00:41:47 -0400
Date: Fri, 13 Oct 2006 21:41:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061013214135.8fbc9f04.akpm@osdl.org>
In-Reply-To: <1160161519800-git-send-email-matthew@wil.cx>
References: <1160161519800-git-send-email-matthew@wil.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 13:05:18 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> Since some devices may not implement the MWI bit, we should check that
> the write did set it and return an error if it didn't.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a544997..3d041f4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -900,13 +900,17 @@ #endif
>  		return rc;
>  
>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	if (! (cmd & PCI_COMMAND_INVALIDATE)) {
> -		pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
> -		cmd |= PCI_COMMAND_INVALIDATE;
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	
> -	return 0;
> +	if (cmd & PCI_COMMAND_INVALIDATE)
> +		return 0;
> +
> +	pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
> +	cmd |= PCI_COMMAND_INVALIDATE;
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
> +
> +	/* read result from hardware (in case bit refused to enable) */
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +
> +	return (cmd & PCI_COMMAND_INVALIDATE) ? 0 : -EINVAL;
>  }
>  
>  /**

Bisection shows that this patch
(pci-check-that-mwi-bit-really-did-get-set.patch in Greg's PCI tree) breaks
suspend-to-disk on my Vaio.  It writes the suspend image and gets to the
point where it's supposed to power down, but doesn't.

After a manual power-cycle it successfully resumes from disk, but
networking (at least) is dead.

