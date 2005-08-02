Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVHBTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVHBTSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVHBTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:18:53 -0400
Received: from gold.veritas.com ([143.127.12.110]:47174 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261713AbVHBTSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:18:52 -0400
Date: Tue, 2 Aug 2005 20:20:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Aug 2005 19:18:52.0078 (UTC) FILETIME=[04785CE0:01C59797]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Linus Torvalds wrote:
> On Tue, 2 Aug 2005, Hugh Dickins wrote:
> > 
> > It might not be so bad.  It's going to access the struct page anyway.
> > And clearing dirty from parent and child at fork time could save two
> > set_page_dirtys at exit time.  But I'm not sure that we could batch the
> > the dirty bit clearing into one TLB flush like we do the write protection.
> 
> Yes, good point. If the thing is still marked dirty in the TLB, some other 
> thread might be writing to the page after we've cleared dirty but before 
> we've flushed the TLB - causing the new dirty bit to be lost. I think.

Would that matter?  Yes, if vmscan sneaked in at some point while
page_table_lock is dropped, and wrote away the page with the earlier data.

But I was worrying about the reverse case, that we clear dirty, then
another thread sets it again before we emerge from copy_page_range,
so it gets left behind granting get_user_pages write permission.

Hmm, that implies that the other thread doesn't yet see wrprotect
(because we've not yet flushed TLB), which probably implies it would
still see dirty set: and so not set it again, so not a possible case.
But that's a precarious, processor-dependent argument: I don't think
it's safe to rely on, and your reverse case is already a problem.

I don't believe there's a safe efficient way we could batch clearing
dirty there.  We could make a second pass of the whole mm after the
flush TLB has asserted the wrprotects; but that won't win friends.

I'm thinking of reverting to the old __follow_page, setting write_access
-1 in the get_user_pages special case (to avoid change to all the arches,
in some of which write_access is a boolean, in some a bitflag, but in
none -1), and in that write_access -1 case passing back the special
code to say do_wp_page has done its full job.  Combining your and
Nick's and Andrew's ideas, and letting Martin off the hook.
Or would that disgust you too much?  (We could give -1 a pretty name ;)

Working on it now, but my brain in an even lower power state than ever.

Hugh
