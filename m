Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWIWSwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWIWSwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIWSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:52:09 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:22972 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751411AbWIWSwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:52:06 -0400
Date: Sat, 23 Sep 2006 19:51:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Yingchao Zhou <yc_zhou@ncic.ac.cn>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       alan <alan@redhat.com>, zxc <zxc@ncic.ac.cn>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
In-Reply-To: <450BAAF4.1080509@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609231835570.32262@blonde.wat.veritas.com>
References: <20060915033842.C205FFB045@ncic.ac.cn>
 <Pine.LNX.4.64.0609150514190.7397@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0609151431320.22674@blonde.wat.veritas.com>
 <450BAAF4.1080509@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 18:50:59.0120 (UTC) FILETIME=[3590FB00:01C6DF41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> 
> > Yes, it would be good if we could do that check in some other,
> > reliable way.  The problem is that can_share_swap_page has to
> > check page_mapcount (and PageSwapCache) and page_swapcount in
> > an atomic way: the page lock is what we have used to guard the
> > movement between mapcount and swapcount.
> > 
> > I'll try to think whether we can do that better,
> > but not until next week.

I currently believe we can do it without TestSetPageLocked in
do_wp_page(): just with a few memory barriers added.  But that
belief may evaporate once I actually focus on each site: it
wouldn't be the first time I've fooled myself like that, so
please keep on the alert, Nick.

> 
> I don't think TestSetPageLocked is the problem. Indeed you may be
> able to get around a few specific cases say, by turning that into
> a plain lock_page()...

Hmm, an actual lock_page, that wasn't what I was intending.
Would be simple, I'm trying to remember why I ruled it out earlier.
Oh, yes, we're holding the pte lock there, that's why.

> ... but the problem is still fundamentally COW.

Well, yes, we wouldn't have all these problems if we didn't have
to respect COW.  But generally a process can, one way or another,
make sure it won't get into those problems: Yingchao is concerned
with the way the TestSetPageLocked unpredictably upsets correctness.
I'd say it's a more serious error than the general problems with COW.

> 
> In other words, one should always be able to return 0 from that
> can_share_swap_page and have the system continue to work... right?
> Because even if you hadn't done that mprotect trick, you may still
> have a problem because the page may *have* to be copied on write
> if it is shared over fork.

Most processes won't fork, and exec has freed them from sharing
their parents pages, and their private file mappings aren't being
used as buffers.  Maybe Yingchao will later have to worry about
those cases, but for now it seems not.

> 
> So if we filled in the missing mm/ implementation of VM_DONTCOPY
> (and call it MAP_DONTCOPY rather than the confusing MAP_DONTFORK)
> such that it withstands such an mprotect sequence, we can then ask
> that all userspace drivers do their get_user_pages memory on these
> types of vmas.

(madvise MADV_DONTFORK)

For the longest time I couldn't understand you there at all, perhaps
distracted by your parenthetical line: at last I think you're proposing
we tweak mprotect to behave differently on a VM_DONTCOPY area.

But differently in what way?  Allow it to ignore Copy-On-Write?
No, of course not.  Go down to the struct page level (one of the
nice things about mprotect is that it doesn't need to look at struct
pages at present, except perhaps inside the ia64 lazy_mmu_prot_update),
and decide if it has to do the copying itself instead?  Doesn't sound
a good place to do it; and would involve just the same problematic
TestSetPageLocked within pte lock that do_wp_page is doing,
so wouldn't solve anything.

Or I'm still misunderstanding you.

Hugh
