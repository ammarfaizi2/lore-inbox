Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155913AbQETXUg>; Sat, 20 May 2000 19:20:36 -0400
Received: by vger.rutgers.edu id <S155912AbQETXU0>; Sat, 20 May 2000 19:20:26 -0400
Received: from linuxcare.com.au ([203.29.91.49]:3734 "EHLO front.linuxcare.com.au") by vger.rutgers.edu with ESMTP id <S155908AbQETXUI>; Sat, 20 May 2000 19:20:08 -0400
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14631.8458.994635.56925@argo.linuxcare.com.au>
Date: Sun, 21 May 2000 09:34:34 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrewm@uow.edu.au (Andrew Morton), jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.rutgers.edu
Subject: Re: PCI MMIO flushing and stuff (was Re: 2.2.15 with eepro100: eth0:
In-Reply-To: <E12tHlg-0006af-00@the-village.bc.nu>
References: <3926F6BE.156E43E1@uow.edu.au> <E12tHlg-0006af-00@the-village.bc.nu>
X-Mailer: VM 6.75 under Emacs 20.3.1
Reply-To: paulus@linuxcare.com.au
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox writes:

> > processors which Linux currently supports do external read/write
> > reordering?  If so, would this alter the order as seen by the PCI
> > bridge?
> 
> PowerPC at least can do this, but see above

Most RISCs have a write buffer which lets reads go ahead of writes.

> > Suppose, for example, that the CPU writes two words to memory.  Does the
> > PCI DMA see them in the correct order (non-Pentium), or must some
> > special barriers be used?
> 
> This is defined in the PentiumII manuals.

I think most RISCs these days have a weak memory ordering model which
basically says that you can't assume anything much about the order in
which memory accesses done by one agent (CPU or DMA controller) are
seen by another agent, unless you put in some explicit barriers.  This
lets the hardware reorder accesses to get improved performance.  I
don't know of any systems that actually reorder writes to
non-cacheable memory though.

> > What happens the PCI DMA wants to write to an address which is currently
> > dirty, within a CPU cache?
> 
> The PCI write is stalled, the cache line written back and invalidated, then
> the data is written
> 
> > What happens when PCI DMA wants to read an address which is currently
> > dirty, within a CPU cache?
> 
> Pretty much the same.
> 
> > What happens when PCI DMA writes to an address which is currently clean
> > within a CPU cache?
> 
> It goes dirty

No, it gets invalidated, surely?

> The memory bus stuff is defined in the intel docs not the PCI docs. On
> a PowerPC for example I believe the answer to most of the above questions
> is 'you lose'. That is why we have pci_alloc_consistent and the like to avoid
> spending all day flushing caches.

No, that's sparc32 you're thinking of IIRC. :-)  PCI DMA is coherent
with the cpu D-cache on all the PowerPCs I've worked on (the I-cache
usually doesn't snoop, though).

Paul.

-- 
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
