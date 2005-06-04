Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFDPP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFDPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVFDPP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:15:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:36278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261377AbVFDPPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:15:18 -0400
Date: Sat, 4 Jun 2005 08:17:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
In-Reply-To: <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0506040814050.1876@ppc970.osdl.org>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
 <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
 <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
 <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
 <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Andreas Koch wrote:
> 
> Actually, I tried that already.  But I didn't get any usable info from
> the oops and GDB (`list *pci_setup_bridge+0x1a2' shows an include file,
> not a line in the function) .  I'll make another attempt tomorrow when
> I am more awake :-)

The oops is because we normally don't even assign but->resource[2] for the 
root bridge. The following seems to fix the oops, but it makes a normal PC 
totally unbootable, so that doesn't help you. I didn't have a serial 
console hooked up, so I didn't get the logs. Somebody who has, and enables 
CONFIG_PCI_DEBUG, can you send me the output?

		Linus

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -164,6 +164,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -908,6 +908,7 @@ struct pci_bus * __devinit pci_scan_bus_
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
+	b->resource[2] = &iomem_resource;
 
 	b->subordinate = pci_scan_child_bus(b);
 
