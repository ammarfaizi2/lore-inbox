Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRHPOP0>; Thu, 16 Aug 2001 10:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271296AbRHPOPQ>; Thu, 16 Aug 2001 10:15:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57227 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271246AbRHPOPK>;
	Thu, 16 Aug 2001 10:15:10 -0400
Date: Thu, 16 Aug 2001 07:15:19 -0700 (PDT)
Message-Id: <20010816.071519.66059870.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816153541.A9265@bytesex.org>
In-Reply-To: <20010816.053415.10296707.davem@redhat.com>
	<20010816153541.A9265@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: Thu, 16 Aug 2001 15:35:41 +0200

   > To be honest, you really shouldn't care about this.  If you are
   > writing a block device, the block/scsi/ide/whatever layer should take
   > care to only give you memory that can be DMA'd to/from.
   > 
   > Same goes for the networking layer.
   
   bttv is neither blkdev nor networking ...
   
It is video layer, and the video layer should be helping along with
these sorts of issues.

The video layer should provide PCI device helpers which allow the
drivers to just do something like:

struct scatterlist *video_pci_get_user_pages(struct pci_dev *pdev,
					     int npages);

void video_pci_put_user_pages(struct pci_dev *pdev,
			      struct scatterlist *sg,
			      int npages);

The scatter list returned (NULL indicates failure, ala -ENOMEM)
will tell the driver everything it needs to know.  Let us define
it as follows:

SG entry 0
	address == base of vmalloc()'d area

SG entry 0 ... NPAGES
	sg_dma_address(sg) = dma_address for that page
	sg_dma_len(sg) = dma_length, usually PAGE_SIZE

sg_dma_len could be something larger than PAGE_SIZE if the
platform has a way of using virtual mappings in PCI space.
You would simply give the device DMA address/len pairs from
the SG array until you either hit the NPAGES entry or you
see a dma_len of zero.

I realize this does not address the kiovec based scheme you
are experimenting with now, but this does deal with the biggest
problem the video layer has right now wrt. portability.

In fact, this isn't even a video layer issue, and the kernel
ought to provide my suggested interfaces in some generic
place.

Later,
David S. Miller
davem@redhat.com
