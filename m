Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVIMPyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVIMPyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVIMPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:54:22 -0400
Received: from silver.veritas.com ([143.127.12.111]:49494 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964815AbVIMPyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:54:21 -0400
Date: Tue, 13 Sep 2005 16:54:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: ARCH_FREE_PTE_NR 5350
Message-ID: <Pine.LNX.4.61.0509131631140.16498@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Sep 2005 15:54:20.0355 (UTC) FILETIME=[674D8930:01C5B87B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I'm mightily puzzled by your ARCH_FREE_PTE_NR 5350 TLB flush speedup
in 2.6.14-rc1.

Partly because all the PTE->PTR typos in include/asm-generic/tlb.h

  #ifdef ARCH_FREE_PTR_NR
    #define FREE_PTR_NR   ARCH_FREE_PTR_NR
  #else

make it do nothing at all.

And partly because mm/memory.c unmap_vmas() is still using:

#ifdef CONFIG_PREEMPT
# define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
#else
/* No preempt: go for improved straight-line efficiency */
# define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
#endif

which would make most of your increase just a waste of space.

Yes, it's long been wrong for ZAP_BLOCK_SIZE to be disconnected
from FREE_PTE_NR.  And there's a serious conflict here between the low
latency people (who don't like thousands of pages freed with preemption
disabled) and the high throughput people (who don't like the terrible
drop that ZAP_BLOCK_SIZE is imposing).

I do think we need to sort this out, but maybe wait until after I've
done my page_table_lock changes - which do change the picture here
(the lock is taken lower down), but not solve it (per-cpu mmu_gather
still needs preemption disabled).

Hugh
