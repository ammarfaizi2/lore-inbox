Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbSIPQcb>; Mon, 16 Sep 2002 12:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSIPQcb>; Mon, 16 Sep 2002 12:32:31 -0400
Received: from h-64-105-136-15.SNVACAID.covad.net ([64.105.136.15]:10114 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262608AbSIPQc3>; Mon, 16 Sep 2002 12:32:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 16 Sep 2002 09:36:15 -0700
Message-Id: <200209161636.JAA02714@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, spstarr@sh0n.net, venom@sns.it
Subject: Re: BUG(): sched.c: Line 944 - 2.5.35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:

>Kernel 2.5.35:
>
>code resides in main schedule() function:
>
>if (unlikely(in_atomic()))
>   BUG();


	That line prevously checked in_interrupt (in 2.5.34) instead of
in_atomic.  If you have CONFIG_PREEMPT defined, the definition of in_atomic
in linux-2.5.35/include/asm-i386/hardirq.h is:

# define in_atomic()    (preempt_count() != kernel_locked())

	When I see this problem at boot, preempt_count() returns 0x4000000
(PREEMPT_ACTIVE) and kernel_locked() returns 0.

	I don't understand the semantics of PREEMPT_ACTIVE to know
whether to

	(1) change the test back to using in_interrupt instead of in_atomic, or
	(2) change the definition of in_atomic(), or
	(3) look for a bug somewhere else.

	However, I know experimentally that changing the test back to
using in_interrupt() results in a possibly unrelated BUG() at line 279
of rmap.c:

void page_remove_rmap(struct page * page, pte_t * ptep)
{
        pte_addr_t pte_paddr = ptep_to_paddr(ptep);
        struct pte_chain *pc;

        if (!page || !ptep)
                BUG();
        if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
                return;

        pte_chain_lock(page);

        BUG_ON(page->pte.direct == 0);



Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
