Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRJGQYl>; Sun, 7 Oct 2001 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276430AbRJGQYc>; Sun, 7 Oct 2001 12:24:32 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:27726
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S276408AbRJGQYU>; Sun, 7 Oct 2001 12:24:20 -0400
Message-Id: <200110071623.f97GNmD01704@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Jes Sorensen <jes@sunsite.dk>, paulus@samba.org,
        "David S. Miller" <davem@redhat.com>,
        James.Bottomley@HansenPartnership.com, linuxopinion@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address 
In-Reply-To: Message from =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr> 
   of "Sun, 07 Oct 2001 09:21:05 +0200." <20011007091404.X953-100000@gerard> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Oct 2001 11:23:47 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would apply the bat to people that wants such a dma to virtual
> general translation. This thing is obviously gross shit.

If you read back in the thread, you'll find the proposed API was per 
pci_device and only when the device driver writer actually asked for it.  This 
makes it potentially as efficient as the code in sym53c8xx in the worst case 
and much more efficient in the best.

We have all agreed that just doing the mapping generally will be inefficient 
for a particular class of hardware with no readable access to its page tables.

> I would also apply the bat to people that look into stuff of other
> people and, instead of trying to actually understand the code, just
> give a look and send inappropriate statements to the list. 

The statement currently made to the list:

> Worse still, every driver that needs this feature is doing it on its own, so
> the code for doing this in usb-ohci is different from the code in the
> sym53c8xx driver etc. 

Is true: both drivers use hashes to do dma to virtual mapping.  They both have 
their own code for doing it (I have looked).  We can disagree about whether 
the code is subtle or complex, but you can't deny that these two drivers have 
separate implementations of the same function.

> In my opinion, any bus_to_virt() thing hurts a lot. It only makes
> sense if it refers to the virt_to_bus() mapping that was used to
> generate the bus address and assumes the reverse function to be a
> mapping. A general bus_to_virt() thing looks so ugly thing to me that
> I donnot want to ever use such.

Right, but we're not arguing over whether to do it generally.  The argument is 
whether an API looking like this:

pci_register_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t 
dmaAddress, size_t size);
void *pci_dma_to_virtual(struct pci_dev *dev, dma_addr_t dmaAddress);
dma_addr_t pci_virtual_to_dma(struct pci_dev *dev, void *virtualAddress);
pci_unregister_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t 
dmaAddress, size_t size);

should or should not be provided.

For this API I claim that:

1. I can do the worst case MMU hardware as efficiently as your driver (because 
it would essentially be a hashed look up of registered mappings for your 
single pci device instance alone, functionally identical to the code you use 
today).

2. on optimal hardware (like x86 where this can be done by bit flipping of the 
address) I can do a whole lot better.

I also claim the same is true for every driver which still needs to do this 
type of mapping (which is a significant fraction of drivers for devices which 
have an intelligent processor core and multiple outstanding jobs with a 
non-predictable order of completion).

Therefore, every driver that needs to do this today is using the least 
efficient method.  Further, they're all coding their own least efficient 
methods.

If you can provide a reasoned counter argument to the above (preferably 
stripped of the invective periphrasis) I'm listening.

James Bottomley

