Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSEILeK>; Thu, 9 May 2002 07:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSEILeJ>; Thu, 9 May 2002 07:34:09 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:38023 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S315717AbSEILeH>;
	Thu, 9 May 2002 07:34:07 -0400
Message-ID: <3CDA5EA4.E565F1D7@colorfullife.com>
Date: Thu, 09 May 2002 13:33:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Dave Engebretsen <engebret@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>
> An example of where these primitives get us into trouble is the use of
> wmb() to order two stores which are only to system memory (where a
> lwsync would do for ppc64) and for a store to system memory followed by
> a store to I/O (many examples in drivers).
>
2 questions:

1) Does that only affect memory barriers, or both memory barriers and
spinlocks?

example (from drivers/net/natsemi.c)

cpu0:
	spin_lock(&lock);
	writew(1, ioaddr+PGSEL);
	...
	writew(0, ioaddr+PGSEL);
	spin_unlock(&lock);

cpu1:
	spin_lock(&lock);
	readw(ioaddr+whatever);	// assumes that the register window is 0.

writew(1, ioaddr+PGSEL) selects a register window of the NIC. Are writew
and the spinlock synchonized on ppc64?

2) when you write "system memory", is that memory allocated with
kmalloc/gfp, or also memory allocated with pci_alloc_consistent()?

I've always assumed that
	pci_alloc_consistent_ptr->data=0;
	writew(0, ioaddr+TRIGGER);

is ordered, i.e. the memory write happens before the writew. Is that
guaranteed?

--
	Manfred
