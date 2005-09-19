Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbVISUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbVISUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVISUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:39:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932624AbVISUjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:39:55 -0400
Date: Mon, 19 Sep 2005 13:39:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Smarduch Mario-CMS063 <CMS063@motorola.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <Pine.LNX.4.61.0509192106460.25004@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0509191327160.2553@g5.osdl.org>
References: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
 <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509191216050.2553@g5.osdl.org>
 <Pine.LNX.4.61.0509192106460.25004@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, Hugh Dickins wrote:
> 
> I was totally overlooking the page_table_lock during the fork.
> 
> But no matter, it's not good enough: src_mm->page_table_lock is acquired
> and dropped at the inner level, in copy_pte_range (looking at latest 2.6):
> it cannot be held across allocating page tables for dst_mm.
> 
> So each time T1 drops it, there's a window for the T2 vs. T3 problem.
> Yet we don't much want to flush TLB each time we leave copy_pte_range.

Hmm. But we do hold the mmap_sem for writing, and we flush before we 
release it, so it should still be ok. The page fault case needs to get it 
for reading anyway.

Yeah, the page_table_lock might make more sense, but I think the mmap_sem 
thing works equally well.

			Linus
