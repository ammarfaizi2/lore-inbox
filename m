Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSBGCLj>; Wed, 6 Feb 2002 21:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291072AbSBGCL3>; Wed, 6 Feb 2002 21:11:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291074AbSBGCLR>;
	Wed, 6 Feb 2002 21:11:17 -0500
Date: Wed, 06 Feb 2002 18:09:15 -0800 (PST)
Message-Id: <20020206.180915.78161963.davem@redhat.com>
To: hch@caldera.de
Cc: davidm@hpl.hp.com, mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020206181042.A11683@caldera.de>
In-Reply-To: <20020206093558.A9445@caldera.de>
	<20020206.004503.118628125.davem@redhat.com>
	<20020206181042.A11683@caldera.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@caldera.de>
   Date: Wed, 6 Feb 2002 18:10:42 +0100
   
   When the sym2 driver is configured with SYM_CONF_DMA_ADDRESSING_MOD > 1
   it uses DAC accessing and needs dma64_addr_t.  It doesn't use it
   when using the default addressing mode.
   
NO it damn well does not!  If the platform is NEVER GOING TO GIVE the
driver a 64-bit address (because, for example, it has IOMMU hardware),
dma_addr_t need only be 32-bits and that it how it is declared on
several platforms.

Please read the DMA API documentation.

dma64_addr_t is _ONLY_, I REPEAT _ONLY_ to be used when the driver
is making use of the following routines for it's DMA usage:

	pci_dac_page_to_dma
	pci_dac_dma_to_page
	pci_dac_dma_to_offset
	pci_dac_dma_sync_single

And NO SCSI OR NET driver should ever use these routines.

In fact, no driver in the tree right now should be using this.
The only known example that needs those interfaces are clustering
cards.  And thats it!

Everything in the tree right now should use only pci_map_single and
friends, and it should set the device DMA mask bits properly to
indicate DAC capability.  Do you see any pci_map_single, pci_map_sg,
etc. implementation working with dma64_addr_t arguments?  If so, thats
a huge bug and it must be fixed.
