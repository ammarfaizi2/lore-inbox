Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDNScU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDNScU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDNScU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:32:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18122 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261379AbVDNScM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:32:12 -0400
Date: Thu, 14 Apr 2005 09:39:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ashok Raj <ashok.raj@intel.com>, germano.barreiro@cyclades.com
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, pc300@cyclades.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PC300 pci_enable_device fix
Message-ID: <20050414123859.GG11131@logos.cnet>
References: <1113427903.21308.3.camel@eeyore> <20050413150243.A26360@unix-os.sc.intel.com> <20050413194531.GE11131@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413194531.GE11131@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Germano, can you give this patch a try before merging, please.

On Wed, Apr 13, 2005 at 04:45:31PM -0300, Marcelo Tosatti wrote:
> On Wed, Apr 13, 2005 at 03:02:43PM -0700, Ashok Raj wrote:
> > On Wed, Apr 13, 2005 at 02:31:43PM -0700, Bjorn Helgaas wrote:
> > > 
> > >    Call pci_enable_device() before looking at IRQ and resources.
> > >    The driver requires this fix or the "pci=routeirq" workaround
> > >    on 2.6.10 and later kernels.
> > 
> > 
> > the failure cases dont seem to worry about pci_disable_device()?
> > 
> > in err_release_ram: etc?
> 
> Yep the failure paths were wrong before, but Bjorn's patch moves 
> pci_enable_device() way up to the beginning of the function. 
> 
> The failure path's err_release_ram etc. wont touch the resources
> without pci_enable_pci(), with the fix.

Hi, 

I see what you mean now, Ashok. Yes, you are right, the error path lacks
pci_disable_device().

Reported by Artur Lipowski.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

--- a/drivers/net/wan/pc300_drv.c.orig	2005-04-14 13:56:04.000000000 -0300
+++ b/drivers/net/wan/pc300_drv.c	2005-04-14 13:58:56.000000000 -0300
@@ -3439,11 +3439,15 @@
 #endif
 	}
 
+	if ((err = pci_enable_device(pdev)) != 0)
+		return err;
+
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
 		printk("PC300 found at RAM 0x%08lx, "
 		       "but could not allocate card structure.\n",
 		       pci_resource_start(pdev, 3));
+		pci_disable_device(pdev);
 		return -ENOMEM;
 	}
 	memset(card, 0, sizeof(pc300_t));
@@ -3527,8 +3531,6 @@
 		goto err_release_ram;
 	}
 
-	if ((err = pci_enable_device(pdev)) != 0)
-		goto err_release_sca;
 
 	card->hw.plxbase = ioremap(card->hw.plxphys, card->hw.plxsize);
 	card->hw.rambase = ioremap(card->hw.ramphys, card->hw.alloc_ramsize);
@@ -3628,6 +3630,7 @@
 err_release_io:
 	release_region(card->hw.iophys, card->hw.iosize);
 	kfree(card);
+	pci_disable_device(pdev);
 	return -ENODEV;
 }
 
