Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTGADqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTGADqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:46:48 -0400
Received: from dp.samba.org ([66.70.73.150]:48348 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264030AbTGADqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:46:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ray Bryant <raybry@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang in 2.4.22-pre2 -- second try 
In-reply-to: Your message of "Mon, 30 Jun 2003 18:24:01 +0200."
             <3F006421.4090408@colorfullife.com> 
Date: Tue, 01 Jul 2003 11:17:44 +1000
Message-Id: <20030701040105.2BCE42C22E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F006421.4090408@colorfullife.com> you write:
> Rusty Russell wrote:
> 
> >2.5 has exactly the same issue: perhaps 2.4 should take this patch,
> >and 2.5 should try something better (I'd suggest trying the embedded
> >minitable approach).
>
> I tried it, but Linus didn't like the idea of on-stack minitables. The 
> patches are still at
> http://www.colorfullife.com/~manfred/Linux-Kernel/poll/

I wonder if he'd change his mind when presented with an apparently
random set_task_state() in __alloc_pages...

Linus?  See thread below: poll_wait is called with task state !=
TASK_RUNNING, but can do a yield on low memory, causing eternal hangs.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


In message <3EFC8AA8.7000501@sgi.com> you write:
>       The simplest fix (as suggested by Manfred Spraul) is to set
> current=>state to TASK_RUNNING just before the call to yield() in
> __alloc_pages().  I have tested this sufficiently that I believe
> this does not change the user level semantics of select() (my
> concern was that if state got set to TASK_RUNNING that the syscall
> could return before any fd's are ready or the select() timeout has
> expired, but this does not appear to be the case).

Horrible problem.  Solution presented is icky, and at the *very* least
needs a comment about its relationship to poll.

More logical would be to have the set_task_state() before
__get_free_page() inside __pollwait, but that will cause every poll to
spin once, killing performance.  Allocating the first page up front
(inside do_pollfd and do_select) would help that, but slow down the
case where normally no alloc is needed, which might be common.  Having
a small first table inside the poll_table itself would work, but the
POLL_TABLE_FULL() macro then gets more complicated.

2.5 has exactly the same issue: perhaps 2.4 should take this patch,
and 2.5 should try something better (I'd suggest trying the embedded
minitable approach).

Anyway, my point is that it's not suitable for the Trivial Patch
Monkey 8)

> Here is a trivial patch against 2.4.22-pre2:
> 
> --- linux-2.4.22-pre2.orig/mm/page_alloc.c      Thu Nov 28 17:53:15 2002
> +++ linux-2.4.22-pre2/mm/page_alloc.c   Fri Jun 27 13:47:49 2003
> @@ -418,6 +418,7 @@
>                  return NULL;
> 
>          /* Yield for kswapd, and try again */
> +        set_current_state(TASK_RUNNING);
>          yield();
>          goto rebalance;
>   }

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
