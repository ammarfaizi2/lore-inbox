Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbVIKBlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbVIKBlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbVIKBlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:41:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932736AbVIKBlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:41:05 -0400
Date: Sat, 10 Sep 2005 18:41:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miguel <frankpoole@terra.es>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <20050911030814.08cbe74c.frankpoole@terra.es>
Message-ID: <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org> <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
 <20050911030814.08cbe74c.frankpoole@terra.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Miguel wrote:
> 
> > > Also, what disk controller is this happening on?
> 
> I'm not sure because I have a software RAID0 of 3x20GB, two hard disks
> are in the VIA controller and the other is in the onboard HPT370
> controller. Doing a diff between the lspci outputs there are some bytes
> different in the data of the HPT370 controller, maybe there is the
> problem.

It looks like your HPT controller.

	 00:0b.0 Mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372/372N (rev 04)
	 ...
	-30: 01 00 00 40 60 00 00 00 00 00 00 00 0b 01 08 08
	+30: 01 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08

That's a _really_ bad value. It's "enabled" (low bit set) but at address 
zero in the bad case. 

Can you double-check this same thing with the git snapshot (or 2.6.13.1) 
that should have the pci_map_rom() thing fixed?

My problem is that I don't see what writes that invalid enable bit. The 
patch that broke things for you explicitly avoids writing any value at 
_all_, much less one with the rom enabled bit set (in fact, if the enabled 
bit had been set, the patch wouldn't have made any difference at all for 
you).

The HPT driver does some strange things:

        /* FIXME: Not portable */
        if (dev->resource[PCI_ROM_RESOURCE].start)
                pci_write_config_byte(dev, PCI_ROM_ADDRESS,
                        dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);

but that one too _explicitly_ only does so for non-zero resource start
values. But something clearly wrote 00000001 to your ROM address..

Can you try this _truly_ cheezy patch that should generate a stack trace 
for the offending place? Btw, only do this with the 2.6.13.1 or git 
kernels that have the fixed pci_map_rom(), otherwise you'll probably get 
bogus traps for that case..

		Linus

----
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -377,6 +377,7 @@ static inline int pci_write_config_word(
 }
 static inline int pci_write_config_dword(struct pci_dev *dev, int where, u32 val)
 {
+	WARN_ON(where == PCI_ROM_ADDRESS && val == 1);
 	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
 }
 
