Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWDHH4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWDHH4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDHH4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:56:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24520 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751394AbWDHH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:56:22 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 08 Apr 2006 01:55:10 -0600
In-Reply-To: <20060407155619.18f3c5ec.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 7 Apr 2006 15:56:19 -0700")
Message-ID: <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Andrew Morton <akpm@osdl.org> wrote:
>>
>> Oleg Nesterov <oleg@tv-sign.ru> wrote:
>> >
>> > -		if (likely(p->tasks.prev != LIST_POISON2))
>> > +		if (likely(p->tasks.prev != LIST_POISON2)) {
>> 
>> argh.
>> 
>> c'mon guys, we can't put a dependency on list_head poisoning into generic
>> code.
>> 
>
> A suitable fix might be to add a new list_del_poison() (or
> list_del_rcu_something()?) and use that everywhere.
>
> But it should use a different poisoning pattern, so we know that the kernel
> will still work correctly when someone removes the list_head debugging.

Agreed.  That is ugly.  I would recommend some new functions
list functions but in thinking about this I believe I see
how we can avoid this case completely.

The first step is to optimize thread_group_leader to be
defined in terms of tasks and not process ids.  Which
is one less pointer dereference.

The second step is to modify de_thread to reduce the
old thread group leader to a thread.  This requires changing the
leaders parents, changing the leaders thread_group leader, unhashing
the leader from the process group and session, and removing
the leader from the task list.

With those two changes exit.c should not need to account for 
the de_thread case.

Oleg please take a hard look and see if you can find anything
that will break with the patch below.

I believe that is all that is needed to cleanly keep do_each_thread
from seeing a single thread multiple times.

Eric

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 541f482..2964a2c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1203,7 +1203,7 @@ extern void wait_task_inactive(task_t * 
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
+#define thread_group_leader(p)	(p == p->group_leader)
 
 static inline task_t *next_thread(task_t *p)
 {


diff --git a/fs/exec.c b/fs/exec.c
index 0291a68..9b0f9c4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -721,9 +721,14 @@ static int de_thread(struct task_struct 
 		list_add_tail(&current->tasks, &init_task.tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
-		leader->parent = leader->real_parent = child_reaper;
+		leader->parent = leader->real_parent = current;
 		current->group_leader = current;
-		leader->group_leader = leader;
+		leader->group_leader = current;
+
+		/* Reduce leader to a thread */
+		detach_pid(leader, PIDTYPE_PGID, current->signal->pgrp);
+		detach_pid(leader, PIDTYPE_SID   current->signal->session);
+		list_del_init(&leader->tasks);
 
 		add_parent(current);
 		add_parent(leader);
