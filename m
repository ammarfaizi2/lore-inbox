Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbTGAFDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbTGAFDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:03:04 -0400
Received: from dp.samba.org ([66.70.73.150]:43649 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265973AbTGAFDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:03:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang in 2.4.22-pre2 -- second try 
In-reply-to: Your message of "Mon, 30 Jun 2003 21:17:12 MST."
             <Pine.LNX.4.44.0306302114170.2186-100000@home.osdl.org> 
Date: Tue, 01 Jul 2003 15:08:37 +1000
Message-Id: <20030701051719.B2B702C090@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306302114170.2186-100000@home.osdl.org> you write:
> 
> On Tue, 1 Jul 2003, Rusty Russell wrote:
> > 
> > Linus?  See thread below: poll_wait is called with task state !=
> > TASK_RUNNING, but can do a yield on low memory, causing eternal hangs.
> 
> Hint: 2.5.x does not have this problem, because the yield() in 2.5.x isn't
> buggy.
> 
> So the proper fix is to just fix yield() on 2.4.x.

Thanks Linus.

Um, Ray?  2.4's yield also does:

	void yield(void)
	{
		set_current_state(TASK_RUNNING);
		sys_sched_yield();
		schedule();
	}

So how did the below patch make any difference?

Now thoroughly confused,
Rusty.

--- linux-2.4.22-pre2.orig/mm/page_alloc.c      Thu Nov 28 17:53:15 2002
+++ linux-2.4.22-pre2/mm/page_alloc.c   Fri Jun 27 13:47:49 2003
@@ -418,6 +418,7 @@
                 return NULL;

         /* Yield for kswapd, and try again */
+        set_current_state(TASK_RUNNING);
         yield();
         goto rebalance;
  }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
