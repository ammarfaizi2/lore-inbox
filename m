Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWGLX3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWGLX3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGLX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:29:30 -0400
Received: from mx.pathscale.com ([64.160.42.68]:60319 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932203AbWGLX32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:29:28 -0400
Subject: Suggestions for how to remove bus_to_virt()
From: Ralph Campbell <ralphc@pathscale.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general <openib-general@openib.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 12 Jul 2006 16:29:27 -0700
Message-Id: <1152746967.4572.263.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking at how to eliminate the bus_to_virt() and
phys_to_virt() calls used by the ib_ipath driver.
I am looking for suggestions on how to proceed.

The current IB core to IB device driver interface relies
on a kernel module being able to call ib_get_dma_mr() to allocate
a memory region which represents all of device addressable memory.
The kernel module is then expected to call dma_map_single(),
dma_map_sg(), etc. to convert physical or virtual addresses into
device addresses.  If the system has an IOMMU, there may be several
physical pages mapped to a single contiguous device address region.
This device address and length (possibly an array of them) is then
passed to the IB device driver so the IB device can DMA data
to or from memory.

The ib_ipath driver cannot tell the HW to DMA data directly to the
device (IOMMU) addresses and must copy the data.  This means the driver
needs to reverse the IOMMU mapping and somehow obtain kernel virtual
addresses so it can memcpy() the data to the correct location.
Currently, the ib_ipath driver requires that the mapping be one-to-one
since there is no practical way to reverse IOMMU mappings.

I believe it is generally agreed that trying to change the dma_map_*
interface to include functions of this sort is not the right approach
to take.

One solution is to change the IB device driver interface so that
kernel virtual addresses are passed to the IB device driver and
the device driver is responsible for calling dma_map_single(), etc.
I believe this will be unacceptable to the OpenFabrics community
since it would require the driver to allocate large amounts of memory
(#QPs * #MaxWRs * sizeof(dma_addr_t + length)) to store the
information needed to undo the mapping when the DMA is complete.
The current IB code allocates the storage for dma_unmap_single(), etc.
as extra elements in structures already needed so it isn't a large
overhead and it is based on the actual number of requests posted
instead of the maximums allowed.

Another solution is to change the IB device driver interface to add
a function which tells the caller what type of addresses the device
expects.  Kernel modules would then be required to pass either a
dma_map_xxx() address or a kernel virtual address based on the
driver's preference.
The current set of IB consumers either start with kmalloc/vmalloc
memory (such as the MAD layer) or a list of physical pages
(such as ISER and SRP). The current code could therefore be
fairly easily changed except for ISER/SRP when a struct page
doesn't have a direct kernel address (high pages) and would
need to call kmap()/kunmap() in that case.

I plan to implement this last approach unless someone has
a better idea.  I would like to get some "buy-in" before
I spend a lot time coding only to be rejected when finished.


