Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271572AbRHPMe1>; Thu, 16 Aug 2001 08:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271575AbRHPMeR>; Thu, 16 Aug 2001 08:34:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3467 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271572AbRHPMeG>;
	Thu, 16 Aug 2001 08:34:06 -0400
Date: Thu, 16 Aug 2001 05:34:15 -0700 (PDT)
Message-Id: <20010816.053415.10296707.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrn9nne9g.8eb.kraxel@bytesex.org>
In-Reply-To: <20010816135150.X4352@suse.de>
	<20010816.045642.116348743.davem@redhat.com>
	<slrn9nne9g.8eb.kraxel@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: 16 Aug 2001 12:14:40 GMT
   
   While we are at it:  Is there some portable way to figure whenever I can
   do a PCI DMA transfer to some page?  On ia32 I can simply look at the
   physical address and if it is behind 4G it doesn't work for 32bit PCI
   devices.  But I think that is not true for architectures which have a
   iommu ...

Currently this is lacking.  The state of affairs for platforms
I know something about is:

x86: "4GB test"
alpha/sparc64/ppc64: any physical memory whatsoever may be accessed
		     via 32-bit PCI addressing due to IOMMU
ia64: "software IOMMU" scheme causes DMA to >4GB addresses to
      require bounce buffers when using 32-bit addressing
      Port posses broken 64-bit PCI addressing hack in an attempt
      to deal with limitations of software IOMMU scheme.

To be honest, you really shouldn't care about this.  If you are
writing a block device, the block/scsi/ide/whatever layer should take
care to only give you memory that can be DMA'd to/from.

Same goes for the networking layer.

In some cases, the distinction being made is "highmem vs not-highmem"
for something being DMA'able on PCI.  This is on thing the networking
references.  But, while this will always lead to correct behavior, it
is very inefficient.

Jens's and my work aims to directly address these kinds of issues.
Whatever we finally end up in Jens's code as the "DMA'able test" will
likely propagate into the networking bits.

Later,
David S. Miller
davem@redhat.com
