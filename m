Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCCMut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCCMut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCCMut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:50:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12982 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261575AbVCCMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:49:16 -0500
Date: Thu, 3 Mar 2005 12:48:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mauricio Lin <mauriciolin@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] A new entry for /proc
In-Reply-To: <3f250c710503022325af22974@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503031151180.8280@goblin.wat.veritas.com>
References: <20050106202339.4f9ba479.akpm@osdl.org> 
    <3f250c7105022507146b4794f1@mail.gmail.com> 
    <3f250c71050228014355797bd8@mail.gmail.com> 
    <3f250c7105022801564a0d0e13@mail.gmail.com> 
    <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com> 
    <3f250c7105030100085ab86bd2@mail.gmail.com> 
    <3f250c710503010617537a3ca@mail.gmail.com> 
    <3f250c710503010744390391e2@mail.gmail.com> 
    <3f250c71050302042059f36525@mail.gmail.com> 
    <Pine.LNX.4.61.0503021858330.5183@goblin.wat.veritas.com> 
    <3f250c710503022325af22974@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Mauricio Lin wrote:
> 
> How about map an unmap each pte?
> 
> I mean remove the pte++ and use pte_offset_map for each incremented
> address and then pte_unmap. So each incremented address is an index to
> get the next pte via pte_offset_map.

We're going round in circles.

No.  Why would you want to do it that way?  Much less efficient.
Mapping and unmapping is expensive - why else would a processor
have a TLB, but to batch these operations?

But probably you're testing without CONFIG_HIGHPTE, with less than
2GB of memory, in which case you'd be unlikely to notice any effect.
(There's highmem in 1GB, but perhaps not enough to rely on the page
tables coming from highmem often enough to show the slowdown.)

When working in an unfamiliar area, follow the example of existing
code which has to do the same kind of thing - various examples in
mm/memory.c and other mm files.  (But don't be surprised if they
change in a little while: rewrite coming to get them all in synch.)

The only reason to contemplate mapping one pte at a time is latency:
the per-cpu mapping which pte_offset_map uses means that preemption
must be disabled until it's unmapped, which may cause bad latency.

zap_pte_range is common and has a lot of work to do, involving the
struct page for each pte, so unmap_vmas divides the work into
ZAP_BLOCK_SIZE pieces.  Whereas mprotect's change_pte_range is
much more like your case, and just does a whole page table at once.

If you look at those examples, you'll notice spin_lock is held on
page_table_lock, which seems to be missing from your code.  You
should add it in: since you're only reading, and your counts are
not critical, on most architectures you'll be safe without the
page_table_lock; but on a few, I suspect it _might_ be possible
to crash the kernel in rare transitory cases without it: be safe.

Hugh
