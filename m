Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVCVVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVCVVzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVCVVyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:54:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:3042 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262064AbVCVVwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:52:32 -0500
Date: Tue, 22 Mar 2005 21:51:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050322123301.090cbfa6.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050322034053.311b10e6.akpm@osdl.org> 
    <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com> 
    <20050322110144.3a3002d9.davem@davemloft.net> 
    <20050322112125.0330c4ee.davem@davemloft.net> 
    <20050322112329.70bde057.davem@davemloft.net> 
    <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com> 
    <20050322123301.090cbfa6.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, David S. Miller wrote:
> On Tue, 22 Mar 2005 19:36:46 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I notice that although both i386 and sparc64 use pgtable-nopud.h, the
> > i386 pud_clear does nothing at all and the sparc64 pud_clear resets to 0.
> 
> This was a dead end.  I386 doesn't do anything with pud_clear() in
> order to work around a chip erratum.
> 
> IA64 does clear in pud_clear() just like sparc64.

My mind kept flipping back and forth on whether it was pud_clear().
I agree, I can't see that it's the issue now.

> I think it's the floor/ceiling stuff.
> 
> At that pud_clear(), we do it if floor-->ceiling (after masking)
> covers the whole PUD.  Not whether start/end do, which is what
> the code sort of does right now.

Not an explanation I understood ;)

> "start" and "end" say which specific entries we might be purging.

Yes.

> "floor" and "ceiling" say that once that purging is done, the
> extent of the potential address space freed.

Well, they specify the limits beyond which we cannot free,
because there's other stuff still making use of addresses beyond.

> I cooked up a quick patch that changes the logic to:
> 
> 	floor &= PUD_MASK;
> 	ceiling &= PUD_MASK;
> 	if (floor - 1 >= ceiling - 1)
> 		return;

That can't be right.  In exit_mmap, for example, floor will be 0
throughout, and the condition will be true for all values of ceiling.

> 	pmd = pmd_offset(pud, start);
> 	pud_clear(pud);
> 	pmd_free_tlb(tlb, pmd);
> 
> and things start to basically work.

Because none of your higher level tables are being freed at all:
eventually you'll run out of memory.

I still can't see what's wrong with the code that's already
there.  My brain is seizing up, I'm taking a break.

Hugh
