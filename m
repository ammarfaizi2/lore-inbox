Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286235AbRLTNPO>; Thu, 20 Dec 2001 08:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286236AbRLTNPF>; Thu, 20 Dec 2001 08:15:05 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:33034 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S286235AbRLTNOv>; Thu, 20 Dec 2001 08:14:51 -0500
Date: Thu, 20 Dec 2001 16:13:31 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - prefetchable memory regions
Message-ID: <20011220161331.A5330@jurassic.park.msu.ru>
In-Reply-To: <20011218235035.P13126@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218235035.P13126@flint.arm.linux.org.uk>; from rmk@flint.arm.linux.org.uk on Tue, Dec 18, 2001 at 11:50:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 11:50:35PM +0000, Russell King wrote:
> The following patch allows architectures to split the prefetchable memory
> regions from the non-prefetchable regions if they wish by supplying a
> third bus resource.  This third resource must have the IORESOURCE_PREFETCH
> flag set.  (Other parts of the PCI layer already assume this is true).
> Currently, some ARM based machines make use of this facility.

This looks fine, but I don't like the idea of artificial splitting
the PCI memory region if we want prefetch support. I can imagine
a situation where we need to set PCI memory window as small as possible,
and proper splitting won't be easy in this case.
So I'm using different approach, a bit more complex, but [hopefully] more
generic:
- pass 1. Allocate only prefetchable resources. At this point, we
  have IORESOURCE_MEM flag cleared for bridged buses.
- pass 2. Allocate IO and memory resources. If we have separate
  prefetchable region on the root bus, start at PCIBIOS_MIN_MEM as usual,
  if not - at the end of prefetchable area from pass 1.

The patch is available at
ftp://ftp.park.msu.ru/ink/patches-2.5/prefetch.diff

Unfortunately, it depends on
ftp://ftp.park.msu.ru/ink/patches-2.5/pci-2.5.diff

The latter is mostly setup-[bus,res].c reorganization,
plus generic fast-back-to-back etc. support, and
corresponding alpha specific stuff.
I'm planning to split it up and post for a discussion
in next few days.

Ivan.
