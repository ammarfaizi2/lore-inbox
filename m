Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbRAUSAv>; Sun, 21 Jan 2001 13:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbRAUSAl>; Sun, 21 Jan 2001 13:00:41 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:31504 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130696AbRAUSAV>;
	Sun, 21 Jan 2001 13:00:21 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101211800.VAA27435@ms2.inr.ac.ru>
Subject: Re: Is sendfile all that sexy?
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 21 Jan 2001 21:00:05 +0300 (MSK)
Cc: zippel@fh-brandenburg.de, mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101201612240.10849-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 20, 1 04:25:45 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> "struct page" tricks, some macros etc WILL NOT WORK. In particular, we do
> not currently have a good "page_to_bus/phys()" function. That means that
> anybody trying to do DMA to this page is currently screwed, simply because
> he has no good way of getting the physical address.

We already have similar problem with 64bit dma on Intel.
Namely, we need page_to_bus() and, moreover, we need 64bit bus addresses
for devices understanding them.

Now we make this in acenic like:

#if defined(CONFIG_X86) && defined(CONFIG_HIGHMEM)

#define BITS_PER_DMAADDR 64

typedef unsigned long long dmaaddr_high_t;

static inline dmaaddr_high_t
pci_map_single_high(struct pci_dev *hwdev, struct page *page,
		    int offset, size_t size, int dir)
{
	dmaaddr_high_t phys;

	phys = (page-mem_map) *
		(unsigned long long) PAGE_SIZE +
			offset;

	return phys;
}

#else


Ingo, do you remember, that we agreed not to consider this code
as "ready for release" until this issue is not cleaned up?
I forgot this. 8)8)8)

Seems, we can remove at least direct dependencies on mem_map
using zone_struct.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
