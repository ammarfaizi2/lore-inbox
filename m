Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSEIVe2>; Thu, 9 May 2002 17:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSEIVe1>; Thu, 9 May 2002 17:34:27 -0400
Received: from host194.steeleye.com ([216.33.1.194]:16658 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314380AbSEIVe0>; Thu, 9 May 2002 17:34:26 -0400
Message-Id: <200205092134.g49LYNo04387@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg fix 
In-Reply-To: Message from Martin Dalecki <dalecki@evision-ventures.com> 
   of "Thu, 09 May 2002 21:45:04 +0200." <3CDAD1C0.9090406@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 17:34:22 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dalecki@evision-ventures.com said:
> If your are at it: I was always itching my had what
> pci_alloc_inconsistent and pci_free_inconsistent is supposed to be?
> Negating semantically the consistent attribute shows nicely that the
> _consistent is a bad nomenclatures. Perhaps something more related to
> the purpose of it would help. Like

> ioalloc() and iofree()

> Could be even abstracted from the bus implementation.

> And of course much less typing... 

I'm all for less typing, but "consistent" memory has a definite meaning to 
some non-x86 architectures (and inconsistent also has a definite and 
semantically opposite meaning).

The x86 is nice because it is fully coherent architecture: the CPUs snoop the 
I/O busses and do CPU cache invalidations for data transferred from an I/O 
device directly to memory and CPU cache flushes when a device reads directly 
from memory.

If the CPU doesn't snoop I/O transfers, you have to manually invalidate or 
flush the necessary CPU cache lines.  The pci_sync_... functions are for doing 
the cache invalidations and flushes correctly.  Sometimes you can obtain a 
region of memory which is "consistent" meaning that  you no longer need to do 
the invalidations/flushes manually because the CPU will operate coherently on 
this region.  "inconsistent" means that you must control the CPU cache 
yourself.  In an incoherent memory architecture, the normal memory allocations 
give you "inconsistent" regions.

The royal pain on some CPUs is that they only have small consistent regions, 
so pci_alloc_consistent can fail and you have to know this and fall back to 
doing all the manual cache operations.  For this reason, some cross platform 
drivers simply choose not to bother with consistent memory at all because the 
cache manipulation operations are optimised away on fully consistent platforms.

I'd like to say that this is totally unrelated to the bus type, but some 
architectures place MMUs on their busses which means that memory consistency 
(and even memory addressability) can indeed be bus specific depending on what 
the MMU actually does.

James


