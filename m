Return-Path: <linux-kernel-owner+w=401wt.eu-S1422841AbWLUIVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWLUIVl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422852AbWLUIVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:21:41 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39864 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422841AbWLUIVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:21:40 -0500
Message-ID: <458A4411.1080500@garzik.org>
Date: Thu, 21 Dec 2006 03:21:37 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Petr Vandrovec <petr@vandrovec.name>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Unbreak MSI on ATI devices
References: <20061221075540.GA21152@vana.vc.cvut.cz>
In-Reply-To: <20061221075540.GA21152@vana.vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> After poking around I've found that problem is that at least ATI USB-HCDs
> apply INTX enable even for MSI, despite warning in the PCI specification that
> it should apply only to MSI (actually I have feeling that on these USB devices 
> disabling INTX in MSI mode drives their INTA# line active as when ohci1394 
> module got loaded kernel complained about interrupt being continuously 
> activated for no good reason (TI's 7421 is one of few MSI-incapable devices
> in my box).
> 
> So my question is - what is real reason for disabling INTX when in MSI mode?
> According to PCI spec it should not be needed, and it hurts at least chips
> listed below:

> Do not disable INTX in MSI mode.  It breaks ATI USB HCDs (both OHCI and EHCI).
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>
> 
> diff -uprdN linux/drivers/pci/msi.c linux/drivers/pci/msi.c
> --- linux/drivers/pci/msi.c	2006-12-16 13:34:52.000000000 -0800
> +++ linux/drivers/pci/msi.c	2006-12-20 23:18:10.000000000 -0800
> @@ -256,7 +256,7 @@ static void enable_msi_mode(struct pci_d
>  		dev->msix_enabled = 1;
>  	}
>  
> -	pci_intx(dev, 0);  /* disable intx */
> +	pci_intx(dev, 1);  /* enable intx, on some devices it affects MSI as well */
>  }

I'm just going to CC Linus, and run ;-)

More seriously.  Some other chips choke if you forget to disable INTx, 
before going into MSI mode.

Thus, turning off one irq source before turning on another is the most 
logical course of action.

I suppose we'll have to quirk ATI for being dumb...?

	Jeff


