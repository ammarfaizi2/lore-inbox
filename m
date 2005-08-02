Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVHBTzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVHBTzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVHBTzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:55:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbVHBTzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:55:49 -0400
Date: Tue, 2 Aug 2005 12:54:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Hugh Dickins wrote:
> > 
> > Yes, good point. If the thing is still marked dirty in the TLB, some other 
> > thread might be writing to the page after we've cleared dirty but before 
> > we've flushed the TLB - causing the new dirty bit to be lost. I think.
> 
> Would that matter?  Yes, if vmscan sneaked in at some point while
> page_table_lock is dropped, and wrote away the page with the earlier data.

Right.

> But I was worrying about the reverse case, that we clear dirty, then
> another thread sets it again before we emerge from copy_page_range,
> so it gets left behind granting get_user_pages write permission.

Hmm.. At least x86 won't do that - the dirty bits are updated with an 
atomic read-modify-write sequence that only sets the dirty bit. We won't 
get a writable page somehow.

But the lost dirty bit is nasty.

> I don't believe there's a safe efficient way we could batch clearing
> dirty there. 

Well, there is one really cheap one: look at how many users the VM has.

The thing is, fork() from a threaded environment is simply not done, so we 
could easily have a "slow and careful mode" for the thread case, and 
nobody would probably ever care. 

Whether its worth it, I dunno. It might actually speed up the fork/exit
cases, so it might be worth looking at for that reason.

> I'm thinking of reverting to the old __follow_page, setting write_access
> -1 in the get_user_pages special case (to avoid change to all the arches,
> in some of which write_access is a boolean, in some a bitflag, but in
> none -1), and in that write_access -1 case passing back the special
> code to say do_wp_page has done its full job.  Combining your and
> Nick's and Andrew's ideas, and letting Martin off the hook.
> Or would that disgust you too much?  (We could give -1 a pretty name ;)

Go for it, I think whatever we do won't be wonderfully pretty.

		Linus
