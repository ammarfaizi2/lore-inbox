Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVISUOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVISUOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVISUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:14:48 -0400
Received: from gold.veritas.com ([143.127.12.110]:43168 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932617AbVISUOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:14:48 -0400
Date: Mon, 19 Sep 2005 21:14:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Smarduch Mario-CMS063 <CMS063@motorola.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <Pine.LNX.4.58.0509191216050.2553@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0509192106460.25004@goblin.wat.veritas.com>
References: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
 <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509191216050.2553@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Sep 2005 20:14:41.0907 (UTC) FILETIME=[C4F3B430:01C5BD56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Linus Torvalds wrote:
> 
> We hold the page_table_lock when doing the fork(), so T2 can't actually be 
> copying the page until we've done the TLB flush, no? And once the TLB 
> flush is done, all the writes by T3 should be in the page, so we copy the 
> right thing at that point, and there is no consistency problems?

I was totally overlooking the page_table_lock during the fork.

But no matter, it's not good enough: src_mm->page_table_lock is acquired
and dropped at the inner level, in copy_pte_range (looking at latest 2.6):
it cannot be held across allocating page tables for dst_mm.

So each time T1 drops it, there's a window for the T2 vs. T3 problem.
Yet we don't much want to flush TLB each time we leave copy_pte_range.

Hugh
