Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWI1XUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWI1XUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWI1XUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:20:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964961AbWI1XUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:20:22 -0400
Date: Thu, 28 Sep 2006 16:19:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: oe@hentges.net, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-ID: <20060928161956.5262e5d3@freekitty>
In-Reply-To: <451C5599.80402@garzik.org>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 19:07:05 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > Another customer..
> > 
> > Begin forwarded message:
> > 
> > Date: Fri, 29 Sep 2006 00:44:01 +0200
> > From: Matthias Hentges <oe@hentges.net>
> > To: Andrew Morton <akpm@osdl.org>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: 2.6.18-mm2
> > 
> > 
> > Hello all,
> > 
> > I've just tested -mm2 on my C2D system and I'm getting a lot of these
> > messages:
> > 
> > "[  139.143807] printk: 131 messages suppressed.
> > [  139.148235] sky2 0000:03:00.0: pci express error (0x500547)"
> > 
> > Please note that the "sky2" driver has always been the black sheep on
> > that system due to regular full lock-ups of the driver, requiring a
> > rmmod sky2 + modprobe sky2 cycle.
> > 
> > This happens often enough to warrant writing a cronjob checking the
> > network and auto-rmmod'ing the module.....
> > 
> > While the above is bloody annoying at times (heh), the driver never
> > caused any messages like the ones I now get with -mm2 .
> 
> sky2 just turned on PCI Express error reporting, so it makes sense that 
> messages would appear.  The better question is whether this is a driver 
> problem, or a hardware problem.  With your "black sheep" comment, I 
> wonder if it isn't a hardware problem that's been hidden.

Here is the debug patch I sent to the first reporter of the problem.
I know what the offset is supposed to be, so if the PCI subsystem is
wrong, this will show. 

--- sky2.orig/drivers/net/sky2.c	2006-09-28 08:45:27.000000000 -0700
+++ sky2/drivers/net/sky2.c	2006-09-28 08:51:24.000000000 -0700
@@ -2463,6 +2463,7 @@
 
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
+#define PEX_UNC_ERR_STAT 0x104		/* PCI extended error capablity */
 	/* clear any PEX errors */
 	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) {
 		hw->err_cap = pci_find_ext_capability(hw->pdev, PCI_EXT_CAP_ID_ERR);
@@ -2470,6 +2471,15 @@
 			sky2_pci_write32(hw,
 					 hw->err_cap + PCI_ERR_UNCOR_STATUS,
 					 0xffffffffUL);
+		else
+			printk(KERN_ERR PFX "pci express found but not extended error support?\n");
+		
+		if (hw->err_cap + PCI_ERR_UNCOR_STATUS != PEX_UNC_ERR_STAT) {
+			
+			printk(KERN_ERR PFX "pci express error status register fixed from %#x to %#x\n",
+			       hw->err_cap, PEX_UNC_ERR_STAT - PCI_ERR_UNCOR_STATUS);
+			hw->err_cap = PEX_UNC_ERR_STAT - PCI_ERR_UNCOR_STATUS;
+		}
 	}
 
 	hw->pmd_type = sky2_read8(hw, B2_PMD_TYP);
