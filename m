Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUI1KIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUI1KIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUI1KIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:08:37 -0400
Received: from the-doors.enix.org ([62.210.169.120]:54684 "EHLO
	the-doors.enix.org") by vger.kernel.org with ESMTP id S264997AbUI1KId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:08:33 -0400
Date: Tue, 28 Sep 2004 12:08:31 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com
Subject: How to handle a specific DMA configuration ?
Message-ID: <20040928100831.GI27756@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[As I'm not subscribed the list, please include me in Cc: for answers]

I am currently porting 2.6 to a home-made MIPS-based platform using
the MIPS RM9000 processor and the Marvell memory/uart/ethernet
controller.

My physical memory mapping is a bit special : I have 384 MB of
memory. The first 256MB are directly connected to the RM9000, while
the last 128MB are connected to the Marvell controller. _Only_ the
last 128MB are usable for DMA (especially for network traffic). For
the moment, Linux only takes care of the first 256MB, but I can change
it to take care of the complete physical memory space (384 MB).

My problem is the allocation of skbuff. They are allocated using
alloc_skb() in net/core/skbuff.c, and uses the "normal" kmalloc()
allocator. kmalloc() will allocate memory somewhere in the physical
memory space : even if a I allow Linux to allocate memory between
256MB and 384MB, I cannot be sure that it will use memory in this
space to allocate skbuff. If skbuff are not allocated in this space,
then I can't use DMA to transfer the buffers.

As I understand the ZONE_DMA thing, it allows to tell Linux that a
physical memory region located between 0 and some value (16 MB on PCs
for old ISA cards compatibility) is the only area usable for DMA. How
could I declare my 256MB-384MB physical memory reagion to be the only
area usable for DMA ? How can I tell the skbuff functions to allocate
_only_ DMA-able memory ? Moreover, can I make assumptions on the
alignement of final data at the bottom of the network stack (my DMA
controller doesn't like the 2 byte-aligned things).

At the moment, I see only three solutions. The two first aren't not
very satisfying, the third might be a solution, but not perfect
neither (and not sure it would work).

 1) Implement a home-made memory allocator dedicated to the allocation
    of DMA buffers inside the 256MB-384MB space. Then modify the
    net/core/skbuff.c functions to use this allocator to allocate/free
    the contents (skb->data) of the skbuffs. I'm not sure that it will
    work, but at least, it involves the modification of
    architecture-independent code for an architecture-dependent
    reason. 

 2) Modify the Marvell Ethernet driver (drivers/net/mv64340_eth.c) to
    change the calls to pci_map_single() and
    pci_unmap_single(). The pci_map_single() would allocate (through a
    dedicated home-made allocator) a DMA buffer, and copy the contents
    of the skbuf to the DMA buffer. The pci_unmap_single() would copy
    the contents of the DMA buffer back to the skb->data buffer. I'm
    quite sure this would work (this is how the 2.4 port that I have
    for this platform work), but it involves the modification of the
    Ethernet driver, and above all, a performance hit.

 3) Modify net/core/skbuf.c to make sure all kmalloc()'ed areas (for
    skbuff contents) are allocated with the GFP_DMA flag. Then, modify
    the arch/mips/mm/init.c file to make sure the first 256MB physical
    pages don't have the DMA bit, and that the next 128MB will have it
    (not sure on how complex it is).

Are there any other solutions available ? If not, which of the
proposed solutions is the best ?

If my problem is unclear, don't hesitate to ask for further details,

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
