Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWDHNa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWDHNa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 09:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWDHNa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 09:30:59 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:38117 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751386AbWDHNa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 09:30:58 -0400
Date: Sat, 8 Apr 2006 21:27:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-ID: <20060408172745.GA89@oleg>
References: <20060406220403.GA205@oleg> <m1acay1fbh.fsf@ebiederm.dsl.xmission.com> <20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org> <20060407155619.18f3c5ec.akpm@osdl.org> <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08, Eric W. Biederman wrote:
>
> Agreed.  That is ugly.

Yes, I agree also.

>
> -#define thread_group_leader(p)	(p->pid == p->tgid)
> +#define thread_group_leader(p)	(p == p->group_leader)
>
> ...
>
> -		leader->group_leader = leader;
> +		leader->group_leader = current;

I thought about similar change too, but I am unsure about
release_task(old_leader)->proc_flush_task() path (because
I don't understand this code).

This change can confuse next_tid(), but this is minor.
I don't see other problems.

However, I think we can do something better instead of
attach_pid(current)/detach_pid(leader):

	void exec_pid(task_t *old, task_t * new, enum pid_type type)
	{
		new->pids[type].pid = old->pids[type].pid;
		hlist_replace_rcu(&old->pids[type].node, &new->pids[type].node);
		old->pids[type].pid = NULL;
	}

So de_thread() can do

	exec_pid(leader, current, PIDTYPE_PGID);
	exec_pid(leader, current, PIDTYPE_SID);

This allows us to iterate over pgrp/session lockless without
seeing the same task twice, btw. But may be it is just unneeded
complication.

> This requires changing the leaders parents
>
>  		current->parent = current->real_parent = leader->real_parent;
> -		leader->parent = leader->real_parent = child_reaper;
> +		leader->parent = leader->real_parent = current;
>  		current->group_leader = current;

I don't understand why do we need this change.

Actually, I think leader doesn't need reparenting at all.
ptrace_unlink(leader) already restored leader->parent = ->real_parent
and ->sibling. So I think we can do (for review only, should go in a
separate patch) this:

--- MM/fs/exec.c~	2006-04-08 02:19:15.000000000 +0400
+++ MM/fs/exec.c	2006-04-08 18:50:35.000000000 +0400
@@ -704,7 +704,6 @@ static int de_thread(struct task_struct 
 		ptrace_unlink(current);
 		ptrace_unlink(leader);
 		remove_parent(current);
-		remove_parent(leader);
 
 
 		/* Become a process group leader with the old leader's pid.
@@ -718,13 +717,11 @@ static int de_thread(struct task_struct 
 		attach_pid(current, PIDTYPE_SID,  current->signal->session);
 		list_replace_rcu(&leader->tasks, &current->tasks);
 
-		current->parent = current->real_parent = leader->real_parent;
-		leader->parent = leader->real_parent = child_reaper;
+		current->parent = current->real_parent = leader->parent;
 		current->group_leader = current;
 		leader->group_leader = leader;
 
 		add_parent(current);
-		add_parent(leader);
 		if (ptrace) {
 			current->ptrace = ptrace;
 			__ptrace_link(current, parent);

Oleg.

