Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129317AbRBPO7J>; Fri, 16 Feb 2001 09:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRBPO67>; Fri, 16 Feb 2001 09:58:59 -0500
Received: from colorfullife.com ([216.156.138.34]:12047 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129317AbRBPO6w>;
	Fri, 16 Feb 2001 09:58:52 -0500
Message-ID: <3A8D4045.F8F27782@colorfullife.com>
Date: Fri, 16 Feb 2001 15:59:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Linus Torvalds wrote:
> > So the only case that ends up being fairly heavy may be a case that is
> > very uncommon in practice (only for unmapping shared mappings in
> > threaded programs or the lazy TLB case).
>
The lazy tlb case is quite fast: lazy tlb thread never write to user
space pages, we don't need to protect the dirty bits. And the first ipi
clears mm->cpu_vm_mask, only one ipi.
>
> I can think of one case where performance is considered quite important:
> mprotect() is used by several garbage collectors, including threaded
> ones.  Maybe mprotect() isn't the best primitive for those anyway, but
> it's what they have to work with atm.
>

Does mprotect() actually care for wrong dirty bits?
The race should be invisible to user space apps.

>>>>>>> mprotect()
for_all_affected_ptes() {
	lock andl ~PERMISSION_MASK, *pte;
	lock orl new_permission, *pte;
}
< now anther cpu could still write to the write protected pages
< and set the dirty bit, but who cares? Shouldn't be a problem.
flush_tlb_range().
< tlb flush before ending the syscall, user space can't notice
< the delay.
<<<<

--
	Manfred
