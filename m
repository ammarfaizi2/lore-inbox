Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSIIUZP>; Mon, 9 Sep 2002 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318877AbSIIUZP>; Mon, 9 Sep 2002 16:25:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38042 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318876AbSIIUZO>;
	Mon, 9 Sep 2002 16:25:14 -0400
Date: Mon, 9 Sep 2002 22:33:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <20020909201516.GA7465@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209092230550.16779-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes one bug in the way we did zap_thread() - but this
alone does not fix the lockup.

the bug was that list_for_each_safe() is not 'safe enough' - zap_thread()  
drops the tasklist lock at which point anything might happen to the child
list.

the lockup is likely in the while loop - ie. zap_thread() not actually
reparenting a thread and thus causing an infinite loop - is that possible?

	Ingo

--- linux/kernel/exit.c.orig	Mon Sep  9 21:59:24 2002
+++ linux/kernel/exit.c	Mon Sep  9 22:24:41 2002
@@ -493,7 +493,6 @@
 static void exit_notify(void)
 {
 	struct task_struct *t;
-	struct list_head *_p, *_n;
 
 	forget_original_parent(current);
 	/*
@@ -554,17 +553,16 @@
 		do_notify_parent(current, current->exit_signal);
 
 zap_again:
-	list_for_each_safe(_p, _n, &current->children)
-		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
-	list_for_each_safe(_p, _n, &current->ptrace_children)
-		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
+	while (!list_empty(&current->children))
+		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
+	while (!list_empty(&current->ptrace_children))
+		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,sibling), current, 0);
 	/*
 	 * zap_thread might drop the tasklist lock, thus we could
 	 * have new children queued back from the ptrace list into the
 	 * child list:
 	 */
-	if (unlikely(!list_empty(&current->children) ||
-			!list_empty(&current->ptrace_children)))
+	if (unlikely(!list_empty(&current->children)))
 		goto zap_again;
 	/*
 	 * No need to unlock IRQs, we'll schedule() immediately

