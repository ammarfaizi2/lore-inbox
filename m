Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSEQLzV>; Fri, 17 May 2002 07:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEQLzU>; Fri, 17 May 2002 07:55:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50331 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314504AbSEQLzT>;
	Fri, 17 May 2002 07:55:19 -0400
Date: Fri, 17 May 2002 04:41:57 -0700 (PDT)
Message-Id: <20020517.044157.34125224.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517153903.A24121@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Fri, 17 May 2002 15:39:03 +0400
   
   What about
   dma_addr_t pci_to_pci_map_single(struct pci_dev *master,
   				 struct pci_dev *target,
   				 dma_addr_t tgt_addr, size_t size, int dir)
   
   Could be implemented without much pain if there is enough interest. :-)
   
tgt_addr does not make any sense, we are trying to DMA to a device
resource, so pass a "struct resource *" and "unsigned long res_offset"
instead of tgt_addr.

So, as a (real life) example, suppose you wanted to portably point
your BTTV card at the framebuffer of a video card, you'd do
something like:

	res = fb_pdev->resource[1];
	res_off = OFFSET_INTO_FRAMEBUFFER;
	bttv_dma_addr = pci_to_pci_map_single(struct pci_dev *bttv_pdev,
					      struct pci_dev *fb_pdev,
					      res, res_off, size,
					      PCI_DMA_FROMDEVICE);

Note the direction is in terms of the master.  The DMA is coming
"from" the master in this "BTTV capture to framebuffer" case.
