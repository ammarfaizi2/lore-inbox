Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBPQXi>; Fri, 16 Feb 2001 11:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBPQX1>; Fri, 16 Feb 2001 11:23:27 -0500
Received: from colorfullife.com ([216.156.138.34]:26895 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129159AbRBPQXQ>;
	Fri, 16 Feb 2001 11:23:16 -0500
Message-ID: <3A8D540C.92C66398@colorfullife.com>
Date: Fri, 16 Feb 2001 17:23:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> And how does that lose a dirty bit?
> 
> For the other processor to not write a dirty bit, it must have a dirty
                            ^^^^^^^^^^^
> TLB entry already which, along with the locked cycle in
> ptep_get_and_clear, means that `entry' will have _PAGE_DIRTY set.  The
> dirty bit is not lost.
> 
The other cpu writes the dirty bit - we just overwrite it ;-)
After the ptep_get_and_clear(), before the set_pte().

The current assumption about the page dirty logic is:
A cpu that has a writable, non-dirty pte cached in its tlb it may
unconditionally set the dirty bit - without honoring present or write
protected bits.

--> set_pte() can either loose a dirty bit or a 'pte_none() entry' could
suddenly become a swap entry unless it's guaranteed that no cpus has a
cached valid tlb entry.

Linus, does the proposed pte gather code handle the second part?
pte_none() suddenly becomes 0x0040.

Back to the current mprotect.c code:

pte is writable, not-dirty.

cpu1:
has a writable, non-dirty pte in it's tlb.
		cpu 2: in mprotect.c
	        entry = ptep_get_and_clear(pte);
		* pte now clear.
		* entry contains the pte value without
		  the dirty bit
cpu decodes a write instruction, and dirties the pte.
lock; orl DIRTY_BIT, *pte
	        set_pte(pte, pte_modify(entry, newprot));
		* pte overwritten with entry.

--> dirty bit lost.

--
	Manfred
