Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTLCU02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTLCU02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:26:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20882 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265176AbTLCU0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:26:25 -0500
Date: Wed, 3 Dec 2003 21:26:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <3FCE453D.9080701@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0312032122420.6622@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
 <Pine.LNX.4.58.0312031203430.7406@home.osdl.org> <3FCE453D.9080701@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Manfred Spraul wrote:

> It's wrong, because next_thread() relies on
> 
>     task->pids[PIDTYPE_TGID].pid_chain.next
> 
> That pointer is not valid after detach_pid(task, PIDTYPE_TGID), and
> that's called within __unhash_process.  Thus next_thread() fails if it's
> called on a dead task. Srivatsa's second patch is the right change: If
> pid_alive() is wrong, then break from the loop without calling
> next_thread().

yes. And for thread groups this can only happen for the thread group
leader if all 'child' threads have exited. So it can never happen that we
somehow get to a 'middle' thread, walk the chain and get to a task that is
invalid. The only possibility is that the starting point is stale itself -
and the pid_alive() test checks that.

the thread group leader being 'zombie' does not mean it's unhashed. Thread
group leaders are never detached threads, they have a parent that waits
for them. So these zombies just hang around until the last thread goes
away, and then the leader is released, unhashed from the PID space (and
thus next_thread() stops being valid) and the parent is notified.

	Ingo

--- linux/fs/proc/base.c.orig	
+++ linux/fs/proc/base.c	
@@ -1666,7 +1666,12 @@ static int get_tid_list(int index, unsig
 
 	index -= 2;
 	read_lock(&tasklist_lock);
-	do {
+	/*
+	 * The starting point task (leader_task) might be an already
+	 * unlinked task, which cannot be used to access the task-list
+	 * via next_thread().
+	 */
+	if (pid_alive(task)) do {
 		int tid = task->pid;
 		if (!pid_alive(task))
 			continue;
