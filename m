Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTBTW01>; Thu, 20 Feb 2003 17:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTBTW01>; Thu, 20 Feb 2003 17:26:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267143AbTBTW0Y>; Thu, 20 Feb 2003 17:26:24 -0500
Date: Thu, 20 Feb 2003 14:32:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302202258130.4400-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302201428540.1159-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
> 
> well, we can do the wait_task_inactive() in both cases - in
> release_task(), and in __put_task_struct(). [in the release_task() path
> that will just be a nop]. This further simplifies the patch.

I think the _real_ simplification is to just have the task switch do this 
in the tail:

	if (prev->state & TASK_DEAD)
		put_task_struct(prev);

suddenly we don't have any issues at all with possibly freeing stuff 
before its time, since we're guaranteed to keep the process around untill 
we've properly scheduled out of it.

Suggested patch (against current BK, which has the finish_task_switch() 
cleanups I mentioned earlier) appended. No special cases, nu subtlety with 
__put_task_struct() caches, no nothing.

		Linus

-----
===== kernel/exit.c 1.97 vs edited =====
--- 1.97/kernel/exit.c	Thu Feb 20 03:10:35 2003
+++ edited/kernel/exit.c	Thu Feb 20 14:28:39 2003
@@ -103,7 +103,6 @@
 		dput(proc_dentry);
 	}
 	release_thread(p);
-	put_task_struct(p);
 }
 
 /* we are using it only for SMP init */
===== kernel/sched.c 1.160 vs edited =====
--- 1.160/kernel/sched.c	Thu Feb 20 05:42:54 2003
+++ edited/kernel/sched.c	Thu Feb 20 14:27:23 2003
@@ -581,6 +581,8 @@
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
+	if (prev->state & TASK_DEAD)
+		put_task_struct(prev);
 }
 
 /**

