Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWFIQFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWFIQFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFIQFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:05:46 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:54970 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030262AbWFIQFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:05:44 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "H. Peter Anvin" <hpa@c2micro.com>
Subject: Re: tg3 broken on 2.6.17-rc5-mm3
Date: Fri, 9 Jun 2006 10:05:21 -0600
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, mchan@broadcom.com
References: <200606071711.06774.bjorn.helgaas@hp.com> <200606082249.14475.bjorn.helgaas@hp.com> <44890117.1000403@c2micro.com>
In-Reply-To: <44890117.1000403@c2micro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606091005.21165.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 23:03, H. Peter Anvin wrote:
> Bjorn Helgaas wrote:
> > On Wednesday 07 June 2006 17:11, Bjorn Helgaas wrote:
> >> Something changed between 2.6.17-rc5-mm2 and -mm3 that broke tg3
> >> on my HP DL360:
> > 
> > and the specific change that broke it seems to be:
> >   gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch.
> > 
> > pci_read:  0000:01:02.0 reg 0x10 len 4 val 0xf7ef0004
> > pci_write: 0000:01:02.0 reg 0x10 len 4 val 0xffffffff
> > pci_read:  0000:01:02.0 reg 0x10 len 4 val 0xffff0004
> > pci_write: 0000:01:02.0 reg 0x10 len 4 val 0xf7ef0004
> > pci_read:  0000:01:02.0 reg 0x14 len 4 val 0x0000
> > pci_write: 0000:01:02.0 reg 0x14 len 4 val 0xffffffff
> > pci_read:  0000:01:02.0 reg 0x14 len 4 val 0xffffffff
> > pci_write: 0000:01:02.0 reg 0x14 len 4 val 0x0000
> 
> ... this is a 64-bit BAR preset with a 16-bit mask, preset
> to the valid 32-bit address 0x0000_0000_f7ef_0000.
> 
> > pci_write: 0000:01:02.0 reg 0x10 len 4 val 0x0004  <=== looks questionable
> > pci_write: 0000:01:02.0 reg 0x14 len 4 val 0x0000
> 
> ... here the algorithm thinks the addrss is above 4 GB and disables it. 
>   It should re-enable it when the device is turned back on, though; if 
> it doesn't that's very strange.
> 
> Anyway, the error seems to be that the line:
> 
> +			} else if (l) {
> 
> ... should be ...
> 
> +			} else if (lhi) {
> 
> ... since l contains the lower half of the pre-set address at that 
> point, and lhi is the upper half.

The patch below indeed fixes the problem.  You can have my
"signed-off" if you want (though you supplied the fix above),
but can you please write the description?  I'm too lazy to
puzzle it all out and you understand it already anyway :-)


Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc5-mm3/drivers/pci/probe.c
===================================================================
--- rc5-mm3.orig/drivers/pci/probe.c	2006-06-09 09:40:51.000000000 -0600
+++ rc5-mm3/drivers/pci/probe.c	2006-06-09 09:42:35.000000000 -0600
@@ -199,7 +199,7 @@
 				printk(KERN_ERR "PCI: Unable to handle 64-bit BAR for device %s\n", pci_name(dev));
 				res->start = 0;
 				res->flags = 0;
-			} else if (l) {
+			} else if (lhi) {
 				/* 64-bit wide address, treat as disabled */
 				pci_write_config_dword(dev, reg, l & ~(u32)PCI_BASE_ADDRESS_MEM_MASK);
 				pci_write_config_dword(dev, reg+4, 0);
