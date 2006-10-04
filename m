Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWJDDfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWJDDfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbWJDDfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:35:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44261 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751026AbWJDDdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:33:36 -0400
Date: Tue, 3 Oct 2006 20:26:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Matthias Hentges <oe@hentges.net>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-ID: <20061003202643.0e0ceab2@localhost.localdomain>
In-Reply-To: <1159930628.16765.9.camel@mhcln03>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
	<20060928161956.5262e5d3@freekitty>
	<1159930628.16765.9.camel@mhcln03>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 04:57:08 +0200
Matthias Hentges <oe@hentges.net> wrote:

> Hello Stephen,
> 
> Am Donnerstag, den 28.09.2006, 16:19 -0700 schrieb Stephen Hemminger:
> 
> > Here is the debug patch I sent to the first reporter of the problem.
> > I know what the offset is supposed to be, so if the PCI subsystem is
> > wrong, this will show. 
> > 
> > --- sky2.orig/drivers/net/sky2.c	2006-09-28 08:45:27.000000000 -0700
> > +++ sky2/drivers/net/sky2.c	2006-09-28 08:51:24.000000000 -0700
> > @@ -2463,6 +2463,7 @@
> >  
> >  	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
> >  
> > +#define PEX_UNC_ERR_STAT 0x104		/* PCI extended error capablity */
> >  	/* clear any PEX errors */
> >  	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) {
> >  		hw->err_cap = pci_find_ext_capability(hw->pdev, PCI_EXT_CAP_ID_ERR);
> > @@ -2470,6 +2471,15 @@
> >  			sky2_pci_write32(hw,
> >  					 hw->err_cap + PCI_ERR_UNCOR_STATUS,
> >  					 0xffffffffUL);
> > +		else
> > +			printk(KERN_ERR PFX "pci express found but not extended error support?\n");
> > +		
> > +		if (hw->err_cap + PCI_ERR_UNCOR_STATUS != PEX_UNC_ERR_STAT) {
> > +			
> > +			printk(KERN_ERR PFX "pci express error status register fixed from %#x to %#x\n",
> > +			       hw->err_cap, PEX_UNC_ERR_STAT - PCI_ERR_UNCOR_STATUS);
> > +			hw->err_cap = PEX_UNC_ERR_STAT - PCI_ERR_UNCOR_STATUS;
> > +		}
> >  	}
> >  
> >  	hw->pmd_type = sky2_read8(hw, B2_PMD_TYP);
> 
> while the above patch indeed removes the error messages from my previous
> mail, I have since seen random but reproduceable  freezes of the box in
> question. I believe they are sky2 related since the freeze can be
> triggered by continuous network traffic (like playing a movie over NFS
> etc.).

When it fixes what does the log say. I'm probably going to back out
the PCI express extended error using the pci_XXX functions.

> The freezes only happen with 2.6.18-mm2 and 2.6.18-mm3. 2.6.18-mm1 works
> perfectly fine.
> I've hooked up the box to my laptop via a serial cable and captured all
> kernel messages from booting up the machine to the freeze. You'll note
> that the last messages are from the sky2 driver ;)
> 

Does it still happen with linus git tree. If so, a git bisect might
help. It might not be sky2 related at all, there has been lots of changes.

> Once frozen the network is dead, the screen won't wake up from suspend
> and CAPSLOCK can not be toggled. SYSRQ (sp?) still works tho.
> 
> Any help in debugging this problem would be appreciated =)

The TX timeout is a symptom of a common bug still not fixed where
the transmitter stops. I'm working on reproducing it on my hardware and switches,
because without a reproducible test, its just shooting in the dark and
that isn't working.

