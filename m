Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVCXM0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVCXM0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVCXM0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:26:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:54684 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262567AbVCXM0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:26:43 -0500
Date: Thu, 24 Mar 2005 13:26:37 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-ID: <20050324122637.GK895@wotan.suse.de>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 05:11:34PM +0000, Hugh Dickins wrote:
> Recent woes with some arches needing their own pgd_addr_end macro; and
> 4-level clear_page_range regression since 2.6.10's clear_page_tables;
> and its long-standing well-known inefficiency in searching throughout
> the higher-level page tables for those few entries to clear and free:
> all can be blamed on ignoring the list of vmas when we free page tables.
> 
> Replace exit_mmap's clear_page_range of the total user address space by
> free_pgtables operating on the mm's vma list; unmap_region use it in the
> same way, giving floor and ceiling beyond which it may not free tables.
> This brings lmbench fork/exec/sh numbers back to 2.6.10 (unless preempt
> is enabled, in which case latency fixes spoil unmap_vmas throughput).
> 
> Beware: the do_mmap_pgoff driver failure case must now use unmap_region
> instead of zap_page_range, since a page table might have been allocated,
> and can only be freed while it is touched by some vma.
> 
> Move free_pgtables from mmap.c to memory.c, where its lower levels are
> adapted from the clear_page_range levels.  (Most of free_pgtables' old
> code was actually for a non-existent case, prev not properly set up,
> dating from before hch gave us split_vma.)  Pass mmu_gather** in the
> public interfaces, since we might want to add latency lockdrops later;
> but no attempt to do so yet, going by vma should itself reduce latency.
> 
> But what if is_hugepage_only_range?  Those ia64 and ppc64 cases need
> careful examination: put that off until a later patch of the series.

Sorry for late answer. Nice approach.... It will not work as well
on large sparse mappings as the bit vectors, but that may be tolerable.

> 
> What of x86_64's 32bit vdso page __map_syscall32 maps outside any vma?

Everything. It could be easily changed though, but I was too lazy for 
it so far. Do you think it is needed for your patch?

-Andi
