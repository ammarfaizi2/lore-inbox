Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSEIQrw>; Thu, 9 May 2002 12:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313906AbSEIQrv>; Thu, 9 May 2002 12:47:51 -0400
Received: from host194.steeleye.com ([216.33.1.194]:61714 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S313898AbSEIQru>; Thu, 9 May 2002 12:47:50 -0400
Message-Id: <200205091647.g49GlkG02757@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.5.14 PCI reorg and non-PCI architectures 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Thu, 09 May 2002 08:23:29 PDT." <20020509152329.GC17158@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 12:47:46 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg@kroah.com said:
> No wait, the NCR driver needs Microchannel, is that true? 

Correct. the two drivers (lasi700 and NCR_D700) both use 53c700 to drive the 
chip core, but they take care of interfacing to the local bus, whatever it is. 
 The chip core (which is bus independent) still has to allocate consistent 
memory for the chip mailbox (although I suppose I could alter the bus drivers 
to pass in a pointer to a pre-allocated region).  I can't get away without 
using pci_sync_single et al. in the bus independent driver, though.

> I would like to push back and ask why you are calling a pci_* function
> from a driver that does not need pci.  Yes, I know it's a nice,
> generic function, but that hasn't stopped people from rewriting that
> same function a number of times in different forms in different places
> in the tree:) 

The 53c700 core must be able to use synchronous memory (if it can) on parisc.  
The only global call for this is pci_alloc_consistent (and its use is advised 
in Documentation/DMA-mapping.txt).  Obviously, x86 is fully synchronous 
anyway, so it only needs to support the call as a type of nop.

> In a perfect world, we should probably create a function like:
> 	void *alloc_consistent (int flags, size_t size, dma_addr_t
> *dma_handle); to solve everyone's needs, but I'm not volunteering to
> do that :) 

I agree with this.  Debate around this naming issue came up in the parisc 
groups (again because we need consistent allocations and some legacy machines 
don't have PCI busses).  The official response them was use 
pci_alloc_consistent and don't worry about it seeming to be a pci specific 
function.  Really, it is only legacy machines that are non-pci, so I suppose 
it does make some sense to have them as special cases of pci specific 
functions.

> I'll go move the file and send the changeset to Linus. 

Thanks!

James


