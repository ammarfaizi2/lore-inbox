Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbRBPRMO>; Fri, 16 Feb 2001 12:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129580AbRBPRMF>; Fri, 16 Feb 2001 12:12:05 -0500
Received: from colorfullife.com ([216.156.138.34]:34063 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129322AbRBPRLt>;
	Fri, 16 Feb 2001 12:11:49 -0500
Message-ID: <3A8D5F6C.D81F2F28@colorfullife.com>
Date: Fri, 16 Feb 2001 18:12:12 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com> <20010216174316.A4500@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Manfred Spraul wrote:
> > The other cpu writes the dirty bit - we just overwrite it ;-)
> > After the ptep_get_and_clear(), before the set_pte().
> 
> Ah, I see.  The other CPU does an atomic *pte |= _PAGE_DIRTY, without
> checking the present bit.  ('scuse me for temporary brain failure).
> 
> How about a pragmatic solution.
>
Ok, Is there one case were your pragmatic solutions is vastly faster?

* mprotect: No. The difference is at most one additional locked
instruction for each pte.

* munmap(anon): No. We must handle delayed accessed anyway (don't call
free_pages_ok() until flush_tlb_ipi returned). The difference is that we
might have to perform a second pass to clear any spurious 0x40 bits.

* munmap(file): No. Second pass required for correct msync behaviour.

* try_to_swap_out(): No. another memory read.

Any other cases?
> 
> Ben, fancy writing a boot-time test?
> 
I'd never rely on such a test - what if the cpu checks in 99% of the
cases, but doesn't handle some cases ('rep movd, everything unaligned,
...'. And check the Pentium III erratas. There is one with the tlb
that's only triggered if 4 instruction lie in a certain window and all
access memory in the same way of the tlb (EFLAGS incorrect if 'andl
mask,<memory_addr>' causes page fault)).

--
	Manfred
