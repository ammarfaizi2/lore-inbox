Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272080AbRHVSqj>; Wed, 22 Aug 2001 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272079AbRHVSq3>; Wed, 22 Aug 2001 14:46:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41900 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272078AbRHVSqP>;
	Wed, 22 Aug 2001 14:46:15 -0400
Date: Wed, 22 Aug 2001 11:46:20 -0700 (PDT)
Message-Id: <20010822.114620.77339267.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108221832.f7MIWHY13542@aslan.scsiguy.com>
In-Reply-To: <20010822.080540.35030343.davem@redhat.com>
	<200108221832.f7MIWHY13542@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 12:32:17 -0600

   I would like the change much better if the size of dma_addr_t
   simply changed to be 64bits wide if high mem support is enabled
   in your kernel config.

Drivers for SAC only PCI devices shall not be bloated by 64-bit type,
not in any case whatsoever.

   Sure, you need the other API changes to more finely set dma characteristics,
   but having two APIs just complicates life for the device driver.

Either your device is 64-bit capable or not, what is so complicated?
Each driver I converted was like 15 minutes or work, at best!
   
   From the device driver's point of view, this wasn't the case.
   The driver asks to have the data mapped into an address that
   its dma engine can understand and the system is supposed to do that
   mapping.

What is the virtual address of physical address 0x100000000
on a 32-bit cpu system if the page is not currently kmap()'d?

Answer: it doesn't exist.

The only portable way is to use pages.  That is what Jens's and
my work aims to do.  The ia64 API is nonportable and works only
on 64-bit systems.

   >It also assumed that using SAC or DAC addressing was simply a matter of
   >"does the device support it", and the world is far from being that simple :-)
   
   Can you enumerate the devices that actually issue a DAC when loaded with
   a 64bit address with 0's in the most significant 32bits?

Sym53c8xx does this.  You have to configure it to do SAC or DAC
for data, descriptors use SAC always.
   
There will certainly be devices in the future which will only
support DAC cycles.

   Now that I'm supposed to use two differnt apis depending on what
   capabilities I enable in my driver, 

I think you are far overcomplicating things.  I mean, look at how
simple the conversion of some of the networking drivers was.  The
sym53c8xx driver conversion was very simple too, even with it's odd
current behavior due to addressing limitations.

It was nothing more than:

1) Adding probe time code to configure DMA attributes correctly.
   Failing the probe is no suitable mode could be determined.

   You know, it allows you to do something like this:

	pci_set_dma_mask(pdev, 0x1fffffffff);
	if (pci_dac_cycles_ok(pdev)) {
		dac_addressing_method = 1;
		goto dma_configured;
	}
	pci_set_dma_mask(pdev, 0x7ffffffffff);
	if (pci_dac_cycles_ok(pdev)) {
		dac_addressing_method = 2;
		goto dma_configured;
	}
	pci_set_dma_mask(pdev, 0xffffffffffffffff);
	if (pci_dac_cycles_ok(pdev)) {
		dac_addressing_method = 3;
		goto dma_configured;
	}
	if (!pci_dma_supported(pdev, 0xffffffff)) {
		probe_fail_msg();
		return -ENODEV;
	}
	dac_addressing_method = 0; /* Use SAC */

2) sed 's/dma_addr_t/dma64_addr_t/'
   sed 's/pci_{map,unmap,dma_sync}*/pci64_{map,unmap,dma_sync}*/'

And doing a cursory glance over the DMA address references
to make sure they weren't being put into u32's or something
similar.

Justin, have you even _TRIED_ to use the new API?

I did, on like 6 drivers, and it works just fine.

Later,
David S. Miller
davem@redhat.com
