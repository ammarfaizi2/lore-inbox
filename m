Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVDNAni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVDNAni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDNAni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:43:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28344 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261410AbVDNAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:43:29 -0400
Date: Wed, 13 Apr 2005 16:45:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, pc300@cyclades.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PC300 pci_enable_device fix
Message-ID: <20050413194531.GE11131@logos.cnet>
References: <1113427903.21308.3.camel@eeyore> <20050413150243.A26360@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413150243.A26360@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 03:02:43PM -0700, Ashok Raj wrote:
> On Wed, Apr 13, 2005 at 02:31:43PM -0700, Bjorn Helgaas wrote:
> > 
> >    Call pci_enable_device() before looking at IRQ and resources.
> >    The driver requires this fix or the "pci=routeirq" workaround
> >    on 2.6.10 and later kernels.
> 
> 
> the failure cases dont seem to worry about pci_disable_device()?
> 
> in err_release_ram: etc?

Yep the failure paths were wrong before, but Bjorn's patch moves 
pci_enable_device() way up to the beginning of the function. 

The failure path's err_release_ram etc. wont touch the resources
without pci_enable_pci(), with the fix.

> >    Reported and tested by Artur Lipowski.
> > 
> >    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> >    ===== drivers/net/wan/pc300_drv.c 1.24 vs edited =====
> >    --- 1.24/drivers/net/wan/pc300_drv.c    2004-12-29 12:25:16 -07:00
> >    +++ edited/drivers/net/wan/pc300_drv.c  2005-04-13 13:35:21 -06:00
> >    @@ -3439,6 +3439,9 @@
> >     #endif
> >            }
> > 
> >    +       if ((err = pci_enable_device(pdev)) != 0)
> >    +               return err;
> >    +
> >            card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
> >            if (card == NULL) {
> >                    printk("PC300 found at RAM 0x%08lx, "
> >    @@ -3526,9 +3529,6 @@
> >                    err = -ENODEV;
> >                    goto err_release_ram;
> >            }
> >    -
> >    -       if ((err = pci_enable_device(pdev)) != 0)
> >    -               goto err_release_sca;
> > 
> >                  card->hw.plxbase       =       ioremap(card->hw.plxphys,
> >    card->hw.plxsize);
> >                  card->hw.rambase       =       ioremap(card->hw.ramphys,
> >    card->hw.alloc_ramsize);
