Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbTBTVvQ>; Thu, 20 Feb 2003 16:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBTVvP>; Thu, 20 Feb 2003 16:51:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61096 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267022AbTBTVvI>;
	Thu, 20 Feb 2003 16:51:08 -0500
Date: Thu, 20 Feb 2003 23:00:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201207320.12127-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302202258130.4400-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> > ie. something like:
> 
> Well, please remove the double test for task inequality.

ok.

> I like the patch conceptually, HOWEVER, I'm not sure it's correct. The
> thing is, moving the wait_task_inactive() to __put_task_struct() means
> that we will be doing the "release_task()" teardown while the task is
> still potentially active on another CPU.
> 
> In particular, we'll be freeing the security stuff and the signals while
> the process may still be active in the scheduler on another CPU. This
> can be dangerous, ie doing things like calling "free_uid()" on a process
> that is still running means that suddenly you have issues like not being
> able to trust "current->user" from interrupts. We may not care right
> now, but it's still wrong (imagine us doing per-user time accounting -
> which makes a _lot_ of sense).

well, we can do the wait_task_inactive() in both cases - in
release_task(), and in __put_task_struct(). [in the release_task() path
that will just be a nop]. This further simplifies the patch.

	Ingo

--- kernel/fork.c.orig
+++ kernel/fork.c
@@ -75,6 +75,7 @@
 void __put_task_struct(struct task_struct *tsk)
 {
 	if (tsk != current) {
+		wait_task_inactive(tsk);
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
 	} else {

