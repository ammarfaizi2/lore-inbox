Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSEITjB>; Thu, 9 May 2002 15:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314242AbSEITjB>; Thu, 9 May 2002 15:39:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11249 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314241AbSEITjA>;
	Thu, 9 May 2002 15:39:00 -0400
Message-ID: <3CDAD03F.45DC911C@vnet.ibm.com>
Date: Thu, 09 May 2002 14:38:39 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
In-Reply-To: <3CDA5EA4.E565F1D7@colorfullife.com>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/09/2002 02:38:43 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/09/2002 02:38:45 PM,
	Serialize complete at 05/09/2002 02:38:45 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> 
> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
> 
> >
> > An example of where these primitives get us into trouble is the use of
> > wmb() to order two stores which are only to system memory (where a
> > lwsync would do for ppc64) and for a store to system memory followed by
> > a store to I/O (many examples in drivers).
> >
> 2 questions:
> 
> 1) Does that only affect memory barriers, or both memory barriers and
> spinlocks?
> 
> example (from drivers/net/natsemi.c)
> 
> cpu0:
>         spin_lock(&lock);
>         writew(1, ioaddr+PGSEL);
>         ...
>         writew(0, ioaddr+PGSEL);
>         spin_unlock(&lock);
> 
> cpu1:
>         spin_lock(&lock);
>         readw(ioaddr+whatever); // assumes that the register window is 0.
> 
> writew(1, ioaddr+PGSEL) selects a register window of the NIC. Are writew
> and the spinlock synchonized on ppc64?

This is an interesting example.  As the implementation stands today, for
this specific example, we are ok because the spin_lock/unlock pair
provides ordering within system memory access pairs OR i/o space pairs. 
Not across the types (we do not use the heavy weight sync).  So if there
are examples where the spin lock is meant to protect system memory
access to i/o space, we are in trouble.

> 2) when you write "system memory", is that memory allocated with
> kmalloc/gfp, or also memory allocated with pci_alloc_consistent()?
> 
> I've always assumed that
>         pci_alloc_consistent_ptr->data=0;
>         writew(0, ioaddr+TRIGGER);
> 
> is ordered, i.e. the memory write happens before the writew. Is that
> guaranteed?
> 

It is not guaranteed on all systems (PowerPC being an example). 
pci_alloc_consistent allocted storage is just normal system memory that
happens to be mapped to a PCI bus for DMA access.

Your example would fail, and in fact is basically what has been observed
to fail on Power4.  

What is needed is:

pci_alloc_consistent_ptr->data = 0;
wmb();
writew(0, ioaddr+TRIGGER);

This code also was observed to fail, when wmb() = eieio, which does not
order system memory accesses to I/O space accesses.

At present, we have worked around this by doing a heavy 'sync' before
and after writew and its ilk.  The point of my initial questions though
is that this fix is not exactly optimal :(

Dave.
