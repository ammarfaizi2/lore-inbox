Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVCUXLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVCUXLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVCUXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:08:47 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:64195
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262185AbVCUXD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:03:27 -0500
Date: Mon, 21 Mar 2005 15:02:05 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050321150205.4af39064.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 14:31:36 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> Builds clean and boots on ia64.
> 
> I haven't tried any hugetlb operations on it though.

It works on ia64 because it doesn't actually do anything
in flush_tlb_pgtables(), I bet.

Hugh, I know the exact trigger case, it's unmapping a VMA
right before the stack segment.  So the free_pgtables() call
happens with this state:

prev->vm_end    == 0x70186000
next->vm_start  == 0xefab8000
vma->vm_start   == 0x70186000
vma->vm_end     == 0x70188000

(so we're doing munmap(0x70186000, PAGE_SIZE), the sparc64
 stack segment for 32-bit tasks grows down from 0xf0000000,
 the bottom of it is at 0xefab8000 at this point in time)

So the free_pgtables() call will be with:

floor   == 0x70186000
ceiling == 0xefab8000

This should be fairly simple, so let's analyze exactly what
happens:

1) vma == the munmap() call's VMA
   next == stack segment VMA, which sits right after "vma"
   addr == 0x70186000 (base of munmap() area)

2) VMA optimization loop runs:
      next->vm_start is 0xefab8000 
      vma->vm_end is 0x70188000
      on sparc64 PMD_SIZE is 1UL << 23 or 0x800000
      therefore vma->vm_end + (2 * PMD_SIZE) is 0x71188000
      this is much less than 0xefab8000 so the loop terminates
      immediately

    Therefore, next is unchanged.

3) free_pgd_range() is invoked with:
    addr    == 0x70186000
    end     == 0x70188000
    floor   == 0x70186000
    ceiling == 0xefab8000

4) We mask addr with PMD_MASK (which is 0xffffffffff800000)
   This sets addr to 0x70000000, which makes it less
   than floor, therefore addr has PMD_SIZE added to it.
   Now, addr is 0x70800000, this is the source of the
   problems as this value determines the "start" argument
   passed to flush_tlb_pgtables().  Note how it is larger
   than "end".

5) We also mask ceiling with PMD_MASK.
   This sets ceiling to 0xef800000.
   Now addr is less than or equal to ceiling - 1 so
   we continue.

6) start is set to addr, which as stated is 0x70800000,
   the free_pud_range() loop is executed

7) start is 0x70800000 and end is 0x70188000
   and here we have the problem that start > end,
   flush_tlb_pgtables() is called with the arguments
   like this and we trigger the aforementioned BUG().

This adjustment of addr relative to floor is very
strange, it can advance "addr" (and thus "start")
past the end of the VMA we are unmapping.

In fact, it is miraculious that this free_pud_range()
calling loop terminates properly!  Actually, it is
no mystery, since the next PGD address is the same
for both the original and adjusted value of "addr".
So the loop terminates after the first iteration.

Anyways, there's the full analysis, what do you make
of this Hugh? :-)
