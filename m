Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319108AbSHFMrv>; Tue, 6 Aug 2002 08:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319110AbSHFMrv>; Tue, 6 Aug 2002 08:47:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16648 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319108AbSHFMrt>; Tue, 6 Aug 2002 08:47:49 -0400
Message-ID: <3D4C67F4.20807@evision.ag>
Date: Sun, 04 Aug 2002 01:32:04 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Gerald Champagne <gerald.champagne@esstech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide prd table size
References: <1028309451.29024.659.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Gerald Champagne napisa³:
> I have a question about the calculation of the PRD_ENTRIES constant used
> in the ide code  The documentation for the size of PRD_ENTRIES says
> this:
> -----------------------------
> /*
> Our Physical Region Descriptor (PRD) table should be large enough to
> handle the biggest I/O request we are likely to see.  Since requests can
> have no more than 256 sectors, and since the typical blocksize is two or
> more sectors, we could get by with a limit of 128 entries here for the
> usual worst case.  Most requests seem to include some contiguous blocks,
> further reducing the number of table entries required.
> 
> As it turns out though, we must allocate a full 4KB page for this, so
> the two PRD tables (ide0 & ide1) will each get half of that, allowing
> each to have about 256 entries (8 bytes each) from this.
> */
> #define PRD_BYTES	8
> #define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
> -----------------------------
> 
> 
> This looks a little outdated, but I'm interested in the second
> paragraph.  I don't see where multiple interfaces are sharing the same
> page.  The documentation here and for pci_alloc_consistent says that
> blocks are allocated in full pages.  This implies that the unused
> portion is wasted.
> 
> So...
> 
> - Is the code wasting half of the page, and should PRD_ENTRIES be
> redefined to be larger?
> 
> - Am I misunderstanding the documentation, and is the other half of the
> page used somewhere else?
> 
> - Am I misunderstanding the code, and do multiple interfaces share the
> page?
> 
> - Should this be modified to use the pci_pool interface as defined in
> DMA-mapping.txt?
> 
> Thanks!

Well the documentation is a bit inadequate.
The reality is a bit more complicated and reveals if you look at the
actual usage pattern:

1. Two drives on a channel share them.
2. primary and secondary channel are tightly coupled by the
    host controller hardware (in esp the PIIX) and have to
    be allocated in one go.
3. Some host controllers don't like it if you really use the last entry.
4. trm380 can deal with much more then anybody else.



