Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSCEPR4>; Tue, 5 Mar 2002 10:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293335AbSCEPRq>; Tue, 5 Mar 2002 10:17:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23426 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293341AbSCEPRc>;
	Tue, 5 Mar 2002 10:17:32 -0500
Date: Tue, 05 Mar 2002 07:15:14 -0800 (PST)
Message-Id: <20020305.071514.127196960.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203051443.GAA05242@adam.yggdrasil.com>
In-Reply-To: <200203051443.GAA05242@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Tue, 5 Mar 2002 06:43:35 -0800
   
   	Just to be clear, I assume that you mean that you cannot
   simply cast these virtual addresses to dma_addr_t and that the
   underlying physical memory is not guaranteed to be below 4GB,
   but that you can use that memory with pci_map_single if your
   PCI device can handle 64 bit addresses.
   
   	If I got it right, then here is some proposed replacement
   text, to possibly save you a little effort:

You haven't got it right.  Physical address > 4GB does not mean
your 32-bit device cannot DMA to it.  Stop thinking about
implementation, that's the whole point of the abstraction :-)

On 64-bit platforms that don't set CONFIG_HIGHMEM, they have MMU's on
the PCI bus that can map arbitrary 64-bit physical addresses to 32-bit
PCI bus addresses.  So on these platforms you may pass any pointer
from kmalloc()/alloc_page() whatsoever into the pci_map_foo()
routines.

In order to handle highmem pages, you have to set your DMA mask
appropriately (to indicate 64-bit addressing capability) and
use pci_map_page() instead of pci_map_single().

Look at other drivers using the DMA interfaces like the two aic7xxx
and all of the sym53c8xx drivers, they get it right.
