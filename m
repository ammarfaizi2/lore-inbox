Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752079AbWJNFWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbWJNFWE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWJNFWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:22:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:441 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752079AbWJNFWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:22:01 -0400
Date: Fri, 13 Oct 2006 22:21:10 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Val Henson <val_henson@linux.intel.com>,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-ID: <20061014052110.GB21616@suse.de>
References: <1160161519800-git-send-email-matthew@wil.cx> <20061013214135.8fbc9f04.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013214135.8fbc9f04.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 09:41:35PM -0700, Andrew Morton wrote:
> On Fri, 06 Oct 2006 13:05:18 -0600
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > Since some devices may not implement the MWI bit, we should check that
> > the write did set it and return an error if it didn't.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index a544997..3d041f4 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -900,13 +900,17 @@ #endif
> >  		return rc;
> >  
> >  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > -	if (! (cmd & PCI_COMMAND_INVALIDATE)) {
> > -		pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
> > -		cmd |= PCI_COMMAND_INVALIDATE;
> > -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> > -	}
> > -	
> > -	return 0;
> > +	if (cmd & PCI_COMMAND_INVALIDATE)
> > +		return 0;
> > +
> > +	pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
> > +	cmd |= PCI_COMMAND_INVALIDATE;
> > +	pci_write_config_word(dev, PCI_COMMAND, cmd);
> > +
> > +	/* read result from hardware (in case bit refused to enable) */
> > +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +
> > +	return (cmd & PCI_COMMAND_INVALIDATE) ? 0 : -EINVAL;
> >  }
> >  
> >  /**
> 
> Bisection shows that this patch
> (pci-check-that-mwi-bit-really-did-get-set.patch in Greg's PCI tree) breaks
> suspend-to-disk on my Vaio.  It writes the suspend image and gets to the
> point where it's supposed to power down, but doesn't.
> 
> After a manual power-cycle it successfully resumes from disk, but
> networking (at least) is dead.

Ok, I'll drop this from my tree too.

Matthew, let me know whn you have a revised patch you wish to have me
include.

thanks,

greg k-h
