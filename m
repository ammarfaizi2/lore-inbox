Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTLCT6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTLCT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:58:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7562 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265116AbTLCT6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:58:44 -0500
Date: Wed, 3 Dec 2003 20:58:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, vatsa@in.ibm.com,
       Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312031015000.6950@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312032050551.4438@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <3FCE217E.1080007@colorfullife.com>
 <Pine.LNX.4.58.0312031015000.6950@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Linus Torvalds wrote:

> > But I don't understand the oops:
> > __exit_sighand clears current->sighand, and then in the next line
> > __unhash_process removes the thread from the task list. But that's under
> > write_lock_irq(&tasklist_lock), and get_tid_list runs under
> > read_lock(&tasklist_lock). It should be impossible that ->sighand is
> > NULL and the task is still listed in the task list.
> 
> The /proc filesystem will keep pointers to processes alive, and can
> reach them even if the process is otherwise gone.
> 
> This is why /proc ends up doing tests like "if (tsk->mm)" etc - because
> it literally can see processes after they are dead.

yes, and we start the 'task list search' at leader_task, which might be an
already unlinked task. So i'd suggest to use a variant of Srivatsa's fix
(attached below) - the extra explanation at this place cannot hurt i
think.

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
