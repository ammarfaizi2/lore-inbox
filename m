Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRETOLP>; Sun, 20 May 2001 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbRETOLG>; Sun, 20 May 2001 10:11:06 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:20467 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261960AbRETOKu>; Sun, 20 May 2001 10:10:50 -0400
Message-ID: <3B07CF20.2ABB5468@uow.edu.au>
Date: Mon, 21 May 2001 00:05:20 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au>,
		<3B07AF49.5A85205F@uow.edu.au>; from andrewm@uow.edu.au on Sun, May 20, 2001 at 09:49:29PM +1000 <20010520154958.E18119@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> [ cc'ed to l-k ]
> 
> > DMA-mapping.txt assumes that it cannot fail.
> 
> DMA-mapping.txt is wrong. Both pci_map_sg and pci_map_single failed if
> they returned zero. You either have to drop the skb or to try again later
> if they returns zero.
> 

Well this is news to me.  No drivers understand this.
How long has this been the case?  What platforms?


For netdevices at least, the pci_map_single() call is always close
to the site of the skb allocation.  So what we can do is to roll
them together and use the existing oom-handling associated with alloc_skb(),
assuming the driver has it...


static inline struct sk_buff *pci_alloc_skb(
                int length, int gfp_mask, int reserve,
                pci_dev *pdev, dma_addr_t *dma_addr, int direction, int irq)
{
        struct sk_buff *skb = alloc_skb(length + 16, gfp_mask);
        if (skb) {
                skb_reserve(ret, 16 + reserve);
                *dma_addr = pci_map_single(pdev, skb->tail, size - reserve, direction);
                if (*dma_addr == 0) {
                        if (irq)
                                dev_kfree_skb_irq(skb);
                        else
                                dev_kfree_skb(skb);
                        skb = 0;
                }
        }
        return skb;
}

Sticky, but a lot of it will be compiled away.

-
