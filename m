Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSIIUhF>; Mon, 9 Sep 2002 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318844AbSIIUgb>; Mon, 9 Sep 2002 16:36:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53151 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318885AbSIIUfl>;
	Mon, 9 Sep 2002 16:35:41 -0400
Date: Mon, 9 Sep 2002 22:45:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.33.0209091338330.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209092244110.19716-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Linus Torvalds wrote:

> > the lockup is likely in the while loop - ie. zap_thread() not actually
> > reparenting a thread and thus causing an infinite loop - is that possible?
> 
> Hmm.. This patch changes the last argument of zap_thread() from a "1" to
> a "0" for the ptrace_children list. Was that intentional or a
> cut-and-paste error? [...]

cut-and-paste error. New patch attached. (with the assert added as well)

	Ingo

--- linux/kernel/exit.c.orig	Mon Sep  9 21:59:24 2002
+++ linux/kernel/exit.c	Mon Sep  9 22:38:44 2002
@@ -461,6 +461,8 @@
 		ptrace_unlink (p);
 
 		list_del_init(&p->sibling);
+		if (p->parent == father && p->parent == p->real_parent)
+			BUG();
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling, &p->parent->children);
 	}
@@ -493,7 +495,6 @@
 static void exit_notify(void)
 {
 	struct task_struct *t;
-	struct list_head *_p, *_n;
 
 	forget_original_parent(current);
 	/*
@@ -554,17 +555,16 @@
 		do_notify_parent(current, current->exit_signal);
 
 zap_again:
-	list_for_each_safe(_p, _n, &current->children)
-		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
-	list_for_each_safe(_p, _n, &current->ptrace_children)
-		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
+	while (!list_empty(&current->children))
+		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
+	while (!list_empty(&current->ptrace_children))
+		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,sibling), current, 1);
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

