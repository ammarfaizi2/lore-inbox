Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154215AbQAaKFY>; Mon, 31 Jan 2000 05:05:24 -0500
Received: by vger.rutgers.edu id <S155264AbQAaIiX>; Mon, 31 Jan 2000 03:38:23 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:2436 "EHLO sunsite.ms.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S155262AbQAaHdD>; Mon, 31 Jan 2000 02:33:03 -0500
Date: Mon, 31 Jan 2000 12:45:52 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
Cc: "David S. Miller" <davem@redhat.com>, rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
Message-ID: <20000131124552.I948@mff.cuni.cz>
Mail-Followup-To: Jes Sorensen <Jes.Sorensen@cern.ch>, "David S. Miller" <davem@redhat.com>, rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk> <200001302211.OAA03036@pizda.ninka.net> <d3oga2r22z.fsf@lxplus011.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <d3oga2r22z.fsf@lxplus011.cern.ch>; from Jes Sorensen on Mon, Jan 31, 2000 at 11:02:28AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

> David> For the actual transfers, you can do the dma_cache_*() calls in
> David> the pci_{un,}map_streaming() calls.
> 
> David> The only place you could possibly need it is for the IDE
> David> scatter list tables, and that would only be if you have _no_
> David> mechanism to disable the CPU cache in the MMU, which I severely
> David> doubt.
> 
> Hmmm ok I just noticed this and I haven't read that DMA mapping
> document yet. I'll have to look at it to see how it affects PCI
> devices that are 64 bit address capable.

The whole interface is currently for SAC. For using DAC, you need arch
details how to build the DAC address (e.g. on UltraSPARC you usually want
0xfffc in bits 63:50 to set DMA bypass) and it really depends if it is a
gain or lose (with SAC and dynamic mapping, you can manage to collapse a
bunch of sg chunks into one sg entry, while with DAC you cannot. Also,
with SAC on sparc64 PCI chips you can specify whether you want streaming
mode or not, while with bypass it is always consistent if I remember well -
the cacheability is determined from the physical address though). On the
other side with DAC you save filling up the IOPTEs and clearing them after.

> 
> The one thing for the m68k is that we have very few machines with
> PCI, though we still suffer a lot from the DMA coherency problem on
> the busses we do have.

The API is pci_* because it takes a struct pci_dev *. SBUS has identical API
with sbus_* which takes struct sbus_dev *.
The goal is to merge all bus device structures into struct pci_dev (but
keeping as much as possible bus specific things in sysdata) and call it a
generic hardware device structure. Then all those interfaces can be merged,
its just the changes need to be incremental (Linus did not like introducing
device_t type and casting struct pci_dev etc. structures to it and back so
it got removed from the patch). But if you don't need any specific device or
bus data in the pci_alloc_consistent, pci_map_single and the like, you can
use it for whatever bus you need. One just passes NULL as the device pointer
to it (this is needed so that drivers handling e.g. ISA (which has no struct
isa_dev nor uses pci_dev) and PCI at the same time can use the dynamic DMA
interface).

> 
> The place where this is a real problem is in drivers where data is
> shared between the adapter and the host CPU, for instance the 53c7xx
> driver. On the m68k we currently use a kernel_set_cachemode() function
> to change the caching of the page allocated for the shared structures,
> but thats a pretty non portable way of doing it. I would like to see
> something a get_free_cachecoherent_page() interface instead, what do
> you think of that?

Why cannot you do this in pci_alloc_consistent?

Cheers,
    Jakub
___________________________________________________________________
Jakub Jelinek | jakub@redhat.com | http://sunsite.mff.cuni.cz/~jj
Linux version 2.3.41 on a sparc64 machine (1343.49 BogoMips)
___________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
