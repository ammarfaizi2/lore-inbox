Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSLEBgt>; Wed, 4 Dec 2002 20:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbSLEBgt>; Wed, 4 Dec 2002 20:36:49 -0500
Received: from host194.steeleye.com ([66.206.164.34]:64777 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263589AbSLEBgs>; Wed, 4 Dec 2002 20:36:48 -0500
Message-Id: <200212050144.gB51iH105366@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Gibson <david@gibson.dropbear.id.au>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from David Gibson <david@gibson.dropbear.id.au> 
   of "Thu, 05 Dec 2002 11:47:44 +1100." <20021205004744.GB2741@zax.zax> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 19:44:17 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@gibson.dropbear.id.au said:
> Do you have an example of where the second option is useful?  Off hand
> the only places I can think of where you'd use a consistent_alloc()
> rather than map_single() and friends is in cases where the hardware's
> behaviour means you absolutely positively have to have consistent
> memory. 

Well, it comes from parisc drivers.  Here you'd really rather have consistent 
memory because it's more efficient, but on certain platforms it's just not 
possible.

In the drivers that do this, it leads to this type of awfulness:

consistent = 1;
if(!mem = pci_alloc_consistent() {
	mem = __get_free_pages
	mem = pci_map_single()
	consistent = 1;
}
....
if(!consistent)
	dma_cache_wback()

etc.

The idea is that this translates to

mem = dma_alloc_consistent(... DMA_CONFORMANCE_NON_CONSISTENT)

...

dma_sync_single(mem..)

Where if you have consistent memory then the sync is a nop.

adam@yggdrasil.com said:
> 	If these routines can allocate non-consistent memory, then how about
> renaming them to something less misleading, like dma_{malloc,free}? 

Yes, I think the above makes this point.  I'll change the names.

James


