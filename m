Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276558AbRJGS3w>; Sun, 7 Oct 2001 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRJGS3m>; Sun, 7 Oct 2001 14:29:42 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:64009 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S276558AbRJGS31> convert rfc822-to-8bit; Sun, 7 Oct 2001 14:29:27 -0400
Date: Sun, 7 Oct 2001 20:24:26 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jes Sorensen <jes@sunsite.dk>, <paulus@samba.org>,
        "David S. Miller" <davem@redhat.com>, <linuxopinion@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to get virtual address from dma address 
In-Reply-To: <200110071623.f97GNmD01704@localhost.localdomain>
Message-ID: <20011007195159.D1867-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Oct 2001, James Bottomley wrote:

> > I would apply the bat to people that wants such a dma to virtual
> > general translation. This thing is obviously gross shit.
>
> If you read back in the thread, you'll find the proposed API was per
> pci_device and only when the device driver writer actually asked for it.  This
> makes it potentially as efficient as the code in sym53c8xx in the worst case
> and much more efficient in the best.
>
> We have all agreed that just doing the mapping generally will be inefficient
> for a particular class of hardware with no readable access to its page tables.
>
> > I would also apply the bat to people that look into stuff of other
> > people and, instead of trying to actually understand the code, just
> > give a look and send inappropriate statements to the list.
>
> The statement currently made to the list:
>
> > Worse still, every driver that needs this feature is doing it on its own, so
> > the code for doing this in usb-ohci is different from the code in the
> > sym53c8xx driver etc.
>
> Is true: both drivers use hashes to do dma to virtual mapping.  They both have
> their own code for doing it (I have looked).  We can disagree about whether
> the code is subtle or complex, but you can't deny that these two drivers have
> separate implementations of the same function.

Am I dreaming? It is less than 30 lines of code one-shot written within a
couple of minutes. Too much sharing code has counter-effects on
maintainability, performances and also may have the adverse effect of
bloating the overall code or making it less readable. We must share what
is worth to be so. The right compromize I see here is absolutely not
yours, it seems.

> > In my opinion, any bus_to_virt() thing hurts a lot. It only makes
> > sense if it refers to the virt_to_bus() mapping that was used to
> > generate the bus address and assumes the reverse function to be a
> > mapping. A general bus_to_virt() thing looks so ugly thing to me that
> > I donnot want to ever use such.
>
> Right, but we're not arguing over whether to do it generally.  The argument is
> whether an API looking like this:
>
> pci_register_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t
> dmaAddress, size_t size);
> void *pci_dma_to_virtual(struct pci_dev *dev, dma_addr_t dmaAddress);
> dma_addr_t pci_virtual_to_dma(struct pci_dev *dev, void *virtualAddress);
> pci_unregister_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t
> dmaAddress, size_t size);

The prototypes seem larger in characters that the full code that does the
work in the sym53c8xx driver. On the other hand, it involves the pcidev
structure and thus may require additionnal synchronisation. You just
illustrates exactly what I wrote above, in my opinion.

> should or should not be provided.
>
> For this API I claim that:
>
> 1. I can do the worst case MMU hardware as efficiently as your driver (because
> it would essentially be a hashed look up of registered mappings for your
> single pci device instance alone, functionally identical to the code you use
> today).
>
> 2. on optimal hardware (like x86 where this can be done by bit flipping of the
> address) I can do a whole lot better.
>
> I also claim the same is true for every driver which still needs to do this
> type of mapping (which is a significant fraction of drivers for devices which
> have an intelligent processor core and multiple outstanding jobs with a
> non-predictable order of completion).
>
> Therefore, every driver that needs to do this today is using the least
> efficient method.  Further, they're all coding their own least efficient
> methods.
>
> If you can provide a reasoned counter argument to the above (preferably
> stripped of the invective periphrasis) I'm listening.


No problem.
Here is the FULL simple code from SYM-2 driver that perform the reverse
mapping (it is mostly the same in sym53c8xx):

/*
 *  A CCB hashed table is used to retrieve CCB address
 *  from DSA value.
 */
#define CCB_HASH_SHIFT		8
#define CCB_HASH_SIZE		(1UL << CCB_HASH_SHIFT)
#define CCB_HASH_MASK		(CCB_HASH_SIZE-1)
#if 1
#define CCB_HASH_CODE(dsa)	\
	(((dsa) >> (_LGRU16_(sizeof(struct sym_ccb)))) & CCB_HASH_MASK)
#else
#define CCB_HASH_CODE(dsa)	(((dsa) >> 9) & CCB_HASH_MASK)
#endif

--

	/*
	 *  Insert this ccb into the hashed list.
	 */
	hcode = CCB_HASH_CODE(cp->ccb_ba);
	cp->link_ccbh = np->ccbh[hcode];
	np->ccbh[hcode] = cp;

--

/*
 *  Look up a CCB from a DSA value.
 */
static ccb_p sym_ccb_from_dsa(hcb_p np, u32 dsa)
{
	int hcode;
	ccb_p cp;

	hcode = CCB_HASH_CODE(dsa);
	cp = np->ccbh[hcode];
	while (cp) {
		if (cp->ccb_ba == dsa)
			break;
		cp = cp->link_ccbh;
	}

	return cp;
}

--

No need to ever provide me with a patch that wants to use _any_ API for
that. It will obviously not be applied.

If there are candidates for using some API like the one your propose, it
will not be a problem for me. I just will not use it. It is as simple as
this. :-)

  Gérard.

