Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKYRLD>; Mon, 25 Nov 2002 12:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSKYRLC>; Mon, 25 Nov 2002 12:11:02 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:8452 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261721AbSKYRLB>; Mon, 25 Nov 2002 12:11:01 -0500
Date: Mon, 25 Nov 2002 20:18:03 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Mueller <mueller@teamix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] D-Link DFE-580TX: Only 3 Ports working
Message-ID: <20021125201803.A830@jurassic.park.msu.ru>
References: <140282249663.20021125161149@teamix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <140282249663.20021125161149@teamix.net>; from mueller@teamix.net on Mon, Nov 25, 2002 at 04:11:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 04:11:49PM +0100, Richard Mueller wrote:
> eth5: D-Link DFE-580TX 4 port Server Adapter at 0xbe00, 00:00:00:00:00:00, IRQ 20.
						    ^^^^
It's clear BIOS bug. All four controllers are sitting behind PCI-to-PCI
bridge which blocks IO access to the ranges 0xb100-0xb3ff, 0xb500-0xb7ff,
0xb900-0xbbff and 0xbd00-0xbfff due to PCI_BRIDGE_CTL_NO_ISA mode.

Does this patch help?

Ivan.

--- linux/arch/i386/kernel/pci-i386.c~	Thu Nov 21 20:34:54 2002
+++ linux/arch/i386/kernel/pci-i386.c	Mon Nov 25 20:04:38 2002
@@ -223,9 +223,19 @@ static void __init pcibios_allocate_reso
 				continue;
 			if (!r->start)		/* Address not assigned at all */
 				continue;
-			if (r->flags & IORESOURCE_IO)
+			if (r->flags & IORESOURCE_IO) {
 				disabled = !(command & PCI_COMMAND_IO);
-			else
+				if ((r->start & 0x300) && r->start > 0x400) {
+					printk(KERN_ERR "PCI: bad alignment "
+					       "of IO region %d [%04lx] of "
+					       "device %s\n",
+						idx, r->start, dev->slot_name);
+					/* We'll assign a new address later */
+					r->end -= r->start;
+					r->start = 0;
+					continue;
+				}
+			} else
 				disabled = !(command & PCI_COMMAND_MEMORY);
 			if (pass == disabled) {
 				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
