Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbRESU7a>; Sat, 19 May 2001 16:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbRESU7U>; Sat, 19 May 2001 16:59:20 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:21188 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261337AbRESU7G>; Sat, 19 May 2001 16:59:06 -0400
Date: Sat, 19 May 2001 16:58:54 -0400
From: Tom Vier <tmv5@home.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010519165854.A530@zero>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010518223436.A563@zero> <20010519144815.A2177@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519144815.A2177@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sat, May 19, 2001 at 02:48:15PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 02:48:15PM +0400, Ivan Kokshaysky wrote:
> This is incorrect. If you want directly mapped PCI window then you don't
> need the iommu_arena for it. If you want scatter-gather mapping, you
> should write address of the SG page table into the T3_BASE register.

i've tried both direct mapped and sg, but it still get pci_map_sg() failures
in sym53c8xx. the sg version, below, won't boot (scsi commands all timeout).
while the added direct map version does boot, it suffers the same problem as
the stock code.

third direct map:
	hose->sg_pci = NULL;
	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 32768);
	__direct_map_base = 0x40000000;
	__direct_map_size = 0x88000000;

	*(vip)CIA_IOC_PCI_W3_BASE = 0xc0000000 | 1;
	*(vip)CIA_IOC_PCI_W3_MASK = (0x08000000 - 1) & 0xfff00000;
	*(vip)CIA_IOC_PCI_T3_BASE = 0x80000000 >> 2;

sg (doesn't work):

	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 32768);
	hose->sg_pci = iommu_arena_new(hose, 0xc0000000, 0x08000000, 32768);
	__direct_map_base = 0x40000000;
	__direct_map_size = 0x80000000;

	*(vip)CIA_IOC_PCI_W3_BASE = hose->sg_pci->dma_base | 3;
	*(vip)CIA_IOC_PCI_W3_MASK = (hose->sg_pci->size - 1) & 0xfff00000;
	*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(hose->sg_pci->ptes) >> 2;

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
