Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVJSRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVJSRSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJSRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:18:31 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27795 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751164AbVJSRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:18:30 -0400
Date: Wed, 19 Oct 2005 12:18:06 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com, muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051019171805.GF10863@us.ibm.com>
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de> <20051017182755.GA26239@granada.merseine.nu> <200510172032.45972.ak@suse.de> <20051017184523.GB26239@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017184523.GB26239@granada.merseine.nu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run a few tests on the original code and the patches posted to the list,
and have some interesting results.  First, my system setup:  Dual Opteron, 8GB
RAM, SIL SATA controller (which is apparently 32bit), pcnet32 NIC (compiled as
a module) connected to the network.  The latter 2 should show any bounce
buffer problems.  

I get the following behavior: 
- With AMD HW IOMMU (AGP_GART), everything works perfectly.
- With IOMMU disabled (iommu=off), my kernel panics in SATA.
- With SW IOMMU (iommu=soft), my kernel is unable to find any partitions on my
SATA disk (and panics)
- With SW IOMMU and Ravikiran's original patch, kernel boots with no aperient
problems
- With SW IOMMU and Ravikiran's second patch, kernel boots with no aperient
problems
- With SW IOMMU and Yasunori's patch, kernel boots with no aperient problems

The edited dmesg output can be found below.  

>From the above, we can tell that my system requires either hardware IOMMU or
bounce buffers for the SATA disk.  We can also tell that the current
implimentation has a bug (where the actual cause lies is unknown).  All of the
patches in this e-mail thread seem to fix my problem and I had no noticeable
problems.

If anyone wants me to try anything on my system, I'll be happy to help.  

Thanks,
Jon

----------------------------------------------------

with Yasunori's last patch and with iommu=soft
[...]
Placing software IO TLB between 0x4821000 - 0x8821000
[...]
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: f9700000-f97fffff
  PREFETCH window: f9000000-f90fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: f9800000-f98fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:08:03.0
  IO window: 3000-3fff
  MEM window: f9200000-f92fffff
  PREFETCH window: f9100000-f91fffff
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: f9300000-f93fffff
  PREFETCH window: f9500000-f95fffff
[...]
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
[...]


with Ravikiran's second patch and with iommu=soft
[...]
Placing software IO TLB between 0x4821000 - 0x8821000
[...]
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: f9700000-f97fffff
  PREFETCH window: f9000000-f90fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: f9800000-f98fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:08:03.0
  IO window: 3000-3fff
  MEM window: f9200000-f92fffff
  PREFETCH window: f9100000-f91fffff
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: f9300000-f93fffff
  PREFETCH window: f9500000-f95fffff
[...]
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
[...]


with Ravikiran's first patch and with iommu=soft
[...]
Placing software IO TLB between 0x4820180 - 0x8820180
[...]
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: f9700000-f97fffff
  PREFETCH window: f9000000-f90fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: f9800000-f98fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:08:03.0
  IO window: 3000-3fff
  MEM window: f9200000-f92fffff
  PREFETCH window: f9100000-f91fffff
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: f9300000-f93fffff
  PREFETCH window: f9500000-f95fffff
[...]
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
[...]



without patch and with iommu=soft
[...]
Placing software IO TLB between 0x104466000 - 0x108466000
[...]
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: f9700000-f97fffff
  PREFETCH window: f9000000-f90fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: f9800000-f98fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:08:03.0
  IO window: 3000-3fff
  MEM window: f9200000-f92fffff
  PREFETCH window: f9100000-f91fffff
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: f9300000-f93fffff
  PREFETCH window: f9500000-f95fffff
[...]
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
[...]
VFS: Cannot open root device "sda2" or unknown-block(8,2)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,2)


without patch and with iommu=off
[...]
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: f9700000-f97fffff
  PREFETCH window: f9000000-f90fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: f9800000-f98fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:08:03.0
  IO window: 3000-3fff
  MEM window: f9200000-f92fffff
  PREFETCH window: f9100000-f91fffff
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: f9300000-f93fffff
  PREFETCH window: f9500000-f95fffff
[...]
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda:<0>Kernel panic - not syncing: PCI-DMA: high address but no IOMMU.
