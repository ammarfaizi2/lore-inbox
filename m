Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVCVWp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVCVWp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCVWp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:45:27 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:58603
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261734AbVCVWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:43:36 -0500
Date: Tue, 22 Mar 2005 14:41:51 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322144151.5b08b047.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 21:51:39 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> I still can't see what's wrong with the code that's already
> there.  My brain is seizing up, I'm taking a break.

Ok, meanwhile I'll do a brain dump of what I think this
code should be doing.

Let's take an example free_pgd_range() call.  Say the
address parameters are:

addr	0x10000
end	0xa4000
floor	0x00000
ceiling	0xb2000

(This example comes from my exit_mmap() VMA dump earlier
 in this thread.  If you disable the VMA skipping optimization
 the first call to free_pgd_range() has these parameters.)

What ought this free_pgd_range() call do?  This range of
addresses, from floor to ceiling, is smaller than a PMD_SIZE
(which on sparc64 is 1 << 23).  Therefore it should clear
no PGD or PUD entries.

Yet, it does clear them, specifically:

free_pgd_range():
	1) mask addr (0x10000) to PMD_MASK, addr is now 0
	2) addr < floor (0x00000) test does not pass
	3) mask ceiling (0xb2000) to PMD_MASK, ceiling is now 0 too
	4) end - 1 > ceiling - 1 test does not pass
	5) addr > end - 1 test does not pass either
	6) We now loop one PGDIR_SIZE at a time from
           addr (0x00000) to end (0xa4000), calling
	   down into...
free_pud_range():
	1) addr=0, end=0xa4000, floor=0, ceiling=0
	2) We loop one PUD_SIZE at a time from
	   addr (0x00000) to end (0xa4000), calling
	   down into...
free_pmd_range():
	1) addr=0, end=0xa4000, floor=0, ceiling=0
	2) We loop one PMD_SIZE at a time from
	   addr (0x00000) to end (0xa4000), calling
	   down into...
free_pte_range():

And later when we finish the loops in free_pmd_range()
and free_pud_range() we do pud_clear() and pgd_clear()
respectively, both wrong.

The source of the problems seems to be how ceiling began
at the top of the call chain as 0xb2000, but when we
masked it with PMD_MASK that set it to zero, which means
"top of address space" in these functions.  That's not
what we want.

I added a quick hack to the simulator I posted, where
we mask ceiling in free_pgd_range(), I do it like this:

	if (ceiling) {
		ceiling &= PMD_MASK;
		if (!ceiling)
			return;
	}

and things seem to behave.  I'll try to analyze things
further and test this out on a real kernel, but all of
these adjustments at the top of free_pgd_range() really
start to look like pure spaghetti. :-)
