Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJFSEV>; Sat, 6 Oct 2001 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275425AbRJFSEC>; Sat, 6 Oct 2001 14:04:02 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:60043 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275424AbRJFSDu>; Sat, 6 Oct 2001 14:03:50 -0400
Date: Sat, 6 Oct 2001 14:04:19 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110061804.f96I4Jk03897@devserv.devel.redhat.com>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <mailman.1002355920.6872.linux-kernel2news@redhat.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain> <d3n136tc48.fsf@lxplus014.cern.ch> <mailman.1002355920.6872.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> The argument for supplying this functionality in the PCI DMA code
> would be that if it was done there it could be done once, and in a
> sophisticated and efficient (and SMP-safe :) fashion, rather than
> ad-hoc in each driver.

This is exactly the kind of thinking that brought us pci_pool.
With all due respect to David-B, it was totally unnecessary,
in my view. However, attempts to make it "pretty" resulted in
something that cannot be implemented right. Just think if
pci_pool_free can be entered from an interrupt. If you allow
that, you cannot free full pages (because some broken architectures
implement pci_alloc_consistent with vmalloc, and vfree is not
interrupt safe). The root of the problem is an attempt to specify
variable sized pools.

I am afraid that if we start adding first class citizen APIs
in the area of pci_alloc_something, it's going to be more and
more interdependent and will place very strong constraints
on what architectures can and cannot do. For example, already
pci_alloc_consistent _cannot_ be implemented on some HP machines
(and, by extension, pci_pool).

> It may also be possible for the PCI DMA code to take advantage of its
> knowledge of a particular platform, for example if the platform only
> has a small range of possible DMA addresses then it could use a simple
> and fast lookup table.  Or it may be possible to read the IOMMU tables
> on some platforms and do the reverse mapping quickly that way - this
> would certainly be the case for the IBM RS/6000 machines since the
> IOMMU tables are in system RAM.

And it neither of these is possible, then what? Then you fall
back on the most generic code, which is the worst case of
all possible partial implementations in drivers.

-- Pete
