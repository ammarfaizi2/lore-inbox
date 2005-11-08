Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVKHBh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVKHBh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVKHBh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:37:26 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:56255 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965120AbVKHBhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:37:25 -0500
Date: Mon, 7 Nov 2005 18:37:22 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: bus_to_virt equivalent
Message-ID: <20051108013722.GK23749@parisc-linux.org>
References: <20051107235247.67981.qmail@web32402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107235247.67981.qmail@web32402.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:52:47PM -0800, Anil kumar wrote:
> Hi,
> 
> I am trying to port bus_to_virt and virt_to_bus to the
> DMA-mapping scheme.
> I found a way to move virt_to_bus() as follows:
> page = virt_to_page(cmd->request_buffer);
> offset = (unsigned long)address & ~PAGE_MASK;
> dma_addr_t addr = pci_map_page(dev, page, offset,
> size,direction);
> 
> But now I want to get virtual address for dma_addr_t.

Did you *read* DMA-mapping.txt?

  Drivers converted fully to this interface should not use virt_to_bus
  any longer, nor should they use bus_to_virt. Some drivers have to
  be changed a little bit, because
  *there is no longer an equivalent to bus_to_virt in the dynamic
  DMA mapping scheme*
  - you have to always store the DMA addresses returned by the
  pci_alloc_consistent, pci_pool_alloc, and pci_map_single calls
  (pci_map_sg stores them in the scatterlist itself if the platform
  supports dynamic DMA mapping in hardware) in your driver structures
  and/or in the card registers.

The reason for this is that there may be many physical addresses which
correspond to the same bus address.  For example (this is on an HP rx8620)
the bus address c001b000 maps to 00000f000001b000 for device 00:03.0,
00000f010001b000 for device 40:03.0, 00000f020001b000 for device 80:03.0
and 00000f030001b000 for device c0:03.0.

Now, maybe we should add a function:

unsigned long device_bus_addr_to_phys(struct device *dev, dma_addr_t handle);

but we don't have one yet.  So you have to follow the rules above.
