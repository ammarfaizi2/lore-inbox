Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbRETRgX>; Sun, 20 May 2001 13:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbRETRgP>; Sun, 20 May 2001 13:36:15 -0400
Received: from front2.grolier.fr ([194.158.96.52]:17332 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S262123AbRETRf6> convert rfc822-to-8bit; Sun, 20 May 2001 13:35:58 -0400
Date: Sun, 20 May 2001 16:23:34 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Andrea Arcangeli <andrea@suse.de>, Richard Henderson <rth@twiddle.net>,
        linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010520161234.B8223@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.10.10105201604080.758-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Ivan Kokshaysky wrote:

> On Sun, May 20, 2001 at 04:40:13AM +0200, Andrea Arcangeli wrote:
> > I was only talking about when you get the "pci_map_sg failed" because
> > you have not 3 but 300 scsi disks connected to your system and you are
> > writing to all them at the same time allocating zillons of pte, and one
> > of your drivers (possibly not even a storage driver) is actually not
> > checking the reval of the pci_map_* functions. You don't need a pte
> > memleak to trigger it, even regardless of the fact I grown the dynamic
> > window to 1G which makes it 8 times harder to trigger than in mainline.
> 
> I think you're too pessimistic. Don't mix "disks" and "controllers" --
> SCSI adapter with 10 drives attached is a single DMA agent, not 10 agents.
> 
> If you're so concerned about Big Iron, go ahead and implement 64-bit PCI
> support, it would be right long-term solution. I'm pretty sure that
> high-end servers use mostly this kind of hardware.
> 
> Oh, well. This doesn't mean that I'm disagreed with what you said. :-)
> Driver writers must realize that pci mappings are limited resources.

The IOMMU code allocation strategy is designed to fail due to
fragmentation as everything that performs contiguous allocations of
variable quantities.

I may add a test of pci_map_* return code in the sym53c8xx driver, but
the driver will panic on failure. It is not acceptable to consider such
kind of failure as a normal situation (returning some ?_BUSY status to
the SCSI driver) for the following reasons:

- IOs may be reordered and break upper layers assumptions.
- Spurious errors and even BUS resets may happen.

For now, driver methods that are requested to queue IOs are not allowed to
wait for resources. Anyway, the pci_map_* interface is unable to wait.

There are obviously ways to deal gracefully with such resource lack, but
the current SCSI layer isn't featured for that. For example, a
freeze/unfreeze mechanism as described in CAM can be implemented in order
not to reorder IOs, and some mechanism (callback, resource wait, etc...)
must be added to restart the operation when resource is likely to be
available.

IMO, the only acceptable fix in the current kernel is to perform IOMMU PTE
allocations of a fixed quantity at a time, as limiting SG entry to fit in
a single PAGE for example.

  Gérard.

PS: May-be I should look how *BSD's handles IOMMUs.

