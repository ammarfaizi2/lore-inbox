Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTBTSRc>; Thu, 20 Feb 2003 13:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTBTSRb>; Thu, 20 Feb 2003 13:17:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20239 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266735AbTBTSQp>; Thu, 20 Feb 2003 13:16:45 -0500
Date: Thu, 20 Feb 2003 10:23:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302200949520.1385-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201015150.1589-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:
> 
> In other words, I think we need to have schedule_tail() do the 
> release_task(), otherwise we'd release it too early while the task 
> structure (and the stack) are both still in use.

Well, it's not "schedule_tail()" any more, since that is no longer called 
by the normal schedule end-path.

Test suggestion:

 - remove the 

        if (tsk->exit_signal == -1)
                release_task(tsk);

   from kernel/exit.c

 - make "finish_switch()" something like

	static void inline finish_switch(struct runqueue *rq, struct task_struct *prev)
	{
		finish_arch_switch(rp, prev);
		if ((prev->state & TASK_ZOMBIE) && (prev->exit_signal == -1))
			release_task(prev);
	}

 - make all of "kernel/sched.c" use "finish_switch()" instead of 
   "finish_arch_switch()" (ie replace it in both schedule_tail() and the
   end of schedule() itself).

At some point we can think about trying to speed up that test for 
release_task(), ie add some extra task-state or something that is set in 
kernel/exit.c so that we don't slow down the task switching unnecessarily.

How does this sound?

Also, for debugging, how about this simple (but expensive) debugging thing
that only works without HIGHMEM (and is obviously whitespace-damaged due
to indenting it):

	--- 1.148/mm/page_alloc.c	Wed Feb  5 20:05:13 2003
	+++ edited/mm/page_alloc.c	Thu Feb 20 10:22:42 2003
	@@ -685,6 +685,7 @@
	 void __free_pages(struct page *page, unsigned int order)
	 {
	 	if (!PageReserved(page) && put_page_testzero(page)) {
	+		memset(page_address(page), 0x01, PAGE_SIZE << order);
	 		if (order == 0)
	 			free_hot_page(page);
	 		else

which should show the effects of a buggy "release_task()" much more 
consistently.

Ehh?

		Linus

