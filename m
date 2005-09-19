Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVISUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVISUex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVISUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:34:53 -0400
Received: from motgate3.mot.com ([144.189.100.103]:35831 "EHLO
	motgate3.mot.com") by vger.kernel.org with ESMTP id S932627AbVISUex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:34:53 -0400
Message-ID: <A752C16E6296D711942200065BFCB6942521C7C3@il02exm10>
From: Smarduch Mario-CMS063 <CMS063@motorola.com>
To: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
Date: Mon, 19 Sep 2005 15:34:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_sem is also acquired in 2.4 properly. 
It seemed a little bit too obvious.
Thanks for your help!

	- mario

-----Original Message-----
From: Hugh Dickins [mailto:hugh@veritas.com] 
Sent: Monday, September 19, 2005 3:14 PM
To: Linus Torvalds
Cc: Smarduch Mario-CMS063; linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6

On Mon, 19 Sep 2005, Linus Torvalds wrote:
> 
> We hold the page_table_lock when doing the fork(), so T2 can't 
> actually be copying the page until we've done the TLB flush, no? And 
> once the TLB flush is done, all the writes by T3 should be in the 
> page, so we copy the right thing at that point, and there is no consistency problems?

I was totally overlooking the page_table_lock during the fork.

But no matter, it's not good enough: src_mm->page_table_lock is acquired and dropped at the inner level, in copy_pte_range (looking at latest 2.6):
it cannot be held across allocating page tables for dst_mm.

So each time T1 drops it, there's a window for the T2 vs. T3 problem.
Yet we don't much want to flush TLB each time we leave copy_pte_range.

Hugh
