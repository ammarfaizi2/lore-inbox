Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBLPnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBLPnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVBLPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 10:43:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21858 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261154AbVBLPnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 10:43:04 -0500
Date: Sat, 12 Feb 2005 15:42:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard F. Rebel" <rrebel@whenu.com>
cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
In-Reply-To: <1108219160.12693.184.camel@blue.obulous.org>
Message-ID: <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com> 
    <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com> 
    <1108219160.12693.184.camel@blue.obulous.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2005, Richard F. Rebel wrote:
> 
> That said, many mod_perl users are *VERY* interested in being able to
> detect and observe how "shared" our forked children are.  Shared meaning
> private pages shared with children (copy on write).  Is it even possible
> to do this in 2.6 kernels?  If so, any pointers would be very helpful.

Not in any of the vanilla kernels.

Mauricio has a /proc/<pid>/smaps patch, in which he returns to looking
at every pte slot of every vma of the process as /proc/<pid>/statm did
in 2.4.  I suggest you ask him offline for his latest version (the last
I saw did not include support for 2.6.11's pud level; and looped in an
inefficient way, repeatedly locating, mapping and unmapping the page
table for each pte slot - needs refactoring into pgd_range, pud_range,
pmd_range, pte_range levels like 2.4's statm).

It wouldn't be hard to take his framework (before or after improvements),
or the 2.4 proc_pid_statm framework, and modify that to give you the
information you're looking for.  But I doubt that the resulting patch
would be accepted into a vanilla kernel - there's no end to the kinds
of numbers that different people might want to see.

I wonder how important swapping is in your case.  If it's an
exceptional case that you can ignore, then a "private shared"
entry would be identified by code something like:

	if (pte_present(pte)) {
		pfn = pte_pfn(pte);
		if (pfn_valid(pfn)) {
			page = pfn_to_page(pfn);
			if (PageAnon(page) && page_mapcount(page) > 1)
				private_shared++;
		}
	}

But if swap use is significant, then it gets rather more complicated:
a present page, even when its mapcount is 1, might still be shared with
other processes, from which which the pte has been unmapped; and where
the pte is not present, there may be a swap entry shared with others.
It can be worked out, but awkward and more than a few lines of code.

Hugh
