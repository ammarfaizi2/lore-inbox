Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUDDJHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUDDJHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 05:07:24 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28357 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262266AbUDDJHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 05:07:22 -0400
Date: Sun, 4 Apr 2004 05:07:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.6-mm] setup_identity_mappings depends on zone init.
In-Reply-To: <20040315205201.7699e1c1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404040437190.16677@montezuma.fsmlabs.com>
References: <20040310233140.3ce99610.akpm@osdl.org>
 <16465.3163.999977.302378@notabene.cse.unsw.edu.au> <20040311172244.3ae0587f.akpm@osdl.org>
 <16465.20264.563965.518274@notabene.cse.unsw.edu.au> <20040311235009.212d69f2.akpm@osdl.org>
 <16466.57738.590102.717396@notabene.cse.unsw.edu.au>
 <16469.2797.130561.885788@notabene.cse.unsw.edu.au> <20040315091843.GA21587@elte.hu>
 <16470.22982.831048.924954@notabene.cse.unsw.edu.au> <20040315205201.7699e1c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Andrew Morton wrote:

> Calling page_address_init() earlier isn't the fix though - pmd pages aren't
> in highmem so we should never have got that far.  Looks like the pgd or the
> pmd page contains garbage.  Did you try it without CONFIG_DEBUG_SLAB?
>
> Nick was seeing slab 0x6b patterns on the NUMAQ, inside the pmd, so there's
> some consistency there.  We do have one early setup fix from Manfred, but
> it's unlikely to cure this.
>
> I'll have a play with your .config, see if I can reproduce it.  If not I'll
> squeeze off -mm3 and would ask you to retest on that if poss.

I spent a bit of time on this today, and the problem appears to be that we haven't
done mem_map or zone initialisation, so mem_map[pfn]->flags is also wrong
(e.g. PG_highmem tests). This is still triple faulting on 2.6.5-rc3-mm4 on my
boxes. CONFIG_HIGHMEM and any setup without 4MB pages should do it. The
following patch got an approving nod from Bill.

Index: linux-2.6.5-rc3-mm4/arch/i386/mm/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc3-mm4/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.5-rc3-mm4/arch/i386/mm/init.c	2 Apr 2004 03:55:20 -0000	1.1.1.1
+++ linux-2.6.5-rc3-mm4/arch/i386/mm/init.c	4 Apr 2004 09:04:48 -0000
@@ -206,7 +206,7 @@ void setup_identity_mappings(pgd_t *pgd_
 			if (!pmd_present(*pmd))
 				pte_base = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 			else
-				pte_base = (pte_t *) page_address(pmd_page(*pmd));
+				pte_base = (pte_t *) pmd_page_kernel(*pmd);
 			pte = pte_base;
 			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
 				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
